$fn = 32;

// Cinema popcorn bucket: hollow striped tub overflowing with kernels
module bucket_body() {
    difference() {
        cylinder(r = 30, h = 60);
        translate([0, 0, 4]) cylinder(r = 27, h = 70);
    }
}

module rim_ring() {
    difference() {
        translate([0, 0, 55]) cylinder(r = 32, h = 5);
        translate([0, 0, 54]) cylinder(r = 29.5, h = 7);
    }
}

module stripes() {
    for (i = [0 : 11]) {
        rotate([0, 0, i * 30])
            translate([30, 0, 3])
                scale([1, 0.75, 1])
                    cylinder(r = 1.8, h = 52, $fn = 4);
    }
}

module kernels() {
    for (ix = [-2 : 1 : 2]) {
        for (iy = [-2 : 1 : 2]) {
            x = ix * 11;
            y = iy * 11;
            d = sqrt(x * x + y * y);
            if (d < 24) {
                translate([x, y, 63 - d * 0.2])
                    sphere(r = 7.5);
            }
        }
    }
    translate([-8, 8, 70]) sphere(r = 7);
    translate([8, -6, 69]) sphere(r = 7);
}

union() {
    bucket_body();
    rim_ring();
    stripes();
    kernels();
}
