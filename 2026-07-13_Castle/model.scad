module castle() {
    // Base/Foundation
    cube([60, 60, 10], center=true);
    
    // Main Keep/Central Tower
    translate([0, 0, 25])
    cylinder(h=40, r=15, $fn=32);
    
    // Battlements on Main Keep
    translate([0, 0, 45])
    cylinder(h=5, r=17, $fn=32);
    
    // Side Towers
    for (i = [0, 1, 2, 3]) {
        rotate([0, 0, i * 90])
        translate([25, 25, 15])
        union() {
            cylinder(h=30, r=8, $fn=20);
            translate([0, 0, 30])
            cylinder(h=10, r=10, $fn=20);
        }
    }
    
    // Walls
    difference() {
        cube([50, 50, 20], center=true);
        cube([45, 45, 25], center=true);
        // Inner hollow for courtyard
        cube([30, 30, 30], center=true);
    }
    
    // Gate
    translate([0, -30, 5])
    cube([15, 10, 15], center=true);
}

castle();
