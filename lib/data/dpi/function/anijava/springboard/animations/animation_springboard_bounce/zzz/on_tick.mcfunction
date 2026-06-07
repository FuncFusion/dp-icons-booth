scoreboard players remove @s aj.tween_duration 1
execute if score @s aj.tween_duration matches 1.. run return 1
execute if score @s aj.tween_duration matches 0 on passengers run data modify entity @s interpolation_duration set value 1
data remove storage animated_java:temp args
execute store result storage animated_java:temp args.frame int 1 run scoreboard players get @s aj.animation_springboard_bounce.frame
function dpi:anijava/springboard/animations/animation_springboard_bounce/zzz/apply_frame with storage animated_java:temp args
execute if score @s aj.animation_springboard_bounce.frame matches 20.. run return run function dpi:anijava/springboard/animations/animation_springboard_bounce/pause
scoreboard players add @s aj.animation_springboard_bounce.frame 1
