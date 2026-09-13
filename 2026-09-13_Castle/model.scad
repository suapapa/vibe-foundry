$fn = 32;

// ---- dimensions ----
wall_h = 12;
wall_t = 2;
courtyard = 40;          // outer footprint of the curtain wall square
tower_r = 5;
tower_h = 20;
keep_w = 14;
keep_h = 24;

// crenellation block
merlon_w = 2.2;
merlon_h = 2.5;
merlon_t = wall_t;

// ---- curtain walls ----
module wall_pair_x(z, y_half) {
    // wall along X at y = +/- y_half
    translate([0, y_half, z])
        cube([courtyard, wall_t, wall_h], center=true);
}

difference() {
    union() {
        // four curtain walls
        wall_pair_x(wall_h/2,  courtyard/2 - wall_t/2);
        wall_pair_x(wall_h/2, -courtyard/2 + wall_t/2);
        rotate([0,0,90]) wall_pair_x(wall_h/2,  courtyard/2 - wall_t/2);
        rotate([0,0,90]) wall_pair_x(wall_h/2, -courtyard/2 + wall_t/2);

        // corner towers (cylinders) with conical roofs
        for (sx = [-1,1], sy = [-1,1]) {
            translate([sx*(courtyard/2 - tower_r*0.35), sy*(courtyard/2 - tower_r*0.35), 0]) {
                cylinder(h=tower_h, r=tower_r);
                translate([0,0,tower_h])
                    cylinder(h=7, r1=tower_r+1.2, r2=0.6);
            }
        }

        // battlements along the wall tops
        for (i = [0:7]) {
            t = -courtyard/2 + 3 + i * (courtyard-6)/7;
            for (sx = [-1,1]) {
                translate([t, sx*(courtyard/2 - wall_t/2), wall_h])
                    cube([merlon_w, merlon_t, merlon_h], center=true);
                translate([sx*(courtyard/2 - wall_t/2), t, wall_h])
                    cube([merlon_t, merlon_w, merlon_h], center=true);
            }
        }

        // central keep
        translate([0,0,0])
            cube([keep_w, keep_w, keep_h], center=true);
        // keep battlement crown
        translate([0,0,keep_h]) {
            cube([keep_w+2, keep_w+2, 1.5], center=true);
            for (i = [0:3]) {
                t = -keep_w/2 - 0.5 + i * (keep_w+1)/3;
                for (sx = [-1,1]) {
                    translate([t, sx*(keep_w/2 + 0.5), 1.5])
                        cube([1.8, 1.5, 2.2], center=true);
                    translate([sx*(keep_w/2 + 0.5), t, 1.5])
                        cube([1.5, 1.8, 2.2], center=true);
                }
            }
        }
        // keep roof spire
        translate([0,0,keep_h + 3.7])
            cylinder(h=6, r1=4, r2=0.5);

        // gatehouse on the front (+y) wall
        translate([0, courtyard/2 - wall_t/2, 0]) {
            cube([10, wall_t + 1.5, wall_h + 4], center=true);
            // two small gate turrets
            translate([-5.5, 0, 0])
                cylinder(h=wall_h + 7, r=2.2);
            translate([5.5, 0, 0])
                cylinder(h=wall_h + 7, r=2.2);
        }

        // gate arch (semi-cylinder lying across Y)
        translate([0, courtyard/2 - wall_t/2, 5])
            rotate([90,0,0])
                cylinder(h=wall_t + 3, r=3);
    }

    // carve the gate opening through everything
    translate([0, courtyard/2 - wall_t, 0])
        cube([6, wall_t + 6, 8], center=true);
    translate([0, courtyard/2 - wall_t/2, 4])
        rotate([90,0,0])
            cylinder(h=wall_t + 4, r=3, center=true);
}

// solid base plinth (ensures a single connected manifold)
translate([0,0,-1])
    cube([courtyard + 6, courtyard + 6, 2], center=true);
