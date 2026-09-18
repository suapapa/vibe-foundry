// Crab - a seashore crab with two prominent pincers
// Low-poly, single connected manifold, grounded at Z = 0.
$fn = 32;

color_body = [0.90, 0.24, 0.16];   // shell red
color_leg  = [0.70, 0.15, 0.11];   // darker limbs
color_claw = [1.00, 0.45, 0.22];   // bright pincers
color_eye  = [0.07, 0.07, 0.09];   // eyes

// Body shell: flattened ellipsoid, centre at Z = 18 (spans Z 8.1 .. 27.9)
module shell() {
    translate([0, 0, 18])
        scale([1.35, 1.00, 0.55])
            sphere(r = 18);
}

// Bone: round segment between two points (guarantees joints overlap)
module bone(p1, p2, r1, r2) {
    v = p2 - p1;
    L = norm(v);
    translate(p1)
        rotate([0, acos(v[2] / L), atan2(v[1], v[0])])
            cylinder(r1 = r1, r2 = r2, h = L, $fn = 12);
}

// One walking leg: hip inside the shell -> knee -> foot on the ground
module leg(sx, ay) {
    hip  = [sx * 13, ay,          14.0];
    knee = [sx * 25, ay * 1.40,    8.5];
    foot = [sx * 33, ay * 1.70,    2.402];  // flat octagon base of the $fn=8 foot lands on Z=0
    bone(hip,  knee, 3.4, 2.5);
    bone(knee, foot, 2.5, 1.7);
    translate(knee) sphere(r = 2.7, $fn = 12);
    translate(foot) sphere(r = 2.6, $fn = 8);
}

// Prominent pincer: arm from the shell front, big claw with two jaws
module pincer(sx) {
    shoulder = [sx *  7, 14, 20.0];
    elbow    = [sx * 16, 22, 18.5];
    clawc    = [sx * 19, 27, 16.0];

    bone(shoulder, elbow, 3.6, 3.0);
    bone(elbow, clawc, 3.0, 2.6);
    translate(elbow) sphere(r = 3.2, $fn = 12);

    // claw body
    translate(clawc)
        scale([0.95, 1.30, 0.85])
            sphere(r = 6.6);

    // upper + lower jaw of the pincer, bases buried in the claw body
    translate(clawc) {
        rotate([  13, 0, 0]) rotate([-90, 0, 0])
            translate([0, 0, 2]) cylinder(r1 = 3.3, r2 = 1.0, h = 13, $fn = 12);
        rotate([ -13, 0, 0]) rotate([-90, 0, 0])
            translate([0, 0, 2]) cylinder(r1 = 3.3, r2 = 1.0, h = 13, $fn = 12);
    }
}

module eyes() {
    for (sx = [-1, 1]) {
        translate([sx * 6, 8, 27.4]) sphere(r = 2.5, $fn = 12);
    }
}

color(color_leg) {
    for (sx = [-1, 1], ay = [-12, 0, 12]) leg(sx, ay);
}

color(color_body) {
    shell();
}

color(color_claw) {
    for (sx = [-1, 1]) pincer(sx);
}

color(color_eye) {
    eyes();
}
