$fn = 32;

module castle() {
    union() {
        // Base slab
        translate([0, 0, 1])
            cube([80, 80, 2], center=true);

        // Outer Walls
        translate([0, 28, 8]) cube([56, 4, 16], center=true);
        translate([0, -28, 8]) cube([56, 4, 16], center=true);
        translate([28, 0, 8]) cube([4, 56, 16], center=true);
        translate([-28, 0, 8]) cube([4, 56, 16], center=true);

        // Wall Battlements / Crenellations
        for (x = [-24 : 8 : 24]) {
            translate([x, 28, 17]) cube([4, 4, 4], center=true);
            translate([x, -28, 17]) cube([4, 4, 4], center=true);
            translate([28, x, 17]) cube([4, 4, 4], center=true);
            translate([-28, x, 17]) cube([4, 4, 4], center=true);
        }

        // 4 Corner Towers
        for (x = [-28, 28]) {
            for (y = [-28, 28]) {
                translate([x, y, 0]) {
                    cylinder(r=6, h=22);
                    translate([0, 0, 21]) cylinder(r=7, h=2);
                    translate([0, 0, 23]) cylinder(r1=7.5, r2=0, h=10);
                }
            }
        }

        // Gatehouse / Main Entrance
        translate([0, -28, 0]) {
            difference() {
                translate([0, 0, 9]) cube([16, 6, 18], center=true);
                translate([0, 0, 5]) cube([8, 8, 12], center=true);
                translate([0, 0, 11]) rotate([90, 0, 0]) cylinder(r=4, h=10, center=true);
            }
            translate([-8, 0, 0]) cylinder(r=4.5, h=24);
            translate([-8, 0, 24]) cylinder(r1=5, r2=0, h=7);
            
            translate([8, 0, 0]) cylinder(r=4.5, h=24);
            translate([8, 0, 24]) cylinder(r1=5, r2=0, h=7);
        }

        // Central Keep
        translate([0, 5, 0]) {
            translate([0, 0, 13]) cube([24, 24, 24], center=true);
            for (pos = [-10 : 5 : 10]) {
                translate([pos, 11.5, 26]) cube([3, 2, 2], center=true);
                translate([pos, -11.5, 26]) cube([3, 2, 2], center=true);
                translate([11.5, pos, 26]) cube([2, 3, 2], center=true);
                translate([-11.5, pos, 26]) cube([2, 3, 2], center=true);
            }
            translate([0, 0, 24]) cylinder(r=6, h=14);
            translate([0, 0, 38]) cylinder(r1=7, r2=0, h=10);
            
            translate([0, 0, 47]) cylinder(r=0.6, h=8);
            translate([2.5, 0, 52.5]) cube([5, 0.4, 3], center=true);
        }
    }
}

castle();
