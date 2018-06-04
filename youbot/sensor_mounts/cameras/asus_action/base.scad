// This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/.

include <misc.scad>

base_screw_dia=m3_screw_dia;
base_screw_xdist = 16;
base_screw_ydist = 24;
base_x = 25;
base_y = 36;
base_height = m3_nut_height + 2*2.4;
base_chamfer=2;

mount_depth = base_screw_ydist-m3_screw_dia-2;

_base_screwx = (base_x-base_screw_xdist)/2;
_base_screwy = (base_y-base_screw_ydist)/2;

module helper(x, y, ang=0) {
    t(x, y, -m3_nut_height/2+base_height/2) r(0, 0, ang){
    m3_nut_hole();
    t(0, 0, -50)m3_screw_hole();
}
}

module base() {
t(-base_x/2, -base_y/2, 0)
difference() {
cube([base_x, base_y, base_height]);
helper(_base_screwx, _base_screwy);
helper(base_x-_base_screwx, _base_screwy);
helper(_base_screwx, base_y-_base_screwy, 180);
helper(base_x-_base_screwx, base_y-_base_screwy, 180);
    
t(0, 0, base_height)chamfer(base_chamfer);
t(0, base_y, base_height)chamfer(base_chamfer);
difference() {
    t(0, 0, base_height)r(0, 0, 90)chamfer(base_chamfer);
    t(0, base_y/2, base_height)r(0, 0, 90)chamfer(base_chamfer, mount_depth);
}

difference() {
    t(base_x, 0, base_height)r(0, 0, 90)chamfer(base_chamfer);
    t(base_x, base_y/2, base_height)r(0, 0, 90)chamfer(base_chamfer, mount_depth);
}
    
r(0, 90, 0)chamfer(base_chamfer);
t(base_x, 0, 0)r(0, 90, 0)chamfer(base_chamfer);
t(0, base_y, 0)r(0, 90, 0)chamfer(base_chamfer);
t(base_x, base_y, 0)r(0, 90, 0)chamfer(base_chamfer);
}
}

