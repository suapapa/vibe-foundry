// Retro Rocket Design
$fn = 32;

module rocket() {
    // Main Body
    cylinder(h = 40, r = 10, center = true);
    
    // Nose Cone
    translate([0, 0, 20])
    sphere(r = 10);
    
    // Fins
    for (r = [0, 120, 240]) {
        rotate([0, 0, r])
        translate([10, 0, -15])
        cube([15, 5, 2]);
    }
    
    // Window
    rotate([0, 90, 0])
    cylinder(h = 2, r = 3, center = true);
}

// Combine components
union() {
    rocket();
    // Add a small base ring for stability
    translate([0,0,-20])
    cylinder(h = 2, r = 12, center = true);
}
