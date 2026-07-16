// Dragon Model
module dragon_body() {
    sphere(r=15);
}

module dragon_neck() {
    translate([10, 0, 10])
    rotate([0, 45, 0])
    cylinder(h=20, r1=8, r2=4);
}

module dragon_head() {
    translate([25, 0, 25])
    sphere(r=6);
}

module dragon_wings() {
    // Left wing
    translate([0, 10, 5])
    rotate([0, -30, -45])
    scale([2, 1, 0.1])
    sphere(r=10);
    
    // Right wing
    translate([0, -10, 5])
    rotate([0, -30, 45])
    scale([2, 1, 0.1])
    sphere(r=10);
}

module dragon_tail() {
    translate([-15, 0, -5])
    rotate([0, 90, 0])
    cylinder(h=30, r1=5, r2=1);
}

module dragon_legs() {
    // Front legs
    translate([5, 8, -10])
    cylinder(h=10, r=3);
    translate([5, -8, -10])
    cylinder(h=10, r=3);
    
    // Back legs
    translate([-10, 8, -10])
    cylinder(h=10, r=3);
    translate([-10, -8, -10])
    cylinder(h=10, r=3);
}

module dragon() {
    union() {
        dragon_body();
        dragon_neck();
        dragon_head();
        dragon_wings();
        dragon_tail();
        dragon_legs();
    }
}

dragon();
