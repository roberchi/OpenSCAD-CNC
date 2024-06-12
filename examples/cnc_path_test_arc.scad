include <../src/cnc_path.scad>
include <../src/cnc_main.scad>

$fn=15;

path = circolar_move(radius=10, arc=90, path=
        move_by(20,
            circolar_move(radius=30, arc=180,  path=
            circolar_move(radius=30, arc=120, dir="l", path=
             move_by([30], 
                start(0,0,0))))));

color("red")trace_tool(path, 0.3);

// if move down or up or ther no segments before arc, normal [x,y] must be specified.
// Normal can also be specified if you want to use different nornal angle insted of the angle calulated as the normal of the last segment
path2 = circolar_move(radius=30, normal=[1,0], arc=120, dir="l", path=
             down(30,
                start(0,0,0)));
color("blue")trace_tool(path2, 0.3);