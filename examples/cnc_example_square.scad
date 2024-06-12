include <../src/cnc_main.scad>;
path=[
[0,0,-8],
[50,0,-8],
[50,50,-8],
[0,50,-8],
[0,0,-8]
];

$fn = $preview ? 25:100;
/* [ Cutting Tool ] */
tool_type = "conic"; // ["cylinder", "conic", "spheric", "profile"]
tool_height = 15; // [0:40]
tool_ext_diameter = 10; // [1:30]
tool_int_diameter = 2; // [0:30]
tool_angle = 45; // [0:80]
tool_show = false;
tool_speed = 10; // [1:40] mm/sec
tool_animate = false;

cut(path, 
    name = tool_type,
    h= tool_height,
    d0 = tool_ext_diameter,
    d1 = tool_int_diameter,
    a= tool_angle,
    speed = tool_speed,
    show = tool_show, 
animate=tool_animate)
    translate([25,25,-50])
        cube([100,100,100], center=true);