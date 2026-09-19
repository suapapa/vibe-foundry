// Bathtub - a vintage clawfoot bathtub
// Low-poly, single connected manifold, grounded at Z = 0.
$fn = 32;

color_shell = [0.94, 0.94, 0.91];   // porcelain white
color_rim   = [0.86, 0.87, 0.85];   // rolled rim
color_leg   = [0.55, 0.36, 0.20];   // cast-iron leg
color_claw  = [0.82, 0.64, 0.34];   // polished bronze claws

// ---------------------------------------------------------------
// Proportions (model sits on Z = 0)
//   Outer hull : ellipsoid centre Z=24, semi-axes (25.6, 16.0, 13.6)
//   Cavity     : ellipsoid centre Z=26, semi-axes (22.0, 13.8, 12.8)
//   The cavity pierces the hull just below its crown, so the basin
//   stays open on top with a thin edge at Z ~ 34 -> oval opening
//   about 17.3 x 10.9.
// ---------------------------------------------------------------
OUTER_C = [0, 0, 24];
OUTER_S = [1.600, 1.000, 0.850];   // x sphere(r = 16)
CAV_C   = [0, 0, 26];
CAV_S   = [1.375, 0.860, 0.799];   // x sphere(r = 16)

// rolled rim riding the basin edge
RIM_Z  = 34.0;
RIM_RX = 17.3;
RIM_RY = 10.85;
RIM_R  = 2.0;

// claw feet anchors (sunk into the thick underside of the basin)
FOOT_X = 12.0;
FOOT_Y =  7.0;

module ellipsoid(c, s) {
    translate(c) scale(s) sphere(r = 16);
}

// basin = solid hull with the inner cavity carved out (open top)
module basin() {
    difference() {
        ellipsoid(OUTER_C, OUTER_S);
        ellipsoid(CAV_C,   CAV_S);
    }
}

// rolled rim: closed loop of overlapping spheres along the basin edge
module rim() {
    n = 32;
    for (i = [0 : n - 1]) {
        a = i * 360 / n;
        translate([RIM_RX * cos(a), RIM_RY * sin(a), RIM_Z])
            sphere(r = RIM_R, $fn = 12);
    }
}

// round tapered segment between two points (claws, joints)
module spike(p1, p2, r1, r2) {
    v = p2 - p1;
    vlen = norm(v);
    translate(p1)
        rotate([0, acos(v[2] / vlen), atan2(v[1], v[0])])
            cylinder(r1 = r1, r2 = r2, h = vlen, $fn = 8);
}

// one claw foot: ankle column + flat pad on the bed + 3 talons
module foot(sx, sy) {
    px = sx * FOOT_X;
    py = sy * FOOT_Y;

    // ankle: buried ~5 units up inside the basin underside, down to the pad
    translate([px, py, 2.2])
        cylinder(r1 = 2.9, r2 = 1.8, h = 15.8);

    // cast-iron pad: flat bottom sits exactly on the bed (Z = 0)
    translate([px, py, 0])
        cylinder(r1 = 4.2, r2 = 3.1, h = 2.9);

    // three talons fanning outward, tips hovering just above the ground
    d  = [sx, sy * 0.80];
    dl = norm(d);
    for (k = [-1, 0, 1]) {
        t  = 32 * k;
        ux = (d[0] * cos(t) - d[1] * sin(t)) / dl;
        uy = (d[0] * sin(t) + d[1] * cos(t)) / dl;
        base = [px + ux * 1.9, py + uy * 1.9, 2.40];
        tip  = [px + ux * 6.2, py + uy * 6.2, 0.75];
        spike(base, tip, 1.15, 0.10);
    }
}

color(color_shell) {
    basin();
}

color(color_rim) {
    rim();
}

color(color_leg) {
    for (sx = [-1, 1], sy = [-1, 1])
        translate([sx * FOOT_X, sy * FOOT_Y, 2.2])
            cylinder(r1 = 2.9, r2 = 1.8, h = 15.8);
    for (sx = [-1, 1], sy = [-1, 1])
        translate([sx * FOOT_X, sy * FOOT_Y, 0])
            cylinder(r1 = 4.2, r2 = 3.1, h = 2.9);
}

color(color_claw) {
    for (sx = [-1, 1], sy = [-1, 1]) {
        px = sx * FOOT_X;
        py = sy * FOOT_Y;
        d  = [sx, sy * 0.80];
        dl = norm(d);
        for (k = [-1, 0, 1]) {
            t  = 32 * k;
            ux = (d[0] * cos(t) - d[1] * sin(t)) / dl;
            uy = (d[0] * sin(t) + d[1] * cos(t)) / dl;
            spike([px + ux * 1.9, py + uy * 1.9, 2.40],
                  [px + ux * 6.2, py + uy * 6.2, 0.75], 1.15, 0.10);
        }
    }
}
