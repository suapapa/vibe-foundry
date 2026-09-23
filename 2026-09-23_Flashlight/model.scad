// Flashlight - heavy-duty cylindrical flashlight with a bezel
// Low-poly, single connected manifold (no internal cavities), rests on Z=0

$fn = 32;

module body() {
    translate([0, 0, 0]) cylinder(r = 17, h = 12);      // tail cap (z 0..12)
    translate([0, 0, 10]) cylinder(r = 15, h = 72);     // main barrel (z 10..82)
    // grip rings, sunk into the barrel
    translate([0, 0, 20]) cylinder(r = 16.2, h = 4);
    translate([0, 0, 32]) cylinder(r = 16.2, h = 4);
    translate([0, 0, 44]) cylinder(r = 16.2, h = 4);
    // switch button on the +X side, sunk 1 unit into the barrel
    translate([14, 0, 58]) rotate([0, 90, 0]) cylinder(r = 4, h = 4);
}

module head() {
    translate([0, 0, 80]) cylinder(r1 = 15, r2 = 22, h = 20);  // flare (z 80..100)
    translate([0, 0, 98]) cylinder(r = 22, h = 26);            // head barrel (z 98..124)
    translate([0, 0, 122]) cylinder(r = 23, h = 6);            // bezel ring (z 122..128)
}

module flashlight() {
    difference() {
        union() {
            body();
            head();
        }
        // open stepped bore: both cuts reach the top face, so no enclosed void
        translate([0, 0, 122]) cylinder(r = 21, h = 7);   // mouth opening, 2 unit rim
        translate([0, 0, 114]) cylinder(r = 17, h = 9);   // reflector throat
    }
}

flashlight();
