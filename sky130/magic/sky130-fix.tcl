###
###     Source file sky130-fix.tcl
###     Process this file with the preprocessor script
###
#-----------------------------------------------------
# Magic/TCL design kit for SKYWATER TECHNAME:  Fixed-layout devices
#-----------------------------------------------------

#----------------------------------------------------------------
# Fixed device: Specify all user-editable default values
#
# deltax --- Additional horizontal space between devices
# deltay --- Additional vertical space between devices
# nx     --- Number of arrayed devices in X
# ny     --- Number of arrayed devices in Y
#
# Note that these values, specifically nx, ny, deltax,
# and deltay, are properties of the instance, not the cell.
# They translate to the instance array x and y counts;  while
# deltax is the x pitch less the cell width, and deltay is the
# y pitch less the cell height.
#
# non-user-editable
#
# nocell --- Indicates that this cell has a predefined layout
#	     and therefore there is no cell to draw.
# xstep  --- Width of the cell (nominal array pitch in X)
# ystep  --- Height of the cell (nominal array pitch in Y)
#----------------------------------------------------------------

# Fixed-layout devices (from sky130_fd_pr_base, _rf, and _rf2 libraries)
#
# Bipolar transistors:
#
# sky130_fd_pr__npn_05v5_W1p00L1p00
# sky130_fd_pr__npn_05v5_W1p00L2p00
# sky130_fd_pr__pnp_05v5_W3p40L3p40
# sky130_fd_pr__pnp_05v5_W0p68L0p68
# sky130_fd_pr__npn_11v0_W1p00L1p00
#
# Parallel Plate Capacitors:
#
# sky130_fd_pr__cap_vpp_11p5x11p7_m1m2m3m4_shieldlim5
# sky130_fd_pr__cap_vpp_11p5x11p7_m1m2_noshield
# sky130_fd_pr__cap_vpp_08p6x07p8_m1m2_shieldl1
# sky130_fd_pr__cap_vpp_04p4x04p6_m1m2_shieldl1
#
# Inductors:
#
# sky130_fd_pr__rf_test_coil1
# sky130_fd_pr__rf_test_coil2
# sky130_fd_pr__rf_test_coil3

proc sky130::sky130_fd_pr__npn_05v5_W1p00L1p00_defaults {} {
    return {nx 1 ny 1 deltax 0 deltay 0 nocell 1 xstep 7.03 ystep 7.03 class bjt}
}
proc sky130::sky130_fd_pr__npn_05v5_W1p00L2p00_defaults {} {
    return {nx 1 ny 1 deltax 0 deltay 0 nocell 1 xstep 7.03 ystep 8.03 class bjt}
}

proc sky130::sky130_fd_pr__pnp_05v5_W0p68L0p68_defaults {} {
    return {nx 1 ny 1 deltax 0 deltay 0 nocell 1 xstep 3.72 ystep 3.72 class bjt}
}

proc sky130::sky130_fd_pr__pnp_05v5_W3p40L3p40_defaults {} {
    return {nx 1 ny 1 deltax 0 deltay 0 nocell 1 xstep 6.44 ystep 6.44 class bjt}
}
proc sky130::sky130_fd_pr__npn_11v0_W1p00L1p00_defaults {} {
    return {nx 1 ny 1 deltax 0 deltay 0 nocell 1 xstep 7.03 ystep 7.03 class bjt}
}

proc sky130::sky130_fd_pr__rf_test_coil1_defaults {} {
    return {nx 1 ny 1 deltax 0 deltay 0 nocell 1 xstep 258 ystep 258 class inductor}
}
proc sky130::sky130_fd_pr__rf_test_coil2_defaults {} {
    return {nx 1 ny 1 deltax 0 deltay 0 nocell 1 xstep 290 ystep 404 class inductor}
}
proc sky130::sky130_fd_pr__rf_test_coil3_defaults {} {
    return {nx 1 ny 1 deltax 0 deltay 0 nocell 1 xstep 290 ystep 404 class inductor}
}

proc sky130::sky130_fd_pr__cap_vpp_11p5x11p7_m1m2m3m4_shieldl1m5_defaults {} {
    return {nx 1 ny 1 deltax 0 deltay 0 nocell 1 xstep 11.08 ystep 11.36 class capacitor}
}
proc sky130::sky130_fd_pr__cap_vpp_11p5x11p7_m1m2_noshield_defaults {} {
    return {nx 1 ny 1 deltax 0 deltay 0 nocell 1 xstep 11.08 ystep 11.36 class capacitor}
}
proc sky130::sky130_fd_pr__cap_vpp_08p6x07p8_m1m2_shieldl1_defaults {} {
    return {nx 1 ny 1 deltax 0 deltay 0 nocell 1 xstep 11.08 ystep 11.36 class capacitor}
}
proc sky130::sky130_fd_pr__cap_vpp_04p4x04p6_m1m2_shieldl1_defaults {} {
    return {nx 1 ny 1 deltax 0 deltay 0 nocell 1 xstep 11.08 ystep 11.36 class capacitor}
}

#----------------------------------------------------------------
# Fixed device: Conversion from SPICE netlist parameters to toolkit
#----------------------------------------------------------------

proc sky130::fixed_convert {parameters} {
    set pdkparams [dict create]
    dict for {key value} $parameters {
	switch -nocase $key {
	    m {
		 dict set pdkparams nx $value
	    }
	    default {
		# Allow unrecognized parameters to be passed unmodified
		dict set pdkparams $key $value
	    }
	}
    }
    return $pdkparams
}

#----------------------------------------------------------------

proc sky130::sky130_fd_pr__npn_05v5_W1p00L1p00_convert {parameters} {
    return [sky130::fixed_convert $parameters]
}

proc sky130::sky130_fd_pr__npn_05v5_W1p00L2p00_convert {parameters} {
    return [sky130::fixed_convert $parameters]
}

proc sky130::sky130_fd_pr__pnp_05v5_W0p68L0p68_convert {parameters} {
    return [sky130::fixed_convert $parameters]
}

proc sky130::sky130_fd_pr__pnp_05v5_W3p40L3p40_convert {parameters} {
    return [sky130::fixed_convert $parameters]
}

proc sky130::sky130_fd_pr__npn_11v0_W1p00L1p00_convert {parameters} {
    return [sky130::fixed_convert $parameters]
}

proc sky130::sky130_fd_pr__rf_test_coil1_convert {parameters} {
    return [sky130::fixed_convert $parameters]
}

proc sky130::sky130_fd_pr__rf_test_coil2_convert {parameters} {
    return [sky130::fixed_convert $parameters]
}

proc sky130::sky130_fd_pr__rf_test_coil3_convert {parameters} {
    return [sky130::fixed_convert $parameters]
}

proc sky130::sky130_fd_pr__cap_vpp_11p5x11p7_m1m2m3m4_shieldl1m5_convert {parameters} {
    return [sky130::fixed_convert $parameters]
}
proc sky130::sky130_fd_pr__cap_vpp_11p5x11p7_m1m2_noshield_convert {parameters} {
    return [sky130::fixed_convert $parameters]
}
proc sky130::sky130_fd_pr__cap_vpp_08p6x07p8_m1m2_shieldl1_convert {parameters} {
    return [sky130::fixed_convert $parameters]
}
proc sky130::sky130_fd_pr__cap_vpp_04p4x04p6_m1m2_shieldl1_convert {parameters} {
    return [sky130::fixed_convert $parameters]
}

#----------------------------------------------------------------
# Fixed device: Interactively specifies the fixed layout parameters
#----------------------------------------------------------------

proc sky130::fixed_dialog {parameters} {
    # Instance fields:	    nx, ny, pitchx, pitchy
    # Editable fields:	    nx, ny, deltax, deltay
    # Non-editable fields:  nocell, xstep, ystep

    # Set a local variable for each parameter (e.g., $l, $w, etc.)
    foreach key [dict keys $parameters] {
        set $key [dict get $parameters $key]
    }

    # "nocell" field causes nx and ny to be dropped in from
    # "array count".  Also "pitchx" and "pitchy" are passed
    # in internal units.  Convert these to microns and generate
    # If there is no pitchx and pitchy, then the device has not
    # yet been created, so keep the deltax and deltay defaults.

    if [dict exists $parameters pitchx] {
	set pitchux [magic::i2u $pitchx]
	set stepux [magic::spice2float $xstep]
        set deltax [magic::3digitpastdecimal [expr $pitchux - $stepux]] 
        # An array size 1 should not cause deltax to go negative
	if {$deltax < 0.0} {set deltax 0.0}
	dict set parameters deltax $deltax
    }
    if [dict exists $parameters pitchy] {
	set pitchuy [magic::i2u $pitchy]
	set stepuy [magic::spice2float $ystep]
        set deltay [magic::3digitpastdecimal [expr $pitchuy - $stepuy]] 
        # An array size 1 should not cause deltay to go negative
	if {$deltay < 0.0} {set deltay 0.0}
	dict set parameters deltay $deltay
    }

    magic::add_entry nx "NX" $parameters
    magic::add_entry ny "NY" $parameters
    magic::add_entry deltax "X step (um)" $parameters
    magic::add_entry deltay "Y step (um)" $parameters
}

proc sky130::sky130_fd_pr__npn_05v5_W1p00L1p00_dialog {parameters} {
    sky130::fixed_dialog $parameters
}

proc sky130::sky130_fd_pr__npn_05v5_W1p00L2p00_dialog {parameters} {
    sky130::fixed_dialog $parameters
}

proc sky130::sky130_fd_pr__pnp_05v5_W0p68L0p68_dialog {parameters} {
    sky130::fixed_dialog $parameters
}

proc sky130::sky130_fd_pr__pnp_05v5_W3p40L3p40_dialog {parameters} {
    sky130::fixed_dialog $parameters
}

proc sky130::sky130_fd_pr__npn_11v0_W1p00L1p00_dialog {parameters} {
    sky130::fixed_dialog $parameters
}

proc sky130::sky130_fd_pr__rf_test_coil1_dialog {parameters} {
    sky130::fixed_dialog $parameters
}

proc sky130::sky130_fd_pr__rf_test_coil2_dialog {parameters} {
    sky130::fixed_dialog $parameters
}

proc sky130::sky130_fd_pr__rf_test_coil3_dialog {parameters} {
    sky130::fixed_dialog $parameters
}

proc sky130::sky130_fd_pr__cap_vpp_11p5x11p7_m1m2m3m4_shieldl1m5_dialog {parameters} {
    sky130::fixed_dialog $parameters
}
proc sky130::sky130_fd_pr__cap_vpp_11p5x11p7_m1m2_noshield_dialog {parameters} {
    sky130::fixed_dialog $parameters
}
proc sky130::sky130_fd_pr__cap_vpp_08p6x07p8_m1m2_shieldl1_dialog {parameters} {
    sky130::fixed_dialog $parameters
}
proc sky130::sky130_fd_pr__cap_vpp_04p4x04p6_m1m2_shieldl1_dialog {parameters} {
    sky130::fixed_dialog $parameters
}

#----------------------------------------------------------------
# Fixed device: Draw the device
#----------------------------------------------------------------

proc sky130::fixed_draw {devname parameters} {

    # Set a local variable for each parameter (e.g., $l, $w, etc.)
    foreach key [dict keys $parameters] {
        set $key [dict get $parameters $key]
    }

    # This cell declares "nocell" in parameters, so it needs to
    # instance the cell and set properties.

    # Instantiate the cell.  The name corresponds to the cell in the sky130_fd_pr_* directory.
    set instname [getcell ${devname}]

    set deltax [magic::spice2float $deltax] 
    set deltay [magic::spice2float $deltay] 
    set xstep [magic::spice2float $xstep] 
    set ystep [magic::spice2float $ystep] 

    # Array stepping
    if {$nx > 1 || $ny > 1} {
        set xstep [expr $xstep + $deltax]
        set ystep [expr $ystep + $deltay]
        box size ${xstep}um ${ystep}um
	array $nx $ny
    }
    select cell $instname
    expand
    return $instname
}

#----------------------------------------------------------------
# No additional parameters declared for drawing
#----------------------------------------------------------------

proc sky130::sky130_fd_pr__npn_05v5_W1p00L1p00_draw {parameters} {
    return [sky130::fixed_draw sky130_fd_pr__rf_npn_05v5_W1p00L1p00 $parameters]
}

proc sky130::sky130_fd_pr__npn_05v5_W1p00L2p00_draw {parameters} {
    return [sky130::fixed_draw sky130_fd_pr__rf_npn_05v5_W1p00L2p00 $parameters]
}

proc sky130::sky130_fd_pr__pnp_05v5_W0p68L0p68_draw {parameters} {
    return [sky130::fixed_draw sky130_fd_pr__rf_pnp_05v5_W0p68L0p68 $parameters]
}

proc sky130::sky130_fd_pr__pnp_05v5_W3p40L3p40_draw {parameters} {
    return [sky130::fixed_draw sky130_fd_pr__rf_pnp_05v5_W3p40L3p40 $parameters]
}

proc sky130::sky130_fd_pr__npn_11v0_W1p00L1p00_draw {parameters} {
    return [sky130::fixed_draw sky130_fd_pr__rf_npn_11v0_W1p00L1p00 $parameters]
}

proc sky130::sky130_fd_pr__rf_test_coil1_draw {parameters} {
    return [sky130::fixed_draw sky130_fd_pr__rf_test_coil1 $parameters]
}

proc sky130::sky130_fd_pr__rf_test_coil2_draw {parameters} {
    return [sky130::fixed_draw sky130_fd_pr__rf_test_coil2 $parameters]
}

proc sky130::sky130_fd_pr__rf_test_coil3_draw {parameters} {
    return [sky130::fixed_draw sky130_fd_pr__rf_test_coil3 $parameters]
}

proc sky130::sky130_fd_pr__cap_vpp_11p5x11p7_m1m2m3m4_shieldl1m5_draw {parameters} {
    return [sky130::fixed_draw sky130_fd_pr__cap_vpp_11p5x11p7_m1m2m3m4_shieldl1m5 $parameters]
}
proc sky130::sky130_fd_pr__cap_vpp_11p5x11p7_m1m2_noshield_draw {parameters} {
    return [sky130::fixed_draw sky130_fd_pr__cap_vpp_11p5x11p7_m1m2_noshield $parameters]
}
proc sky130::sky130_fd_pr__cap_vpp_08p6x07p8_m1m2_shieldl1_draw {parameters} {
    return [sky130::fixed_draw sky130_fd_pr__cap_vpp_08p6x07p8_m1m2_shieldl1 $parameters]
}
proc sky130::sky130_fd_pr__cap_vpp_04p4x04p6_m1m2_shieldl1_draw {parameters} {
    return [sky130::fixed_draw sky130_fd_pr__cap_vpp_04p4x04p6_m1m2_shieldl1 $parameters]
}

#----------------------------------------------------------------
# Fixed device: Check device parameters for out-of-bounds values
#----------------------------------------------------------------

proc sky130::fixed_check {parameters} {

    # Set a local variable for each parameter (e.g., $l, $w, etc.)
    foreach key [dict keys $parameters] {
        set $key [dict get $parameters $key]
    }

    # Normalize distance units to microns
    set deltax [magic::spice2float $deltax -1] 
    set deltax [magic::3digitpastdecimal $deltax]
    set deltay [magic::spice2float $deltay -1] 
    set deltay [magic::3digitpastdecimal $deltay]

    # nx, ny must be integer
    if {![string is int $nx]} {
	puts stderr "NX must be an integer!"
        dict set parameters nx 1
    }
    if {![string is int $ny]} {
	puts stderr "NY must be an integer!"
        dict set parameters nx 1
    }

    # Number of devices in X and Y must be at least 1
    if {$nx < 1} {
	puts stderr "NX must be >= 1"
        dict set parameters nx 1
    }
    if {$ny < 1} {
	puts stderr "NY must be >= 1"
        dict set parameters nx 1
    }
    # Step less than zero violates DRC
    if {$deltax < 0} {
	puts stderr "X step must be >= 0"
        dict set parameters deltax 0
    }
    if {$deltay < 0} {
	puts stderr "Y step must be >= 0"
        dict set parameters deltay 0
    }
    return $parameters
}

#----------------------------------------------------------------

proc sky130::sky130_fd_pr__npn_05v5_W1p00L1p00_check {parameters} {
    return [sky130::fixed_check $parameters]
}

proc sky130::sky130_fd_pr__npn_05v5_W1p00L2p00_check {parameters} {
    return [sky130::fixed_check $parameters]
}

proc sky130::sky130_fd_pr__pnp_05v5_W0p68L0p68_check {parameters} {
    return [sky130::fixed_check $parameters]
}

proc sky130::sky130_fd_pr__pnp_05v5_W3p40L3p40_check {parameters} {
    return [sky130::fixed_check $parameters]
}

proc sky130::sky130_fd_pr__npn_11v0_W1p00L1p00_check {parameters} {
    return [sky130::fixed_check $parameters]
}

proc sky130::sky130_fd_pr__rf_test_coil1_check {parameters} {
    return [sky130::fixed_check $parameters]
}

proc sky130::sky130_fd_pr__rf_test_coil2_check {parameters} {
    return [sky130::fixed_check $parameters]
}

proc sky130::sky130_fd_pr__rf_test_coil3_check {parameters} {
    return [sky130::fixed_check $parameters]
}

proc sky130::sky130_fd_pr__cap_vpp_11p5x11p7_m1m2m3m4_shieldl1m5_check {parameters} {
    return [sky130::fixed_check $parameters]
}
proc sky130::sky130_fd_pr__cap_vpp_11p5x11p7_m1m2_noshield_check {parameters} {
    return [sky130::fixed_check $parameters]
}
proc sky130::sky130_fd_pr__cap_vpp_08p6x07p8_m1m2_shieldl1_check {parameters} {
    return [sky130::fixed_check $parameters]
}
proc sky130::sky130_fd_pr__cap_vpp_04p4x04p6_m1m2_shieldl1_check {parameters} {
    return [sky130::fixed_check $parameters]
}
