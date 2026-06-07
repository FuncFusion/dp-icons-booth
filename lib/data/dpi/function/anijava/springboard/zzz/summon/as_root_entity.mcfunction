execute store result score @s aj.id run scoreboard players add aj.last_id aj.id 1
function animated_java:global/gu/get_entity_uuid_string
data modify storage animated_java:temp args.uuid set from storage animated_java:gu out
execute store result storage animated_java:temp args.id int 1 run scoreboard players get @s aj.id
function animated_java:global/data_manager/create_entry with storage animated_java:temp args
execute store result storage animated_java:temp args.id int 1 run scoreboard players get @s aj.id
function animated_java:global/data_manager/read with storage animated_java:temp args
data modify storage animated_java:temp entry.data.uuids append from storage animated_java:gu out
data modify storage animated_java:temp entry.data.root_uuid set from storage animated_java:gu out
data modify storage animated_java:temp entry.data.blueprint_id set value "dpi:anijava/springboard"
data modify storage animated_java:temp entry.data.rig_hash set value "5be7395897e17bcb2a4c271746cb23ffbfd9bda76d720bea7bc526cc6eb83a60"
tp @s ~ ~ ~ ~ ~
execute on passengers if entity @s[tag=dpi.anijava.springboard.node.bottom] run function dpi:anijava/springboard/zzz/summon/as_node/bottom
data modify storage animated_java:temp entry.data.uuids append from storage animated_java:gu out
data modify storage animated_java:temp entry.data.uuids_by_name.bottom set from storage animated_java:gu out
execute on passengers if entity @s[tag=dpi.anijava.springboard.node.springs] run function dpi:anijava/springboard/zzz/summon/as_node/springs
data modify storage animated_java:temp entry.data.uuids append from storage animated_java:gu out
data modify storage animated_java:temp entry.data.uuids_by_name.springs set from storage animated_java:gu out
execute on passengers if entity @s[tag=dpi.anijava.springboard.node.top] run function dpi:anijava/springboard/zzz/summon/as_node/top
data modify storage animated_java:temp entry.data.uuids append from storage animated_java:gu out
data modify storage animated_java:temp entry.data.uuids_by_name.top set from storage animated_java:gu out
function dpi:anijava/springboard/zzz/set_default_pose
function animated_java:global/data_manager/write with storage animated_java:temp args
execute if data storage animated_java:temp args.variant run function dpi:anijava/springboard/zzz/summon/zzz/variant_arg/no_variants_warning
execute if score #success aj.i matches 0 run return fail
execute if data storage animated_java:temp args.animation run function dpi:anijava/springboard/zzz/summon/animation_arg/process with storage animated_java:temp args
execute if score #success aj.i matches 0 run return fail
execute on passengers run rotate @s ~ ~
data modify entity @s teleport_duration set value 1
execute on passengers run data modify entity @s teleport_duration set value 1
tag @s remove aj.new
execute on passengers run tag @s remove aj.new
