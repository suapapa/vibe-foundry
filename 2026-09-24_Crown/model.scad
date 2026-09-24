// Crown - royal golden crown with jewels and velvet lining
// Low-poly, single connected manifold, rests on Z=0

$fn = 32;

BAND_RO = 30.0;   // band outer radius
BAND_RI = 24.0;   // band inner radius (head opening)
BAND_H  = 14.0;   // band height (z 0..14)

LIP_RO  = 32.0;   // decorative rim outer radius
LIP_RI  = 23.9;   // rim inner wall, 0.1 inside the band opening
LIP_Z0  = 11.0;   // rim bottom
LIP_Z1  = 16.0;   // rim top

LIN_R   = 24.3;   // velvet lining radius (0.3 sunk into the band wall)
LIN_Z0  =  3.0;   // lining bottom
LIN_Z1  = 12.0;   // lining top (inside the rim wall: real overlap, no coplanar faces)

SPK_R   = 28.0;   // spike ring radius (mid of the rim wall)
SPK_R1  =  3.8;   // spike base radius
SPK_EMB =  1.0;   // how far the spike base sinks into the rim

module band() {
    difference() {
        cylinder(r = BAND_RO, h = BAND_H);
        translate([0, 0, -1]) cylinder(r = BAND_RI, h = BAND_H + 2);
    }
}

module rim() {
    difference() {
        translate([0, 0, LIP_Z0]) cylinder(r = LIP_RO, h = LIP_Z1 - LIP_Z0);
        translate([0, 0, LIP_Z0 - 1]) cylinder(r = LIP_RI, h = (LIP_Z1 - LIP_Z0) + 2);
    }
}

module lining() {
    // velvet lining: recessed cup inside the band
    translate([0, 0, LIN_Z0]) cylinder(r = LIN_R, h = LIN_Z1 - LIN_Z0);
}

module spikes() {
    // eight low-poly spikes, alternating tall and short
    for (i = [0 : 7]) {
        rotate([0, 0, i * 45])
            translate([SPK_R, 0, LIP_Z1 - SPK_EMB])
                cylinder(r1 = SPK_R1, r2 = 0.6, h = (i % 2 == 0) ? 26 : 18);
    }
    // ball finials on the four tall spikes
    for (i = [0 : 2 : 7]) {
        rotate([0, 0, i * 45]) translate([SPK_R, 0, 39.5]) sphere(r = 1.9);
    }
}

module jewels() {
    for (i = [0 : 7]) {
        rotate([0, 0, i * 45 + 22.5]) translate([BAND_RO - 0.5, 0, 7]) sphere(r = 3.0);
    }
    // larger front-centre jewel
    translate([BAND_RO - 0.8, 0, 7]) sphere(r = 4.2);
}

union() {
    band();
    rim();
    lining();
    spikes();
    jewels();
}
