include <../src/cnc_path.scad>
echo("test move_by");
 echo( [[10, 10, 10], [20, 20, 20]] ==
    move_by([10, 10, 10],
            start(10,10,10)));
 echo(  [[10, 10, 10], [20, 20, 10]] ==
    move_by([10,10],
            start(10,10,10)));
            
 echo( [[10, 10, 10], [20, 10, 10]] ==
    move_by([10],
            start(10,10,10)));
            
 echo( [[10, 10, 10], [10, 20, 10]] ==
    move_by([undef,10],
            start(10,10,10)));
 echo( [[10, 10, 10], [20, 10, 10]] ==
    move_by([10, undef],
            start(10,10,10)));
echo([[10, 10, 10], [10, 20, 20]] ==
    move_by([undef, 10, 10],
            start(10,10,10)));
 echo([[10, 10, 10], [10, 10, 20]] ==
    move_by([undef, undef, 10],
            start(10,10,10)));

echo("test move_to");
echo( [[0, 0, 0], [10, 10, 10]] ==
    move_to([10, 10, 10],
            start(0,0,0)));
 echo( [[0, 0, 0], [10, 10, 0]] == 
    move_to([10,10],
            start(0,0,0)));
            
 echo([[0, 0, 0], [10, 0, 0]] ==
    move_to([10],
            start(0,0,0)));
            
 echo([[0, 0, 0], [0, 10, 0]] ==
    move_to([undef,10],
            start(0,0,0)));
 echo([[0, 0, 0], [10, 0, 0]] ==
    move_to([10, undef],
            start(0,0,0)));
echo([[0, 0, 0], [0, 10, 10]] ==
    move_to([undef, 10, 10],
            start(0,0,0)));
 echo([[0, 0, 0], [0, 0, 10]] ==
    move_to([undef, undef, 10],
            start(0,0,0)));

echo("test up");

echo([[0, 0, 0], [0, 0, 10]] ==
    up(10,
            start(0,0,0)));
echo([[0, 0, 0], [0, 0, -10]] ==
    down(10,
            start(0,0,0)));