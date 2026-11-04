###
###     Source file gf180mcu-bjt.tcl
###     Process this file with the preprocessor script
###
#-----------------------------------------------------
# Magic/TCL design kit for GF TECHNAME:  Bipolar transistors and eFuse
#-----------------------------------------------------

#----------------------------------------------------------------
# Bipolar: Specify all user-editable default values
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

proc gf180mcu::npn_05p00x05p00_defaults {} {
    return {nx 1 ny 1 deltax 0 deltay 0 nocell 1 xstep 15.29 ystep 22.92 class bjt}
}

proc gf180mcu::npn_00p54x02p00_defaults {} {
    return {nx 1 ny 1 deltax 0 deltay 0 nocell 1 xstep 13.55 ystep 14.95 class bjt}
}

proc gf180mcu::npn_10p00x10p00_defaults {} {
    return {nx 1 ny 1 deltax 0 deltay 0 nocell 1 xstep 23.04 ystep 23.04 class bjt}
}

proc gf180mcu::npn_00p54x10p00_defaults {} {
    return {nx 1 ny 1 deltax 0 deltay 0 nocell 1 xstep 16.94 ystep 16.94 class bjt}
}

proc gf180mcu::eFuse_defaults {} {
    return {nx 1 ny 1 deltax 0 deltay 0 nocell 1 xstep 16.94 ystep 16.94}
}

proc gf180mcu::npn_00p54x04p00_defaults {} {
    return {nx 1 ny 1 deltax 0 deltay 0 nocell 1 xstep 13.92 ystep 16.96 class bjt}
}

proc gf180mcu::npn_00p54x08p00_defaults {} {
    return {nx 1 ny 1 deltax 0 deltay 0 nocell 1 xstep 12.36 ystep 21.22 class bjt}
}

proc gf180mcu::pnp_05p00x05p00_defaults {} {
    return {nx 1 ny 1 deltax 0 deltay 0 nocell 1 xstep 8.25 ystep 8.25 class bjt}
}

proc gf180mcu::pnp_05p00x00p42_defaults {} {
    return {nx 1 ny 1 deltax 0 deltay 0 nocell 1 xstep 3.69 ystep 8.25 class bjt}
}

proc gf180mcu::pnp_10p00x10p00_defaults {} {
    return {nx 1 ny 1 deltax 0 deltay 0 nocell 1 xstep 13.25 ystep 13.25 class bjt}
}

proc gf180mcu::pnp_10p00x00p42_defaults {} {
    return {nx 1 ny 1 deltax 0 deltay 0 nocell 1 xstep 3.75 ystep 13.25 class bjt}
}

#----------------------------------------------------------------
# Bipolar: Conversion from SPICE netlist parameters to toolkit
#----------------------------------------------------------------

proc gf180mcu::fixed_convert {parameters} {
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

proc gf180mcu::npn_05p00x05p00_convert {parameters} {
    return [gf180mcu::fixed_convert $parameters]
}

proc gf180mcu::npn_00p54x02p00_convert {parameters} {
    return [gf180mcu::fixed_convert $parameters]
}

proc gf180mcu::npn_10p00x10p00_convert {parameters} {
    return [gf180mcu::fixed_convert $parameters]
}

proc gf180mcu::npn_00p54x04p00_convert {parameters} {
    return [gf180mcu::fixed_convert $parameters]
}

proc gf180mcu::npn_00p54x10p00_convert {parameters} {
    return [gf180mcu::fixed_convert $parameters]
}
proc gf180mcu::eFuse_convert {parameters} {
    return [gf180mcu::fixed_convert $parameters]
}
proc gf180mcu::npn_00p54x08p00_convert {parameters} {
    return [gf180mcu::fixed_convert $parameters]
}

proc gf180mcu::pnp_05p00x05p00_convert {parameters} {
    return [gf180mcu::fixed_convert $parameters]
}

proc gf180mcu::pnp_05p00x00p42_convert {parameters} {
    return [gf180mcu::fixed_convert $parameters]
}

proc gf180mcu::pnp_10p00x10p00_convert {parameters} {
    return [gf180mcu::fixed_convert $parameters]
}

proc gf180mcu::pnp_10p00x00p42_convert {parameters} {
    return [gf180mcu::fixed_convert $parameters]
}

#----------------------------------------------------------------
# Bipolar: Interactively specifies the fixed layout parameters
#----------------------------------------------------------------

proc gf180mcu::fixed_dialog {parameters} {
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

#----------------------------------------------------------------

proc gf180mcu::npn_05p00x05p00_dialog {parameters} {
    gf180mcu::fixed_dialog $parameters
}

proc gf180mcu::npn_00p54x02p00_dialog {parameters} {
    gf180mcu::fixed_dialog $parameters
}

proc gf180mcu::npn_10p00x10p00_dialog {parameters} {
    gf180mcu::fixed_dialog $parameters
}

proc gf180mcu::npn_00p54x04p00_dialog {parameters} {
    gf180mcu::fixed_dialog $parameters
}

proc gf180mcu::npn_00p54x10p00_dialog {parameters} {
    gf180mcu::fixed_dialog $parameters
}

proc gf180mcu::eFuse_dialog {parameters} {
    gf180mcu::fixed_dialog $parameters
}

proc gf180mcu::npn_00p54x08p00_dialog {parameters} {
    gf180mcu::fixed_dialog $parameters
}

proc gf180mcu::pnp_05p00x05p00_dialog {parameters} {
    gf180mcu::fixed_dialog $parameters
}

proc gf180mcu::pnp_05p00x00p42_dialog {parameters} {
    gf180mcu::fixed_dialog $parameters
}

proc gf180mcu::pnp_10p00x10p00_dialog {parameters} {
    gf180mcu::fixed_dialog $parameters
}

proc gf180mcu::pnp_10p00x00p42_dialog {parameters} {
    gf180mcu::fixed_dialog $parameters
}

#----------------------------------------------------------------
# PNP: Draw the device
#----------------------------------------------------------------

proc gf180mcu::fixed_draw {devname parameters} {

    # Set a local variable for each parameter (e.g., $l, $w, etc.)
    foreach key [dict keys $parameters] {
        set $key [dict get $parameters $key]
    }

    # This cell declares "nocell" in parameters, so it needs to
    # instance the cell and set properties.

    # Instantiate the cell.  The name corresponds to the cell in the primdev directory.
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

proc gf180mcu::npn_05p00x05p00_draw {parameters} {
   return [gf180mcu::fixed_draw npn_05p00x05p00_0 $parameters]
}

proc gf180mcu::npn_00p54x02p00_draw {parameters} {
   return [gf180mcu::fixed_draw npn_00p54x02p00_0 $parameters]
}

proc gf180mcu::npn_10p00x10p00_draw {parameters} {
   return [gf180mcu::fixed_draw npn_10p00x10p00_0 $parameters]
}

proc gf180mcu::npn_00p54x08p00_draw {parameters} {
   return [gf180mcu::fixed_draw npn_npn_00p54x08p00_0 $parameters]
}

proc gf180mcu::npn_00p54x10p00_draw {parameters} {
   return [gf180mcu::fixed_draw npn_00p54x10p00_0 $parameters]
}

proc gf180mcu::eFuse_draw {parameters} {
   return [gf180mcu::fixed_draw eFuse_0 $parameters]
}

proc gf180mcu::npn_00p54x04p00_draw {parameters} {
   return [gf180mcu::fixed_draw npn_00p54x04p00_0 $parameters]
}

proc gf180mcu::pnp_05p00x05p00_draw {parameters} {
   return [gf180mcu::fixed_draw pnp_05p00x05p00_0 $parameters]
}

proc gf180mcu::pnp_05p00x00p42_draw {parameters} {
   return [gf180mcu::fixed_draw pnp_05p00x00p42_0 $parameters]
}

proc gf180mcu::pnp_10p00x10p00_draw {parameters} {
   return [gf180mcu::fixed_draw pnp_10p00x10p00_0 $parameters]
}

proc gf180mcu::pnp_10p00x00p42_draw {parameters} {
   return [gf180mcu::fixed_draw pnp_10p00x00p42_0 $parameters]
}

#----------------------------------------------------------------
# Bipolar: Check device parameters for out-of-bounds values
#----------------------------------------------------------------

proc gf180mcu::fixed_check {parameters} {

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

proc gf180mcu::npn_05p00x05p00_check {parameters} {
    return [gf180mcu::fixed_check $parameters]
}

proc gf180mcu::npn_00p54x02p00_check {parameters} {
    return [gf180mcu::fixed_check $parameters]
}

proc gf180mcu::npn_10p00x10p00_check {parameters} {
    return [gf180mcu::fixed_check $parameters]
}

proc gf180mcu::npn_00p54x04p00_check {parameters} {
    return [gf180mcu::fixed_check $parameters]
}

proc gf180mcu::npn_00p54x10p00_check {parameters} {
    return [gf180mcu::fixed_check $parameters]
}

proc gf180mcu::eFuse_check {parameters} {
    return [gf180mcu::fixed_check $parameters]
}

proc gf180mcu::npn_00p54x08p00_check {parameters} {
    return [gf180mcu::fixed_check $parameters]
}

proc gf180mcu::pnp_05p00x05p00_check {parameters} {
    return [gf180mcu::fixed_check $parameters]
}

proc gf180mcu::pnp_05p00x00p42_check {parameters} {
    return [gf180mcu::fixed_check $parameters]
}

proc gf180mcu::pnp_10p00x10p00_check {parameters} {
    return [gf180mcu::fixed_check $parameters]
}

proc gf180mcu::pnp_10p00x00p42_check {parameters} {
    return [gf180mcu::fixed_check $parameters]
}
