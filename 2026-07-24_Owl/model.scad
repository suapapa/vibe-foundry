// Low-Poly Wise Owl
// Date: 2026-07-24

// Palette
color_body = [0.45, 0.32, 0.23];       // Warm brown body
color_chest = [0.90, 0.85, 0.75];      // Cream chest feathers
color_eye_white = [0.98, 0.98, 0.98];  // White eye ring
color_eye_iris = [0.95, 0.70, 0.10];   // Gold iris
color_eye_pupil = [0.10, 0.10, 0.12];  // Dark pupil
color_beak = [0.95, 0.55, 0.10];       // Orange beak/feet
color_wing = [0.35, 0.24, 0.16];       // Darker brown wing
color_tuft = [0.30, 0.20, 0.12];       // Ear tufts

$fn = 8; // Low-poly aesthetic

module owl_foot() {
    color(color_beak) {
        for (a = [-20, 0, 20]) {
            rotate([0, 0, a])
            translate([0, 6, 2])
            rotate([15, 0, 0])
            cylinder(r1=2.5, r2=1, h=12, center=false, $fn=5);
        }
    }
}

module owl_body() {
    // Feet
    translate([-10, 0, 0]) owl_foot();
    translate([10, 0, 0]) owl_foot();

    // Main Body
    color(color_body) {
        translate([0, 0, 18])
        scale([1, 0.85, 1.2])
        sphere(r=18, $fn=7);
    }

    // Chest feathers
    color(color_chest) {
        translate([0, 6, 18])
        scale([0.7, 0.5, 0.9])
        sphere(r=16, $fn=7);
    }

    // Wings
    for (side = [-1, 1]) {
        color(color_wing) {
            translate([side * 16, -2, 18])
            rotate([side * 15, -side * 10, -side * 10])
            scale([0.4, 0.8, 1.3])
            sphere(r=15, $fn=6);
        }
    }
}

module owl_head() {
    // Head base
    color(color_body) {
        translate([0, 0, 38])
        scale([1, 0.9, 0.85])
        sphere(r=16, $fn=8);
    }

    // Facial disc / eye region
    color(color_chest) {
        translate([0, 8, 38])
        scale([1.1, 0.3, 0.8])
        sphere(r=13, $fn=8);
    }

    // Ear tufts / feather horns
    for (side = [-1, 1]) {
        color(color_tuft) {
            translate([side * 9, 2, 48])
            rotate([-10, side * 20, 0])
            cylinder(r1=4, r2=0.5, h=12, $fn=5);
        }
    }

    // Eyes (Large wise eyes)
    for (side = [-1, 1]) {
        translate([side * 7.5, 10, 39]) rotate([90, 0, 0]) {
            // White outer ring
            color(color_eye_white)
            cylinder(r=5.5, h=2, center=true, $fn=10);
            
            // Iris
            color(color_eye_iris)
            translate([0, 0, 0.8])
            cylinder(r=4, h=2, center=true, $fn=10);
            
            // Pupil
            color(color_eye_pupil)
            translate([0, 0, 1.5])
            cylinder(r=2.2, h=2, center=true, $fn=8);

            // Catchlight (tiny dot)
            color(color_eye_white)
            translate([1, 1, 2.2])
            cylinder(r=0.7, h=1, center=true, $fn=6);
        }
    }

    // Beak
    color(color_beak) {
        translate([0, 12, 35])
        rotate([110, 0, 0])
        cylinder(r1=3.5, r2=0.5, h=8, $fn=4);
    }
}

module owl() {
    owl_body();
    owl_head();
}

owl();
