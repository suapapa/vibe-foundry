$fn = 32;

// Bed Frame
difference() {
    cube([60, 100, 15], center = true);
    translate([0, 0, 5])
        cube([56, 96, 15], center = true);
}

// Mattress
translate([0, 0, 8])
    cube([58, 98, 8], center = true);

// Pillows
translate([0, 35, 15])
    rotate([0, 10, 0])
    cube([45, 25, 5], center = true);

translate([0, 35, 15])
    rotate([0, -10, 0])
    cube([45, 25, 5], center = true);

// Blanket (Folded)
translate([0, 0, 12])
    cube([56, 90, 4], center = true);
