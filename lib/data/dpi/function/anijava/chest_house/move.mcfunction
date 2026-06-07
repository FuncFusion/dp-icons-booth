tp @s ~ ~ ~ ~ ~
execute store result storage animated_java:temp args.id int 1 run scoreboard players get @s aj.id
function animated_java:global/data_manager/read with storage animated_java:temp args
execute at @s on passengers run rotate @s ~ ~
