// A stylized pine tree with a textured trunk.
// Generated for: 2026-07-11 Tree

module pine_tree() {
    // Trunk
    color("Sienna") {
        cylinder(h=15, r1=3, r2=2, $fn=20);
        // Texture detail for trunk
        for (i = [0 : 4]) {
            translate([0, 0, i * 3.5])
            rotate([45, i * 90, 30])
            cylinder(h=2, r=1, $fn=6);
        }
    }

    // Foliage - Layer 1 (Bottom)
    color("ForestGreen") {
        translate([0, 0, 10])
        cylinder(h=1, r1=8, r2=2, $fn=12);
        
        translate([0, 0, 12])
        cylinder(h=1, r1=7, r2=1, $fn=12);
        
        translate([0, 0, 14])
        cylinder(h=1, r1=6, r2=0.5, $fn=12);
    }
    
    // Foliage - Layer 2 (Middle)
    color("DarkGreen") {
        translate([0, 0, 16])
        cylinder(h=1, r1=5, r2=1, $fn=12);
        
        translate([0, 0, 18])
        cylinder(h=1, r1=4, r2=0.5, $fn=12);
    }
    
    // Foliage - Layer 3 (Top)
    color("Green") {
        translate([0, 0, 20])
        sphere(r=3, $fn=12);
    }
}

pine_tree();
