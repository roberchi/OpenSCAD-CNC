include <../src/cnc_main.scad>;
include <../src/cnc_path.scad>;


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


path = circolar_move(radius=10, arc=90, path=
        move_by(20,
            circolar_move(radius=30, arc=180,  path=
            circolar_move(radius=30, arc=120, dir="l", path=
             move_by([30],
                down(10,
                    start(0,0,0)))))));
                
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
        cube([300,300,100], center=true);