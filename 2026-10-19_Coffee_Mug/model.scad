$fn = 32;

// Coffee Mug
module mug_body() {
    cylinder(h = 40, r = 15);
}

module mug_rim() {
    translate([0, 0, 40])
    cylinder(h = 2, r = 16);
}

module mug_handle() {
    translate([15, 0, 20])
    rotate([0, 90, 0])
    rotate_extrude(convexity = 10)
    translate([8, 0, 0])
    circle(r = 3);
}

union() {
    mug_body();
    mug_rim();
    mug_handle();
}
