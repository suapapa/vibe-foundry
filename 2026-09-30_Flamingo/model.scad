$fn = 32;

module flamingo() {
    // Body
    translate([0, 0, 15])
    scale([1.2, 1, 0.8])
    sphere(r=8);

    // Neck
    translate([5, 0, 20])
    rotate([0, -20, 0])
    cylinder(h=15, r1=3, r2=1.5);
    
    translate([10, 0, 32])
    rotate([0, 45, 0])
    cylinder(h=5, r1=1.5, r2=1);

    // Head
    translate([13, 0, 36])
    sphere(r=3);

    // Beak
    translate([15, 0, 36])
    rotate([0, 90, 0])
    cylinder(h=4, r1=1.5, r2=0);

    // Leg
    translate([0, 0, 15])
    rotate([0, 170, 0])
    cylinder(h=15, r=1);
    
    // Foot
    translate([0, 0, 0])
    cylinder(h=1, r=3);
}

flamingo();
