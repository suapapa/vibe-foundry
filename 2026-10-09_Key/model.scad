$fn = 32;

// Simplified Skeleton Key

// 1. Shaft
cylinder(h = 60, r = 2, center = true);

// 2. Bow (Simple ring)
translate([0, 0, 30])
difference() {
    cylinder(h = 6, r = 10, center = true);
    cylinder(h = 8, r = 7, center = true);
}

// 3. Bit
translate([0, -2, -20])
difference() {
    cube([6, 8, 6], center = true);
    translate([2, 2, 0]) cube([4, 4, 8], center = true);
}

// 4. Simple Ball Decoration
translate([0, 0, 15]) sphere(r = 3);
translate([0, 0, -15]) sphere(r = 3);
