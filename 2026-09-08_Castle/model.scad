$fn = 32;

// ---- Parameters ----
W       = 64;         // curtain wall span (center-to-center)
WT      = 6;          // wall thickness
WH      = 20;         // wall height
MERLON_H= 4;          // battlement merlon height
TOW_R   = 9;          // corner tower radius
TOW_H   = 34;         // corner tower shaft height
KEEP_W  = 22;         // keep footprint
KEEP_H  = 30;         // keep height

module battlement(side_len, thick, z, span) {
    // row of merlons along X, centered, at height z
    n = floor(side_len / 8);
    step = side_len / n;
    for (i = [0 : n - 1]) {
        translate([-side_len/2 + step*(i+0.5), 0, z])
            cube([step*0.55, thick, MERLON_H], center=true);
    }
}

module corner_tower(x, y) {
    union() {
        // shaft
        translate([x, y, TOW_H/2])
            cylinder(h = TOW_H, r = TOW_R, center=true);
        // battlement collar
        translate([x, y, TOW_H + 1.5])
            cylinder(h = 3, r1 = TOW_R + 1.5, r2 = TOW_R + 1, center=true);
        for (a = [0 : 45 : 315]) {
            rotate([0, 0, a]) translate([x, y, TOW_H + 4])
                translate([TOW_R + 0.5, 0, 0])
                    cube([2.5, 2.5, 4], center=true);
        }
        // conical spire
        translate([x, y, TOW_H + 6])
            cylinder(h = 14, r1 = TOW_R + 1.5, r2 = 0, center=true);
        // spire finial
        translate([x, y, TOW_H + 21])
            sphere(r = 1.6);
    }
}

module gatehouse() {
    union() {
        // gate block spanning the front gap
        translate([0, -W/2, 14])
            cube([26, WT + 2, 28], center=true);
        // two round turrets flanking the gate
        translate([-13, -W/2, 17]) cylinder(h = 34, r = 5, center=true);
        translate([ 13, -W/2, 17]) cylinder(h = 34, r = 5, center=true);
        translate([-13, -W/2, 36]) cylinder(h = 8, r1 = 5.5, r2 = 0, center=true);
        translate([ 13, -W/2, 36]) cylinder(h = 8, r1 = 5.5, r2 = 0, center=true);
        // merlons on gatehouse roof
        for (mx = [-10 : 5 : 10])
            translate([mx, -W/2, 29]) cube([3, WT + 2, 4], center=true);
    }
    // NOTE: gate opening is implied visually by dark recess block below;
    // we carve a real doorway with the difference() in main().
}

module castle_solid() {
    union() {
        // Rock plinth
        translate([0, 0, 3])
            scale([1, 1, 0.5]) sphere(r = 56);
        translate([0, 0, 6.5])
            cube([W + 24, W + 24, 3], center=true);

        // Curtain walls (front wall split for the gate)
        translate([-W/4 - 13, W/2, 6 + WH/2]) cube([W/2 + WT, WT, WH], center=true);
        translate([ W/4 + 13, W/2, 6 + WH/2]) cube([W/2 + WT, WT, WH], center=true);
        translate([0,  W/2, 6 + WH/2]) cube([WT, W + WT, WH], center=true);
        translate([0, -W/2, 6 + WH/2]) cube([W + WT, WT, WH], center=true);

        // Walkway coping on top of walls
        translate([0,  W/2, 6 + WH + 1]) cube([WT + 4, W + WT + 4, 2], center=true);
        translate([0, -W/2, 6 + WH + 1]) cube([W + WT + 4, WT + 4, 2], center=true);
        translate([-W/2, 0, 6 + WH + 1]) cube([WT + 4, W + WT + 4, 2], center=true);
        translate([ W/2, 0, 6 + WH + 1]) cube([WT + 4, W + WT + 4, 2], center=true);

        // Merlons
        translate([0,  W/2, 6 + WH + 4]) battlement(W + WT, WT, 0, W);
        translate([0, -W/2, 6 + WH + 4]) battlement(W + WT, WT, 0, W);
        rotate([0, 0, 90])
            translate([0, W/2, 6 + WH + 4]) battlement(W + WT, WT, 0, W);
        rotate([0, 0, 90])
            translate([0, -W/2, 6 + WH + 4]) battlement(W + WT, WT, 0, W);

        // Corner towers
        corner_tower(-W/2, -W/2);
        corner_tower( W/2, -W/2);
        corner_tower(-W/2,  W/2);
        corner_tower( W/2,  W/2);

        // Gatehouse on the front (-Y)
        gatehouse();

        // Central keep
        translate([0, 4, 6 + KEEP_H/2])
            cube([KEEP_W, KEEP_W, KEEP_H], center=true);
        translate([0, 4, 6 + KEEP_H + 1.5])
            cube([KEEP_W + 4, KEEP_W + 4, 3], center=true);
        for (mx = [-KEEP_W/2 : 6 : KEEP_W/2]) {
            translate([mx, 4 + KEEP_W/2 + 1, 6 + KEEP_H + 4.5])
                cube([3, 4, 5], center=true);
            translate([mx, 4 - KEEP_W/2 - 1, 6 + KEEP_H + 4.5])
                cube([3, 4, 5], center=true);
        }
        for (my = [-KEEP_W/2 + 6 : 6 : KEEP_W/2 - 6]) {
            translate([KEEP_W/2 + 1, 4 + my, 6 + KEEP_H + 4.5])
                cube([4, 3, 5], center=true);
            translate([-KEEP_W/2 - 1, 4 + my, 6 + KEEP_H + 4.5])
                cube([4, 3, 5], center=true);
        }
        // keep roof tower
        translate([0, 4, 6 + KEEP_H + 12])
            cylinder(h = 16, r1 = 8, r2 = 0, center=true);
        translate([0, 4, 6 + KEEP_H + 21])
            sphere(r = 1.8);

        // Banner pole on the keep
        translate([0, 4, 6 + KEEP_H + 22.5])
            cylinder(h = 10, r = 0.5, center=true);
    }
}

// Carve the gate doorway through the front wall + gatehouse
difference() {
    castle_solid();
    translate([0, -W/2, 6 + 7])
        cube([10, WT + 8, 14], center=true);
}
