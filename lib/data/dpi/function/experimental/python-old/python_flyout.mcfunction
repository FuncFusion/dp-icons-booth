## @s = dpi.aj.chest_house.root

execute store result storage dpi:experimental python_levitate_frame int 1 run scoreboard players get @s aj.python_levitate.frame
execute store result storage dpi:experimental python_levitate2_frame int 1 run scoreboard players get @s aj.python_levitate2.frame

execute if score @s aj.python_levitate.frame matches -1..100 unless score @s aj.python_levitate.frame matches 0 run scoreboard players operation $python dpi.experimental = @s aj.python_levitate.frame
execute if score @s aj.python_levitate2.frame matches -1..100 unless score @s aj.python_levitate2.frame matches 0 run scoreboard players operation $python dpi.experimental = @s aj.python_levitate2.frame

execute if score @s aj.python_levitate2.frame matches -1..100 unless score @s aj.python_levitate2.frame matches 0 run say scheduled levitate1
execute if score @s aj.python_levitate.frame matches -1..100 unless score @s aj.python_levitate.frame matches 0 run say scheduled levitate2
execute if score @s aj.python_levitate2.frame matches -1..100 unless score @s aj.python_levitate2.frame matches 0 run schedule function dpi:experimental/python/python_levitate 16t
execute if score @s aj.python_levitate.frame matches -1..100 unless score @s aj.python_levitate.frame matches 0 run schedule function dpi:experimental/python/python_levitate2 16t

execute if score @s aj.python_levitate.frame matches -1..100 unless score @s aj.python_levitate.frame matches 0 run say stop levitate1
execute if score @s aj.python_levitate2.frame matches -1..100 unless score @s aj.python_levitate2.frame matches 0 run say stop levitate2
execute if score @s aj.python_levitate.frame matches -1..100 unless score @s aj.python_levitate.frame matches 0 run function dpi:aj/chest_house/animations/python_levitate/stop
execute if score @s aj.python_levitate2.frame matches -1..100 unless score @s aj.python_levitate2.frame matches 0 run function dpi:aj/chest_house/animations/python_levitate2/stop

schedule function dpi:experimental/python/python_flyout_start 1t