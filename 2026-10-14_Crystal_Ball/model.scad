$fn = 32;

// Crystal Ball
// A mystical scrying orb mounted on an ornate three-legged stand.

module crystal_ball() {
    // The orb itself
    color("lightblue", 0.5)
    sphere(r=20);
    
    // Inner glowing core
    color("white")
    sphere(r=5);
}

module stand() {
    // Central pillar
    cylinder(h=10, r=3);
    
    // Ornate legs
    for (i = [0 : 120 : 360]) {
        rotate([0, 0, i])
        translate([10, 0, 0])
        cylinder(h=5, r1=3, r2=0.5);
        
        rotate([0, 0, i])
        translate([10, 0, 5])
        cylinder(h=5, r1=2, r2=0.5);
    }
    
    // Base plate
    cylinder(h=2, r=15);
}

// Assembly
translate([0, 0, 20])
crystal_ball();

translate([0, 0, 0])
stand();
