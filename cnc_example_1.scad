include <cnc_main.scad>;
path=[
[0,0,0],
[0,0,-18],
[0,0,0],
[0,100,-5],
[10,120,-1],
[10,130,-10],
[50,130,-10],
[50,180,-10]
];

$fn = $preview ? 25:100;
/* [ Cutting Tool ] */
tool_type = "conic"; // ["cylinder", "conic", "spheric", "profile"]
tool_height = 15; // [0:40]
tool_ext_diameter = 40; // [1:30]
tool_int_diameter = 20; // [0:30]
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
    translate([0,0,-70])
        cube([400,400,140], true);