// euroCardGotekMount2

$fn = 32;

cardSupportDist = 130.0;
gotekMountOffset = 10.0;
holeDiam = 3.2;
mountThick = 2.0;
mountWidth = 10.0;
mountDepth = 122.0;
gotekWidth = 100.0;

module cardSupportMount() {
    difference() {
        union() {
            cylinder(d = mountWidth, h = mountThick);
            translate([-mountWidth/2, 0, 0]) cube([mountWidth, mountWidth * 1.5, mountThick]);
        }
        translate([0, 0, -0.01]) cylinder(d = holeDiam, h = mountThick + 0.02);
    }
    translate([mountWidth/2, mountWidth/2, 0]) cube([4, mountWidth, mountThick]);
}

//mirror([1, 0, 0]) {
    translate([0, 0, mountWidth/2]) {
        rotate([0, 90, 0]) cardSupportMount();
        translate([cardSupportDist - mountThick, 0, 0]) rotate([0, 90, 0]) cardSupportMount();
    }
    gotekMountDepthOffset = 6;
    translate([0, mountWidth/2, -gotekMountDepthOffset]) {
        difference() {
            cube([cardSupportDist, mountWidth, mountThick]);
            translate([10, mountWidth/2, -0.01]) cylinder(d = holeDiam, h = mountThick + 0.02);
            translate([10 + 59.5, mountWidth/2, -0.01]) cylinder(d = holeDiam, h = mountThick + 0.02);
            translate([10 + 89.5, mountWidth/2, -0.01]) cylinder(d = holeDiam, h = mountThick + 0.02);
        }
    }

    translate([0, gotekMountOffset * 1.5, -gotekMountDepthOffset]) {
            cube([cardSupportDist, mountThick, mountWidth * 2 - mountThick*2]);
    }
//}