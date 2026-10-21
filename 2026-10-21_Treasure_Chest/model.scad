$fn = 32;

// Treasure Chest - Low Poly

module chest_body() {
    difference() {
        // Main box
        cube([40, 25, 25], center = true);
        
        // Hollow inside
        translate([0, 0, 2])
            cube([36, 21, 22], center = true);
    }
}

module chest_lid() {
    translate([0, 0, 12.5])
    rotate([0, 0, 0])
    difference() {
        // Arched lid shape
        translate([0, 0, 5])
        scale([1, 0.6, 0.8])
        sphere(r = 22);
        
        // Flatten bottom of lid
        translate([0, 0, -25])
        cube([50, 50, 50], center = true);
        
        // Flatten front of lid (cut off)
        translate([0, 15, 0])
        cube([50, 20, 50], center = true);
    }
}

module brass_trim() {
    // Front trim
    translate([0, -12.5, 0])
    cube([42, 2, 26], center = true);
    
    // Corner reinforcements
    for(x=[-18, 18], y=[-10.5, 10.5], z=[-11, 11]) {
        translate([x, y, z])
        cube([3, 3, 3], center = true);
    }
}

// Combine everything
union() {
    chest_body();
    chest_lid();
    brass_trim();
}
