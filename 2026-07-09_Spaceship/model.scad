$fn = 32;

module spaceship() {
    // Main body
    hull() {
        cylinder(h = 40, r1 = 5, r2 = 10, center = true);
        translate([0, 0, -20]) cylinder(h = 20, r1 = 10, r2 = 5, center = true);
    }
    
    // Wings
    translate([0, 0, 0]) {
        rotate([90, 0, 0]) cylinder(h = 10, r = 20, center = true);
        rotate([90, 0, 90]) cylinder(h = 10, r = 20, center = true);
    }
    
    // Cockpit
    translate([10, 0, 5]) 
    sphere(r = 4);
}

spaceship();