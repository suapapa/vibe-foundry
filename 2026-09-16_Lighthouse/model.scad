$fn = 32;

// Tall striped lighthouse on a small rock

// Rock mound (flattened sphere, bottom touching Z=0)
module rock() {
    translate([0, 0, 9]) scale([1, 0.85, 0.5]) sphere(r=18);
    translate([12, -7, 7]) scale([1, 0.9, 0.6]) sphere(r=6);
    translate([-13, 6, 6]) scale([1, 0.8, 0.5]) sphere(r=7);
    translate([5, 12, 5.5]) scale([1, 1, 0.55]) sphere(r=5);
}

// Tapered tower body: r(z) = 8.5 - 3.5*(z-10)/42, from z=10 (sunk into rock) to z=52
module tower() {
    translate([0, 0, 10]) cylinder(h=42, r1=8.5, r2=5);
}

// Raised stripe bands (each sinks 2+ units into the tower on both ends)
module stripes() {
    translate([0, 0, 15]) cylinder(h=6, r1=8.43, r2=8.30);
    translate([0, 0, 25]) cylinder(h=6, r1=7.62, r2=7.48);
    translate([0, 0, 35]) cylinder(h=6, r1=6.80, r2=6.67);
    translate([0, 0, 44]) cylinder(h=6, r1=6.09, r2=5.96);
}

// Gallery deck + railing
module gallery() {
    translate([0, 0, 50]) cylinder(h=2.5, r=7);
    for (a = [0:45:315]) {
        rotate([0, 0, a])
            translate([6.4, 0, 51.5]) cylinder(h=3.5, r=0.35);
    }
    translate([0, 0, 54.8]) cylinder(h=0.7, r=6.5);
}

// Lamp room and roof
module lamp_room() {
    translate([0, 0, 52]) cylinder(h=6.5, r1=4.2, r2=3.6);
    translate([0, 0, 58]) cylinder(h=5, r1=4.8, r2=0.5);
    translate([0, 0, 62.5]) sphere(r=1);
}

union() {
    rock();
    tower();
    stripes();
    gallery();
    lamp_room();
}
