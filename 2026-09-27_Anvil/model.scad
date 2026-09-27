// Anvil - heavy blacksmith's anvil on a sturdy pedestal
// Low-poly, single connected manifold, rests on Z = 0

$fn = 32;

// ---- pedestal (stepped block, centred slightly toward the horn) ----
FOOT   = [96, 52,  8];
PLINTH = [78, 42, 10];
COLUMN = [60, 34, 17];
CAP    = [70, 40,  6];

// ---- anvil ----
SOLE_W  = 62;  SOLE_D  = 36;  SOLE_H  = 8;   // anvil base plate
WAIST_W = 34;  WAIST_D = 22;  WAIST_H = 17;  // narrow waist
HEAD_W  = 56;  HEAD_D  = 26;  HEAD_H  = 11;  // body
FACE_W  = 60;  FACE_D  = 28;  FACE_H  = 5;   // hardened top face
HEEL_W  = 10;                                // heel overhang (-x)

HORN_R1 = 7;   HORN_R2 = 1.4; HORN_L = 28;   // horn (+x), cone along +x

module pedestal() {
    translate([-43, -26,  0]) cube([FOOT[0],   FOOT[1],   FOOT[2]]);
    translate([-34, -21,  7]) cube([PLINTH[0], PLINTH[1], PLINTH[2]]);
    translate([-25, -17, 16]) cube([COLUMN[0], COLUMN[1], COLUMN[2]]);
    translate([-30, -20, 32]) cube([CAP[0],    CAP[1],    CAP[2]]);
}

module anvil() {
    // base plate, waist, body, face
    translate([-29, -18, 37]) cube([SOLE_W,  SOLE_D,  SOLE_H]);
    translate([-15, -11, 44]) cube([WAIST_W, WAIST_D, WAIST_H]);
    translate([-26, -13, 60]) cube([HEAD_W,  HEAD_D,  HEAD_H]);
    translate([-28, -14, 70]) cube([FACE_W,  FACE_D,  FACE_H]);
    // heel (+ step block under it)
    translate([-36, -13, 60]) cube([HEEL_W, HEAD_D, HEAD_H]);
    translate([-36, -10, 51]) cube([HEEL_W, 20, 10]);
    // horn
    translate([24, 0, 67.5]) rotate([0, 90, 0])
        cylinder(r1 = HORN_R1, r2 = HORN_R2, h = HORN_L);
}

union() {
    pedestal();
    anvil();
}
