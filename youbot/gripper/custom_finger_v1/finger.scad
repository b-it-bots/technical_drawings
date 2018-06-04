// This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/.

width=30;
length=73;
thick=20;
t=0.4*6;
socket_height=9;
hole_dia=3.9;
hole_dist=15;
top_dia=5;
steps=5;
extra = thick/2;

module finger() {
    difference() {
        linear_extrude(height=thick+extra) difference() {
            hull() {
                t(-width/2, 0, 0) square([width, socket_height]);
                t(0, length-top_dia/2, 0) circle(d=top_dia, $fn=32);
            }
            difference() {
                polygon([[width/2-t, socket_height],
                         [-width/2+t, socket_height],
                         [0, length-top_dia/2]]);
                _start=socket_height;
                _end=length-top_dia/2;
                _step_size=(_end-_start)/(steps+1);
                for(i = [1 : steps]) {
                    t(-width/2, -t/2 + _start + i*_step_size, 0) square([width, t]);
                }
            }
            t(-hole_dist/2, socket_height/2, 0)circle(d=hole_dia, $fn=32);
            t( hole_dist/2, socket_height/2, 0)circle(d=hole_dia, $fn=32);
        }
        if(extra > 0) {
            rad=105.5;
            _eff = length - socket_height;
            union() {
                t(-width/2-1, -1, thick)cube([width+2, socket_height+1, extra]);
                intersection() {
                    t(-width/2, socket_height, thick) cube([width, _eff/2, extra]);
                    t(0, socket_height, thick + rad)r(0, 90, 0)cylinder(r=rad,h=width*1.1, center=true, $fn=128);
                }
                difference() {
                    t(-width/2, socket_height + _eff/2, thick) cube([width, _eff/2, extra]);
                    t(0, length, thick+extra - rad)r(0, 90, 0)cylinder(r=rad,h=width*1.1, center=true, $fn=128);
                }
            }
        }
    }
}

t(-width/2, 0, 0) finger();
t(width/2, length, 0)r(0, 0, 180) finger();

module r(x, y, z) {
    rotate([x, y, z]) children();
}
module t(x, y, z) {
    translate([x, y, z]) children();
}