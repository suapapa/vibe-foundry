// Desk Lamp - adjustable anglepoise lamp with a conical shade
$fn = 32;

// ---- parameters (mm) ----
BASE_R   = 38;
BASE_H   = 6;
DOME_R   = 5;
ARM_R    = 4.5;
L_LOW    = 70;
A_LOW    = 28;   // lower arm tilt from vertical, deg
L_UP     = 65;
A_UP     = 62;   // upper arm tilt from vertical, deg
JOINT_R  = 6;

SHADE_R1 = 6;    // shade radius at the arm end
SHADE_R2 = 24;   // shade mouth radius
SHADE_H  = 38;
A_SHADE  = 35;   // shade axis tilt from straight down, deg
BULB_R   = 8;

// ---- derived points ----
P0 = [0, 0, BASE_H];
P1 = [L_LOW*sin(A_LOW), 0, BASE_H + L_LOW*cos(A_LOW)];
P2 = [P1[0] + L_UP*sin(A_UP), 0, P1[2] + L_UP*cos(A_UP)];
SD = [sin(A_SHADE), 0, -cos(A_SHADE)];
SP = [P2[0] - 6*SD[0], 0, P2[2] - 6*SD[2]];
BP = [P2[0] + 30*SD[0], 0, P2[2] + 30*SD[2]];

// ---- base ----
cylinder(r = BASE_R, h = BASE_H);
translate([0, 0, BASE_H - 1]) sphere(r = DOME_R);

// ---- lower arm + joints ----
translate(P0) sphere(r = JOINT_R);
translate(P0) rotate([0, A_LOW, 0]) cylinder(r = ARM_R, h = L_LOW);
translate(P1) sphere(r = JOINT_R + 0.5);

// ---- upper arm ----
translate(P1) rotate([0, A_UP, 0]) cylinder(r = ARM_R, h = L_UP);
translate(P2) sphere(r = JOINT_R - 1);

// ---- conical shade ----
translate(SP) rotate([0, 180 - A_SHADE, 0]) cylinder(r1 = SHADE_R1, r2 = SHADE_R2, h = SHADE_H);

// ---- bulb ----
translate(BP) sphere(r = BULB_R);
