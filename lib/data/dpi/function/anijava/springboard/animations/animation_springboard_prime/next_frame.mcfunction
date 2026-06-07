execute store result storage animated_java:temp args.id int 1 run scoreboard players get @s aj.id
function animated_java:global/data_manager/read with storage animated_java:temp args
execute if score @s aj.animation_springboard_prime.frame matches 16.. run scoreboard players set @s aj.animation_springboard_prime.frame 1
data remove storage animated_java:temp args
execute store result storage animated_java:temp args.frame int 1 run scoreboard players get @s aj.animation_springboard_prime.frame
execute at @s run function dpi:anijava/springboard/animations/animation_springboard_prime/zzz/apply_frame with storage animated_java:temp args
scoreboard players add @s aj.animation_springboard_prime.frame 1
