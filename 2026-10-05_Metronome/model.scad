$fn = 32;

// Metronome Base (Pyramidal)
module base() {
    polyhedron(
        points=[
            [0, 0, 0], [20, 0, 0], [20, 20, 0], [0, 20, 0], // bottom square
            [10, 10, 30]                                    // top apex
        ],
        faces=[
            [0, 1, 4], [1, 2, 4], [2, 3, 4], [3, 0, 4],     // sides
            [0, 3, 2, 1]                                    // bottom
        ]
    );
}

// Pendulum Arm (Vertical thin rod)
module arm() {
    translate([10, 10, 5])
    cylinder(h=25, r=1);
}

// Pendulum Weight (Sphere at the bottom)
module weight() {
    translate([10, 10, 0])
    sphere(r=3);
}

// Combining everything into one manifold
union() {
    base();
    arm();
    weight();
}
