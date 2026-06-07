execute store result storage animated_java:temp args.id int 1 run scoreboard players get @s aj.id
function animated_java:global/data_manager/read with storage animated_java:temp args
function dpi:anijava/springboard/animations/pause_all
tag @s add dpi.anijava.springboard.animation.animation_springboard_prime.playing
scoreboard players set @s aj.animation_springboard_prime.frame 0
tag @s add aj.transforms_only
execute at @s run function dpi:anijava/springboard/animations/animation_springboard_prime/zzz/set_frame {frame: 0}
tag @s remove aj.transforms_only
