//EuroCardDwarsBase4

$fn = 32;

beugellengte = 122.0;
beugelbreedte = 10.0;
beugeldikte = 3.0;

beugelDist = 122.0;

module beugel() {
    translate([0, -beugelbreedte/2, 0]) cube([beugellengte, beugelbreedte, beugeldikte]);
    cylinder(d = beugelbreedte, h = beugeldikte);
    translate([beugelDist, 0, 0]) cylinder(d = beugelbreedte, h = beugeldikte);
}

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

//translate([0, 0, -1]) color("red") cube([beugelDist, 2, 2]);