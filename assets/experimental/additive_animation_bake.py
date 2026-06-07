import json

# --- Математика изингов ---

def ease_out_cubic(t):
    """Плавный отлёт: быстро стартует, плавно замедляется к концу."""
    return 1 - pow(1 - t, 3)

def ease_in_out_asymmetric(t):
    """Прилёт: ease in out, где ease in дольше выражен."""
    return (t**2.5) / (t**2.5 + pow(1 - t, 1.5))

# --- Математика Blockbench (Catmull-Rom Spline) ---

def get_blockbench_catmullrom_offset(time, amplitude=10.0, period=3.0):
    """
    Точная симуляция Catmull-Rom сплайна, который строит Blockbench 
    для 3-х кадровой луп-анимации левитации.
    """
    half_period = period / 2.0
    time = time % period # Оставляем время в пределах одного цикла (0 - 3.0)
    
    if time <= half_period:
        # Движение вниз (от 0 до 1.5 сек)
        u = time / half_period
        return amplitude - 6 * amplitude * (u**2) + 4 * amplitude * (u**3)
    else:
        # Движение вверх (от 1.5 до 3.0 сек)
        u = (time - half_period) / half_period
        return -amplitude + 6 * amplitude * (u**2) - 4 * amplitude * (u**3)

# --- Вспомогательные функции ---

def lerp(start, end, t):
    return start + (end - start) * t

def lerp_3d(p1, p2, t):
    return [lerp(p1[0], p2[0], t), lerp(p1[1], p2[1], t), lerp(p1[2], p2[2], t)]

def generate_animations():
    animations = {}
    
    # Настройки для json_file
    pos_start = [0.0, 0.0, 0.0]
    pos_end = [13.0, -11.0, -4.0]
    
    lev_amplitude = 10.0
    lev_period = 3.0           # 3 секунды на полный цикл левитации
    transition_duration = 0.75 # Отлёт и прилёт занимают 0.75 сек
    tick_length = 0.05         # 1 тик в Minecraft
    
    # --- НАСТРОЙКА СИНХРОНИЗАЦИИ ---
    # То самое количество кадров (3), которое тебе приходилось вычитать.
    # Скрипт сам добавит их в конец кривой левитации.
    sync_offset_frames = 3 
    
    total_lev_frames = int(lev_period / tick_length)
    transition_frames = int(transition_duration / tick_length)
    
    for n in range(total_lev_frames):
        t_start = n * tick_length
        
        frame_id = n + 1
        if frame_id == total_lev_frames:
            frame_id = -1
            
        out_keyframes = {}
        in_keyframes = {}
        
        for f in range(transition_frames + 1):
            t = f * tick_length
            progress = t / transition_duration
            
            # 1. Просчитываем смещение с учетом синхронизации
            # progress * sync_offset_frames плавно докидывает нужные кадры к концу
            current_lev_time = t_start + t + (progress * sync_offset_frames * tick_length)
            y_offset = get_blockbench_catmullrom_offset(current_lev_time, lev_amplitude, lev_period)
            lev_vec = [0.0, y_offset, 0.0]
            
            # 2. Генерируем кадр для отлёта (OUT)
            p_out = ease_out_cubic(progress)
            base_out = lerp_3d(pos_start, pos_end, p_out)
            final_out = [base_out[i] + lev_vec[i] for i in range(3)]
            out_keyframes[str(round(t, 2))] = [round(val, 4) for val in final_out]
            
            # 3. Генерируем кадр для прилёта (IN)
            p_in = ease_in_out_asymmetric(progress)
            base_in = lerp_3d(pos_end, pos_start, p_in)
            final_in = [base_in[i] + lev_vec[i] for i in range(3)]
            in_keyframes[str(round(t, 2))] = [round(val, 4) for val in final_in]
            
        animations[f"json_file_out_{frame_id}"] = {
            "animation_length": transition_duration,
            "bones": {
                "json_file": {
                    "position": out_keyframes
                }
            }
        }
        
        animations[f"json_file_in_{frame_id}"] = {
            "animation_length": transition_duration,
            "bones": {
                "json_file": {
                    "position": in_keyframes
                }
            }
        }
        
    output = {
        "format_version": "1.8.0",
        "animations": animations
    }
    
    with open("./assets/experimental/compiled_json_file_animations.json", "w", encoding="utf-8") as f:
        json.dump(output, f, indent=4)
    print("Готово! Компенсация в 3 кадра добавлена.")

if __name__ == "__main__":
    generate_animations()