$fn = 32;

// Sofa Base
cube([60, 30, 10], center = true);

// Sofa Seat Cushions (3 seats)
translate([-18, 0, 5], center = true)
    cube([35, 28, 8], center = true);
translate([0, 0, 5], center = true)
    cube([35, 28, 8], center = true);
translate([18, 0, 5], center = true)
    cube([35, 28, 8], center = true);

// Sofa Backrest
translate([0, -12, 15], center = true)
    cube([60, 5, 25], center = true);

// Armrests
translate([-28, 0, 10], center = true)
    cube([5, 30, 15], center = true);
translate([28, 0, 10], center = true)
    cube([5, 30, 15], center = true);

// Legs
translate([-25, -12, -10], center = true)
    cylinder(h = 10, r = 2);
translate([25, -12, -10], center = true)
    cylinder(h = 10, r = 2);
translate([-25, 12, -10], center = true)
    cylinder(h = 10, r = 2);
translate([25, 12, -10], center = true)
    cylinder(h = 10, r = 2);
