//EuroCardDwarsBaseMulti5

guideCount = 7;

module beugel() {
    translate([0, -beugelbreedte/2, 0]) cube([beugellengte, beugelbreedte, beugeldikte]);
    cylinder(d = beugelbreedte, h = beugeldikte);
    translate([beugelDist, 0, 0]) cylinder(d = beugelbreedte, h = beugeldikte);
}

$fn = 32;

//beugellengte = 122.0;
beugellengte = 72.0 + 25.0 * (guideCount-1);
beugelbreedte = 10.0;
beugeldikte = 3.0;

//beugelDist = 122.0;
beugelDist = beugellengte;

module beugel2() {
    hull() {
        cylinder(d = beugelbreedte, h = beugeldikte);
        translate([beugelbreedte, beugelbreedte, 0]) cylinder(d = beugelbreedte, h = beugeldikte);
    }
    hull() {
        translate([beugelbreedte, beugelbreedte, 0]) cylinder(d = beugelbreedte, h = beugeldikte);
        translate([beugellengte - beugelbreedte, beugelbreedte, 0]) cylinder(d = beugelbreedte, h = beugeldikte);
    }
    hull() {
        translate([beugellengte - beugelbreedte, beugelbreedte, 0]) cylinder(d = beugelbreedte, h = beugeldikte);
        translate([beugelDist, 0, 0]) cylinder(d = beugelbreedte, h = beugeldikte);
    }
}

difference() {
    beugel2();
    translate([0, 0, -0.01]) cylinder(d = 3.2, h = beugeldikte + 0.02);
    translate([beugelDist, 0, -0.01]) cylinder(d = 3.2, h = beugeldikte + 0.02);
}

// for visual testing
//translate([0, 0, -1]) color("red") cube([beugelDist, 2, 2]);