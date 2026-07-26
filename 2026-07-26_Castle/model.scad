// Medieval Castle 3D Model
// Low-poly procedural design in OpenSCAD

$fn = 12; // Crisp low-poly faceted look

// Color Palette
stone_color       = [0.65, 0.65, 0.68]; // Light grey stone
stone_dark        = [0.45, 0.45, 0.48]; // Darker stone for trim/battlements
roof_color        = [0.80, 0.25, 0.20]; // Crimson red roofs
door_color        = [0.45, 0.28, 0.15]; // Wood brown
flag_color        = [0.90, 0.75, 0.15]; // Gold flag
ground_color      = [0.35, 0.65, 0.35]; // Grass green

// Parameters
wall_h = 16;
wall_t = 3.2;
castle_size = 50; // Outer dimension

module merlon() {
    cube([2.5, 3.4, 3.1], center=true);
}

module battlements_line(length) {
    count = floor(length / 5);
    for (i = [0 : count-1]) {
        translate([i * 5 - length/2 + 2.5, 0, 0])
            merlon();
    }
}

module wall_section(length) {
    color(stone_color)
        cube([length, wall_t, wall_h], center=false);
    color(stone_dark)
        translate([0, wall_t/2, wall_h + 1.5])
            battlements_line(length);
}

module corner_tower() {
    tower_h = 24;
    r = 6;
    roof_h = 10;
    
    color(stone_color)
        cylinder(r=r, h=tower_h, $fn=12);
    
    color(stone_dark)
        translate([0, 0, tower_h - 0.1])
            cylinder(r1=r, r2=r+1, h=2.2, $fn=12);
            
    color(roof_color)
        translate([0, 0, tower_h + 1.9])
            cylinder(r1=r+1.2, r2=0.01, h=roof_h, $fn=12);
}

module gatehouse() {
    gh_w = 16;
    gh_d = 8;
    gh_h = 20;
    
    color(stone_color)
    difference() {
        cube([gh_w, gh_d, gh_h], center=true);
        translate([0, 0, -gh_h/2 + 4])
            rotate([90, 0, 0])
                cylinder(r=3.5, h=gh_d+4, center=true, $fn=16);
        translate([0, 0, -gh_h/2 + 2])
            cube([7, gh_d+4, 4.1], center=true);
    }
    
    color(door_color)
        translate([0, 0, -gh_h/2 + 3.5])
            cube([6.8, 1, 7], center=true);
            
    color(stone_dark)
    for (x = [-6, 0, 6]) {
        translate([x, 0, gh_h/2 + 1.5])
            cube([2.5, gh_d, 3], center=true);
    }
}

module keep() {
    keep_w = 22;
    keep_d = 22;
    keep_h = 32;
    
    color(stone_color)
        cube([keep_w, keep_d, keep_h], center=true);
        
    color(stone_dark)
        translate([0, 0, keep_h/2 + 1])
            cube([keep_w+2, keep_d+2, 2], center=true);
            
    spire_r = 6;
    spire_h = 16;
    translate([0, 0, keep_h/2 + 1.9]) {
        color(stone_color)
            cylinder(r=spire_r, h=spire_h, $fn=12);
        
        color(roof_color)
            translate([0, 0, spire_h - 0.1])
                cylinder(r1=spire_r+1, r2=0.01, h=12, $fn=12);
                
        color(stone_dark)
            translate([0, 0, spire_h + 11.9])
                cylinder(r=0.4, h=8.2, $fn=8);
                
        color(flag_color)
            translate([2, 0, spire_h + 18])
                rotate([90, 0, 0])
                    linear_extrude(0.3)
                        polygon(points=[[0,0], [4, -1.5], [0, -3]]);
    }
    
    for (x = [-keep_w/2, keep_w/2]) {
        for (y = [-keep_d/2, keep_d/2]) {
            translate([x, y, keep_h/2]) {
                color(stone_color)
                    cylinder(r=2.5, h=8, $fn=8);
                color(roof_color)
                    translate([0, 0, 7.9])
                        cylinder(r1=3, r2=0.01, h=5.2, $fn=8);
            }
        }
    }
}

module castle() {
    half = castle_size / 2;
    
    color(ground_color)
        translate([0, 0, 1])
            cube([castle_size + 20, castle_size + 20, 2], center=true);
            
    color(stone_dark)
        translate([0, 0, 2.5])
            cube([castle_size + 4, castle_size + 4, 1.2], center=true);
            
    translate([0, 0, 3]) {
        translate([0, 4, 16])
            keep();
            
        translate([-half, -half, 0]) corner_tower();
        translate([half, -half, 0])  corner_tower();
        translate([-half, half, 0])  corner_tower();
        translate([half, half, 0])   corner_tower();
        
        translate([-half, half - wall_t/2, 0])
            wall_section(castle_size);
            
        translate([-half + wall_t/2, -half, 0])
            rotate([0, 0, 90])
                wall_section(castle_size);
                
        translate([half + wall_t/2, -half, 0])
            rotate([0, 0, 90])
                wall_section(castle_size);
                
        translate([-half, -half + wall_t/2, 0])
            wall_section((castle_size - 16) / 2);
            
        translate([8, -half + wall_t/2, 0])
            wall_section((castle_size - 16) / 2);
            
        translate([0, -half + wall_t/2, 10])
            gatehouse();
    }
}

castle();
