$fn = 32;

// Sunflower Model

// Central seed disc
cylinder(h = 5, r = 15, center = true);

// Petals
for (i = [0 : 12 : 360]) {
    rotate([0, 0, i])
    translate([15, 0, 0])
    scale([1.5, 0.5, 0.2])
    cylinder(h = 2, r = 10, center = true);
}

// A bit of texture on the disc
for (j = [0 : 45 : 360]) {
    rotate([0, 0, j])
    translate([5, 5, 2])
    sphere(r = 2);
}
