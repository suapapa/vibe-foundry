$fn = 32;

// Cat - stylized low-poly silhouette

// Body
translate([0, 0, 26])
    scale([1.55, 1.0, 1.0])
    sphere(16);

// Legs (4)
leg_x = 16;
leg_y = 9;
for (lx = [-leg_x, leg_x], ly = [-leg_y, leg_y])
    translate([lx, ly, 0])
        cylinder(h = 24, r1 = 4.2, r2 = 3.4);

// Neck
translate([21, 0, 30])
    rotate([0, 45, 0])
    cylinder(h = 14, r = 6.5);

// Head
translate([30, 0, 42])
    scale([1.15, 1.0, 1.0])
    sphere(11);

// Muzzle
translate([38, 0, 39])
    scale([1.2, 1.0, 0.8])
    sphere(6);

// Ears (two cones)
for (ey = [-6, 6])
    translate([27, ey, 50])
        rotate([0, ey > 0 ? 22 : -22, ey > 0 ? -14 : 14])
        scale([0.75, 1.0, 1.0])
        cylinder(h = 11, r1 = 4.5, r2 = 0.6);

// Tail - arching curve
for (i = [0:6])
    let (t = i / 6,
         tx = -24 - 13 * sin(75 * t),
         tz = 30 + 26 * t - 8 * t * t)
        translate([tx, 0, tz])
        sphere(3.4 - 1.3 * t);
