// Suspension Bridge - miniature suspension bridge with twin pylons
// Low-poly, single connected manifold, rests on Z = 0

$fn = 32;

DECK_L = 130;          // deck length (x: -65 .. 65)
DECK_W = 22;           // deck width  (y: -11 .. 11)
DECK_T = 2.5;          // deck thickness (z: 0 .. 2.5)

PYLON_X    = 40;       // tower centre line, x = +-40
LEG_Y      = 8;        // tower legs, y = +-8 (inside the deck -> one solid)
LEG_R      = 2.0;      // tower leg radius
TOP_Z      = 32.5;     // tower saddle height
SAG        = 18;       // main span sag
HALF_SPAN  = PYLON_X;  // half of the suspended span

CABLE_R   = 0.8;       // main cable radius
HANG_R    = 0.35;      // vertical suspender radius
HANG_STEP = 10;        // node spacing on the main cable

ANCH_X = 58;           // anchorage cable end (buried in the anchorage block)
ANCH_Z = 4;

function cz(x) = TOP_Z - SAG * (1 - (x / HALF_SPAN) * (x / HALF_SPAN));

// strut between two points, extended past both ends so neighbours overlap
module strut(p1, p2, r) {
    d  = p2 - p1;
    L  = norm(d);
    ax = [-d[1], d[0], 0];
    na = norm(ax);
    translate(p1)
        rotate(a = na < 1e-6 ? 0 : acos(min(1, max(-1, d[2] / L))),
               v = na < 1e-6 ? [1, 0, 0] : ax)
            translate([0, 0, -0.8 * r])
                cylinder(r = r, h = L + 1.6 * r);
}

module deck() {
    translate([-DECK_L / 2, -DECK_W / 2, 0]) cube([DECK_L, DECK_W, DECK_T]);
    // side railings
    for (s = [1, -1])
        translate([-DECK_L / 2, s * (DECK_W / 2 - 1.0) - 0.4, DECK_T])
            cube([DECK_L, 0.8, 2.0]);
}

module tower() {
    for (sx = [1, -1], sy = [1, -1])
        translate([sx * PYLON_X, sy * LEG_Y, 0]) cylinder(r = LEG_R, h = TOP_Z + 1.5);
    // top portal beam (cable saddles)
    for (sx = [1, -1])
        translate([sx * PYLON_X - 2.2, -LEG_Y - 1, TOP_Z - 2.5]) cube([4.4, 2 * LEG_Y + 2, 3.0]);
    // lower strut
    for (sx = [1, -1])
        translate([sx * PYLON_X - 1.6, -LEG_Y, 7]) cube([3.2, 2 * LEG_Y, 2.5]);
}

module main_cable(y) {
    // suspended span: parabola over the deck
    for (i = [0 : 2 * 4 - 1])
        strut([-HALF_SPAN + i * HANG_STEP, y, cz(-HALF_SPAN + i * HANG_STEP)],
              [-HALF_SPAN + (i + 1) * HANG_STEP, y, cz(-HALF_SPAN + (i + 1) * HANG_STEP)],
              CABLE_R);
    // side spans: tower top down into the anchorage
    for (sx = [1, -1])
        strut([sx * PYLON_X, y, TOP_Z], [sx * ANCH_X, y, ANCH_Z], CABLE_R);
}

module suspenders(y) {
    for (i = [1 : 2 * 4 - 1]) {
        x = -HALF_SPAN + i * HANG_STEP;
        strut([x, y, cz(x)], [x, y, DECK_T - 0.7], HANG_R);
    }
}

module anchorages() {
    for (sx = [1, -1])
        translate([sx * (DECK_L / 2 - 10), -DECK_W / 2, 0]) cube([10, DECK_W, 5]);
}

union() {
    deck();
    tower();
    anchorages();
    for (sy = [1, -1]) {
        main_cable(sy * LEG_Y);
        suspenders(sy * LEG_Y);
    }
}
