execute store result score @s aj.id run scoreboard players add aj.last_id aj.id 1
function animated_java:global/gu/get_entity_uuid_string
data modify storage animated_java:temp args.uuid set from storage animated_java:gu out
execute store result storage animated_java:temp args.id int 1 run scoreboard players get @s aj.id
function animated_java:global/data_manager/create_entry with storage animated_java:temp args
execute store result storage animated_java:temp args.id int 1 run scoreboard players get @s aj.id
function animated_java:global/data_manager/read with storage animated_java:temp args
data modify storage animated_java:temp entry.data.uuids append from storage animated_java:gu out
data modify storage animated_java:temp entry.data.root_uuid set from storage animated_java:gu out
data modify storage animated_java:temp entry.data.blueprint_id set value "dpi:anijava/chest_house"
data modify storage animated_java:temp entry.data.rig_hash set value "5a1c92b4fd0ad3d08deacbbc342fca28a53b3c7380aef4702f342b6042b1329d"
tp @s ~ ~ ~ ~ ~
execute on passengers if entity @s[tag=dpi.anijava.chest_house.node.lid] run function dpi:anijava/chest_house/zzz/summon/as_node/lid
data modify storage animated_java:temp entry.data.uuids append from storage animated_java:gu out
data modify storage animated_java:temp entry.data.uuids_by_name.lid set from storage animated_java:gu out
execute on passengers if entity @s[tag=dpi.anijava.chest_house.node.chest_house] run function dpi:anijava/chest_house/zzz/summon/as_node/chest_house
data modify storage animated_java:temp entry.data.uuids append from storage animated_java:gu out
data modify storage animated_java:temp entry.data.uuids_by_name.chest_house set from storage animated_java:gu out
execute on passengers if entity @s[tag=dpi.anijava.chest_house.node.mcf_tick] run function dpi:anijava/chest_house/zzz/summon/as_node/mcf_tick
data modify storage animated_java:temp entry.data.uuids append from storage animated_java:gu out
data modify storage animated_java:temp entry.data.uuids_by_name.mcf_tick set from storage animated_java:gu out
function dpi:anijava/chest_house/zzz/set_default_pose
function animated_java:global/data_manager/write with storage animated_java:temp args
execute if data storage animated_java:temp args.variant run function dpi:anijava/chest_house/zzz/summon/zzz/variant_arg/no_variants_warning
execute if score #success aj.i matches 0 run return fail
execute if data storage animated_java:temp args.animation run function dpi:anijava/chest_house/zzz/summon/animation_arg/process with storage animated_java:temp args
execute if score #success aj.i matches 0 run return fail
execute on passengers run rotate @s ~ ~
data modify entity @s teleport_duration set value 1
execute on passengers run data modify entity @s teleport_duration set value 1
tag @s remove aj.new
execute on passengers run tag @s remove aj.new
