// This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/.

include <misc.scad>
include <base.scad>

camera_height=24.5;
camera_depth=34.5;
camera_width=25;
camera_wallt=4;
camera_cable_dia=5;
camera_bp_height = 2.4;
camera_bp_depth = 16;
camera_bp_width = 19;
camera_bp_pos = 9.5;
camera_inner_cham = 1;
camera_outer_cham = 2;
camera_screw_pos = camera_width/2-5;
camera_screw_dia=m3_screw_dia;
camera_screw_top_wallt = 6;
camera_screw_top_depth = 8;
camera_front_notch_depth = 1;
camera_front_notch_width = 10;
camera_front_notch_cham = 1;
camera_nut_pos=1.2;
camera_cable_dia=6;

mount_angle = -10;

mount_dist = 18;
mount_depth = base_screw_ydist-m3_screw_dia-2;
mount_width = camera_width;

text_size = 7.5;
text_height = 1;
text = "b-it-bots";
text_font = "helvetica:style=Bold";


_camera_front_notch_cham_tmp = sqrt(camera_front_notch_cham*camera_front_notch_cham*2)/2;

r(0, 90, 0)
full();
//camera_mount();
module full() {
    union() {
r(-mount_angle, 0, 0) t(0, 0, mount_dist/2) camera_mount();
t(0, 0, -base_height-mount_dist/2)base();

r(0, 90, 0)t(0, 0, -mount_width/2)cylinder(h=mount_width, r=mount_depth/2, $fn=32);
t(-mount_width/2, -mount_depth/2, -mount_dist/2)cube([mount_width, mount_depth, mount_dist/2]);
r(-mount_angle, 0, 0) t(-mount_width/2, -mount_depth/2, 0)cube([mount_width, mount_depth, mount_dist/2]);
    }
}

module camera_back_notch() {
    difference() {
        t(0, -camera_screw_top_depth, 0)cube([camera_width/2, camera_screw_top_depth, camera_screw_top_wallt]);
        t(0, 0, camera_screw_top_wallt)r(45+90, 0, 0)t(-camera_width/4, -5, 0)cube([camera_width, 10, cham(camera_screw_top_wallt-camera_wallt)]);
    }
}
module camera_mount() {
    difference() {
    union() {
    camera_mount_half();
    mirror([1, 0, 0])camera_mount_half();
    }
t(-camera_cable_dia/2, -(camera_wallt+camera_depth+camera_screw_top_depth)/2-0.1, camera_wallt)cube([camera_cable_dia, camera_screw_top_depth+0.1, camera_screw_top_wallt-camera_wallt-0.4]);
  t(0, 0, camera_wallt*2 + camera_height-text_height)r(0, 0, 90)linear_extrude(height = text_height+1) text(text,font = text_font, size=text_size, halign="center", valign="center", center=true);
}
}
module camera_mount_half() {
    t(0, camera_screw_top_depth-(camera_screw_top_depth+camera_depth+camera_wallt)/2, 0)
    difference() {
        union() {
    difference() {
    cube([camera_width/2, camera_depth+camera_wallt, camera_height+2*camera_wallt]);
    t(-camera_width/4, -1, camera_wallt) cube([camera_width, camera_depth+1, camera_height]);
        t(-1, camera_bp_pos, camera_wallt-camera_bp_height)cube([camera_bp_width/2+1, camera_bp_depth, camera_bp_height+1]);
    }
    t(0, camera_depth-camera_front_notch_depth, camera_wallt) difference() {
cube([camera_front_notch_width/2, camera_front_notch_depth, camera_height]);
t(camera_front_notch_width/2, 0, 0)r(0, 0, 45)t(-5, 0, 0) cube([10, _camera_front_notch_cham_tmp, camera_height]);
}
camera_back_notch();
t(0, 0, camera_screw_top_wallt+camera_height+2*camera_wallt-camera_screw_top_wallt)mirror([0, 0, 1])camera_back_notch();
t(camera_width/4, camera_depth, camera_wallt)chamfer(camera_inner_cham, camera_width/2);
t(camera_width/4, camera_depth, camera_wallt+camera_height)chamfer(camera_inner_cham, camera_width/2);
}
t(camera_screw_pos, -camera_screw_top_depth/2, -camera_height/2)m3_screw_hole();
t(camera_screw_pos, -camera_screw_top_depth/2, camera_nut_pos)m3_nut_hole();

t(0, camera_depth+camera_wallt, camera_height + 2*camera_wallt)chamfer(camera_outer_cham);
t(0, camera_depth+camera_wallt, 0)chamfer(camera_outer_cham);
t(0, -camera_screw_top_depth, 0)chamfer(camera_outer_cham);
t(0, -camera_screw_top_depth, camera_height + 2*camera_wallt)chamfer(camera_outer_cham);


t(camera_width/2, camera_depth+camera_wallt, 0)r(0, 90, 0)chamfer(camera_outer_cham);
t(camera_width/2, -camera_screw_top_depth, 0)r(0, 90, 0)chamfer(camera_outer_cham);

difference() {
t(camera_width/2, 0, 0)r(0, 0, 90)chamfer(camera_outer_cham);
    t(camera_width/2, -camera_screw_top_depth+(camera_depth+camera_wallt+camera_screw_top_depth)/2, 0)r(0, 0, 90)chamfer(camera_outer_cham, mount_depth);
}
t(camera_width/2, 0, camera_height + 2*camera_wallt)r(0, 0, 90)chamfer(camera_outer_cham);
}
}




