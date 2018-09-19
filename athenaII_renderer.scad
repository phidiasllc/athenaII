/************************************************************************************

athena_renderer.scad - easily select and render parts and plates for manufacture of Athena platform
Copyright 2015 Jerry Anzalone
Author: Jerry Anzalone <info@phidiasllc.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.

************************************************************************************/

// include the modules required for rendering
include <athenaII.scad>
include<extruder_drive.scad>

//render_part(part_to_render = 10);
render_plate(plate_to_render = 20);

// renders individual parts
module render_part(part_to_render) {
	// end that holds motor - 3 required
	if (part_to_render == 1) athena_end_idler(z_offset_guides = 8);

	// end that holds idler bearings and end limit switches - 3 required
	if (part_to_render == 2) athena_end_motor(z_offset_guides = 8);

	// clamps the guide rods firmly to motor/idler ends - 12 required
	if (part_to_render == 3) bar_clamp();

	// permits tensioning of belts and mount point to carriage - 3 sets required
	if (part_to_render == 4) athena_belt_terminators();

	// carriages ride on the guide rods 3 required for basic platform
	if (part_to_render == 5) athena_basic_carriage();

	// carriages ride on the guide rods 3 required for Parthenos
	if (part_to_render == 6) athena_convertible_carriage(linear_bearing = bearing_lm8uu);

	// the roller switch mount - 3 required for Parthenos
	if (part_to_render == 7) central_limit_switch();

	// if the platform uses a BBB and melzi, one of these is required
	if (part_to_render == 8) bbb_melzi_mount(render_large = true, render_small = true);

	// mounts to vertical board, holds magnetic tools not in use and hides wires - convenience, not required for Parthenos
	if (part_to_render == 9) athena_tool_holder();

	// mounts to vertical board to which extruder drive is mounted and holds spool - convenience, not required
	if (part_to_render == 10) athena_spool_holder(render_mount = false, render_arm = true, render_retainer = false, mount_wood = true);

	// mounts to vertical board, holds tools and hides wires - convenience, not required
	if (part_to_render == 11) athena_hand_tool_holder(wood_mount = true, sonicare_magnet = false);

	// Mounting plate fits in slotted motor-end linking board, one required; print with support
	if (part_to_render == 12) connector_plate();

	// for holding glass to base plate, three required
	if (part_to_render == 13) glass_holddown();

	// end effector with built-in mount for hot end, one required for basic platform
	if (part_to_render == 14) hotend_effector(headless = true, quickrelease = true, vent = false, dalekify = false);

	// thumbscrew for the quick release connector
	if (part_to_render == 15) thumbscrew_quickrelease();

	// shroud mounted to bottom of end effector for improved print cooling
	if (part_to_render == 16) hotend_shroud(height = 18, twist = 5);
        
	if (part_to_render == 17) idler_jig();

	// a place to play
	if (part_to_render == 99) sandbox();
}

// renders production plates
module render_plate(plate_to_render) {
	// approximate build circle to assure placement and fit on build platform
//    translate([0, 0, -h_clamp / 2 - 1])
//        color([1, 0, 0])
//            circle(r = 110);

	if (plate_to_render == 1)
    {
		for (i = [-1:2])
			translate([0, i * (w_clamp + 14) - 30, 0])
				athena_end_idler(z_offset_guides = 8);
        
        for (i = [0, 180])
            rotate([0, 0, i])
                translate([l_clamp / 2 + 20, 0, 0])
                    rotate([0, 0, 270])
                        athena_end_idler(z_offset_guides = 8);
    }

	if (plate_to_render == 2)
    {
		for (i = [-1:1])
			translate([0, i * (w_clamp + 2) - 30, 0])
				athena_end_motor(z_offset_guides = 8);
/*        
        for (i = [0, 180])
            rotate([0, 0, i])
                translate([l_clamp / 2 + 23, 0, 0])
                    rotate([0, 0, 270])
                        athena_end_motor(z_offset_guides = 8);
*/    }

	// hot end effector
	if (plate_to_render == 3) {
		hotend_effector(quickrelease = true, dalekify = false);
	}

	// fixed terminators
	if (plate_to_render == 4) {
		for (i = [-3:2], j = [-1:1])
			//rotate([0, 0, i * 120])
				translate([i * 11, j * 32, 0])
					athena_fixed_belt_terminator();
	}

	// free terminators
	if (plate_to_render == 5) {
		for (i = [-3:2], j = [-1:1])
			//rotate([0, 0, i * 120])
				translate([i * 11, j * 25, 0])
					athena_free_belt_terminator();
	}

	if (plate_to_render == 7) {
        for (i = [-1:1])
            translate([0, i * 36.5, 0])
            {
                // Parthenos carriages
                translate([22, -2, 0])
                    rotate([0, 0, 180])
                        athena_convertible_carriage();

                athena_convertible_carriage();
            }
	}

	if (plate_to_render == 8)
    {
        for (i = [-1:1])
            translate([0, i * 32, 0])
            {
                translate([22, -2, 0])
                    rotate([0, 0, 180])
                        athena_basic_carriage();

                athena_basic_carriage();
            }
	}

	if (plate_to_render == 9) {
        thumbscrew_quickrelease();
        
       for (i = [1:3])
            for (j = [0:5 * i + i -1])
                rotate([0, 0, j * 60 / i])
                    translate([0, i * 21.5, 0])
                        rotate([0, 0, j%2 * 30])
                            thumbscrew_quickrelease();
	}

	if (plate_to_render == 10) {
		for (i = [-1:1], j = [-2:1])
			translate([i * 30, j * 25 + 12.5, 0])
			athena_spool_holder
            (
				render_mount = true,
				mount_wood = true
            );
	}

	if (plate_to_render == 11) {
		for(i = [-1:1])
			translate([0, i * 55, 0])
				bbb_melzi_mount(render_large = true, render_small = false);

	}
    
    if (plate_to_render == 12) {
        for (j = [-2 : 2])
            translate([0, j * 27, 0])
                for (i = [0,1])
                    rotate([0, 0, (i % 2) * 180])
                        translate([0, i * 9, 0])
                            athena_spool_holder
                            (
                                render_arm = true,
                                mount_wood = true
                            );
    }
    
    if (plate_to_render == 13) {
        // 36 spool arm retainers:
        athena_spool_holder
        (
            render_retainer = true,
            mount_wood = true
        );
        
        for (j = [1 : 3])
            for (i = [0:5 * j + j - 1])
                rotate([0, 0, i * 60 / j])
                    translate([j * (d_pivot + 7), 0, 0])
                        athena_spool_holder
                        (
                            render_retainer = true,
                            mount_wood = true
                        );
    }

    if (plate_to_render == 14)
    {
        for (i = [1:4])
            for (j = [0:5 * i + i -1])
                rotate([0, 0, j * 60 / i])
                    translate([i * 13.5, 0, 0])
                        rotate([0, 0, 50])
                            glass_holddown();
    }
    
    if (plate_to_render == 15)
    {
        for (i = [-1:1], j = [-4:4])
            translate([i * 42 + (abs(j) % 2) * 21, j * 9, 0])
                support_strut();
    }
    
    if (plate_to_render == 16)
    {
        for (j = [1 : 3])
            for (i = [0:5 * j + j - 1])
                rotate([0, 0, i * 60 / j])
                    translate([j * 21, 0, 0])
                        axle_8mm();
    }
    
    if (plate_to_render == 17)
    {
        for (i = [-3:2], j = [-2:1])
            translate([i * 20.5, j * 38.5, 0])
                extruder_idler_608z();
    }
    
    if (plate_to_render == 18)
    {
        for (i = [-3:2], j = [-2:2])
            translate([i * 18, j * 21 + abs(i)%2 * 10.5, 0])
                rotate([0, 0, abs(i)%2 * 180])
                    wire_keeper();
    }
    
    if (plate_to_render == 19)
    {
        for (i = [0,1])
            translate([0, i * 53.5, 0])
                bbb_melzi_mount(render_large = true, render_small = false);
    }
    
    if (plate_to_render == 20)
    {
        translate([34, -8, 0])
            rotate([0, 0, 180])
                idler_jig();

        translate([-34, 9, 0])
           idler_jig();
        
        translate([0, -25.5, 0])
            idler_jig();
        
        rotate([0, 0, 180])
            translate([0, -26.5, 0])
                idler_jig();
        
        translate([0, -60, 0])
            idler_jig();
        
        rotate([0, 0, 180])
            translate([0, -61, 0])
                idler_jig();
        
    }
}

module sandbox()
{
    hotend_effector(headless = true, quickrelease = true, vent = false, dalekify = false);
    
    translate([12.5, 58, 0])
        rotate([0, 0, 180])
            hotend_effector(headless = true, quickrelease = true, vent = false, dalekify = false);
    
    translate([57, -19, 0])
        rotate([0, 0, 180])
            hotend_effector(headless = true, quickrelease = true, vent = false, dalekify = false);
    
    translate([-55, -12, 0])
        rotate([0, 0, 180])
            hotend_effector(headless = true, quickrelease = true, vent = false, dalekify = false);
}



module carriage_double() {
	linear_bearing = bearing_lm8uu;
	spacing = 0.5;
	union() {
		translate([0, 0, -h_carriage / 2 + spacing])
			difference() {
				union() {
					carriage_body(linear_bearing = linear_bearing);

					// magnet mounts
					for (i = [-1, 1])
						translate([i * l_effector / 2, -carriage_offset, stage_mount_pad + h_carriage_magnet_mount / sin(tie_rod_angle)])
							rotate([90 - tie_rod_angle, 0, 0])
								magnet_mount(r_pad = r_pad_carriage_magnet_mount, h_pad = h_carriage_magnet_mount);

					mirror([0, 0, 1])
						for (i = [-1, 1])
							translate([i * l_effector / 2, -carriage_offset, stage_mount_pad + h_carriage_magnet_mount / sin(tie_rod_angle)])
								rotate([90 - tie_rod_angle, 0, 0]) {
									magnet_mount(r_pad = r_pad_carriage_magnet_mount, h_pad = h_carriage_magnet_mount);

									// support for printing the mounts
									translate([0, 0, (h_magnet + h_carriage_magnet_mount) / 2 - r_bearing_seated + 0.25])
										difference() {
											cylinder(r = od_magnet / 2 + r_pad_carriage_magnet_mount, h = h_magnet + h_carriage_magnet_mount, center = true);

											cylinder(r = od_magnet / 2, h = h_magnet + h_carriage_magnet_mount, center = true);
										}
							}

				}

				for (i = [-1, 1])
					translate([i * cc_guides / 2, 0, 0])
						carriage_wire_tie_relief(
							linear_bearing = linear_bearing,
							clearance = 0.5
						);

				carriage_bearing_relief(linear_bearing = linear_bearing);

				// flatten the bottom
				translate([0, 0, -h_carriage])
					cube([2 * cc_guides, 4 * (linear_bearing[0] + 6), h_carriage], center = true);
			}
		// bottom half
		translate([0, 0, h_carriage / 2 - spacing])
			difference() {
				union() {
					carriage_body(limit_switch_mount = false, linear_bearing = linear_bearing);

					// add a protrusion for making the vertical board-mounted directional limit switch
					translate([d_pulley / 2 + x_pass / 2 + 5, y_web - 7.5, 0]) // offset it from the belt terminator mount point
						rotate([0, 90, 0])
							intersection() {
								cylinder(r = h_carriage / 2, h = 7, center = true);

								translate([0, h_carriage / 2 - y_web - 2, 0])
									cube([h_carriage, h_carriage, 11], center = true);
							}

				}
				for (i = [-1, 1])
					translate([i * cc_guides / 2, 0, 0])
					carriage_wire_tie_relief(
						linear_bearing = linear_bearing,
						clearance = 0.5
					);

				carriage_bearing_relief(linear_bearing = linear_bearing);

				// belt terminator mount
				translate([d_pulley / 2, y_web, h_carriage / 2 - d_M3_screw / 2 - 5])
					rotate([90, 0, 0])
						cylinder(r = d_M3_screw / 2, h = w_carriage_web + 2, center = true);
			}
	}
}

module hotend_shroud(
	height,
	twist
) {
	t_shroud_base = 2.5;
	t_shroud = 0.6;

	difference() {
		hull() {
		union() {
			cylinder(r = r1_opening + 1.5 + t_shroud, h = t_shroud_base);

				hull()
					effector_shroud_holes(diameter = d_M3_cap / 2, height = t_shroud_base);

				translate([0, 0, height - 0.1])
					cylinder(r = r1_opening + 1.5 + t_shroud, h = 0.1);
			}
		}

		translate([0, 0, -0.5])
			if (twist > 0)
				metric_thread(
					diameter = 2 * (r1_opening + 1.5),
					pitch = 3,
					length = height + 1,
					internal = true,
					n_starts = twist);
			else
				cylinder(r = r1_opening + 1.5, h = height + 2);

		translate([0, 0, t_shroud_base])
			effector_shroud_holes(diameter = d_M3_cap / 2, height = height);

		translate([0, 0, -1])
			effector_shroud_holes(diameter = d_M3_screw / 2, height = t_shroud_base + 2);
	}
}
