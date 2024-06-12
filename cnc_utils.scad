module line(start, end, thickness = 1) {
    hull() {
        translate(start) sphere(thickness, $fn=10);
        translate(end) sphere(thickness, $fn=10);
    }
}

module trace_tool(points, thickness=1){
    for(i=[0:len(points)-2])
        line(points[i], points[i+1], thickness);
}

// Function to calculate distance between two points
function distance(p1, p2) = 
    sqrt(pow(p2[0] - p1[0],2) +
        pow(p2[1] - p1[1],2) + 
        pow(p2[2] - p1[2], 2));

function sum(v, i = 0, r = 0) = i < len(v) ? sum(v, i + 1, r + v[i]) : r;
function reverse_sum(v, i = 0, r = 0) =  i >= 0 ? reverse_sum(v, i - 1, r + v[i]) : r;

function calculate_distances(points) = let(
        numPoints = len(points),
        distances = [for (i = [0 : numPoints - 2]) distance(points[i], points[i + 1])]
    )
    distances;

function cumulative_distances(distances) = 
    let(
        numPoints = len(distances),
        cum_distances = [for (i = [-1 : numPoints - 1]) i<0?0:(distances[i] + reverse_sum(distances, i-1))]
    )
    cum_distances;
 
function partial(list,start,end) = [for (i = [start:end]) list[i]];
    
function first(v) = 
    len(v) == 0 ? undef : v[0] != undef ? v[0] : first(partial(v, 1, len(v)-1));
        
// Calculate the position of the object at a given time.
function position_at_time(points, speed, time) =
    let(
        distances = calculate_distances(points),
        cum_distances = cumulative_distances(distances),   
        total_time = cum_distances[len(cum_distances) - 1]/speed,
        total_distance = speed * total_time * (time>1?1:time),

        position = 
        [for (i=[0: len(cum_distances) - 2]) 
            (cum_distances[i] <= total_distance) && (total_distance < cum_distances[i+1])?
                    let(
                    segment_start = points[i],
                    segment_end = points[i + 1],
                    segment_distance = distances[i],
                    distance_into_segment = total_distance - cum_distances[i],
                    t = distance_into_segment / segment_distance
                    )
                    
                    [i, segment_start + t * (segment_end - segment_start)]
                    :undef]
        )
   
    first(position);  


/*
        points=[[0,0,0],[10,0,0],[20,0,0],[40,0,0]];
//
        echo(position_at_time(points, 1,0));


path=[
[0,0,0],
[0,100,5],
[10,120,1],
[10,130,10],
[50,130,10],
[50,180,10]
];        
echo(position_at_time(path, 1,.10));*/