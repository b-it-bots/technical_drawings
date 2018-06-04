// This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/.

m3_nut_height = 2.4;
m3_nut_dia = 5.8;
m3_screw_dia=3.1;


module chamfer(x,l=1000) {
    rotate([45, 0, 0])cube([l, 2*cham(x), 2*cham(x)], center=true);
}

module r(x, y, z) {
    rotate([x, y, z]) children();
}
module t(x, y, z) {
    translate([x, y, z]) children();
}
function cham(x) = sqrt(x*x*2)/2;

module m3_nut_hole(l=100) {
    module circle_outer(radius,fn){
        fudge = 1/cos(180/fn);
        circle(r=radius*fudge,$fn=fn);
    }
    union() {
        linear_extrude(height=m3_nut_height)r(0, 0, 90)circle_outer(m3_nut_dia/2, 6);
        t(-m3_nut_dia/2, -l, 0)cube([m3_nut_dia, l, m3_nut_height]);
    }
}

module cylinder_outer(height,radius,fn){
    fudge = 1/cos(180/fn);
    cylinder(h=height,r=radius*fudge,$fn=fn);
}
    
module m3_screw_hole(l=100) {
    cylinder_outer(l, m3_screw_dia/2, 12);
}