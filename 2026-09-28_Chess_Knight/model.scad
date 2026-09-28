$fn = 32;

// Chess Knight - Low Poly Horse Head
module chess_knight() {
    union() {
        // Base / Neck
        cylinder(h = 15, r1 = 12, r2 = 10);
        
        // Main Head Mass
        translate([0, 0, 15])
        scale([1, 1.2, 0.8])
        sphere(r = 10);
        
        // Snout
        translate([0, 8, 20])
        rotate([0, -20, 0])
        scale([1, 1.5, 0.8])
        sphere(r = 7);
        
        // Ears
        translate([4, 0, 28])
        rotate([0, -30, 0])
        cylinder(h = 8, r1 = 3, r2 = 1);
        
        translate([-4, 0, 28])
        rotate([0, 30, 0])
        cylinder(h = 8, r1 = 3, r2 = 1);
        
        // Eyes (indented)
        translate([4, 7, 23])
        sphere(r = 2);
        
        translate([-4, 7, 23])
        sphere(r = 2);
        
        // Mane/Back of head detail
        translate([0, -8, 20])
        scale([0.8, 0.5, 1])
        cylinder(h = 10, r = 6);
    }
}

chess_knight();
