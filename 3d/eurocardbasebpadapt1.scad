//EuroCardBaseBPadapt1

$fn = 32;

ECBeamHeight = 13.0;
ECBeamWidth = 6.5;
ECBeamLength = 85.0;
ECBeamHalfWidth = ECBeamWidth / 2;
adaptLen = 20.0 - ECBeamWidth;

mountHoleDist = 13.0;
mountHole1Offset = 15.0;
mountHole2Offset = mountHole1Offset + 25.0;
mountHole3Offset = mountHole1Offset + 50.0;
mountHole = 2.5;

bpHole1Offset = 15.0;
bpHole2Offset = 42.5;
bpHole3Offset = 70.5;
bpHoleZOffset = 5.0;
bpHole = 2.05;

module beam() {
    cube([ECBeamWidth, ECBeamLength, ECBeamHeight]);
}

module mountHoleSet() {
    translate([0, -mountHoleDist / 2, 0]) cylinder(d = mountHole, h = ECBeamHeight + 0.02);
    translate([0, mountHoleDist / 2, 0]) cylinder(d = mountHole, h = ECBeamHeight + 0.02);
}

module adaptBeam() {
    difference() {
        cube([adaptLen, ECBeamWidth, ECBeamHeight]);
        translate([adaptLen - ECBeamWidth, ECBeamHalfWidth, bpHoleZOffset]) rotate([0, 90, 0])
            cylinder(d = mountHole, h = ECBeamWidth + 0.02);
    }
}

difference() {
    beam();
    // back plane hole 1
    translate([-0.01, bpHole1Offset, bpHoleZOffset]) rotate([0, 90, 0]) 
        cylinder(d = bpHole, h = ECBeamWidth + 0.02);
    translate([-0.01, bpHole2Offset, bpHoleZOffset]) rotate([0, 90, 0]) 
        cylinder(d = bpHole, h = ECBeamWidth + 0.02);
    translate([-0.01, bpHole3Offset, bpHoleZOffset]) rotate([0, 90, 0]) 
        cylinder(d = bpHole, h = ECBeamWidth + 0.02); 
}
//20.5
translate([ECBeamWidth, 15.0 - ECBeamHalfWidth, 0]) adaptBeam();
translate([ECBeamWidth, 42.5 - ECBeamHalfWidth, 0]) adaptBeam();
translate([ECBeamWidth, 70.5 - ECBeamHalfWidth, 0]) adaptBeam(); 
