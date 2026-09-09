$fn = 32;

// ---- Parameters ----
BR_R    = 2.5;        // branch radius
BR_LEN  = 56;         // branch length (along X)
BODY    = [8, 6, 7.2]; // body ellipsoid semi-axes (x, y, z)
BODY_C  = [0, 0, 13.5]; // body center
HEAD_R  = 4.5;        // head radius
HEAD_C  = [7.5, 0, 18]; // head center
TAIL_A  = 30;         // tail tilt from vertical (degrees, leaning -X)
TAIL_L  = 12;         // tail length

module branch() {
    // horizontal branch along X resting on the ground (bottom at Z = 0)
    translate([0, 0, BR_R])
        rotate([0, 90, 0])
            cylinder(h = BR_LEN, r = BR_R, center = true);
    // small stub branch for character (tilts up, base inside the branch)
    translate([BR_LEN/2 - 12, 0, BR_R])
        rotate([0, -55, 0])
            cylinder(h = 8, r = 1.3);
}

module body() {
    translate(BODY_C) scale(BODY) sphere(r = 1);
}

module head() {
    translate(HEAD_C) sphere(r = HEAD_R);
}

module beak() {
    // cone pointing +X, base buried in the head
    translate([HEAD_C[0] + HEAD_R - 1, 0, HEAD_C[2] + 0.6])
        rotate([0, 90, 0])
            cylinder(h = 4.5, r1 = 1.5, r2 = 0.15);
}

module tail() {
    // cone sweeping up and back (-X), base inside the body
    translate([BODY_C[0] - 3, 0, BODY_C[2] + 1])
        rotate([0, -TAIL_A, 0])
            cylinder(h = TAIL_L, r1 = 2.6, r2 = 0.35);
}

module wing(side) {
    // flattened ellipsoid glued to each flank
    translate([BODY_C[0] - 0.5, side * 5.0, BODY_C[2] - 0.5])
        scale([5.5, 1.2, 4.2]) sphere(r = 1);
}

module eye(side) {
    translate([HEAD_C[0] + 3.2, side * 2.4, HEAD_C[2] + 1.4])
        sphere(r = 0.9);
}

module leg(side) {
    // legs from body down into the branch (z 3..7.5 overlaps both)
    translate([1.5, side * 1.8, 3.0])
        cylinder(h = 4.5, r = 0.8);
    // tiny foot gripping the branch
    translate([2.4, side * 1.8, 4.4])
        rotate([0, 90, 0])
            cylinder(h = 2.4, r = 0.5);
}

// ---- Assembly (single connected union) ----
union() {
    branch();
    body();
    head();
    beak();
    tail();
    wing(1);
    wing(-1);
    eye(1);
    eye(-1);
    leg(1);
    leg(-1);
}
