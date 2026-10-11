$fn = 32;

// Main Body
color("red")
cube([40, 15, 6], center=true);

// Handle hinge area
translate([-15, 0, 0])
color("silver")
cylinder(h=6, r=3, center=true);

// Tool 1: Blade (peeking out)
translate([5, 0, 1])
rotate([0, -20, 0])
color("silver")
cube([25, 4, 1], center=true);

// Tool 2: Screwdriver (peeking out)
translate([-5, 5, 1])
rotate([0, 45, 0])
color("silver")
cylinder(h=10, r=1.5, center=true);

// Tool 3: File (peeking out)
translate([0, -5, 1])
rotate([0, 70, 0])
color("silver")
cube([15, 2, 1], center=true);

// Decorative rivet
translate([15, 0, 3])
color("gold")
cylinder(h=1, r=1, center=true);
