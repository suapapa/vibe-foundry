$fn = 32;

// ---- Parameters ----
HULL   = [14, 5.5, 3];   // hull ellipsoid semi-axes (x, y, z)
HULL_C = [0, 0, 3];      // hull center (bottom touches Z = 0)
MAST_X = -2;             // mast position along X
MAST_BOT = 3;            // mast base (buried inside hull)
MAST_TOP = 32;           // mast top
BOOM_Z = 8;              // boom / sail base height

module hull() {
    translate(HULL_C) scale(HULL) sphere(r = 1);
}

module cabin() {
    // small cabin box on the deck, centered near midship
    translate([-1, -2.5, 4.5]) cube([6, 5, 2.5], center = true);
}

module mast() {
    // vertical mast, base buried in the hull interior
    translate([MAST_X, 0, MAST_BOT])
        cylinder(h = MAST_TOP - MAST_BOT, r = 0.6);
}

module boom() {
    // horizontal spar along +X at sail base height
    translate([MAST_X, 0, BOOM_Z])
        rotate([0, 90, 0])
            cylinder(h = 8, r = 0.35);
}

module sail() {
    // triangular sail: tall cone (r2 -> 0) flattened thin in Y,
    // apex merges into the mast near the top
    translate([MAST_X, 0, BOOM_Z])
        scale([1, 0.1, 1])
            cylinder(h = 22, r1 = 8, r2 = 0.25);
}

module sailboat() {
    color("saddlebrown") hull();
    color("floralwhite") cabin();
    color("peru") mast();
    color("peru") boom();
    color("whitesmoke") sail();
}

sailboat();
