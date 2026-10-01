$fn = 32;

module walkie_talkie() {
    // Main body
    difference() {
        cube([20, 10, 35], center = true);
        // Screen area
        translate([0, 5, 10])
            cube([16, 1, 10], center = true);
    }

    // Antenna
    translate([7, 0, 20])
        cylinder(h = 15, r1 = 1.5, r2 = 0.5);
    
    translate([7, 0, 27.5])
        sphere(r = 2);

    // Speaker grill area (simplified)
    translate([0, -5, -10])
        for (i = [-2:2]) {
            translate([0, -0.5, i])
                cube([8, 1, 0.5], center = true);
        }
        
    // Button/Control area
    translate([-5, 5, 0])
        cube([4, 1, 2], center = true);
}

walkie_talkie();
