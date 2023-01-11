/*
 * Duplo to Brio converter, for making bridges for Brio tracks using Duplo bricks
 *
 * Design by Thomas Flummer, http://hackmeister.dk/
 *
 * This work is licensed under a Creative Commons Attribution-ShareAlike 3.0 Unported License
 *
 */

resolution = 100;
//cube([76, 10, 10], center=true);

module duplo_interface() {
    // Duplo interface
    difference()
    {
        union()
        {
            translate([16, 0, -6.05])
                cylinder(r = 13.4/2, h = 7.9, center = true, $fn = resolution);

            translate([0, 0, -6.05])
                cylinder(r = 13.4/2, h = 7.9, center = true, $fn = resolution);

            translate([-16, 0, -6.05])
                cylinder(r = 13.4/2, h = 7.9, center = true, $fn = resolution);

            translate([24, (25.5/2)+(2.5/2), -6.05])
                cube([1, 2.5, 7.9], center = true);
            translate([8, (25.5/2)+(2.5/2), -6.05])
                cube([1, 2.5, 7.9], center = true);
            translate([-8, (25.5/2)+(2.5/2), -6.05])
                cube([1, 2.5, 7.9], center = true);
            translate([-24, (25.5/2)+(2.5/2), -6.05])
                cube([1, 2.5, 7.9], center = true);

            translate([24, -(25.5/2)-(2.5/2), -6.05])
                cube([1, 2.5, 7.9], center = true);
            translate([8, -(25.5/2)-(2.5/2), -6.05])
                cube([1, 2.5, 7.9], center = true);
            translate([-8, -(25.5/2)-(2.5/2), -6.05])
                cube([1, 2.5, 7.9], center = true);
            translate([-24, -(25.5/2)-(2.5/2), -6.05])
                cube([1, 2.5, 7.9], center = true);

            translate([+(25.5/2)+(2.5/2)+16, -8, -6.05])
                cube([2.5, 1, 7.9], center = true);
            translate([+(25.5/2)+(2.5/2)+16, 8, -6.05])
                cube([2.5, 1, 7.9], center = true);

            translate([-(25.5/2)-(2.5/2)-16, -8, -6.05])
                cube([2.5, 1, 7.9], center = true);
            translate([-(25.5/2)-(2.5/2)-16, 8, -6.05])
                cube([2.5, 1, 7.9], center = true);
        }

        union()
        {
            translate([16, 0, -6])
                cylinder(r = 10/2, h = 8.1, center = true, $fn = resolution);

            translate([0, 0, -6])
                cylinder(r = 10/2, h = 8.1, center = true, $fn = resolution);

            translate([-16, 0, -6])
                cylinder(r = 10/2, h = 8.1, center = true, $fn = resolution);
        }
    }
}

module duplo_to_brio()
{
    union()
    {
        difference()
        {
            // Initial cuboid
            union()
            {
                translate([0, 0, 0])
                    cube([63.8, 40, 20], center = true);
            }
            union()
            {
                // Peg end space
                translate([(63.8/2)-9.5, 0, 4.5])
                    cube([21, 41, 13], center = true);

                // Slot end space
                translate([-(63.8/2)+9.5, 0, 4.5])
                    cube([21, 41, 13], center = true);

                // Hollow underneath space (Duplo)
                translate([0, 0, -7.5])
                    cube([63.8-3, 31.7-3, 7], center = true);

                // Angle cut (rear)
                translate([0, 20.8, -10])
                rotate(56, [1, 0, 0])
                    cube([80, 20, 8], center = true);

                // Angle cut (front)
                translate([0, -20.8, -10])
                rotate(-56, [1, 0, 0])
                    cube([80, 20, 8], center = true);

                // Slot hole
                translate([0, 0, 4.5])
                    cylinder(r = 6.5, h = 13, center = true, $fn = resolution);

                // Slot slot
                translate([-8, 0, 4.5])
                    cube([20, 7, 13], center = true);

                // Rail space (rear)
                translate([0, 25/2, 8.5])
                    cube([30, 5, 4], center = true);

                // Rail space (front)
                translate([0, -25/2, 8.5])
                    cube([30, 5, 4], center = true);

                // Rail chamfer (front-front)
                translate([0, -25/2-1.5, 8.5+1.5])
                    rotate(-56, [1, 0, 0])
                    cube([30, 3, 4], center = true);

                // Rail chamfer (front-rear)
                translate([0, -25/2+1.5, 8.5+1.5])
                    rotate(56, [1, 0, 0])
                    cube([30, 3, 4], center = true);

                // Rail chamfer (rear-front)
                translate([0, 25/2-1.5, 8.5+1.5])
                    rotate(-56, [1, 0, 0])
                    cube([30, 3, 4], center = true);

                // Rail chamfer (rear-rear)
                translate([0, 25/2+1.5, 8.5+1.5])
                    rotate(56, [1, 0, 0])
                    cube([30, 3, 4], center = true);
            }
        }

        // Peg plug
        translate([11.9+12, 0, 3.5])
            cylinder(r = 11.5/2, h = 13, center = true, $fn = resolution);

        // Peg rod
        translate([11.9+5, 0, 3.5])
            cube([12, 6, 13], center = true);

        duplo_interface();
    }
}

*duplo_to_brio();

//angle = 30; // °
// Length of the piece should be about 1 Duplo brick, 63.8mm.
// angle/360 * C = 63.8mm
//C = 63.8 * 360 / angle;
//echo ("C", C);
// C = 2 * PI * r
// r = C / 2 / PI
//r = C / 2 / PI;
//r = 63.8 / sin(angle);
//echo (r);

ledge_slot = 6;
ledge_peg = 18;
ledge_depth = 12-7;

slope = 1/6;
w = 63.8 - ledge_slot - ledge_peg;
h = w*slope;
echo("h", h);
r = (w*w+h*h)/(2*h);
echo("r", r);

angle = acos((r-h) / r);
echo("angle", angle);
C = w * 360 / angle;

intersection() {
    difference() {
        union() {
            translate([0, 0, -r+h+1])
            rotate([0, 0, -90])
            rotate([0, -90, 0])
            rotate_extrude(angle = angle, $fn=200)
            translate([r, 0, 0]) union() {

                difference() {
                    translate([-8, -20, 0]) square([20, 40]);

                    // Rail slots
                    translate([12-3.495, -2.5-12.5, 0])
                        square([3.5, 5]);
                    translate([12-3.495, -2.5+12.5, 0])
                        square([3.5, 5]);

                    // Rail chamfers
                    translate([12.5, 10.5, 0])
                    rotate(56, [0, 0, 1])
                    square([4, 4], center=true);
                    translate([12.5, 14.5, 0])
                    rotate(-56, [0, 0, 1])
                    square([4, 4], center=true);

                    translate([12.5, -14.5, 0])
                    rotate(56, [0, 0, 1])
                    square([4, 4], center=true);
                    translate([12.5, -10.5, 0])
                    rotate(-56, [0, 0, 1])
                    square([4, 4], center=true);
                }
            }
            
            translate([-ledge_slot, -20, -20+ledge_depth+h+1]) cube([ledge_slot, 40, 20]);

            translate([0, -20, -r+h+1])
            rotate([0, angle, 0])
            translate([0, 0, -10+ledge_depth+r]) cube([ledge_peg, 40, 10]);
        }

        // Slot connector
        translate([0, 0, 0]) union() {
            // End space
            //cube([20, 21, 41], center = true);

            // Slot
            translate([0, 0, h+10])
                cube([20, 7, 9], center = true);

            // Hole
            translate([12, 0, h+8])
                //rotate([0, 90, 0])
                    cylinder(r = 6.5, h = 7*2, center = true, $fn = resolution);
        }
    }
    translate([-100, -100, 0]) cube([200, 200, 200]);
}

// Peg connector
translate([0, 0, -r+8])
rotate([0, angle, 0])
translate([0, 0, r+7])
union() {
    // Slot
    //translate([0, -10, 0])
        cube([20, 7, 7], center = true);

    // Hole
    translate([12, 0, 0])
        cylinder(r = 6.5, h = 7, center = true, $fn = resolution);
}

translate([w/2+ledge_slot, 0, 0])
union() {
    difference() {
       translate([0, 0, -5]) cube([63.8, 40, 10], center = true);
        translate([0, 0, -6.55]) cube([63.8-3, 31.7-3, 7], center = true);
    }
    duplo_interface();
}
