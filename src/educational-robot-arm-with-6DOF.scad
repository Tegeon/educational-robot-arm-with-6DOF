/* {{{ %%SECTION_HEADER%%
 * * * *
 * This header information is automatically generated by KodeUtils.
 *
 * File 'educational-robot-arm-with-6DOF.scad' edited by kwendenarmo,
 * last modified: 2015-04-06.
 * This file is part of 'educational-robot-arm-with-6DOF' package, please see
 * the readme files for more information about this file and this package.
 *
 * Copyright (C) 2014, 2015 by kwendenarmo <kwendenarmo@akornsys-rdi.net>
 * Released under the GNU GPLv3
 *
 *    This program is free software: you can redistribute it and/or modify
 *    it under the terms of the GNU General Public License as published by
 *    the Free Software Foundation, either version 3 of the License, or
 *    (at your option) any later version.
 *
 *    This program is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License
 *    along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * * * *
 * %%EOS_HEADER%% }}}
 */

use <MCAD/involute_gears.scad>
$fn=360;

assemble = true;
debug = false;
showservos = true;

if (debug == true) {
    fastener();
}

if ((debug == false) && (assemble == true) ) {
    translate([-164,0,47]) rotate([0,-90,0]) gripper();
    translate([-161,-30,42]) wrist();
    translate([-110,30,52]) rotate([180,0,0]) arm();
    translate([-59,-30,42]) arm();
    translate([0,0,35.9]) plate();
    feet();
}

if ((debug == false) && (assemble == false) ) {
    gripper();
    //axle();
    //left_jaw();
    //right_jaw();
    //rest();
    //wrist();
    //arm();
    //fastener();
    //clip();
    //plate();
    //grip();
    //feet();
}

module gripper() {
    if (assemble == true) {
        translate([-13,11.5,22]) rotate([90,0,0]) fastener();
        translate([0,0,-2.5]) axle();
        translate([0,3,22]) union() {
            translate([13,0,0]) rotate([90,0,0]) right_jaw(); //close: rotate([90,345,0])
            translate([-13,0,0]) rotate([90,0,0]) left_jaw(); //close: rotate([90,15,0])
        }
    }
    translate([13,3.5,22]) rotate([-90,0,180]) servo9g(225); //close: servo9g(240)
    difference() {
        translate([0,0,0.5]) union() {
            for (i= [13:45:359]) {
                rotate([0,0,i]) hull() {
                    translate([37,0,0]) cylinder(r=3, h=3);
                    translate([-37,0,0]) cylinder(r=3, h=3);
                }
            }
            difference() {
                cylinder(r=20, h=6);
                union() {
                    translate([13,4,22]) rotate([90,0,0]) cylinder(r=17, h=8);
                    translate([-13,4,22]) rotate([90,0,0]) cylinder(r=17, h=8);
                }
            }
            translate([-19,4.25,0]) cube([12,6,28]);
            translate([-13,4.25,21.5]) rotate([90,0,0]) cylinder(r=6, h=1);
            translate([30.5,4,0]) cube([6.5,8.25,28]);
            translate([0.5,4,0]) cube([6.5,8.25,28]);
        }
        union() {
            translate([0,0,-3]) cylinder(r=4, h=12);
            translate([0,0,-1]) hull() {
                cylinder(r=3.8, h=10);
                translate([-14.6,0,0]) cylinder(r=2.1, h=10);
            }
            for (i= [110,300,240]) {
                rotate([0,0,i]) translate([10,0,0]) cylinder(r=3, h=10);
            }
            translate([-13,12,22]) rotate([90,0,0]) cylinder(r=3.5, h=10);
            translate([4.75,18,22]) rotate([90,0,0]) cylinder(r=1, h=17);
            translate([32.75,18,22]) rotate([90,0,0]) cylinder(r=1, h=17);
            translate([4.75,18,22]) rotate([90,0,0]) cylinder(r=3, h=4);
            translate([32.75,18,22]) rotate([90,0,0]) cylinder(r=3, h=4);
        }
    }
}

module axle() {
    difference() {
        union() {
            cylinder(r=15, h=3);
            for (i= [110,300,240]) {
                rotate([0,0,i]) translate([10,0,0]) difference() {
                    union() {
                        cylinder(r=2.5, h=9.25);
                        translate([0,0,9.25]) cylinder(r1=3.5, r2=2, h=3);
                    }
                    union() {
                        translate([-5,2.5,9]) cube([10,4,4]);
                        translate([-5,-6.5,9]) cube([10,4,4]);
                        translate([-1,-5,6.25]) cube([2,10,7]);
                    }
                }
            }
        }
        union() {
            translate([0,0,-1]) cylinder(r=4, h=5);
            translate([0,0,1.75]) hull() {
                cylinder(r=3.8, h=3);
                translate([-14.6,0,0]) cylinder(r=2.1, h=3);
            }
        }
    }
}

module jaw(angle) {
    difference() {
        union() {
            translate([0,0,6]) rotate([180,0,angle]) gear(number_of_teeth=10, diametral_pitch=0.39, pressure_angle=20, clearance = 0.2, gear_thickness=6, rim_thickness=6, rim_width=6, hub_thickness=6, hub_diameter=20, bore_diameter=4, circles=0, backlash=0.5, twist=0, involute_facets=0, flat=false);
            hull() {
                translate([0,50,0]) cylinder(r=10, h=6);
                translate([15,15,0]) cylinder(r=10, h=6);
            }
            hull() {
                cylinder(r=10, h=6);
                translate([15,15,0]) cylinder(r=10, h=6);
            }
        }
        union() {
            translate([-4.5,35,-1]) rotate([0,0,-15]) scale([-1,1,1]) cube([20,40,8]);
            if (angle != 0) {
                translate([-4.75,35,0]) for(i = [-3:1.9:30]) {
                    translate([i*sin(15),i*cos(15),-1]) rotate([0,0,30]) cube([2,2,8]);
                }
            }
            else {
                translate([-4.75,35,0]) for(i = [-4:1.9:30]) {
                    translate([i*sin(15),i*cos(15),-1]) rotate([0,0,30]) cube([2,2,8]);
                }
            }
        }
    }
}

module right_jaw() {
    difference() {
        jaw(0);
        union() {
            translate([0,0,-1])cylinder(r=4, h=8);
            translate([0,0,2]) rotate([0,0,-45]) hull() {
                cylinder(r=3.8, h=5);
                translate([0,14.6,0]) cylinder(r=2.1, h=5);
            }
        }
    }
}

module left_jaw() {
    mirror() difference() {
        jaw(18);
        union() {
            translate([0,0,-1])cylinder(r=3.5, h=8);
        }
    }
}

module rest() {
    difference() {
        union() {
                cylinder(r=35, h=3);
                translate([-8,16,0]) cube([16,6.25,16]);
                translate([-8,16,0]) cube([2.5,12,16]);
                translate([5.5,16,0]) cube([2.5,12,16]);
                translate([-8.5,-30,0]) cube([3,7.25,16]);
                translate([5.5,-30,0]) cube([3,7.25,16]);
        }
        union() {
                translate([0,15,10]) rotate([-90,0,0]) cylinder(r=3.5, h=9);
                translate([9,-26.375,9.5]) rotate([0,-90,0]) cylinder(r=0.5, h=18);
                translate([0,0,-1]) cylinder(r=17, h=3.1);
                translate([0,0,2]) cylinder(r1=17, r2=16, h=3);
        }
    }
}

module wrist() {
    if (assemble == true) {
        translate([59,60.5,5]) rotate([90,0,0]) fastener();
        translate([7,60.5,5]) rotate([90,0,0]) fastener();
        translate([-3,30,5]) rotate([0,90,0]) rest();
    }
    translate([0,30,5]) rotate([-90,0,90]) servo9g(90);
    difference() {
        union() {
            cube([65,60,10]);
        }
        union() {
            translate([59,-1,5]) rotate([-90,0,0]) cylinder(r=3.5, h=62); //falso eje delantero
            translate([59,59,5]) rotate([-90,0,0]) cylinder(r=5.5, h=2); //rebaje fastener delantero
            translate([7,50,5]) rotate([-90,0,0]) cylinder(r=3.5, h=15); //falso eje trasero
            translate([7,59,5]) rotate([-90,0,0]) cylinder(r=5.5, h=2); //rebaje fastener trasero
            translate([36,9.5,-1]) cube([30,37,12]); //hueco servo plate
            translate([46,50,-1]) cube([20,6.5,12]); //hueco anclaje fastener
            translate([41,-1,-1]) cube([25,6.5,12]); //hueco anclaje horn servo
            translate([59,10,5]) rotate([90,90,0]) cylinder(r=3.8, h=5);
            translate([59,8,5]) rotate([90,90,0]) hull() { //horn
                cylinder(r=3.8, h=2.6);
                translate([0,-14.6,0]) cylinder(r=2.1, h=2.6);
            }
            translate([-1,7.25,-1]) cube([12,45.5,12]);
            translate([10.5,12.4,-1]) cube([17,23.75,12]);
            translate([10,10.25,5]) rotate([0,90,0]) cylinder(r=1, h=7);
            translate([10,38.375,5]) rotate([0,90,0]) cylinder(r=1, h=7);
            translate([17,31,3]) cube([10,30,4]);
            translate([10,42,-1]) cube([4,10.75,12]);
            translate([6.5,3.65,-4]) cylinder(r=0.75, h=18);
        }
    }
}

module arm() {
    if (assemble == true) {
        translate([59,60.5,5]) rotate([90,0,0]) fastener();
    }
    translate([8,50,5]) rotate([-90,180,0]) servo9g(0);
    difference() {
        union() {
            cube([65,60,10]);
            translate([-3,18,0]) cube([5,20.5,10]);
        }
        union() {
            translate([59,-1,5]) rotate([-90,0,0]) cylinder(r=3.5, h=62); //falso eje delantero
            translate([8,-1,5]) rotate([-90,0,0]) cylinder(r=3.5, h=15); //falso eje trasero
            translate([59,59,5]) rotate([-90,0,0]) cylinder(r=5.5, h=2); //rebaje fastener
            translate([36,9.5,-1]) cube([30,37,12]); //hueco servo plate
            translate([2,22.5,-1]) cube([23.5,20,12]); //hueco servo arm
            translate([-1,38.5,-1]) cube([28,25,12]); //hueco servo arm
            translate([25,38.5,-1]) cube([5.5,23,12]); //hueco aleta servo arm
            translate([46,50,-1]) cube([20,6.5,12]); //hueco anclaje fastener
            translate([41,-1,-1]) cube([25,6.5,12]); //hueco anclaje horn servo
            translate([-1,-1,-1]) cube([20,5,12]); //mordido fastener exterior
            translate([-1,9,-1]) cube([20,9,12]); //mordido fastener interior
            translate([59,10,5]) rotate([90,90,0]) cylinder(r=3.8, h=5);
            translate([59,8,5]) rotate([90,90,0]) hull() {
                cylinder(r=3.8, h=2.6);
                translate([0,-14.6,0]) cylinder(r=2.1, h=2.6);
            }
            translate([27.75,39,5]) rotate([90,0,0]) cylinder(r=1, h=7);
            translate([-.25,39,5]) rotate([90,0,0]) cylinder(r=1, h=7);
            translate([-4,23,3]) cube([10,10,4]);
        }
    }
}

module plate() {
    if (assemble == true) {
        translate([0,0,-1]) grip();
    }
    difference() {
        union() {
            translate([0,0,0]) cylinder(r=35, h=5);
            translate([0,0,-3.5]) difference() {
                cylinder(r=33, h=3.5);
                translate([0,0,-1]) cylinder(r=32, h=6);
            }
        }
        union() {
            translate([0,0,-0.5]) hull() {
                cylinder(r=3.2, h=2.1);
                translate([0,-14.15,0]) cylinder(r=2.1, h=2.1);
            }
            translate([0,0,-1]) cylinder(r=4, h=7);
            translate([-22.5,-10,-0.5]) cube([5,8,7]);
            translate([6,-10,-0.5]) cube([5,8,7]);
            translate([-14.5,-18.3,-0.5]) cube([5,2.5,7]);
            translate([-8,6.5,-0.5]) cube([5,2.5,7]);
            translate([-6.5,20,-0.5]) cube([13,6.5,7]);
            translate([-(calc_chord(10,6)/2),15.25,-1]) cube([calc_chord(10,6),5,7]);
            translate([-(calc_chord(10,6)/2),26.25,-0.1]) cube([calc_chord(10,6),5,7]);
            translate([-(calc_chord(10,6)/2),-27.25,-1]) cube([calc_chord(10,6),10,7]);
        }
    }
}

function calc_chord(r,h) = 2*(sqrt(pow(r,2)-pow(h,2)));

module grip() {
    translate([0,-20,12.15]) rotate([90,0,0]) servo9g(180);
    translate([6.5,-9.5,0]) difference() { //fijación servo
        cube([4,7,15]);
        translate([1.85,-1,12.15]) rotate([-90,0,0]) cylinder(r=1, h=7);
    }
    translate([-22,-9.5,0]) difference() { //fijación servo
        cube([4,7,15]);
        translate([2.25,-1,12.15]) rotate([-90,0,0]) cylinder(r=1, h=7);
    }
    translate([-14,-17.8,0]) cube([4,1.5,9]); //tope servo delantero
    translate([-7.5,7,0]) cube([4,1.5,9]); //tope servo trasero
    difference() {
        translate([-6,20.5,0]) cube([12,5.5,18]); //falso eje
        //*translate([0,-23.5,0]) cube(40);
        translate([0,35,12]) rotate([90,0,0]) cylinder(r=3.5, h=70);
    }
    difference() { //base
        translate([0,0,-2]) cylinder(r=28, h=3);
        union() {
            translate([0,0,-3]) cylinder(r=4, h=5);
            translate([0,0,0.8]) hull() {
                cylinder(r=3.2, h=2.6);
                translate([0,-14.15,0]) cylinder(r=2.1, h=2.6);
            }
        }
    }
}

module feet() {
    union() {
        translate([0,0,33.15]) servo9g(270);
        for (i = [ [0,0,0], [0,0,90], [0,0,180], [0,0,270] ]) {
            rotate(i) union() {
                difference() {
                    union() {
                        translate([0,-5,0]) cube([40,10,3]);
                        translate([40,0,0]) cylinder(r=5, h=3);
                        translate([30,-5,3]) difference(){
                            cube([10,10,29.5]);
                            union() {
                                translate([5,5,3]) cylinder(r=3.5, h=27);
                                translate([5,5,-1]) cylinder(r=2, h=5);
                            }
                        }
                    }
                    translate([35,0,-1]) cylinder(r=2, h=5);
                }
            }
        }
        for (i = [ [-21.75,-7.5,0], [6.35,-7.5,0] ]) {
            translate(i) difference() {
                cube([4,15,22]);
                union() {
                    translate([2,7.5,16]) cylinder(r=1, h=7); //taladro rosca
                    translate([-2,3.25,6.5]) cube(8.5); //hueco cable
                }
            }
        }
    }
}

module fastener() {
    if (assemble == true) {
        translate([0,0,15.5]) clip();
    }
    difference() {
        union() {
            cylinder(r=3.2, h=18);
            cylinder(r=5, h=1);
        }
        union() {
            translate([0,0,15.5]) rotate_extrude(convexity = 10) translate([3.8, 0, 0]) circle(r = 1, $fn = 20);
        }
    }
}

module clip() {
    difference() {
        union() {
            translate([0,0,-0.5]) cylinder(r=5.5, h=1);
        }
        union() {
            translate([0,0,-1]) cylinder(r=2.9, h=3);
            translate([0,0,-1]) cube([10,10,3]);
            translate([0,0,-1]) rotate([0,0,20]) cube([10,10,3]);
        }
    }
}

module servo_horn() {
    difference() {
        union() {
            translate([0,0,2.7]) hull() {
                cylinder(r=3, h=1.6);
                translate([14.15,0,0]) cylinder(r=1.9, h=1.6);
            }
            cylinder(r=3.65, h=4.3);
        }
        union() {
            translate([0,0,-1]) cylinder(r=2.2, h=3.7);
            translate([0,0,3.45]) cylinder(r=2.4, h=2);
            translate([0,0,-1]) cylinder(r=1.25, h=7);
            translate([4.5,0,1]) cylinder(r=0.45, h=4);
            translate([6.6,0,1]) cylinder(r=0.45, h=4);
            translate([8.7,0,1]) cylinder(r=0.45, h=4);
            translate([10.8,0,1]) cylinder(r=0.45, h=4);
            translate([12.9,0,1]) cylinder(r=0.45, h=4);
            translate([15,0,1]) cylinder(r=0.45, h=4);
        }
    }
}

module servo9g(angle) {
    //TowerPro SG90 9g servo
    if (showservos == true) {
        rotate([0,0,angle]) servo_horn();
        translate([-17.2,-6.325,-27]) union() {
            //cuerpo motor
            translate([0,0,0]) cube([23,12.65,22.8]);
            translate([-4.75,0,15.85]) difference() {
                cube([32.5,12.65,2.3]);
                union() {
                    translate([2.2,6.325,-1]) cylinder(r=1, h=4);
                    translate([-1,5.675,-1]) cube([3,1.3,4]);
                    translate([30.3,6.325,-1]) cylinder(r=1, h=4);
                    translate([30.3,5.675,-1]) cube([3,1.3,4]);
                }
            }
            translate([17.2,6.325,22.8]) cylinder(r=5.8, h=4.2);
            translate([10.35,6.325,22.8]) cylinder(r=2.75, h=4.2);
            translate([10.35,3.575,22.8]) cube([3,5.5,4.2]);
            //eje motor
            translate([17.2,6.325,27]) difference() {
                cylinder(r=2.325, h=2.7);
                translate([0,0,-1] )cylinder(r=0.9, h=5);
            }
            //cables
            translate([23,6.325,5.1]) union() {
                rotate([0,90,0]) color("red") cylinder(r=0.6, h=4.75);
                translate([0,-1.1,0]) rotate([0,90,0]) color("brown") cylinder(r=0.6, h=4.75);
                translate([0,1.1,0]) rotate([0,90,0]) color("orange") cylinder(r=0.6, h=4.75);
            }
        }
    }
}
