// I/O shield for BKHD 1264 NAS MB

// Taken from pages 14 at https://web.archive.org/web/20120725150314/http://www.formfactors.org/developer/specs/atx2_2.pdf
io_shield_width = 44.45 - 0.3; // 1.75" ± 0.008"
io_shield_height = 158.75 - 0.3; // 6.25" ± 0.008"
io_shield_max_rounding = 1; // 0.039"
io_shield_overlap = 2.54; // 0.1"

// Note based on specs.
io_shield_thickness = 1;
io_shield_border = 1.5;
io_shield_border_height = 2.54;

// Datum 0,0 is set to left bottom corner of the I/O Aperture.
translate([-io_shield_overlap, -io_shield_overlap, 0]) union() {

    // Border
    translate([io_shield_overlap, io_shield_overlap, io_shield_thickness]){
        difference() {
            roundedcube(io_shield_height, io_shield_width, io_shield_border_height, io_shield_max_rounding);

            // We move super small amount down to avoid shimmering in openSCAD preview.
            translate([io_shield_border, io_shield_border, -0.001]) cube([
                io_shield_height - 2 * io_shield_border,
                io_shield_width - 2 * io_shield_border,
                io_shield_border_height + 0.002
            ]);
        }
    }

    // Backplate
    difference() {
        roundedcube(
            io_shield_height + 2 * io_shield_overlap,
            io_shield_width + 2 * io_shield_overlap,
            io_shield_thickness,
            io_shield_max_rounding
        );

        translate([io_shield_overlap, io_shield_overlap, -1]) {
            // Place your IO recesses here.

            // IMPORTANT: All distances are relative to the left bottom corner of the I/O aperture! This makes it easy
            // to measure and position the cutouts. Remember when using cylinders, openscad uses position as the center!

            translate([5, 35, 1.6]) linear_extrude(0.5) text("BKHD 1264 NAS MB", size=5);
            translate([5, 30, 1.6]) linear_extrude(0.5) text("https://github.com/rvbg/mainboard-io-shields/tree/main/designs/bkhd-1264-nas-mb    v00.1", size=2.5);

            // USB+USB
            translate([   7,    3, 0]) cube([13, 6.5, 3]);
            translate([   7, 11.5, 0]) cube([13, 6.5, 3]);

            // HDMI+DP
            translate([  26,    3, 0]) cube([17, 5.5, 3]);
            translate([  26,   14, 0]) cube([17, 5.5, 3]);

            // USB+USB
            translate([  49,    3, 0]) cube([13, 6.5, 3]);
            translate([  49, 11.5, 0]) cube([13, 6.5, 3]);

            // LEDs
            translate([ 66,   3, 0]) cube([6, 10, 3]);

            // 4x RJ-45
            translate([ 76, 3.5, 0]) cube([60, 12, 3]);

            // Audio jack 3.5mm
            translate([148,   7, 0]) cylinder(3, 5, 3, $fn=25);
        }
    }
}

module roundedcube(xdim, ydim, zdim, rdim){
    hull(){
        translate([rdim,rdim,0]) cylinder(h=zdim,r=rdim, $fn=100);
        translate([xdim-rdim,rdim,0]) cylinder(h=zdim,r=rdim, $fn=100);
        translate([rdim,ydim-rdim,0]) cylinder(h=zdim,r=rdim, $fn=100);
        translate([xdim-rdim,ydim-rdim,0]) cylinder(h=zdim,r=rdim, $fn=100);
    }
}
