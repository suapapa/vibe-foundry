$fn = 32;

// ---- Parameters ----
TRUNK_R    = 2.2;        // trunk base radius
TRUNK_TOP  = 30;         // trunk top height (buried into lowest foliage layer)
BARK_N     = 9;          // number of bark ridge rings
BARK_R     = 0.45;       // bark ridge protrusion
LAYERS     = 4;          // pine foliage cone layers
LAYER_R0   = 11;         // lowest cone radius
LAYER_R    = 2.6;        // radius shrink per layer
LAYER_H    = 9;          // cone height
LAYER_Z0   = 6;          // lowest cone base height
LAYER_STEP = 6;          // vertical spacing between cone bases

// ---- Trunk with textured (ridged) bark ----
module trunk() {
    cylinder(h = TRUNK_TOP, r1 = TRUNK_R, r2 = TRUNK_R * 0.6);
    // horizontal bark ridges: thin fat rings hugging the trunk
    for (i = [0 : BARK_N - 1]) {
        t = i / (BARK_N - 1);
        z = 1 + t * 24;
        r = TRUNK_R * (1 - t * 0.4) + BARK_R;
        translate([0, 0, z])
            cylinder(h = 0.8, r1 = r, r2 = r);
    }
}

// ---- One pine foliage cone (tip slightly rounded via small sphere) ----
module foliage_cone(base_z, r) {
    translate([0, 0, base_z])
        cylinder(h = LAYER_H, r1 = r, r2 = r * 0.18);
    translate([0, 0, base_z + LAYER_H])
        scale([r * 0.18, r * 0.18, 1]) sphere(r = 1);
}

// ---- Stacked pine layers ----
module foliage() {
    for (i = [0 : LAYERS - 1]) {
        foliage_cone(LAYER_Z0 + i * LAYER_STEP, LAYER_R0 - i * LAYER_R);
    }
}

// ---- Root flare so the base sits solid on Z = 0 ----
module root_flare() {
    cylinder(h = 2.5, r1 = TRUNK_R * 1.6, r2 = TRUNK_R);
    // a few exposed root bulges splayed around the base
    for (a = [0 : 90 : 270]) {
        rotate([0, 0, a])
            translate([TRUNK_R * 0.9, 0, 0.9])
                scale([1.5, 0.55, 0.45]) sphere(r = 1);
    }
}

// ---- Assemble: single connected manifold, bottom at Z = 0 ----
{
    trunk();
    foliage();
    root_flare();
}
