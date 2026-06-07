execute store result storage animated_java:temp args.id int 1 run scoreboard players get @s aj.id
function animated_java:global/data_manager/read with storage animated_java:temp args
tag @s add dpi.anijava.chest_house.animation.chest_open.playing
scoreboard players set @s aj.chest_open.frame 0
tag @s add aj.transforms_only
execute at @s run function dpi:anijava/chest_house/animations/chest_open/zzz/set_frame {frame: 0}
tag @s remove aj.transforms_only
