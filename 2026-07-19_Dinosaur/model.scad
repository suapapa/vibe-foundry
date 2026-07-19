// Dinosaur (T-Rex) low-poly model
 = 20;

module dinosaur() {
    // Body
    scale([1.5, 1, 1])
    sphere(r=10);

    // Tail
    translate([-12, 0, -2])
    rotate([0, 45, 0])
    cylinder(h=15, r1=6, r2=0, center=true);

    // Neck
    translate([10, 0, 5])
    rotate([-30, 0, 0])
    cylinder(h=15, r1=4, r2=2);

    // Head
    translate([14, 0, 12])
    rotate([-10, 0, 0])
    union() {
        sphere(r=5); // Main head
        // Jaw/Snout
        translate([3, 0, -2])
        cube([6, 6, 4], center=true);
    }

    // Arms (tiny)
    translate([8, 6, -2])
    rotate([0, 90, 0])
    cylinder(h=6, r=1.5);
    
    translate([8, -6, -2])
    rotate([0, -90, 0])
    cylinder(h=6, r=1.5);

    // Legs
    translate([0, 5, -10])
    cylinder(h=10, r=2);
    
    translate([0, -5, -10])
    cylinder(h=10, r=2);
}

dinosaur();
