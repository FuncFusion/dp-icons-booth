execute store result storage animated_java:temp args.id int 1 run scoreboard players get @s aj.id
function animated_java:global/data_manager/read with storage animated_java:temp args
execute unless data storage animated_java:temp {entry: {data: {rig_hash: "5a1c92b4fd0ad3d08deacbbc342fca28a53b3c7380aef4702f342b6042b1329d"}}} run function animated_java:global/remove/outdated_rig
function dpi:anijava/chest_house/remove/this/zzz/0 with storage animated_java:temp entry.data.uuids_by_name
function animated_java:global/remove/entity_stack
