$fn=200;



module chairbase() {
    rounding_r = 80.5;
    rounding_height = 10;
    part_x = 43;
    part_y = 125;
    part_height = 10;

        
    translate([0,-part_y/2,1]) {
        translate([-part_x/2,0,0]) cube([part_x, part_y, part_height]);
       
            intersection() {
                union() {
                    // Demi cylindre 1
                    translate([0,rounding_r-3,0]) difference() {
                    cylinder(r=rounding_r,h=rounding_height);
                    translate([-rounding_r,0,-0.5]) cube([3*rounding_r, part_y*2, part_height*2-1]);
                    }
                    // Demi cylindre 2
                    translate([0,part_y/3+6.5,0]) difference() {
                        cylinder(r=rounding_r,h=rounding_height);
                        translate([-rounding_r,-part_y*2,-0.5]) cube([3*rounding_r, part_y*2, part_height*2-1]);
                    }
                }
               translate([-part_x/2,-part_y/2-0.5,0]) cube([part_x-1, part_y*2-1, part_height]);
            }
    }
}

module chairextra() {
    part_x = 23;
    part_x_middle=33;
    ergot_x=3;
    part_y = 80;
    ergot_y=12;
    part_height=5;
    union() { 
        translate([-part_x/2, -part_y/2,0]) cube([part_x,part_y,part_height]);
       
        
        translate([-part_x_middle/2, -part_y/4,0]) cube([part_x_middle,part_y/2,part_height]);
        translate([part_x_middle/2, -ergot_y/2,0]) cube([ergot_x,ergot_y,part_height]);
    };
}

module bite() {
    cylinder(d=5, h=4);
}

module rotadapter(right) {
    part_y=133.5;
    inner_d = 70;
    part_height=10;
    
    intersection() {
        difference() {
            cylinder(d=part_y, h=part_height);
            translate([0,0,-0.5]) cylinder(d=inner_d, h=part_height+1);
            translate([20,-30,-0.5]) cube([70,130,part_height+1]);
            translate([-part_y/2-24.75,-100,-0.5]) cube([70,130,part_height+1]);
        }
        
            difference() {
                union() {
            translate([20,-40,0]) cylinder(d=65,h=part_height);
            translate([-20,40,0]) cylinder(d=65,h=part_height);
                    translate([-25,-100,-5]) cube([50,200,200]);
                }
                
            
        }
    }
}

module bigscrewholes() {
    // Screw holes
    translate([0,55,-1]) cylinder(d=7, h=20);
    translate([0,-55,-1]) cylinder(d=7, h=20);
    // Screw head holes
    translate([0,55,10]) cylinder(d=15, h=3);
    translate([0,-55,10]) cylinder(d=15, h=3);
}

module chair(right=0) {
    minusangle = (right)>0 ? -1 : 1;
    
    trou_size=3;
    trou_headsize=7;
    difference() {
        union() {
            chairbase();
            translate([0,0,10]) chairextra();
            translate([10,0,15]) bite();
            translate([0,0,10*right+1]) rotate([0,180*right,0]) rotadapter(right);
        }
        // screw holes
        translate([7,30,-1]) cylinder(d=trou_size, h=200);
        translate([-7,30,-1]) cylinder(d=trou_size, h=200);
        translate([7,-30,-1]) cylinder(d=trou_size, h=200);
        translate([-7,-30,-1]) cylinder(d=trou_size, h=200);
        // screw head holes
        translate([7,30,-1]) cylinder(d=trou_headsize, h=7);
        translate([-7,30,-1]) cylinder(d=trou_headsize, h=7);
        translate([7,-30,-1]) cylinder(d=trou_headsize, h=7);
        translate([-7,-30,-1]) cylinder(d=trou_headsize, h=7);
        // screw head holes
        translate([7,30,5]) cylinder(d1=trou_headsize, d2=trou_size, h=3);
        translate([-7,30,5]) cylinder(d1=trou_headsize, d2=trou_size, h=3);
        translate([7,-30,5]) cylinder(d1=trou_headsize, d2=trou_size, h=3);
        translate([-7,-30,5]) cylinder(d1=trou_headsize, d2=trou_size, h=3);
        
        
        // Accoudoir holes
        bigscrewholes();
        for (rot =[0:minusangle*5:minusangle*45])
        rotate(a=[0,0,rot]) union() {
            bigscrewholes();
        }
    }
}

module accoudoir(explode) {
    part_x = 90;
    part_y = 250;
    part_z = 30;
    
    trou_x = 50;
    trou_y = 145;
    trou_z = 10;
    translate([0,0,explode]) difference() {
        // masse
        translate([-part_x/2, -part_y/2,0]) cube([part_x, part_y, part_z]);
        // trou
        translate([-trou_x/2,-trou_y/2,-1]) cube([trou_x,trou_y,trou_z]);
        
        // trou de vis
        translate([0,-55,-1]) cylinder(d=5, h=20);
        translate([0,55,-1]) cylinder(d=5, h=20);
    }
}


//color("#9090FF") accoudoir(20);
rotate([0,0,180]) chair();

translate([120,0,0]) chair(right=1);
//machin();
//TODO: arrondir le extra (pas l'ergot)
