execute store result storage animated_java:temp args.id int 1 run scoreboard players get @s aj.id
function animated_java:global/data_manager/read with storage animated_java:temp args
execute if score @s aj.mcf_tick_levitate.frame matches 81.. run scoreboard players set @s aj.mcf_tick_levitate.frame 1
data remove storage animated_java:temp args
execute store result storage animated_java:temp args.frame int 1 run scoreboard players get @s aj.mcf_tick_levitate.frame
execute at @s run function dpi:anijava/chest_house/animations/mcf_tick_levitate/zzz/apply_frame with storage animated_java:temp args
scoreboard players add @s aj.mcf_tick_levitate.frame 1
