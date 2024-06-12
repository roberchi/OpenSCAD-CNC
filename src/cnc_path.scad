// This is a library of functions to create paths in 3D space
// The functions are used to create paths for the extrusion of 3D shapes

// The functions are:
// start(x,y,z) - creates a path starting at the given point
// move_by(by, path) - moves the path by the given vector or scalar
// move_to(to, path) - moves the path to the given point
// up(to, path) - moves the path up the cutting tool by the given amount
// down(to, path) - moves the path down the cutting tool by the given amount
// circolar_move(radius, dir="right", arc=360, path) - creates a circular path segment ($fn is used to determine the number of segments, default is 10)

// The path is a list of points [[x,y,z], [x,y,z], ...]
function start(x,y,z) = [[x,y,z]];

// move by a vector or scalar
// arguments: 
// by - the value to move to, use [x,y,z] or [x,y] or [x] or [undef, y, z] or [undef, y] or other combinations or a scalar to continue in the same direction, this needs at least two points in the path
// path - the current path
function move_by(by, path) = 
        is_list(by) ? // vector
        let(
            last = path[len(path)-1])
            concat(path, 
                [[
                    by[0] != undef? by[0] + last[0] : last[0],
                    len(by) >= 2 ? by[1] != undef? by[1] + last[1] : last[1] : last[1],
                    len(by) == 3 ? by[2] != undef? by[2] + last[2] : last[2] : last[2]
                ]]
            )
        : // by is a scalar
        len(path) > 1 ? 
            let(
                last = path[len(path)-1],
                prev = path[len(path)-2],
                v = [last[0] - prev[0], last[1] - prev[1], last[2] - prev[2]],
                l = sqrt(v[0]*v[0] + v[1]*v[1] + v[2]*v[2]),
                n = [v[0] / l, v[1] / l, v[2] / l]
            )
            concat(path, 
                [[
                    last[0] + n[0] * by,
                    last[1] + n[1] * by,
                    last[2] + n[2] * by
                ]]
            )
        :
            path; // do nothing if path is empty or has only one point 

// move to a point
// arguments: 
// to - the point to move to, use [x,y,z] or [x,y] or [x] or [undef, y, z] or [undef, y] or other combinations
// path - the current path
function move_to(to, path) = 
    let(last = path[len(path)-1])
    concat(path, 
    [[
        to[0] != undef? to[0] : last[1],
        len(to) >= 2 ? to[1] != undef? to[1] : last[1] : last[1],
        len(to) == 3 ? to[2] != undef? to[2] : last[2] : last[2]
    ]]
    );

function up(to, path) = let(
last = path[len(path)-1])
    concat(path, 
    [[
        last[0],
        last[1],
        to
    ]]
    );    

function down(to, path) = let(
last = path[len(path)-1])
    concat(path, 
    [[
        last[0],
        last[1],
        -to
    ]]
    ); 
 
// create a circular path segment
// arguments:
// radius - the radius of the circle
// normal - the normal to the plane of the circle, if not provided it is calculated from the last two points in the path
// dir - the direction of the circle, "right" or "r" for clockwise, "left" or "l" for counter clockwise
// arc - the angle of the arc in degrees
// path - the current path, at least one points and normal is needed or two points in the path 
function circolar_move(radius, normal=undef, dir="right", arc=360, path) = 
        let(
            steps = $fn == 0 ? 10 : $fn,
            // get last segment
            p0 = path[len(path)-2],
            p1 = path[len(path)-1],
            // calculate the normal to the plane
            n = is_undef(normal) ? [p1[0] - p0[0], p1[1] - p0[1]] : normal,
            // normalize normal
            nn = [n[0] / sqrt(n[0] * n[0] + n[1] * n[1]), n[1] / sqrt(n[0] * n[0] + n[1] * n[1])],
            // calculate the center of the circle based on direction
            c = dir == "right" || dir == "r" ? [p1[0] + nn[1]*radius, p1[1] - nn[0]*radius] : [p1[0] - nn[1]*radius, p1[1] + nn[0]*radius],
            arc = dir == "right" || dir == "r" ? -arc : arc,
            // vector from center to p1
            v = [p1[0] - c[0], p1[1] - c[1]],
            // rotate vector to create arc segments 
            segments =  [
                for (a = [0 : steps]) 
                    [
                        c[0] + v[0] * cos(a * arc / steps) - v[1] * sin(a * arc / steps), 
                        c[1] + v[0] * sin(a * arc / steps) + v[1] * cos(a * arc / steps), 
                        p1[2]
                    ]
                ] 
            )
           
    concat(path,segments);

