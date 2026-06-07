execute store result storage animated_java:temp args.id int 1 run scoreboard players get @s aj.id
function animated_java:global/data_manager/read with storage animated_java:temp args
function dpi:anijava/chest_house/animations/pause_all
tag @s add dpi.anijava.chest_house.animation.chest_open.playing
$scoreboard players set @s aj.tween_duration $(duration)
$scoreboard players set @s aj.chest_open.frame $(to_frame)
scoreboard players operation #this aj.i = @s aj.tween_duration
tag @s add aj.transforms_only
execute at @s run function dpi:anijava/chest_house/animations/chest_open/zzz/apply_frame {frame: 0}
$execute at @s run function dpi:anijava/chest_house/animations/chest_open/zzz/apply_frame {frame: $(to_frame)}
tag @s remove aj.transforms_only
execute on passengers store result entity @s interpolation_duration int 1 run scoreboard players get #this aj.i
