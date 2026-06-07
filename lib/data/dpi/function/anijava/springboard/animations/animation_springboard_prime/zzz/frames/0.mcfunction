$data merge entity $(springs) {transformation: [-1.4056f,-0.2796f,0f,0f,-0.2796f,1.4056f,0f,0.0782f,0f,0f,-1.4331f,0f,0f,0f,0f,1f],start_interpolation: 0,interpolation_duration: 1}
$data merge entity $(top) {transformation: [-1.6667f,0f,0f,0f,0f,1.6667f,0f,0.5172f,0f,0f,-1.6667f,0f,0f,0f,0f,1f],start_interpolation: 0,interpolation_duration: 1}
execute unless entity @s[tag=aj.transforms_only] at @s run function dpi:anijava/springboard/animations/animation_springboard_prime/zzz/frames/0_root_function
