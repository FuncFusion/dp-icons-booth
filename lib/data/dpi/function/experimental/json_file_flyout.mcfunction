execute store result storage dpi:experimental json_file_levitate_frame int 1 run scoreboard players get @e[type=item_display,tag=dpi.aj.chest_house.root,limit=1] aj.json_file_levitate.frame
execute store result storage dpi:experimental json_file_levitate2_frame int 1 run scoreboard players get @e[type=item_display,tag=dpi.aj.chest_house.root,limit=1] aj.json_file_levitate2.frame

execute as @e[type=minecraft:item_display,tag=dpi.aj.chest_house.root,limit=1] if score @s aj.json_file_levitate.frame matches -1..200 unless score @s aj.json_file_levitate.frame matches 0 run scoreboard players operation $json_file dpi.experimental = @e[type=item_display,tag=dpi.aj.chest_house.root,limit=1] aj.json_file_levitate.frame
execute as @e[type=minecraft:item_display,tag=dpi.aj.chest_house.root,limit=1] if score @s aj.json_file_levitate2.frame matches -1..200 unless score @s aj.json_file_levitate2.frame matches 0 run scoreboard players operation $json_file dpi.experimental = @e[type=item_display,tag=dpi.aj.chest_house.root,limit=1] aj.json_file_levitate2.frame

execute as @e[type=minecraft:item_display,tag=dpi.aj.chest_house.root,limit=1] if score @s aj.json_file_levitate2.frame matches -1..200 unless score @s aj.json_file_levitate2.frame matches 0 run say scheduled levitate1
execute as @e[type=minecraft:item_display,tag=dpi.aj.chest_house.root,limit=1] if score @s aj.json_file_levitate.frame matches -1..200 unless score @s aj.json_file_levitate.frame matches 0 run say scheduled levitate2
execute as @e[type=minecraft:item_display,tag=dpi.aj.chest_house.root,limit=1] if score @s aj.json_file_levitate2.frame matches -1..200 unless score @s aj.json_file_levitate2.frame matches 0 run schedule function dpi:experimental/json_file_levitate 16t
execute as @e[type=minecraft:item_display,tag=dpi.aj.chest_house.root,limit=1] if score @s aj.json_file_levitate.frame matches -1..200 unless score @s aj.json_file_levitate.frame matches 0 run schedule function dpi:experimental/json_file_levitate2 16t

execute as @e[type=minecraft:item_display,tag=dpi.aj.chest_house.root,limit=1] if score @s aj.json_file_levitate.frame matches -1..200 unless score @s aj.json_file_levitate.frame matches 0 run say stop levitate1
execute as @e[type=minecraft:item_display,tag=dpi.aj.chest_house.root,limit=1] if score @s aj.json_file_levitate2.frame matches -1..200 unless score @s aj.json_file_levitate2.frame matches 0 run say stop levitate2
execute as @e[type=minecraft:item_display,tag=dpi.aj.chest_house.root,limit=1] if score @s aj.json_file_levitate.frame matches -1..200 unless score @s aj.json_file_levitate.frame matches 0 run function dpi:aj/chest_house/animations/json_file_levitate/stop
execute as @e[type=minecraft:item_display,tag=dpi.aj.chest_house.root,limit=1] if score @s aj.json_file_levitate2.frame matches -1..200 unless score @s aj.json_file_levitate2.frame matches 0 run function dpi:aj/chest_house/animations/json_file_levitate2/stop

schedule function dpi:experimental/json_file_flyout_start 1t