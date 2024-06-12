include <cnc_main.scad>;

$fn=50;
create_tool(name="cylinder", h=10, d0=5);
translate([20,0,0])
    create_tool(name="conic", h=10, d0=5, d1=2, a=60);
translate([40,0,0])
    create_tool(name="spheric", h=10, d0=5);
translate([60,0,0])
    create_tool(name="profile", h=10, d0=5, d1=2);

