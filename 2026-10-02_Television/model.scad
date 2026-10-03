$fn = 32;

union() {
    // TV Cabinet
    cube([60, 45, 40], center=true);
    
    // Screen Area (Front Plate)
    translate([0, -22.5, 5])
        cube([52, 5, 32], center=true);
    
    // Antenna Left
    translate([-15, 10, 20]) {
        sphere(r=4);
        rotate([0, -20, 0])
            cylinder(h=30, r=1.5);
    }
    
    // Antenna Right
    translate([15, 10, 20]) {
        sphere(r=4);
        rotate([0, 20, 0])
            cylinder(h=30, r=1.5);
    }
    
    // Stand
    translate([0, 0, -20])
        cylinder(h=5, r1=15, r2=5);
        
    // Knobs
    translate([-20, -22.5, -5])
        cylinder(h=5, r=3);
    translate([-10, -22.5, -5])
        cylinder(h=5, r=3);
}
