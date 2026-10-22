$fn = 32;

// Body
color("black")
translate([0, 0, 20])
sphere(r=15);

// Belly
color("white")
translate([0, -2, 18])
sphere(r=12);

// Head
color("black")
translate([0, 0, 35])
sphere(r=10);

// Eyes
color("white")
translate([4, -8, 37])
sphere(r=3);
color("white")
translate([-4, -8, 37])
sphere(r=3);

color("black")
translate([4, -10, 38])
sphere(r=1);
color("black")
translate([-4, -10, 38])
sphere(r=1);

// Beak
color("orange")
translate([0, -10, 34])
rotate([90, 0, 0])
cylinder(r1=3, r2=0, h=6);

// Flippers
color("black")
translate([13, 0, 22])
rotate([0, 30, 0])
scale([1, 0.3, 1.5])
sphere(r=8);

color("black")
translate([-13, 0, 22])
rotate([0, -30, 0])
scale([1, 0.3, 1.5])
sphere(r=8);

// Feet
color("orange")
translate([7, 0, 2])
scale([1.5, 1, 0.5])
sphere(r=6);

color("orange")
translate([-7, 0, 2])
scale([1.5, 1, 0.5])
sphere(r=6);
