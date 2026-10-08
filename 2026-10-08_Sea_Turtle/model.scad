$fn = 32;

module sea_turtle() {
    // Body (Carapace)
    color("green")
    scale([1.2, 1, 0.8])
    sphere(r=10);

    // Head
    color("green")
    translate([12, 0, 0])
    sphere(r=4);

    // Eyes
    color("black")
    translate([14, 2, 2])
    sphere(r=0.8);
    color("black")
    translate([14, -2, 2])
    sphere(r=0.8);

    // Flippers (Front Right)
    color("darkgreen")
    translate([8, 8, 0])
    rotate([0, 45, 45])
    scale([1.5, 0.5, 0.2])
    cylinder(h=1, r=4);

    // Flippers (Front Left)
    color("darkgreen")
    translate([8, -8, 0])
    rotate([0, -45, -45])
    scale([1.5, 0.5, 0.2])
    cylinder(h=1, r=4);

    // Flippers (Back Right)
    color("darkgreen")
    translate([-8, 8, 0])
    rotate([0, -45, -45])
    scale([1.5, 0.5, 0.2])
    cylinder(h=1, r=4);

    // Flippers (Back Left)
    color("darkgreen")
    translate([-8, -8, 0])
    rotate([0, 45, 45])
    scale([1.5, 0.5, 0.2])
    cylinder(h=1, r=4);
}

sea_turtle();
