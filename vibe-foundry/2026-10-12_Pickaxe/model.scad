$fn = 32;

// Low-poly mining pickaxe: wooden handle + double-ended steel pick head.
// Single connected manifold via union of primitives.

union() {
    // Handle (slightly tilted for a natural grip look)
    rotate([0, 8, 0])
        cylinder(h = 34, r = 2, center = false);

    // Head hub where the pick crosses the handle
    translate([0, 0, 34])
        rotate([0, 90, 0])
            cylinder(h = 6, r = 3.5, center = true);

    // Right pick arm (tapering outward)
    translate([1, 0, 34])
        rotate([0, 90, 0])
            cylinder(h = 14, r1 = 2.6, r2 = 1.2, center = false);

    // Right pick tip
    translate([15, 0, 34])
        rotate([0, 90, 0])
            cylinder(h = 8, r1 = 1.2, r2 = 0.2, center = false);

    // Left pick arm
    translate([-1, 0, 34])
        rotate([0, 90, 0])
            cylinder(h = 14, r1 = 2.6, r2 = 1.2, center = false);

    // Left pick tip
    translate([-15, 0, 34])
        rotate([0, 90, 0])
            cylinder(h = 8, r1 = 1.2, r2 = 0.2, center = false);

    // Handle butt cap
    translate([0, 0, 0])
        sphere(r = 2.2);
}
