$fn = 32;

// Ice Cream Cone: waffle cone + ice cream scoop + cherry
cone_h     = 60;   // cone height
cone_bot_r = 2;    // tip radius
cone_top_r = 12;   // opening radius
scoop_r    = 14;   // scoop radius
scoop_z    = cone_h + 7;
cherry_r   = 3.5;

union() {
    // waffle cone (tapered frustum, tip at the bottom)
    translate([0, 0, 2])
        cylinder(r1 = cone_bot_r, r2 = cone_top_r, h = cone_h - 2);

    // rolled rim band at the cone opening
    translate([0, 0, cone_h - 3])
        cylinder(r = cone_top_r + 0.6, h = 3);

    // ice cream scoop
    translate([0, 0, scoop_z])
        sphere(r = scoop_r);

    // cherry on top
    translate([0, 0, scoop_z + scoop_r - 5])
        sphere(r = cherry_r);
}
