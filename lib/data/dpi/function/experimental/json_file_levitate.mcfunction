say play levitate
#scoreboard players remove $json_file dpi.experimental 3
execute store result storage dpi:experimental json_file.frame int 1 run scoreboard players get $json_file dpi.experimental
execute as @e[type=minecraft:item_display,tag=dpi.aj.chest_house.root,limit=1] run function dpi:aj/chest_house/animations/json_file_levitate/apply_frame with storage dpi:experimental json_file
execute as @e[type=minecraft:item_display,tag=dpi.aj.chest_house.root,limit=1] run function dpi:aj/chest_house/animations/json_file_levitate/resume
scoreboard players reset $json_file dpi.experimental