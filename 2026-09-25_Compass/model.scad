// Compass - brass pocket compass with a directional needle
// Low-poly, single connected manifold, rests on Z = 0

$fn = 32;

CASE_R  = 30.0;   // outer radius of the brass case
CASE_H  = 10.0;   // case height (z 0..10)
WALL_T  = 3.0;    // side wall thickness
FLOOR_H = 2.5;    // solid bottom plate thickness
INNER_R = CASE_R - WALL_T;  // 27.0 inner cavity radius

FACE_R  = INNER_R + 0.2;    // 27.2 dial/glass disc, sinks 0.2 into the wall
FACE_Z0 = 8.5;              // disc bottom
FACE_H  = 1.0;              // disc thickness (top at z = 9.5)

NEEDLE_L = 20.0;            // needle half length
NEEDLE_T = 8.8;             // needle centre height (sinks into the dial disc)

module case_body() {
    difference() {
        cylinder(r = CASE_R, h = CASE_H);
        translate([0, 0, FLOOR_H]) cylinder(r = INNER_R, h = CASE_H);
    }
}

module dial() {
    // flat face disc that closes the top of the case
    translate([0, 0, FACE_Z0]) cylinder(r = FACE_R, h = FACE_H);
}

module needle() {
    // north half - points +Y
    translate([0, 0, NEEDLE_T])
        rotate([-90, 0, 0])
            scale([1, 0.45, 1])
                cylinder(r1 = 2.3, r2 = 0.2, h = NEEDLE_L);
    // south half - points -Y
    translate([0, 0, NEEDLE_T])
        rotate([90, 0, 0])
            scale([1, 0.45, 1])
                cylinder(r1 = 2.3, r2 = 0.2, h = NEEDLE_L);
    // centre hub / pivot cap
    translate([0, 0, FACE_Z0]) cylinder(r = 2.8, h = 3.0);
}

module ticks() {
    // four diagonal dial marks, sunk 0.3 into the face disc
    for (a = [45 : 90 : 315]) {
        rotate([0, 0, a])
            translate([18.2, -0.8, FACE_Z0 + 0.7])
                cube([1.6, 1.6, 1.2]);
    }
}

module bail() {
    // flat lug reaching out of the case
    translate([-4, 26, 2]) cube([8, 9, 6]);
    // chain ring, overlapping the lug by 3 units
    difference() {
        translate([0, 38, 1]) cylinder(r = 6, h = 6);
        translate([0, 38, 0]) cylinder(r = 2.5, h = 8);
    }
}

union() {
    case_body();
    dial();
    needle();
    ticks();
    bail();
}
