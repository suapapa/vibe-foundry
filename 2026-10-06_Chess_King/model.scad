$fn = 32;

// Chess King Model

module king_base() {
    cylinder(h = 5, r1 = 10, r2 = 10);
}

module king_body() {
    translate([0, 0, 5])
    cylinder(h = 25, r1 = 10, r2 = 6);
}

module king_neck() {
    translate([0, 0, 30])
    cylinder(h = 3, r1 = 6, r2 = 4);
}

module king_crown() {
    translate([0, 0, 33])
    difference() {
        cylinder(h = 7, r1 = 4, r2 = 5);
        // Cutouts for crown points
        for (i = [0 : 60 : 360]) {
            rotate([0, 0, i])
            translate([4, 0, 2])
            cylinder(h = 10, r1 = 2, r2 = 2);
        }
    }
}

module king_cross() {
    translate([0, 0, 40]) {
        // Vertical bar
        cube([2, 2, 5], center = true);
        // Horizontal bar
        rotate([0, 0, 0])
        cube([5, 2, 2], center = true);
    }
}

// Assembly
union() {
    king_base();
    king_body();
    king_neck();
    king_crown();
    king_cross();
}
