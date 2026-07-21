// Dragon Model
$fn = 20;

module dragon() {
    // Body
    color("forestgreen")
    scale([1.5, 0.8, 0.8])
    sphere(r=10);

    // Neck
    translate([10, 0, 5])
    rotate([0, -30, 0])
    cylinder(h=15, r1=5, r2=3);

    // Head
    translate([15, 0, 15])
    rotate([0, 45, 0])
    union() {
        sphere(r=5);
        // Snout
        translate([5, 0, -2])
        cylinder(h=8, r1=3, r2=1);
    }

    // Tail
    for (i = [0 : 10]) {
        translate([(-10 - i*5), 0, -2 - i*2])
        rotate([0, -20, 0])
        sphere(r=4 - i*0.3);
    }

    // Wings
    // Left Wing
    translate([0, 10, 0])
    rotate([-20, -45, 0])
    scale([2, 0.1, 1])
    sphere(r=12);

    // Right Wing
    translate([0, -10, 0])
    rotate([-20, 45, 0])
    scale([2, 0.1, 1])
    sphere(r=12);
    
    // Legs
    // Front Left
    translate([5, 7, -5])
    cylinder(h=10, r=2);
    // Front Right
    translate([5, -7, -5])
    cylinder(h=10, r=2);
    // Back Left
    translate([-8, 7, -5])
    cylinder(h=10, r=2);
    // Back Right
    translate([-8, -7, -5])
    cylinder(h=10, r=2);
}

dragon();
