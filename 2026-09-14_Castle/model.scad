$fn = 32;

// ---- parameters ----------------------------------------------------------
BASE_H   = 3;    // rock slab height (model touches Z = 0)
FOOT     = 76;   // outer footprint of the curtain-wall square
WT       = 5;    // wall thickness
WH       = 16;   // wall top height
TOW_R    = 8.5;  // corner tower radius
TOW_H    = 33;   // corner tower shaft top
RING_H   = 36;   // tower crown ring top
CONE_B   = 10.4; // cone base radius
CONE_TOP = 42;   // cone apex height
KEEP_W   = 20;   // keep footprint width
KEEP_H   = 29;   // keep body top
BAND_H   = 31;   // keep parapet band top
ARCH_R   = 4.5;  // gate arch radius
ARCH_Z   = 6;    // arch axis height (arch sinks into slab)

stone  = [0.72, 0.70, 0.66];
roof_c = [0.50, 0.16, 0.14];
wood   = [0.35, 0.22, 0.12];
flag   = [0.85, 0.72, 0.15];

// ---- rock slab (everything sinks into this, bottom at Z = 0) -------------
color(stone)
    translate([-FOOT/2 - 3, -FOOT/2 - 3, 0])
        cube([FOOT + 6, FOOT + 6, BASE_H]);

// ---- one curtain wall side (front, +Y outer face) ------------------------
module wall_side() {
    // body: from x -FOOT/2..FOOT/2, inner face flush with footprint edge
    translate([-FOOT/2, FOOT/2 - WT, 0])
        cube([FOOT, WT, WH]);
    // merlons on the wall top, sunk 1 unit into it
    for (mx = [-FOOT/2 + 13, -FOOT/2 + 21.667, FOOT/2 - 21.667, FOOT/2 - 13])
        translate([mx - 1.4, FOOT/2 - 4, WH - 1])
            cube([2.8, 4, 2.6]);
}

// ---- corner tower --------------------------------------------------------
module tower() {
    // shaft starts at z = 1 (sunk into slab)
    cylinder(r = TOW_R, h = TOW_H - 1);
    // crown ring, bottom sunk 2 into the shaft
    translate([0, 0, TOW_H - 2]) cylinder(r = TOW_R + 1.4, h = RING_H - (TOW_H - 2));
    // 8 merlons on the crown, sunk 1.5 into the ring
    for (a = [0 : 45 : 315])
        rotate([0, 0, a])
            translate([-(TOW_R + 0.9), -1.1, RING_H - 1.5])
                cube([2.2, 2.2, 2.4]);
    // conical roof, base sunk 2 into the ring
    translate([0, 0, RING_H - 2])
        cylinder(h = CONE_TOP - (RING_H - 2), r1 = CONE_B, r2 = 0.4);
}

// ---- central keep --------------------------------------------------------
module keep() {
    // body starts at z = 1 (sunk into slab)
    translate([-KEEP_W/2, -KEEP_W/2, 1])
        cube([KEEP_W, KEEP_W, KEEP_H - 1]);
    // parapet band, bottom sunk 2 into the body
    translate([-KEEP_W/2 - 1.5, -KEEP_W/2 - 1.5, KEEP_H - 2])
        cube([KEEP_W + 3, KEEP_W + 3, BAND_H - (KEEP_H - 2)]);
    // 5 merlons per side on the band, sunk 1 into it
    for (kx = [-11.25, -5.625, 0, 5.625, 11.25]) {
        translate([kx - 1.4, -KEEP_W/2 - 2.6, BAND_H - 1]) cube([2.8, 3.2, 2.6]);
        translate([kx - 1.4,  KEEP_W/2 - 0.6, BAND_H - 1]) cube([2.8, 3.2, 2.6]);
        translate([-KEEP_W/2 - 2.6, kx - 1.4, BAND_H - 1]) cube([3.2, 2.8, 2.6]);
        translate([ KEEP_W/2 - 0.6, kx - 1.4, BAND_H - 1]) cube([3.2, 2.8, 2.6]);
    }
    // roof peak (wide low cone, sunk 1 into the band)
    translate([0, 0, BAND_H - 1])
        cylinder(h = 9, r1 = KEEP_W * 0.66, r2 = 0.5);
}

// ---- gate arch cutter (round-topped tunnel through front wall) -----------
module arch_cut() {
    // cutter spans y = 32..39 (wall is 33..38); rotX(+90) extrudes toward -Y
    translate([0, FOOT/2 + 1, ARCH_Z])
        rotate([90, 0, 0])
            cylinder(h = WT + 1, r = ARCH_R);
    translate([-ARCH_R, FOOT/2 - WT - 1, 0])
        cube([ARCH_R * 2, WT + 2, ARCH_Z + 0.001]);
}

// ---- wooden door set into the front wall above the arch ------------------
module door() {
    translate([-3.2, FOOT/2 - 1, 8]) cube([6.4, 1.6, 8.5]);
    for (dx = [-2.1, 0, 2.1])
        translate([dx - 0.35, FOOT/2 - 1.4, 8.6]) cube([0.7, 2.2, 7.5]);
}

// ---- assembly ------------------------------------------------------------
difference() {
    union() {
        color(stone) {
            for (rz = [0, 90, 180, 270])
                rotate([0, 0, rz]) wall_side();
            for (sx = [-1, 1], sy = [-1, 1])
                translate([sx * (FOOT/2 - WT/2), sy * (FOOT/2 - WT/2), 0])
                    tower();
            keep();
        }
        // red conical tower roofs (same placement as tower() cones)
        color(roof_c)
            for (sx = [-1, 1], sy = [-1, 1])
                translate([sx * (FOOT/2 - WT/2), sy * (FOOT/2 - WT/2), 0])
                    translate([0, 0, RING_H - 2])
                        cylinder(h = CONE_TOP - (RING_H - 2), r1 = CONE_B, r2 = 0.4);
        color(wood) door();
        // gold flag poles + pennants (bases sunk into cones / keep roof peak)
        color(flag) {
            for (sx = [-1, 1], sy = [-1, 1])
                translate([sx * (FOOT/2 - WT/2), sy * (FOOT/2 - WT/2), 0]) {
                    translate([0, 0, CONE_TOP - 2]) cylinder(h = 8, r = 0.35);
                    translate([0.2, 0, CONE_TOP + 3.2]) cube([0.3, 4, 2.4]);
                    translate([0.2, 0, CONE_TOP + 0.4]) cube([0.3, 3.2, 2.0]);
                }
            translate([0, 0, BAND_H + 6]) cylinder(h = 14, r = 0.45);
            translate([0.3, 0, BAND_H + 14.5]) cube([0.35, 6.5, 3.4]);
            translate([0.3, 0, BAND_H + 10.5]) cube([0.35, 5.2, 3.0]);
        }
    }
    arch_cut();
}
