include <cnc_utils.scad>;


module create_tool(name="cylinder", h=10, d0=5, d1=0, a=45){
    if(name == "cylinder"){
         cylinder(h,d0/2,d0/2, center=false);
    }
    else if(name == "conic"){
        points=[
        [0,0],
        [0,h],
        [d0/2,h],
        [d0/2, tan(a)*(d0-d1)/2],
        [d1/2,0],
        [0,0]
        ];

        rotate_extrude()
            polygon(points);

    }
    else if(name == "spheric"){
        translate([0,0,d0/2])
        union(){
            cylinder(h-d0/2, d0/2, d0/2);
            sphere(d0/2);
        }
    }
    else if(name== "profile"){
        difference(){
        cylinder(h,d0/2,d0/2);
        rotate_extrude()
            translate([d0/2,0,0])
                circle((d0-d1)/2);
        }
    }
}

    
// move cut tool
module move_tool(path=[0,0,0], 
    name="cylinder", h=10, d0=5, d1=0, a=45, 
    speed=0, animate=false, show_tool_only=false){

    let($fn=show_tool_only?20:$fn){  
        if (animate == true && $t != 1 && speed != 0){
            position = position_at_time(path,speed, $t);
            if(show_tool_only==true){
                translate(position[1])
                   create_tool(name, h, d0, d1, a);
            }
            else{
                if(position[0] > 0){
                    union(){
                        hull(){
                                translate(position[1])
                                    create_tool(name, h, d0, d1, a);                       
                                translate(path[position[0]])
                                    create_tool(name, h, d0, d1, a);
                            };
                        for(i=[1:position[0]]){
                            
                            hull(){
                                translate(path[i])
                                    create_tool(name, h, d0, d1, a);
                                translate(path[i-1])
                                    create_tool(name, h, d0, d1, a);
                            }
                        }
                    }}
                else{
                    union(){
                        hull(){
                                translate(position[1])
                                    create_tool(name, h, d0, d1, a);
                                translate(path[0])
                                    create_tool(name, h, d0, d1, a);
                            };
                    }
                }
            }
        }
        else
        {
            union(){
                for(i=[1:len(path)-1]){
                    
                    hull(){
                        translate(path[i])
                            create_tool(name, h, d0, d1, a);
                        translate(path[i-1])
                            create_tool(name, h, d0, d1, a);
                    }
                }
            };
        }
    }
}

module cut(path, 
    name="cylinder", h=10, d0=5, d1=0, a=45, 
    speed=0,
    show=false,
    animate=false){
    difference(){
        children();
        move_tool(path, name, h, d0, d1, a, speed, animate);
    }
    
    if (show){
        color("red")
            //translate([0,0,tool_height/2])           
                trace_tool(path, 0.3);
        color("blue", alpha=0.2)
            move_tool(path, name, h, d0, d1, a, speed, animate, show_tool_only=true);
        
    }
}

