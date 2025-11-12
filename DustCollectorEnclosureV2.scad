/*
  RIDGID 3 Gallon 5.0 Peak HP NXT shop vac
*/
module shopVac() {
    vacWidth = 19.5;
    vacDepth = 11;
    vacHeight = 12;

    inflowHeight = 4;
    inflowInset = 3.5;

    switchWidth = 1.5;
    switchDepth = 2.5;
    switchHeight = 1; // doesn't really matter, just needs to be consistent
    switchDepthOffset = 3.5;
    switchWidthOffset = 6.5;

    color("orange", 1) {
        difference() {
            cube([vacWidth, vacDepth, vacHeight]);
            translate([vacWidth - inflowInset - 1, 1, 1]) {
                cube([inflowInset + 2, vacDepth - 2, inflowHeight + 5]);
            }
        }
    }
    color("black", 1.0) {
        translate([vacWidth - inflowInset - 1, vacDepth / 2, inflowHeight]) {
            rotate([0, 90, 0]) {
                cylinder(h = 1, r = 1.25, $fn = 20);
            }
        }
    }
    color("grey", 1.0) {
        translate([vacWidth - switchWidthOffset, switchDepthOffset, vacHeight - switchHeight + 0.1]) {
            cube([switchWidth, switchDepth, switchHeight]);
        }
    }
}


/*
  Tupperware (airtight) chip collector
*/
module tupperware() {
    chipWidth = 15;
    chipHeight = 9.5;
    chipDepth = 11.25;

    color("white", 0.85) 
        cube([chipWidth, chipDepth, chipHeight]);
}

/*
  Cyclonic "dust deputy" from Oenida Air Systems
*/
module dustDeputy() {
    deputyConeHeight = 13.5;
    deputyBottomRadius = 3;
    deputyTopRadius = 4.5;

    color("white", 0.85) {
        cylinder(
            h = deputyConeHeight,
            r1 = deputyBottomRadius,
            r2 = deputyTopRadius,
            $fn = 90
        );
        translate([deputyTopRadius * 0.3, 0, deputyConeHeight - 3]) {
            rotate([0, 90, 0]) {
                cylinder(h = 5, r = 1.25, $fn = 20);
            }
        }
        translate([0, 0, deputyConeHeight]) {
            rotate([0, 0, 0]) {
                cylinder(h = 3, r = 1.25, $fn = 20);
            }
        }
    }
}

/*
  Build from 3/4 inch plywood with dowel or biscuit joinery.
*/
module cabinet() {
    overallDepth = 12;
    overallWidth = 32;
    overallHeight = 29;

    // bottom
    color("green", 1.0) {
        cube([overallWidth, overallDepth, 0.75]);
    }

    // top
    color("green", 1.0) {
        translate([0, 0, overallHeight - 0.75]) {
            cube([overallWidth, overallDepth, 0.75]);
        }
    }

    // side 1
    color("lightgreen") {
        translate([0, 0, 0.75]) {
            cube([0.75, overallDepth, overallHeight - (0.75 * 2)]);
        }
    }

    // side 2
    color("lightgreen") {
        translate([overallWidth - 0.75, 0, 0.75]) {
            difference() {
                cube([0.75, overallDepth, overallHeight - (0.75 * 2)]);
                translate([-0.25, 5.75, 19.25]) {
                    rotate([0, 90, 0]) {
                        cylinder(h = 1.25, r = 2, $fn = 20);
                    }
                }
            }
        }
    }

    // center divider
    color("lightgreen") {
        translate([14, 0, 0.75]) {
            difference() {
                cube([0.75, overallDepth, overallHeight - (0.75 * 2)]);
                translate([-0.25, 5.75, 19.25 + 5]) {
                    rotate([0, 90, 0]) {
                        cylinder(h = 1.25, r = 2, $fn = 20);
                    }
                }
            }
        }
    }
    // front
    color("darkgreen") {
        translate([0, -0.75 - 027, 0]) {
            cube([overallWidth, 0.75, overallHeight]);
        }
    }
    // back
    color("darkgreen") {
        translate([0, 12, 0]) {
            cube([overallWidth, 0.75, overallHeight]);
        }
    }
}

// Assembly:

cabinet();

translate([13, 0, 1]) {
    rotate([0, -90, 0]) {
        shopVac();
    }
}

translate([15.5, 0, 0.75]) {
    tupperware();
}

translate([23, 5.5, 9.5]) {
    dustDeputy();
}

/*

NOT SHOWN:

1. Hose from shop vac through the hole in the center divider and to the top of the Dust Deputy.
2. Anti-implosion baffle inside tupperware. (Two pieces of plywood hot glued together to keep the box from imploding at max suction.)

*/

echo(version=version());