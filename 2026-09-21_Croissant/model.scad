$fn = 32;

// Croissant: curved crescent pastry tube + buttery layered ridge rings
T_MAX   = 105;   // half sweep of the crescent (deg)
R_ARC   = 55;    // radius of the crescent centreline
R_TUBE  = 20;    // tube radius at the belly
ARCH_Z  = 7;     // how much the belly rises above the tips
SEG     = 26;    // spheres used to build the curved body
RIDGE_N = 9;     // number of ridge rings
RIDGE_H = 2.6;   // ridge ring thickness
RIDGE_E = 0.13;  // ridge protrusion (fraction of local tube radius)

// centreline of the crescent: arc in XY, belly lifted in Z
function tpos(a) = [R_ARC * sin(a), R_ARC * cos(a) - R_ARC,
                    ARCH_Z * (1 - (a / T_MAX) * (a / T_MAX))];

// tube radius: fat belly, tapered points
function trad(a) = R_TUBE * (0.15 + 0.85 * cos(80 * abs(a) / T_MAX));

union() {
    // ---- crescent body: overlapping spheres along the arc ----
    for (i = [0 : SEG]) {
        a = -T_MAX + 2 * T_MAX * i / SEG;
        p = tpos(a);
        translate(p) sphere(r = trad(a));
    }

    // ---- buttery layered ridge rings, perpendicular to the tube ----
    for (i = [0 : RIDGE_N - 1]) {
        a = -T_MAX + (2 * T_MAX / RIDGE_N) * (i + 0.5);
        p = tpos(a);
        translate(p)
            rotate([0, 0, 90 - a])
                rotate([90, 0, 0])
                    cylinder(r = trad(a) * (1 + RIDGE_E),
                             h = RIDGE_H, center = true);
    }
}
