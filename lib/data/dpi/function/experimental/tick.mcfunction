execute if score $json_file dpi.experimental matches -1 run scoreboard players add $json_file dpi.experimental 1
execute if score $json_file dpi.experimental matches 59 run scoreboard players set $json_file dpi.experimental -1
execute if score $json_file dpi.experimental matches 0..58 run scoreboard players add $json_file dpi.experimental 1

execute if score $python dpi.experimental matches -1 run scoreboard players add $python dpi.experimental 1
execute if score $python dpi.experimental matches 99 run scoreboard players set $python dpi.experimental -1
execute if score $python dpi.experimental matches 0..98 run scoreboard players add $python dpi.experimental 1