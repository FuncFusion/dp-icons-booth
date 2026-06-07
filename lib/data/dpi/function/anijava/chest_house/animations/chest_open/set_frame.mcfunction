execute store result storage animated_java:temp args.id int 1 run scoreboard players get @s aj.id
function animated_java:global/data_manager/read with storage animated_java:temp args
data remove storage animated_java:temp args
$execute store result storage animated_java:temp args.frame int 1 run scoreboard players set @s aj.chest_open.frame $(frame)
execute at @s run function dpi:anijava/chest_house/animations/chest_open/zzz/set_frame with storage animated_java:temp args
