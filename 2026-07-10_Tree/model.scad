// A stylized pine tree with a textured trunk.
// Generated for: 2026-07-10 | Tree

module pine_tree() {
    // Trunk
    color("Sienna")
    cylinder(h = 20, r1 = 3, r2 = 1.5, $fn = 20);
    
    // Texture on trunk (bumps)
    for (i = [0 : 5]) {
        translate([0, 0, i * 4])
        rotate([0, 0, i * 72])
        translate([1.5, 0, 0])
        sphere(r = 1, $fn = 12);
    }

    // Leaves - multiple layers of cones
    color("ForestGreen") {
        // Bottom layer
        translate([0, 0, 10])
        cylinder(h = 15, r1 = 8, r2 = 0, $fn = 12);
        
        // Middle layer
        translate([0, 0, 18])
        cylinder(h = 12, r1 = 6, r2 = 0, $fn = 10);
        
        // Top layer
        translate([0, 0, 25])
        cylinder(h = 8, r1 = 3, r2 = 0, $fn = 8);
    }
    
    // Topmost tip
    color("ForestGreen")
    translate([0, 0, 32])
    sphere(r = 1.5, $fn = 12);
}

pine_tree();
