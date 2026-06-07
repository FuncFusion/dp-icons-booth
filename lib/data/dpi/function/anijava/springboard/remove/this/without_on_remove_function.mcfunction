execute store result storage animated_java:temp args.id int 1 run scoreboard players get @s aj.id
function animated_java:global/data_manager/read with storage animated_java:temp args
execute unless data storage animated_java:temp {entry: {data: {rig_hash: "5be7395897e17bcb2a4c271746cb23ffbfd9bda76d720bea7bc526cc6eb83a60"}}} run function animated_java:global/remove/outdated_rig
function dpi:anijava/springboard/remove/this/zzz/0 with storage animated_java:temp entry.data.uuids_by_name
function animated_java:global/remove/entity_stack
