// Unicorn for 2026-07-23
$fn = 20;

module unicorn() {
    // Body
    color("white")
    hull() {
        translate([0, 0, 0]) sphere(r=10);
        translate([20, 0, 0]) sphere(r=10);
    }

    // Neck
    color("white")
    translate([18, 0, 5])
    rotate([0, -30, 0])
    cylinder(h=15, r1=8, r2=5);

    // Head
    color("white")
    translate([25, 0, 15])
    rotate([0, -40, 0])
    union() {
        sphere(r=7);
        // Snout
        translate([6, 0, -2])
        sphere(r=4);
    }

    // Horn
    color("gold")
    translate([28, 0, 22])
    rotate([0, -40, 0])
    cylinder(h=12, r1=1, r2=0.1);

    // Legs
    module leg() {
        cylinder(h=12, r=2);
    }

    color("white") {
        translate([5, 7, -12]) leg();
        translate([5, -7, -12]) leg();
        translate([15, 7, -12]) leg();
        translate([15, -7, -12]) leg();
    }

    // Tail
    color("white")
    translate([-5, 0, 5])
    rotate([0, 45, 0])
    cylinder(h=10, r=2);
}

unicorn();