execute store result storage animated_java:temp args.id int 1 run scoreboard players get @s aj.id
function animated_java:global/data_manager/read with storage animated_java:temp args
tag @s add dpi.anijava.chest_house.animation.mcf_tick_levitate.playing
scoreboard players set @s aj.mcf_tick_levitate.frame 0
tag @s add aj.transforms_only
execute at @s run function dpi:anijava/chest_house/animations/mcf_tick_levitate/zzz/set_frame {frame: 0}
tag @s remove aj.transforms_only
