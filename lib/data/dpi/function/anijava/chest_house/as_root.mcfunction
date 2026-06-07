execute unless score @s aj.id matches -2147483648..2147483647 run return run tellraw @a [{text: "", color: "red"}, [{color: "gray", text: "\n "}, {color: "#00aced", text: "\u1d00\u0274\u026a\u1d0d\u1d00\u1d1b\u1d07\u1d05 \u1d0a\u1d00\u1d20\u1d00"}, {color: "dark_gray", italic: true, text: "\n (dpi:anijava/chest_house)"}, "\n \u2192 "], "\u1d07\u0280\u0280\u1d0f\u0280: ", {text: "Function Not Executed as Entity with ID Score", underlined: true}, "\n\n ", {text: "[This Function]", color: "yellow", hover_event: {action: "show_text", value: [{color: "yellow", text: "dpi:anijava/chest_house/as_root"}]}}, " must be executed as an entity with a ", {text: "aj.id", color: "yellow"}, " score.", "\n"]
execute store result storage animated_java:temp args.id int 1 run scoreboard players get @s aj.id
function animated_java:global/data_manager/read with storage animated_java:temp args
$data modify storage animated_java:temp args.command set value '$(command)'
data modify storage animated_java:temp args.root_uuid set from storage animated_java:temp entry.data.root_uuid
function dpi:anijava/chest_house/as_root_entity with storage animated_java:temp args
