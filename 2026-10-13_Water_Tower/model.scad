$fn = 32;

// Water Tower - Spherical tank on metal stilts
module water_tower() {
    // Main Tank (Sphere)
    translate([0, 0, 40])
    sphere(r = 20);
    
    // Tank Base/Connection (Cylinder)
    translate([0, 0, 25])
    cylinder(h = 15, r1 = 10, r2 = 5);

    // Stilts (4 legs)
    for (i = [0 : 3]) {
        rotate([0, 0, i * 90])
        translate([8, 0, 0])
        cylinder(h = 30, r = 1.5);
    }

    // Cross braces (Cubes)
    for (i = [0 : 3]) {
        rotate([0, 0, i * 90 + 45])
        translate([5, 0, 15])
        cube([12, 1.5, 1.5], center = true);
    }
    
    // Bottom Base Plate
    translate([0, 0, 0])
    cylinder(h = 2, r = 12);
}

water_tower();
