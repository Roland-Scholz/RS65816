//EuroCardGuidebase2

$fn = 32;

ECBeamHeight = 13.0;
ECBeamWidth = 6.5;
ECBeamLength = 85.0;

mountHoleDist = 13.0;
mountHole1Offset = 15.0;
mountHole2Offset = mountHole1Offset + 25.0;
mountHole3Offset = mountHole1Offset + 50.0;
mountHole = 2.5;

bpHole1Offset = 15.0;
bpHole2Offset = 42.5;
bpHole3Offset = 70.5;
bpHoleZOffset = 5.0;

module beam() {
    cube([ECBeamWidth, ECBeamLength, ECBeamHeight]);
}

module mountHoleSet() {
    translate([0, -mountHoleDist / 2, 0]) cylinder(d = mountHole, h = ECBeamHeight + 0.02);
    translate([0, mountHoleDist / 2, 0]) cylinder(d = mountHole, h = ECBeamHeight + 0.02);
}

difference() {
    beam();
    translate([ECBeamWidth / 2, 0, -0.01]) {
        // guide 1
        translate([0, mountHole1Offset, 0]) mountHoleSet();
        // guide 2
        translate([0, mountHole2Offset, 0]) mountHoleSet();
        // guide 3
        translate([0, mountHole3Offset, 0]) mountHoleSet();
    }
    // back plane hole 1
    translate([-0.01, bpHole1Offset, bpHoleZOffset]) rotate([0, 90, 0]) 
        cylinder(d = mountHole, h = ECBeamWidth + 0.02);
    translate([-0.01, bpHole2Offset, bpHoleZOffset]) rotate([0, 90, 0]) 
        cylinder(d = mountHole, h = ECBeamWidth + 0.02);
    translate([-0.01, bpHole3Offset, bpHoleZOffset]) rotate([0, 90, 0]) 
        cylinder(d = mountHole, h = ECBeamWidth + 0.02); 
    //20.5
//    translate([-0.01, 15.0, 0]) rotate([0, 90, 0]) cylinder(d = 1, h = ECBeamWidth + 0.02);
//    translate([-0.01, 40.0, 0]) rotate([0, 90, 0]) cylinder(d = 1, h = ECBeamWidth + 0.02);
//    translate([-0.01, 65.0, 0]) rotate([0, 90, 0]) cylinder(d = 1, h = ECBeamWidth + 0.02);
    
    
}