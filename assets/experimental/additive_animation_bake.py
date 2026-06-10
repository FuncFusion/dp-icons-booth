import json
import math
import os

# --- Математика изингов ---

def ease_out_cubic(t):
    """Плавный отлёт: быстро стартует, плавно замедляется к концу."""
    return 1 - pow(1 - t, 3)

def ease_in_out_asymmetric(t):
    """Прилёт: ease in out, где ease in дольше выражен."""
    return (t**2.5) / (t**2.5 + pow(1 - t, 1.5))

# --- Математика Blockbench (Catmull-Rom Spline) ---

def get_blockbench_catmullrom_offset(time, amplitude, period):
    """Точная симуляция Catmull-Rom сплайна из Blockbench."""
    half_period = period / 2.0
    time = time % period
    
    if time <= half_period:
        u = time / half_period
        return amplitude - 6 * amplitude * (u**2) + 4 * amplitude * (u**3)
    else:
        u = (time - half_period) / half_period
        return -amplitude + 6 * amplitude * (u**2) - 4 * amplitude * (u**3)

# --- Вспомогательные функции ---

def lerp(start, end, t):
    return start + (end - start) * t

def lerp_3d(p1, p2, t):
    return [lerp(p1[0], p2[0], t), lerp(p1[1], p2[1], t), lerp(p1[2], p2[2], t)]

def extract_pos(keyframe_data):
    """Извлекает координаты X,Y,Z независимо от формата Blockbench."""
    if isinstance(keyframe_data, list):
        return keyframe_data
    elif isinstance(keyframe_data, dict) and "post" in keyframe_data:
        return keyframe_data["post"]
    return [0.0, 0.0, 0.0]

def main():
    # --- НАСТРОЙКИ ---
    tick_length = 0.05
    sync_offset_frames = 3 # Твоя компенсация рассинхрона
    
    print("=== Генератор запеченных анимаций ===")
    source_file = "./assets/chest_house2.animation.json"
        
    if not os.path.exists(source_file):
        print(f"Ошибка: Файл '{source_file}' не найден в папке со скриптом.")
        return
        
    with open(source_file, "r", encoding="utf-8") as f:
        data = json.load(f)
        
    icons = ["json_file", "python", "structure_file", "mcf_tick"]
    print(f"\nДоступные иконки: {', '.join(icons)}")
    target_icon = input("Введите название иконки: ").strip()
    
    if target_icon not in icons:
        print("Ошибка: такой иконки нет.")
        return

    # --- АВТОМАТИЧЕСКОЕ ИЗВЛЕЧЕНИЕ ДАННЫХ ---
    print(f"\nСчитываю данные для '{target_icon}'...")
    
    # 1. Траектория отлёта (из chest_open)
    chest_open = data["animations"]["chest_open"]["bones"][target_icon]["position"]
    # Находим максимальное время в chest_open (обычно 0.75)
    transition_times = sorted([float(k) for k in chest_open.keys()])
    transition_duration = transition_times[-1] 
    
    pos_start = extract_pos(chest_open[str(transition_times[0]) if transition_times[0] != 0.0 else "0.0"])
    pos_end = extract_pos(chest_open[str(transition_duration)])
    
    # 2. Данные левитации (из _levitate)
    lev_anim = data["animations"][f"{target_icon}_levitate"]
    lev_period = lev_anim["animation_length"]
    lev_pos_data = lev_anim["bones"][target_icon]["position"]
    
    # Считаем максимальные и минимальные значения Y для поиска амплитуды и центра
    y_values = [extract_pos(v)[1] for v in lev_pos_data.values()]
    y_max = max(y_values)
    y_min = min(y_values)
    
    lev_amplitude = (y_max - y_min) / 2.0
    center_y_start = (y_max + y_min) / 2.0
    
    print(f"- Период левитации: {lev_period} сек")
    print(f"- Амплитуда: {lev_amplitude}, Центр оси Y: {center_y_start}")
    print(f"- Старт: {pos_start} -> Конец: {pos_end}")
    print("Генерирую кадры...")

    # --- ГЕНЕРАЦИЯ ---
    animations = {}
    total_lev_frames = int(lev_period / tick_length)
    transition_frames = int(transition_duration / tick_length)
    
    for n in range(total_lev_frames):
        t_start = n * tick_length
        
        # Индексы 1..N, последний -1
        frame_id = n + 1
        if frame_id == total_lev_frames:
            frame_id = -1
            
        out_keyframes = {}
        in_keyframes = {}
        
        for f in range(transition_frames + 1):
            t = f * tick_length
            progress = t / transition_duration
            
            # Смещение с учетом синхронизации (sync_offset_frames)
            current_lev_time = t_start + t + (progress * sync_offset_frames * tick_length)
            catmull_offset = get_blockbench_catmullrom_offset(current_lev_time, lev_amplitude, lev_period)
            
            # --- OUT (Отлёт) ---
            p_out = ease_out_cubic(progress)
            base_out = lerp_3d(pos_start, pos_end, p_out)
            # Добавляем Y-смещение (центр_старта + текущее колебание)
            final_out = [
                base_out[0], 
                base_out[1] + center_y_start + catmull_offset, 
                base_out[2]
            ]
            out_keyframes[str(round(t, 2))] = [round(val, 4) for val in final_out]
            
            # --- IN (Прилёт) ---
            p_in = ease_in_out_asymmetric(progress)
            base_in = lerp_3d(pos_end, pos_start, p_in)
            final_in = [
                base_in[0], 
                base_in[1] + center_y_start + catmull_offset, 
                base_in[2]
            ]
            in_keyframes[str(round(t, 2))] = [round(val, 4) for val in final_in]
            
        animations[f"{target_icon}_out_{frame_id}"] = {
            "animation_length": transition_duration,
            "bones": { target_icon: { "position": out_keyframes } }
        }
        
        animations[f"{target_icon}_in_{frame_id}"] = {
            "animation_length": transition_duration,
            "bones": { target_icon: { "position": in_keyframes } }
        }
        
    output = {
        "format_version": "1.8.0",
        "animations": animations
    }
    
    out_file = f"./assets/experimental/{target_icon}_flyouts.json"
    with open(out_file, "w", encoding="utf-8") as f:
        json.dump(output, f, indent=4)
        
    print(f"\nГотово! Файл '{out_file}' успешно сохранён.")

if __name__ == "__main__":
    main()