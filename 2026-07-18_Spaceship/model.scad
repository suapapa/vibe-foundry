// Futuristic Spaceship
module spaceship() {
    // Central Body
    rotate([0, 90, 0])
    cylinder(h=30, r1=6, r2=2, center=true, $fn=20);

    // Cockpit
    translate([12, 0, 4])
    sphere(r=3, $fn=12);

    // Nose
    translate([15, 0, 0])
    sphere(r=5, $fn=10);

    // Tail
    translate([-15, 0, 0])
    rotate([0, 90, 0])
    cylinder(h=10, r1=4, r2=1, center=true, $fn=10);

    // Wings
    translate([0, 10, 0])
    rotate([0, 90, 0])
    cylinder(h=15, r=2, center=true, $fn=10);

    translate([0, -10, 0])
    rotate([0, 90, 0])
    cylinder(h=15, r=2, center=true, $fn=10);
}

union() {
    spaceship();
}
