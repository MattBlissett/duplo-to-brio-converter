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

duplo_to_brio();

angle = 30; // °
// Length of the piece should be about 1 Duplo brick, 63.8mm.
// angle/360 * C = 63.8mm
C = 63.8 * 360 / angle;
echo ("C", C);
// C = 2 * PI * r
// r = C / 2 / PI
//r = C / 2 / PI;
r = 63.8 / sin(angle);
echo (r);

difference() {
    rotate_extrude(angle = angle, $fn=200)
    translate([r, 0, 0]) union() {

        difference() {
            translate([0, -20, 0]) square([12, 40]);

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

    // Female connector
    translate([r+11, 0, 0]) union() {
        // End space
        cube([20, 21, 41], center = true);

        // Slot
        translate([0, 9, 0])
            cube([20, 20, 7], center = true);

        // Hole
        translate([0, 18, 0])
            rotate([0, 90, 0])
                cylinder(r = 6.5, h = 20, center = true, $fn = resolution);
    }

    // Male connector end space
    rotate(angle, [0, 0, 1])
    translate([r+11, 0, 0])
    cube([20, 41, 41], center = true);
}

intersection() {
    union() {
        peg_diam = 6.5;
        angle_cyl = (63.8-peg_diam) / C * 360;

        // Peg connector
        rotate(angle_cyl, [0, 0, 1])
        translate([r+11, 0, 0])
        union() {
            // Slot
            translate([0, -10, 0])
                cube([20, 20, 7], center = true);

            // Hole
            rotate([0, 90, 0])
                cylinder(r = 6.5, h = 20, center = true, $fn = resolution);
        }
    }
    cylinder(r=r+12.05, h=40, $fn=200, center=true);
}

d = r - r * cos(angle);
intersection() {
    union() {
        translate([r-d/2, 63.8/2, 0]) cube([d, 63.8, 40], center = true);
    }
    cylinder(r=r+0.05, h=40, $fn=100, center=true);
}

translate([r-d, 63.8/2, 0])
rotate([90, 0, 90]) union() {
    difference() {
       translate([0, 0, -5]) cube([63.8, 40, 10], center = true);
        translate([0, 0, -6.55]) cube([63.8-3, 31.7-3, 7], center = true);
    }
    duplo_interface();
}
