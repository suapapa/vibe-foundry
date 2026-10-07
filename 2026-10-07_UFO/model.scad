$fn = 32;

// UFO Main Body (Saucer)
difference() {
    scale([2.5, 2.5, 0.6]) sphere(r=10);
    scale([2.6, 2.6, 0.7]) sphere(r=10);
}

// Cockpit Dome (Glass)
translate([0, 0, 4])
scale([1.2, 1.2, 0.8]) sphere(r=5);

// Underside detail (small sphere or cylinder)
translate([0, 0, -2])
cylinder(h=2, r1=3, r2=0, center=false);
