$fn = 32;

// Game Controller Body
module body() {
    hull() {
        translate([-30, -15, 0]) cube([60, 30, 10], center=true);
        translate([-35, 0, 0]) sphere(r=12);
        translate([35, 0, 0]) sphere(r=12);
    }
}

// Thumbsticks
module thumbstick(x, y) {
    translate([x, y, 10]) {
        cylinder(h=5, r=8); // Base
        translate([0, 0, 5]) cylinder(h=10, r=5); // Stick
    }
}

// Shoulder Buttons (L/R)
module shoulder_buttons() {
    translate([-25, 0, 15]) rotate([0, 90, 0]) cylinder(h=10, r=4);
    translate([25, 0, 15]) rotate([0, 90, 0]) cylinder(h=10, r=4);
}

// D-Pad
module dpad() {
    translate([-20, 0, 10]) {
        cube([12, 4, 4], center=true); // Horiz
        cube([4, 12, 4], center=true); // Vert
    }
}

// Main Assembly
union() {
    body();
    thumbstick(-15, -5);
    thumbstick(15, -5);
    thumbstick(-15, 5);
    thumbstick(15, 5);
    dpad();
    shoulder_buttons();
}
