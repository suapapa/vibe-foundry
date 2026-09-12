$fn = 32;

// ---- Parameters ----
BASE    = 80;    // base slab span
BASE_H  = 3;     // base slab height
SPAN    = 52;    // tower center-to-center span
WALL_T  = 6;     // curtain wall thickness
WALL_H  = 19;    // curtain wall height (top at Z=19)
TOW_R   = 9;     // corner tower radius
TOW_H   = 32;    // corner tower shaft top
ROOF_H  = 12;    // conical roof height
KEEP_W  = 20;    // keep footprint
KEEP_H  = 27;    // keep top

stone  = [0.72, 0.70, 0.66];
roof_c = [0.55, 0.18, 0.16];
wood   = [0.35, 0.22, 0.12];

/* Base slab: the model touches Z = 0 here ------------------------------- */
color(stone)
    translate([-BASE/2, -BASE/2, 0]) cube([BASE, BASE, BASE_H]);

/* Corner tower ----------------------------------------------------------- */
module tower() {
    // shaft: bottom sunk 2 units into the slab (z 1..32)
    cylinder(r = TOW_R, h = TOW_H);
    // crown ring
    translate([0, 0, TOW_H - 2]) cylinder(r = TOW_R + 1.5, h = 3.5);
    // 8 merlons on the crown, sunk 2.5 units into the ring (45-degree steps)
    for (a = [0 : 45 : 315])
        rotate([0, 0, a])
            translate([TOW_R + 0.25, -1.1, TOW_H - 1])
                cube([2.4, 2.2, 4]);
}

/* Conical spire sunk 3 units into the shaft ------------------------------ */
module tower_roof() {
    translate([0, 0, TOW_H - 3])
        cylinder(r1 = TOW_R + 1.5, r2 = 0, h = ROOF_H);
    // finial ball on the spire tip
    translate([0, 0, TOW_H - 3 + ROOF_H]) sphere(r = 1.5);
}

/* Curtain wall along X, centered in X/Y, merlons embedded 4 units -------- */
module wall(len) {
    // NOTE: explicit corners (this wasm build ignores vector center=)
    translate([-len/2, -WALL_T/2, 0]) cube([len, WALL_T, WALL_H]);
    // 4 merlons per wall, step = 13; deeper than the wall in Y so no faces coincide
    for (cx = [-19.5, -6.5, 6.5, 19.5])
        translate([cx - 3.25, -WALL_T/2 + 1, WALL_H - 4])
            cube([6.5, WALL_T - 2, 5]);
}

/* Keep: box + crown + merlons + pyramid roof + flag ---------------------- */
module keep() {
    translate([-KEEP_W/2, -KEEP_W/2, 0]) cube([KEEP_W, KEEP_W, KEEP_H]);
    // crown slab wider than the box
    translate([-KEEP_W/2 - 1, -KEEP_W/2 - 1, KEEP_H - 3])
        cube([KEEP_W + 2, KEEP_W + 2, 4]);
    // merlons around the crown, sunk 2.5 units into the slab
    for (mx = [-8, 0, 8]) {
        translate([mx - 1.5,  9.5, KEEP_H - 2.5]) cube([3, 3, 4]);
        translate([mx - 1.5, -12.5, KEEP_H - 2.5]) cube([3, 3, 4]);
    }
    for (my = [-6.5, 0, 6.5]) {
        translate([ 9.5, my - 1.5, KEEP_H - 2.5]) cube([3, 3, 4]);
        translate([-12.5, my - 1.5, KEEP_H - 2.5]) cube([3, 3, 4]);
    }
    // pyramid roof (4-sided cone) sunk 3 units into the crown
    translate([0, 0, KEEP_H - 3])
        rotate([0, 0, 45])
            cylinder(r1 = KEEP_W * 0.78, r2 = 0, h = 9, $fn = 4);
    // flag pole starting deep inside the keep box, past the pyramid apex
    translate([0, 0, KEEP_H - 6]) cylinder(r = 0.5, h = 13);
    // flag starts inside the pole
    translate([0.2, 0, KEEP_H + 4]) cube([4.5, 0.4, 2]);
}

/* Assembly --------------------------------------------------------------- */
Z0 = 1; // everything rises from z=1, i.e. 2 units inside the slab (top at 3)

color(stone) {
    // four corner towers
    for (dx = [-1, 1], dy = [-1, 1])
        translate([dx * SPAN / 2, dy * SPAN / 2, Z0]) tower();

    // curtain walls (N/S along X, E/W via 90-degree rotation)
    translate([0,  SPAN / 2, Z0]) wall(SPAN);
    translate([0, -SPAN / 2, Z0]) wall(SPAN);
    rotate([0, 0, 90]) {
        translate([0,  SPAN / 2, Z0]) wall(SPAN);
        translate([0, -SPAN / 2, Z0]) wall(SPAN);
    }

    // central keep
    translate([0, 0, Z0]) keep();
}

color(roof_c) {
    for (dx = [-1, 1], dy = [-1, 1])
        translate([dx * SPAN / 2, dy * SPAN / 2, Z0]) tower_roof();
}

// gate door: protrudes 1 unit past the wall face, buried 5 units inside it
color(wood)
    translate([-5, -SPAN / 2 - 4, Z0]) cube([10, 6, 14]);
