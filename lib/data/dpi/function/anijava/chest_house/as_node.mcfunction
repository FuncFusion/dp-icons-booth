data remove storage animated_java:temp args
$data modify storage animated_java:temp args merge value {name:'$(name)', command:'$(command)', uuid:'+MISSING_UUID+'}
execute store result storage animated_java:temp args.id int 1 run scoreboard players get @s aj.id
function animated_java:global/data_manager/read with storage animated_java:temp args
function dpi:anijava/chest_house/zzz/as_node/as_data with storage animated_java:temp args
