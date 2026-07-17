// Rocket Model
// A classic retro-style rocket ship.

module rocket_body() {
    cylinder(h = 20, r1 = 4, r2 = 5);
}

module nose_cone() {
    translate([0, 0, 20])
    sphere(r = 5);
}

module fins() {
    for (i = [0 : 3]) {
        rotate([0, 0, i * 90])
        translate([4, -0.5, 0])
        cube([5, 1, 5]);
    }
}

module engine() {
    translate([0, 0, -2])
    cylinder(h = 2, r1 = 6, r2 = 4);
}

module window() {
    translate([0, 0, 12])
    cylinder(h = 1, r = 2);
}

union() {
    rocket_body();
    nose_cone();
    fins();
    engine();
    translate([0, 0, 12])
    cylinder(h = 1, r = 2); // simplified window
}
