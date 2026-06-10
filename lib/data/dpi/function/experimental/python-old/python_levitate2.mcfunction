say play python levitate2
execute store result storage dpi:experimental python.frame int 1 run scoreboard players get $python dpi.experimental
execute as @e[type=minecraft:item_display,tag=dpi.aj.chest_house.root,limit=1] run function dpi:aj/chest_house/animations/python_levitate2/apply_frame with storage dpi:experimental python
execute as @e[type=minecraft:item_display,tag=dpi.aj.chest_house.root,limit=1] run function dpi:aj/chest_house/animations/python_levitate2/resume
scoreboard players reset $python dpi.experimental