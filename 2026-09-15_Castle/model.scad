$fn = 32;

// Medieval castle with towers and battlements

module tower(x, y) {
    translate([x, y, 0]) {
        cylinder(h=26, r=7);
        translate([0, 0, 25.5]) cylinder(h=11, r1=7.5, r2=1.5);
        for (a = [0:45:315]) {
            rotate([0, 0, a])
                translate([0, 8.2, 26.5]) cube([2.6, 2.2, 3.6], center=true);
        }
    }
}

module merlons_x(n, L) {
    step = L / (n - 1);
    for (i = [0:n-1])
        translate([-L/2 + i*step, 0, 0]) cube([2.8, 2.2, 3.4], center=true);
}

module merlons_y(n, L) {
    step = L / (n - 1);
    for (i = [0:n-1])
        translate([0, -L/2 + i*step, 0]) cube([2.2, 2.8, 3.4], center=true);
}

difference() {
    union() {
        // Ground base plinth
        translate([40, 33, 0]) cube([96, 78, 2], center=true);

        // Curtain walls (height 14)
        translate([40, -6, 7])  cube([80, 4, 14], center=true);
        translate([40, 72, 7])  cube([80, 4, 14], center=true);
        translate([-2, 33, 7])  cube([4, 66, 14], center=true);
        translate([82, 33, 7])  cube([4, 66, 14], center=true);

        // Battlements on curtain walls
        translate([40, -6, 15.5]) merlons_x(13, 76);
        translate([40, 72, 15.5]) merlons_x(13, 76);
        translate([-2, 33, 15.5]) merlons_y(11, 62);
        translate([82, 33, 15.5]) merlons_y(11, 62);

        // Gatehouse: two drum towers + block over the doorway
        translate([29, -6, 0])  cylinder(h=19, r=6);
        translate([51, -6, 0])  cylinder(h=19, r=6);
        translate([40, -6, 14]) cube([24, 9, 10], center=true);
        translate([40, -6, 20.5]) merlons_x(5, 20);

        // Corner towers with conical roofs and crenellations
        tower(2, 0);
        tower(78, 0);
        tower(2, 66);
        tower(78, 66);

        // Keep: body, ledge, crenellated top, pyramid roof
        translate([40, 40, 0]) {
            cube([26, 20, 36], center=true);
            translate([0, 0, 36]) cube([29, 23, 2], center=true);
            translate([0, 0, 38.5]) {
                translate([0, 10.4, 0]) merlons_x(7, 25);
                translate([0, -10.4, 0]) merlons_x(7, 25);
                translate([13, 0, 0]) merlons_y(5, 17);
                translate([-13, 0, 0]) merlons_y(5, 17);
            }
            translate([0, 0, 36.5]) cylinder(h=14, r1=12.5, r2=1.2);
        }

        // Keep corner turrets
        for (dx = [-13, 13], dy = [-10, 10]) {
            translate([40+dx, 40+dy, 0]) {
                cylinder(h=40, r=3.2);
                translate([0, 0, 39.5]) cylinder(h=8, r1=4, r2=0.8);
            }
        }
    }

    // Gate opening through the front wall and gatehouse
    translate([40, -12, 6]) cube([10, 18, 12], center=true);
}
