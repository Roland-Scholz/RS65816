// EurocardGuide3

$fn = 32;

pcbThick = 1.8;
guideLen = 150;
guideHeight = 2.75;
guideThick = 1.5;
guideWidth = guideThick * 2 + pcbThick;

module guide() {
    guideZ = guideThick + guideHeight;
    difference() {
        translate([0, 0, guideZ  / 2]) cube([guideLen, guideWidth, guideZ], true);
        translate([-0.01, 0, guideThick + guideHeight / 2]) 
            cube([guideLen + 0.03, pcbThick, guideHeight + 0.01], true);
        translate([guideLen / 2 -14, -guideWidth/2-0.01, guideZ]) rotate([0, 10, 0]) 
            cube([15, guideWidth + 0.02, guideHeight]);
    }
}

mountWidth = 6.5;
mountHole = 3.2;

module sideMount() {
  difference() {
    union() {
        cylinder(d = mountWidth, h = guideThick);
        translate([-mountWidth / 2, 0, 0]) cube([mountWidth, mountWidth * 2, guideThick]);
        translate([0, mountWidth * 2, 0]) cylinder(d = mountWidth, h = guideThick);
    }
    translate([0, 0, -0.01]) cylinder(d = mountHole, h = guideThick + 0.02);
    translate([0, mountWidth * 2, -0.01]) cylinder(d = mountHole, h = guideThick + 0.02);
  }
}

guide();
translate([guideLen / 2 -mountWidth, -mountWidth, 0]) sideMount();
translate([0, -mountWidth, 0]) sideMount();
translate([-guideLen / 2 +mountWidth, -mountWidth, 0]) sideMount();

