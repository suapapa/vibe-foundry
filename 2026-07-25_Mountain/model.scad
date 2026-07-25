// Low-Poly Jagged Snowy Mountain Peak
// Generated for Vibe Foundry Daily 3D Model (2026-07-25)

$fn = 6; // Hexagonal/low-poly style facets

// Color Palette
color_rock_dark = [0.28, 0.30, 0.34];
color_rock_mid  = [0.42, 0.45, 0.48];
color_rock_light= [0.55, 0.58, 0.62];
color_snow      = [0.95, 0.97, 1.00];

module mountain_peak(height=60, radius=35, facets=6, twist=15) {
    rotate([0, 0, twist])
    cylinder(h=height, r1=radius, r2=0, $fn=facets);
}

module snow_cap(height=22, radius=13, z_offset=38, facets=6, twist=15) {
    translate([0, 0, z_offset])
    rotate([0, 0, twist])
    cylinder(h=height, r1=radius, r2=0, $fn=facets);
}

union() {
    // Ground Base
    color(color_rock_dark)
    translate([0, 0, 0])
    cylinder(h=4, r=42, $fn=8);

    // Secondary Ridge Peak 1 (Left)
    color(color_rock_dark)
    translate([-18, -10, 2])
    mountain_peak(height=38, radius=22, facets=5, twist=10);
    
    color(color_snow)
    translate([-18, -10, 2])
    snow_cap(height=14, radius=8, z_offset=24, facets=5, twist=10);

    // Secondary Ridge Peak 2 (Right Front)
    color(color_rock_mid)
    translate([16, -12, 2])
    mountain_peak(height=32, radius=18, facets=6, twist=35);
    
    color(color_snow)
    translate([16, -12, 2])
    snow_cap(height=11, radius=6, z_offset=21, facets=6, twist=35);

    // Secondary Ridge Peak 3 (Back)
    color(color_rock_dark)
    translate([2, 18, 2])
    mountain_peak(height=42, radius=20, facets=5, twist=50);

    color(color_snow)
    translate([2, 18, 2])
    snow_cap(height=15, radius=7, z_offset=27, facets=5, twist=50);

    // Small Jagged Crag (Front Left)
    color(color_rock_light)
    translate([-10, -22, 2])
    mountain_peak(height=20, radius=12, facets=5, twist=20);

    // Main Central Peak (Tallest & Jagged)
    color(color_rock_mid)
    translate([0, 0, 2])
    mountain_peak(height=62, radius=30, facets=6, twist=0);

    // Extra jagged overlay peak for asymmetry
    color(color_rock_light)
    translate([-2, 3, 2])
    rotate([3, -4, 5])
    mountain_peak(height=60, radius=26, facets=5, twist=25);

    // Main Snow Cap (Layer 1 - Collar/Shoulder)
    color(color_snow)
    translate([0, 0, 36])
    rotate([2, -3, 12])
    cylinder(h=26, r1=13, r2=0, $fn=6);

    // Main Snow Cap Peak Tip
    color(color_snow)
    translate([0, 0, 42])
    rotate([-1, 2, 5])
    cylinder(h=21, r1=10, r2=0, $fn=5);
}
