execute if score $json_file dpi.experimental matches -1 run scoreboard players add $json_file dpi.experimental 1
execute if score $json_file dpi.experimental matches 59 run scoreboard players set $json_file dpi.experimental -1
execute if score $json_file dpi.experimental matches 0..58 run scoreboard players add $json_file dpi.experimental 1