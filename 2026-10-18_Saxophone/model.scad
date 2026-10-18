$fn = 32;

// Saxophone body
module saxophone_body() {
    rotate([0, 90, 0])
    difference() {
        union() {
            // Main curved tube (simplified as a bent cylinder/union of segments)
            translate([0, 0, 0])
            cylinder(h = 40, r = 3);
            
            translate([0, 0, 35])
            rotate([0, 45, 0])
            cylinder(h = 20, r = 3);
            
            translate([10, 0, 50])
            rotate([0, -45, 0])
            cylinder(h = 15, r = 3);
        }
        // Hollow out the tube
        union() {
            translate([0, 0, -1])
            cylinder(h = 42, r = 2.2);
            
            translate([0, 0, 36])
            rotate([0, 45, 0])
            cylinder(h = 22, r = 2.2);
            
            translate([10, 0, 51])
            rotate([0, -45, 0])
            cylinder(h = 17, r = 2.2);
        }
    }
}

// Bell
module bell() {
    translate([18, 0, 60])
    rotate([0, -45, 0])
    difference() {
        cylinder(h = 15, r1 = 3, r2 = 10);
        translate([0, 0, -1])
        cylinder(h = 17, r1 = 2.5, r2 = 9);
    }
}

// Keys (simple spheres/cylinders)
module keys() {
    for (i = [0 : 5]) {
        translate([2, 0, 5 + i * 6])
        sphere(r = 1.5);
        
        translate([2, 0, 5 + i * 6])
        cylinder(h = 2, r = 1);
    }
}

// Mouthpiece
module mouthpiece() {
    translate([-2, 0, 0])
    rotate([0, 90, 0])
    cylinder(h = 8, r = 3);
}

// Combine everything
union() {
    saxophone_body();
    bell();
    keys();
    mouthpiece();
}
