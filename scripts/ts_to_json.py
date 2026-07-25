import ast
import json
import os
import re

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
ICONS_DIR = os.path.join(SCRIPT_DIR, "..", "..", "mc-dp-icons", "src", "data", "icons")
OUTPUT_PATH = os.path.join(SCRIPT_DIR, "..", "icon_data.json")

FILES = [
    "dataPackIcons",
    "resourcePackIcons",
    "bedrockAddonIcons",
    "bedrockResourceIcons",
    "languageIcons",
    "generalIcons",
]


def parse_ts(filepath: str) -> list[dict]:
    with open(filepath) as f:
        raw = f.read()

    src = raw
    src = re.sub(r"^import .*", "", src, flags=re.MULTILINE)
    src = re.sub(r"^import type .*", "", src, flags=re.MULTILINE)
    src = re.sub(r"^export (const|type) \w+(: IconDefinition\[\])? = ", "", src, flags=re.MULTILINE)
    src = re.sub(r"^export type \{[\w\s,]+\};", "", src, flags=re.MULTILINE)
    src = re.sub(r"(\w+):\s*(?=[\"\[])",
                 lambda m: f'"{m.group(1)}": ', src)
    src = re.sub(r",\s*]", "]", src)
    src = re.sub(r",\s*\}", "}", src)
    src = src.strip().rstrip(";")
    src = re.sub(r"/\*.*?\*/", "", src, flags=re.DOTALL)

    src = src.strip().strip(",").strip()

    if not src.endswith("]") and not src.endswith("}"):
        print(f"  WARN: {filepath} doesn't end with ] or }}")
        return []

    try:
        return ast.literal_eval(src)
    except Exception as e:
        print(f"  ERROR parsing {filepath}: {e}")
        print(f"  First 500 chars: {src[:500]}")
        return []


def main():
    typed = {}
    named_dirs = {}
    named_files = {}

    for fname in FILES:
        fpath = os.path.join(ICONS_DIR, f"{fname}.ts")
        if not os.path.exists(fpath):
            continue
        entries = parse_ts(fpath)
        for entry in entries:
            if not isinstance(entry, dict):
                continue
            icon_name = entry.get("name")
            if not icon_name:
                continue

            for ext in entry.get("extensions", []):
                if "/" not in ext:
                    typed[ext] = icon_name

            for fn in entry.get("filenames", []):
                named_files[fn.split("/")[-1]] = icon_name

            for fol in entry.get("foldernames", []):
                if icon_name.endswith("_closed"):
                    named_dirs[fol + "_closed"] = icon_name
                else:
                    named_dirs[fol] = icon_name
                if icon_name.endswith("_folder"):
                    named_files[f"{fol}_file"] = icon_name.removesuffix("_folder") + "_file"

    typed.setdefault("dir", "generic_folder")
    typed.setdefault("mcfunction", "mcfunction_file")
    typed.setdefault("mcf", "mcfunction_file")

    named_files["tick.mcfunction"] = "mcfunction_tick_file"
    named_files["load.mcfunction"] = "mcfunction_load_file"

    result = {"typed": typed, "named_dirs": named_dirs, "named_files": named_files}

    os.makedirs(os.path.dirname(OUTPUT_PATH), exist_ok=True)
    with open(OUTPUT_PATH, "w") as f:
        json.dump(result, f, indent=2)

    mcf_path = os.path.join(SCRIPT_DIR, "..", "lib", "data", "dpi", "function", "load_icons.mcfunction")
    os.makedirs(os.path.dirname(mcf_path), exist_ok=True)
    with open(mcf_path, "w") as f:
        f.write("data modify storage dpi:generated typed_icons set value {}\n")
        f.write("data modify storage dpi:generated named_dirs set value {}\n")
        f.write("data modify storage dpi:generated named_files set value {}\n")
        f.write("data modify storage dpi:generated typed_icon_names set value {}\n")
        f.write("data modify storage dpi:generated named_icon_names set value {}\n")
        for ext, icon in sorted(typed.items()):
            f.write(f'data modify storage dpi:generated typed_icons."{ext}" set value {{atlas:"items", sprite:"dpi:icons/{icon}"}}\n')
            f.write(f'data modify storage dpi:generated typed_icon_names."{ext}" set value "{icon}"\n')
        for name, icon in sorted(named_dirs.items()):
            f.write(f'data modify storage dpi:generated named_dirs."{name}" set value {{atlas:"items", sprite:"dpi:icons/{icon}"}}\n')
            f.write(f'data modify storage dpi:generated named_icon_names."{name}" set value "{icon}"\n')
        for name, icon in sorted(named_files.items()):
            f.write(f'data modify storage dpi:generated named_files."{name}" set value {{atlas:"items", sprite:"dpi:icons/{icon}"}}\n')
            f.write(f'data modify storage dpi:generated named_icon_names."{name}" set value "{icon}"\n')

    print(f"Generated {OUTPUT_PATH}")
    print(f"Generated {mcf_path}")
    print(f"  typed_icons: {len(typed)} entries")
    print(f"  named_dirs: {len(named_dirs)} entries")
    print(f"  named_files: {len(named_files)} entries")
    print(f"  typed_icon_names: {len(typed)} entries")
    print(f"  named_icon_names: {len(named_dirs) + len(named_files)} entries")


if __name__ == "__main__":
    main()
