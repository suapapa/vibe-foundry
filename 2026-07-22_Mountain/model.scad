$fn = 12;

module mountain_peak() {
    // Base rock
    hull() {
        cylinder(h=2, r=25, $fn=8);
        translate([0,0,40]) sphere(r=1, $fn=4);
        translate([15,15,30]) sphere(r=1, $fn=4);
        translate([-15,-15,25]) sphere(r=1, $fn=4);
    }
    
    // Adding some jaggedness
    for (i = [0 : 7]) {
        rotate([i * 45, i * 30, i * 90])
        translate([10, 10, 10])
        cylinder(h = 20, r1 = 5, r2 = 0, $fn = 4);
    }
}

module snow_cap() {
    // Snow layer on top
    translate([0,0,35])
    color("white")
    sphere(r=12, $fn=8);
    
    // Some snow on the sides
    translate([15, -5, 15])
    rotate([45, 0, 45])
    color("white")
    sphere(r=8, $fn=6);
}

union() {
    mountain_peak();
    snow_cap();
}
