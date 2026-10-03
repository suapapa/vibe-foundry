$fn = 32;

// Scooter Body (Main Frame)
module scooter_body() {
    union() {
        // Base/Floorboard
        translate([0, 0, 5])
        cube([30, 10, 2], center=true);
        
        // Front Shield/Leg Guard
        translate([12, 0, 12])
        rotate([0, -10, 0])
        cube([2, 12, 20], center=true);
        
        // Seat
        translate([-5, 0, 15])
        rotate([0, 10, 0])
        scale([1.5, 1, 0.5])
        cylinder(h=5, r=5, center=true);

        // Handlebars/Stem
        translate([12, 0, 15])
        cylinder(h=15, r=1.5);
        
        // Handlebars
        translate([12, 0, 28])
        rotate([0, 90, 0])
        cylinder(h=15, r=1);
        
        // Front Wheel
        translate([15, 0, 5])
        rotate([90, 0, 0])
        cylinder(h=4, r=7, center=true);
        
        // Rear Wheel
        translate([-12, 0, 5])
        rotate([90, 0, 0])
        cylinder(h=4, r=7, center=true);
        
        // Rear Stand/Support
        translate([-10, 0, 2])
        cube([2, 2, 5], center=true);
    }
}

// Mirror
module mirror() {
    translate([12, 0, 32])
    rotate([0, 180, 0])
    union() {
        // Mirror Stem
        cylinder(h=5, r=1);
        // Mirror Head
        translate([0, 0, 5])
        sphere(r=3);
    }
}

// Final Assembly
union() {
    scooter_body();
    mirror();
}
