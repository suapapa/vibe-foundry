$fn = 32;

// Seat
cylinder(h=5, r=20);

// Legs
for (angle = [0, 120, 240]) {
    rotate([0, 0, angle])
    translate([12, 0, -15])
    cylinder(h=15, r=3);
}
