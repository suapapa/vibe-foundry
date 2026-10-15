$fn = 32;

union() {
    // Spiral candy part
    for (a = [0 : 45 : 360]) {
        rotate([0, 0, a])
        translate([6, 0, 0])
        sphere(r = 7);
    }
    
    // Stick
    translate([0, 0, -30])
    cylinder(h = 40, r = 2);
}
