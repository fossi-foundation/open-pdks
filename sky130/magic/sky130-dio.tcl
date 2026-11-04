###
###     Source file sky130-dio.tcl
###     Process this file with the preprocessor script
###
#-----------------------------------------------------
# Magic/TCL design kit for SKYWATER TECHNAME:  Diodes
#-----------------------------------------------------

#----------------------------------------------------------------
# Drawn diode routines
#----------------------------------------------------------------

proc sky130::diode_recalc {field parameters} {
    # Set a local variable for each parameter (e.g., $l, $w, etc.)
    foreach key [dict keys $parameters] {
        set $key [dict get $parameters $key]
    }
    switch  $field {
	area { puts stdout "area changed" }
	peri { puts stdout "perimeter changed" }
	w   { puts stdout "width changed" }
	l   { puts stdout "length changed" }
    }
    dict set parameters area $area
    dict set parameters peri $peri
    dict set parameters w $w
    dict set parameters l $l
}

#----------------------------------------------------------------
# diode: Conversion from SPICE netlist parameters to toolkit
#----------------------------------------------------------------

proc sky130::diode_convert {parameters} {
    set pdkparams [dict create]
    dict for {key value} $parameters {
	switch -nocase $key {
	    l -
	    w -
	    peri {
		# Length, width, and perimeter are converted to units of microns
		set value [magic::spice2float $value]
		# set value [expr $value * 1e6]
		set value [magic::3digitpastdecimal $value]
		dict set pdkparams [string tolower $key] $value
	    }
	    area {
		# area also converted to units of microns
		set value [magic::spice2float $value]
		# set value [expr $value * 1e12]
		set value [magic::3digitpastdecimal $value]
		dict set pdkparams [string tolower $key] $value
	    }
	    m {
                # Convert m to ny
		dict set pdkparams ny $value
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
# diode: Interactively specifies the fixed layout parameters
#----------------------------------------------------------------

proc sky130::diode_dialog {device parameters} {
    # Editable fields:      w, l, area, perim, nx, ny

    magic::add_entry area "Area (um^2)" $parameters
    magic::add_entry peri "Perimeter (um)" $parameters
    sky130::compute_aptot $parameters
    magic::add_message atot "Total area (um^2)" $parameters
    magic::add_message ptot "Total perimeter (um)" $parameters
    magic::add_entry l "Length (um)" $parameters
    magic::add_entry w "Width (um)" $parameters
    magic::add_entry nx "X Repeat" $parameters
    magic::add_entry ny "Y Repeat" $parameters

    if {[dict exists $parameters compatible]} {
       set sellist [dict get $parameters compatible]
       magic::add_selectlist gencell "Device type" $sellist $parameters $device
    }

    if {[dict exists $parameters doverlap]} {
	magic::add_checkbox doverlap "Overlap at end contact" $parameters
    }
    if {[dict exists $parameters elc]} {
        magic::add_checkbox elc "Add left end contact" $parameters
    }
    if {[dict exists $parameters erc]} {
        magic::add_checkbox erc "Add right end contact" $parameters
    }
    if {[dict exists $parameters etc]} {
        magic::add_checkbox etc "Add top end contact" $parameters
    }
    if {[dict exists $parameters ebc]} {
        magic::add_checkbox ebc "Add bottom end contact" $parameters
    }

    if {[dict exists $parameters guard]} {
        magic::add_checkbox full_metal "Full metal guard ring" $parameters
    }
    if {[dict exists $parameters glc]} {
        magic::add_checkbox glc "Add left guard ring contact" $parameters
    }
    if {[dict exists $parameters grc]} {
        magic::add_checkbox grc "Add right guard ring contact" $parameters
    }
    if {[dict exists $parameters gtc]} {
        magic::add_checkbox gtc "Add top guard ring contact" $parameters
    }
    if {[dict exists $parameters gbc]} {
        magic::add_checkbox gbc "Add bottom guard ring contact" $parameters
    }
    if {[dict exists $parameters viagb]} {
	magic::add_entry viagb  "Bottom guard ring via coverage \[+/-\](%)" $parameters
    }
    if {[dict exists $parameters viagt]} {
	magic::add_entry viagt  "Top guard ring via coverage \[+/-\](%)" $parameters
    }
    if {[dict exists $parameters viagr]} {
	magic::add_entry viagr  "Right guard ring via coverage \[+/-\](%)" $parameters
    }
    if {[dict exists $parameters viagl]} {
	magic::add_entry viagl  "Left guard ring via coverage \[+/-\](%)" $parameters
    }

    if {[dict exists $parameters vias]} {
	magic::add_checkbox vias "Add vias over contacts" $parameters
    }

    magic::add_dependency sky130::diode_recalc $device sky130 l w area peri

    if {[dict exists $parameters addports]} {
	magic::add_checkbox doports "Add ports" $parameters
    }

    # magic::add_checkbox dummy "Add dummy" $parameters
}

#----------------------------------------------------------------
# Diode total area and perimeter computation
#----------------------------------------------------------------

proc sky130::compute_aptot {parameters} {
    foreach key [dict keys $parameters] {
        set $key [dict get $parameters $key]
    }
    set area [magic::spice2float $area]
    set area [magic::3digitpastdecimal $area]
    set peri [magic::spice2float $peri]
    set peri [magic::3digitpastdecimal $peri]

    # Compute total area
    catch {set magic::atot_val [expr ($area * $nx * $ny)]}
    # Compute total perimeter
    catch {set magic::ptot_val [expr ($peri * $nx * $ny)]}
}

#----------------------------------------------------------------
# diode: Check device parameters for out-of-bounds values
#----------------------------------------------------------------

proc sky130::diode_check {parameters} {

    set guard 0
    # Set a local variable for each parameter (e.g., $l, $w, etc.)
    foreach key [dict keys $parameters] {
        set $key [dict get $parameters $key]
    }

    # Normalize distance units to microns
    set l [magic::spice2float $l]
    set l [magic::3digitpastdecimal $l] 
    set w [magic::spice2float $w]
    set w [magic::3digitpastdecimal $w] 

    set area [magic::spice2float $area]
    set area [magic::3digitpastdecimal $area] 
    set peri [magic::spice2float $peri]
    set peri [magic::3digitpastdecimal $peri] 

    if {$l == 0} {
        # Calculate L from W and area
	set l [expr ($area / $w)]
	dict set parameters l [magic::float2spice $l]
    } elseif {$w == 0} {
        # Calculate W from L and area
	set w [expr ($area / $l)]
	dict set parameters w [magic::float2spice $w]
    }
    if {$w < $wmin} {
	puts stderr "Diode width must be >= $wmin"
	dict set parameters w $wmin
    } 
    if {$l < $lmin} {
	puts stderr "Diode length must be >= $lmin"
	dict set parameters l $lmin
    } 

    # Check via coverage for syntax
    if {$guard == 1} {
    	if {[catch {expr abs($viagb)}]} {
	    puts stderr "Guard ring bottom via coverage must be numeric!"
            dict set parameters viagb 0
    	} elseif {[expr abs($viagb)] > 100} {
	    puts stderr "Guard ring bottom via coverage can't be more than 100%"
            dict set parameters viagb 100
    	}
    	if {[catch {expr abs($viagt)}]} {
	    puts stderr "Guard ring top via coverage must be numeric!"
            dict set parameters viagt 0
	} elseif {[expr abs($viagt)] > 100} {
	    puts stderr "Guard ring top via coverage can't be more than 100%"
            dict set parameters viagt 100
	}
	if {[catch {expr abs($viagr)}]} {
	    puts stderr "Guard ring right via coverage must be numeric!"
            dict set parameters viagr 0
	} elseif {[expr abs($viagr)] > 100} {
	    puts stderr "Guard ring right via coverage can't be more than 100%"
            dict set parameters viagr 100
   	} 
        if {[catch {expr abs($viagl)}]} {
	    puts stderr "Guard ring left via coverage must be numeric!"
            dict set parameters viagl 0
	} elseif {[expr abs($viagl)] > 100} {
	   puts stderr "Guard ring left via coverage can't be more than 100%"
           dict set parameters viagl 100
	}
    }

    # Calculate area and perimeter from L and W
    set area [expr ($l * $w)]
    dict set parameters area [magic::float2spice $area]
    set peri [expr (2 * ($l + $w))]
    dict set parameters peri [magic::float2spice $peri]
    sky130::compute_aptot $parameters

    return $parameters
}

#------------------------------------------------------------------
# NOTE:  sky130_fd_pr__diode_pw2nd_05v5_lvt,
# sky130_fd_pr__diode_pw2nd_05v5_nvt, sky130_fd_pr__diode_pd2nw_05v5_lvt,
# and sky130_fd_pr__diode_pd2nw_11v0 are all considered parasitic diodes.
# They may be generated by invoking the build procedure on the
# command line.  To enable them in the PDK, add them to the
# appropriate compatible {} list.
#------------------------------------------------------------------

proc sky130::sky130_fd_pr__diode_pw2nd_05v5_defaults {} {
    return {w 0.45 l 0.45 area 0.2025 peri 1.8 \
	nx 1 ny 1 dummy 0 lmin 0.45 wmin 0.45 class diode \
	elc 1 erc 1 etc 1 ebc 1 doverlap 0 \
	compatible {sky130_fd_pr__diode_pw2nd_05v5 sky130_fd_pr__diode_pw2nd_05v5_lvt \
	sky130_fd_pr__diode_pw2nd_05v5_nvt sky130_fd_pr__diode_pw2nd_11v0} \
	full_metal 1 vias 1 viagb 0 viagt 0 viagl 0 viagr 0 doports 1}
}

proc sky130::sky130_fd_pr__diode_pw2nd_05v5_lvt_defaults {} {
    return {w 0.45 l 0.45 area 0.2025 peri 1.8 \
	nx 1 ny 1 dummy 0 lmin 0.45 wmin 0.45 class diode \
	elc 1 erc 1 etc 1 ebc 1 doverlap 0 \
	compatible {sky130_fd_pr__diode_pw2nd_05v5 sky130_fd_pr__diode_pw2nd_05v5_lvt \
	sky130_fd_pr__diode_pw2nd_05v5_nvt sky130_fd_pr__diode_pw2nd_11v0} \
	full_metal 1 vias 1 viagb 0 viagt 0 viagl 0 viagr 0 doports 1}
}

proc sky130::sky130_fd_pr__diode_pw2nd_05v5_nvt_defaults {} {
    return {w 0.45 l 0.45 area 0.2024 peri 1.8 \
	nx 1 ny 1 dummy 0 lmin 0.45 wmin 0.45 class diode \
	elc 1 erc 1 etc 1 ebc 1 doverlap 0 \
	compatible {sky130_fd_pr__diode_pw2nd_05v5 sky130_fd_pr__diode_pw2nd_05v5_lvt \
	sky130_fd_pr__diode_pw2nd_05v5_nvt sky130_fd_pr__diode_pw2nd_11v0} \
	full_metal 1 vias 1 viagb 0 viagt 0 viagl 0 viagr 0 doports 1}
}

proc sky130::sky130_fd_pr__diode_pw2nd_11v0_defaults {} {
    return {w 0.45 l 0.45 area 0.2024 peri 1.8 \
	nx 1 ny 1 dummy 0 lmin 0.45 wmin 0.45 class diode \
	elc 1 erc 1 etc 1 ebc 1 doverlap 0 \
	compatible {sky130_fd_pr__diode_pw2nd_05v5 sky130_fd_pr__diode_pw2nd_05v5_lvt \
	sky130_fd_pr__diode_pw2nd_05v5_nvt sky130_fd_pr__diode_pw2nd_11v0} \
	full_metal 1 vias 1 viagb 0 viagt 0 viagl 0 viagr 0 doports 1}
}

proc sky130::sky130_fd_pr__photodiode_defaults {} {
    return {nx 1 ny 1 deltax 0 deltay 0 xstep 8.0 ystep 8.0 class diode}
}

proc sky130::sky130_fd_pr__diode_pd2nw_05v5_defaults {} {
    return {w 0.45 l 0.45 area 0.2025 peri 1.8 \
	nx 1 ny 1 dummy 0 lmin 0.45 wmin 0.45 class diode \
	elc 1 erc 1 etc 1 ebc 1 \
	glc 1 grc 1 gtc 1 gbc 1 doverlap 0 \
	compatible {sky130_fd_pr__diode_pd2nw_05v5 sky130_fd_pr__diode_pd2nw_05v5_lvt \
	sky130_fd_pr__diode_pd2nw_05v5_hvt sky130_fd_pr__diode_pd2nw_11v0} \
	full_metal 1 vias 1 viagb 0 viagt 0 viagl 0 viagr 0 doports 1}
}

proc sky130::sky130_fd_pr__diode_pd2nw_05v5_lvt_defaults {} {
    return {w 0.45 l 0.45 area 0.2025 peri 1.8 \
	nx 1 ny 1 dummy 0 lmin 0.45 wmin 0.45 class diode \
	elc 1 erc 1 etc 1 ebc 1 \
	glc 1 grc 1 gtc 1 gbc 1 doverlap 0 \
	compatible {sky130_fd_pr__diode_pd2nw_05v5 sky130_fd_pr__diode_pd2nw_05v5_lvt \
	sky130_fd_pr__diode_pd2nw_05v5_hvt sky130_fd_pr__diode_pd2nw_11v0} \
	full_metal 1 vias 1 viagb 0 viagt 0 viagl 0 viagr 0 doports 1}
}

proc sky130::sky130_fd_pr__diode_pd2nw_05v5_hvt_defaults {} {
    return {w 0.45 l 0.45 area 0.2025 peri 1.8 \
	nx 1 ny 1 dummy 0 lmin 0.45 wmin 0.45 class diode \
	elc 1 erc 1 etc 1 ebc 1 \
	glc 1 grc 1 gtc 1 gbc 1 doverlap 0 \
	compatible {sky130_fd_pr__diode_pd2nw_05v5 sky130_fd_pr__diode_pd2nw_05v5_lvt \
	sky130_fd_pr__diode_pd2nw_05v5_hvt sky130_fd_pr__diode_pd2nw_11v0} \
	full_metal 1 vias 1 viagb 0 viagt 0 viagl 0 viagr 0 doports 1}
}


proc sky130::sky130_fd_pr__diode_pd2nw_11v0_defaults {} {
    return {w 0.45 l 0.45 area 0.2024 peri 1.8 \
	nx 1 ny 1 dummy 0 lmin 0.45 wmin 0.45 class diode \
	elc 1 erc 1 etc 1 ebc 1 \
	glc 1 grc 1 gtc 1 gbc 1 doverlap 0 \
	compatible {sky130_fd_pr__diode_pd2nw_05v5 sky130_fd_pr__diode_pd2nw_05v5_lvt \
	sky130_fd_pr__diode_pd2nw_05v5_hvt sky130_fd_pr__diode_pd2nw_11v0} \
	full_metal 1 vias 1 viagb 0 viagt 0 viagl 0 viagr 0 doports 1}
}

#----------------------------------------------------------------

proc sky130::sky130_fd_pr__diode_pw2nd_05v5_convert {parameters} {
    return [sky130::diode_convert $parameters]
}

proc sky130::sky130_fd_pr__diode_pw2nd_05v5_lvt_convert {parameters} {
    return [sky130::diode_convert $parameters]
}

proc sky130::sky130_fd_pr__diode_pw2nd_05v5_nvt_convert {parameters} {
    return [sky130::diode_convert $parameters]
}

proc sky130::sky130_fd_pr__diode_pw2nd_11v0_convert {parameters} {
    return [sky130::diode_convert $parameters]
}

proc sky130::sky130_fd_pr__photodiode_convert {parameters} {
    return [sky130::fixed_convert $parameters]
}

proc sky130::sky130_fd_pr__diode_pd2nw_05v5_convert {parameters} {
    return [sky130::diode_convert $parameters]
}

proc sky130::sky130_fd_pr__diode_pd2nw_05v5_lvt_convert {parameters} {
    return [sky130::diode_convert $parameters]
}

proc sky130::sky130_fd_pr__diode_pd2nw_05v5_hvt_convert {parameters} {
    return [sky130::diode_convert $parameters]
}

proc sky130::sky130_fd_pr__diode_pd2nw_11v0_convert {parameters} {
    return [sky130::diode_convert $parameters]
}

#----------------------------------------------------------------

proc sky130::sky130_fd_pr__diode_pw2nd_05v5_dialog {parameters} {
    sky130::diode_dialog sky130_fd_pr__diode_pw2nd_05v5 $parameters
}

proc sky130::sky130_fd_pr__diode_pw2nd_05v5_lvt_dialog {parameters} {
    sky130::diode_dialog sky130_fd_pr__diode_pw2nd_05v5_lvt $parameters
}

proc sky130::sky130_fd_pr__diode_pw2nd_05v5_nvt_dialog {parameters} {
    sky130::diode_dialog sky130_fd_pr__diode_pw2nd_05v5_nvt $parameters
}

proc sky130::sky130_fd_pr__diode_pw2nd_11v0_dialog {parameters} {
    sky130::diode_dialog sky130_fd_pr__diode_pw2nd_11v0 $parameters
}

proc sky130::sky130_fd_pr__photodiode_dialog {parameters} {
    sky130::fixed_dialog $parameters
}

proc sky130::sky130_fd_pr__diode_pd2nw_05v5_dialog {parameters} {
    sky130::diode_dialog sky130_fd_pr__diode_pd2nw_05v5 $parameters
}

proc sky130::sky130_fd_pr__diode_pd2nw_05v5_lvt_dialog {parameters} {
    sky130::diode_dialog sky130_fd_pr__diode_pd2nw_05v5_lvt $parameters
}

proc sky130::sky130_fd_pr__diode_pd2nw_05v5_hvt_dialog {parameters} {
    sky130::diode_dialog sky130_fd_pr__diode_pd2nw_05v5_hvt $parameters
}

proc sky130::sky130_fd_pr__diode_pd2nw_11v0_dialog {parameters} {
    sky130::diode_dialog sky130_fd_pr__diode_pd2nw_11v0 $parameters
}

#----------------------------------------------------------------

proc sky130::sky130_fd_pr__diode_pw2nd_05v5_check {parameters} {
    sky130::diode_check $parameters
}

proc sky130::sky130_fd_pr__diode_pw2nd_05v5_lvt_check {parameters} {
    sky130::diode_check $parameters
}

proc sky130::sky130_fd_pr__diode_pw2nd_05v5_nvt_check {parameters} {
    sky130::diode_check $parameters
}

proc sky130::sky130_fd_pr__diode_pw2nd_11v0_check {parameters} {
    sky130::diode_check $parameters
}

proc sky130::sky130_fd_pr__photodiode_check {parameters} {
    sky130::fixed_check $parameters
}

proc sky130::sky130_fd_pr__diode_pd2nw_05v5_check {parameters} {
    sky130::diode_check $parameters
}

proc sky130::sky130_fd_pr__diode_pd2nw_05v5_lvt_check {parameters} {
    sky130::diode_check $parameters
}

proc sky130::sky130_fd_pr__diode_pd2nw_05v5_hvt_check {parameters} {
    sky130::diode_check $parameters
}

proc sky130::sky130_fd_pr__diode_pd2nw_11v0_check {parameters} {
    sky130::diode_check $parameters
}

#----------------------------------------------------------------
# Diode: Draw a single device
#----------------------------------------------------------------

proc sky130::diode_device {parameters} {
    # Epsilon for avoiding round-off errors
    set eps  0.0005

    # Set local default values if they are not in parameters
    set doports 0	;# no port labels by default
    set dev_surround 0
    set dev_sub_type ""

    set term_d ""	;# diffusion
    set term_s ""	;# substrate/well

    # Set a local variable for each parameter (e.g., $l, $w, etc.)
    foreach key [dict keys $parameters] {
        set $key [dict get $parameters $key]
    }

    # If there is no end_sub_surround, set it to sub_surround
    if {![dict exists $parameters end_sub_surround]} {
	set end_sub_surround $sub_surround
    }

    # Draw the device
    pushbox
    box size 0 0

    set hw [/ $w 2.0]
    set hl [/ $l 2.0]

    # Calculate ring size (measured to contact center)
    set gx [+ $w [* 2.0 [+ $dev_spacing $dev_surround]] $contact_size]
    set gy [+ $l [* 2.0 [+ $dev_spacing $dev_surround]] $contact_size]

    # Draw the ring first, because diode may occupy well/substrate plane
    set guardparams $parameters
    dict set guardparams plus_diff_type $end_type
    dict set guardparams plus_contact_type $end_contact_type
    dict set guardparams diff_surround $end_surround
    dict set guardparams sub_type $end_sub_type
    dict set guardparams sub_surround $sub_surround
    dict set guardparams guard_sub_surround $end_sub_surround
    dict set guardparams glc $elc
    dict set guardparams grc $erc
    dict set guardparams gtc $etc
    dict set guardparams gbc $ebc

    if {$term_s != ""} {
	dict set guardparams bulk $term_s
    } else {
	dict unset guardparams bulk
    }
    set cext [sky130::guard_ring $gx $gy $guardparams]

    pushbox
    box grow n ${hl}um
    box grow s ${hl}um
    box grow e ${hw}um
    box grow w ${hw}um
    paint ${dev_type}
    set cext [sky130::unionbox $cext [sky130::getbox]]

    if {$dev_sub_type != ""} {
	box grow n ${sub_surround}um
	box grow s ${sub_surround}um
	box grow e ${sub_surround}um
	box grow w ${sub_surround}um
	paint ${dev_sub_type}
    }
    popbox

    # Diffusion port label
    if {$term_d != ""} {
	label $term_d c $dev_type
	select area label
	port make
    }

    if {${w} < ${l}} {
	set orient vert
    } else {
	set orient horz
    }

    # Reduce width by surround amount
    set w [- $w [* ${dev_surround} 2.0]]
    set l [- $l [* ${dev_surround} 2.0]]

    # Draw via over contact first
    if {$vias != 0} {
        pushbox
        set ch $l
    	if {$ch < $via_size} {set ch $via_size}
    	set cw $w
    	if {$cw < $via_size} {set cw $via_size}
	box grow n [/ $ch 2]um
	box grow s [/ $ch 2]um
	box grow w [/ $cw 2]um
	box grow e [/ $cw 2]um
        sky130::mcon_draw
        popbox
    }
    set cext [sky130::unionbox $cext [sky130::draw_contact ${w} ${l} \
		${dev_surround} ${metal_surround} ${contact_size} \
		${dev_type} ${dev_contact_type} li ${orient}]]

    popbox
    return $cext
}

#----------------------------------------------------------------
# Diode: Draw the tiled device
#----------------------------------------------------------------

proc sky130::diode_draw {parameters} {
    tech unlock *

    # Set defaults if they are not in parameters
    set doverlap 0	;# overlap diodes at contacts
    set guard 0		;# draw a guard ring
    set prohibit_overlap false  ;# don't prohibit overlaps
    set doports 0

    # Set a local variable for each parameter (e.g., $l, $w, etc.)
    foreach key [dict keys $parameters] {
        set $key [dict get $parameters $key]
    }

    # Normalize distance units to microns
    set w [magic::spice2float $w]
    set l [magic::spice2float $l]

    pushbox
    box values 0 0 0 0

    # Determine the base device dimensions by drawing one device
    # while all layers are locked (nothing drawn).  This allows the
    # base drawing routine to do complicated geometry without having
    # to duplicate it here with calculations.

    tech lock *
    set bbox [sky130::diode_device $parameters]
    # puts stdout "Diagnostic: Device bounding box e $bbox (um)"
    tech unlock *

    set fw [- [lindex $bbox 2] [lindex $bbox 0]]
    set fh [- [lindex $bbox 3] [lindex $bbox 1]]
    set lw [+ [lindex $bbox 2] [lindex $bbox 0]]
    set lh [+ [lindex $bbox 3] [lindex $bbox 1]]

    # If prohibit_overlap is true, then end overlapping is prohibited when
    # nx or ny is > 1 to prevent DRC errors (typically from well spacing rule)
    if {$prohibit_overlap == true} {
        if {($nx > 1) || ($ny > 1)} {
	    set doverlap 0
	}
    }

    # Determine tile width and height (depends on overlap)

    if {$doverlap == 0} {
	set dx [+ $fw $end_spacing]
        set dy [+ $fh $end_spacing]
    } else {
        # overlap contact
        set dx [- $fw [+ [* 2.0 $sub_surround] [* 2.0 $end_surround] $contact_size]]
        set dy [- $fh [+ [* 2.0 $sub_surround] [* 2.0 $end_surround] $contact_size]]
    }

    # Determine core width and height
    set corex [+ [* [- $nx 1] $dx] $fw]
    set corey [+ [* [- $ny 1] $dy] $fh]
    set corellx [/ [+ [- $corex $fw] $lw] 2.0]
    set corelly [/ [+ [- $corey $fh] $lh] 2.0]

    if {$guard != 0} {
	# Calculate guard ring size (measured to contact center)
	set gx [+ $corex [* 2.0 [+ $diff_spacing $diff_surround]] $contact_size]
	set gy [+ $corey [* 2.0 [+ $diff_spacing $diff_surround]] $contact_size]

	# Draw the guard ring first, because diode may occupy well/substrate plane
	# (NOTE:  Diode models have no bulk terminal, so do not create a port)
	sky130::guard_ring $gx $gy $parameters
    }

    pushbox
    box move w ${corellx}um
    box move s ${corelly}um
    if {($nx > 1) || ($ny > 1)} {
	pushbox
	set hfw [/ $fw 2.0]
	set hfh [/ $fh 2.0]
	box move w ${hfw}um
	box move s ${hfh}um
	box size ${corex}um ${corey}um
	paint $end_sub_type
	popbox
    }
    for {set xp 0} {$xp < $nx} {incr xp} {
	pushbox
	for {set yp 0} {$yp < $ny} {incr yp} {
	    if {$doports} {
		if {($ny == 1) && ($nx == 1)} {
		    dict set parameters term_d D1
		} elseif {$ny == 1} {
		    dict set parameters term_d D1_$xp
		} elseif {$nx == 1} {
		    dict set parameters term_d D1_$yp
		} else {
		    dict set parameters term_d D1_${xp}_$yp
		}
		if {($xp == 0) && ($yp == 0)} {
		    dict set parameters term_s D2
		} else {
		    dict set parameters term_s ""
		}
	    }
	    sky130::diode_device $parameters
            box move n ${dy}um
        }
	popbox
        box move e ${dx}um
    }
    popbox
    popbox

    tech revert
}

#----------------------------------------------------------------
# Photodiode: Draw a single device
#----------------------------------------------------------------

proc sky130::photodiode_device {parameters} {

    set doports 0	;# no port labels by default

    # Set a local variable for each parameter (e.g., $l, $w, etc.)
    foreach key [dict keys $parameters] {
        set $key [dict get $parameters $key]
    }

    # Draw the device
    pushbox
    box size 0 0

    # Device has ntap fixed width of 0.41 x 0.41
    # Surrounded by nwell 0.84 x 0.84
    # Surrounded by deep nwell 3.0 x 3.0

    pushbox
    box grow c 0.205um
    paint nsd
    popbox
    pushbox
    box grow c 0.42um
    paint nwell
    popbox
    pushbox
    box grow c 1.5um
    paint photo

    set cext [sky130::getbox]

    popbox

    # Only enough space for one contact
    set w ${contact_size}
    set l ${contact_size}

    set cext [sky130::unionbox $cext [sky130::draw_contact ${w} ${l} \
		0 ${metal_surround} ${contact_size} \
		nsd nsc li horz]]

    popbox
    return $cext
}

#----------------------------------------------------------------

proc sky130::photodiode_draw {parameters} {

    # Set a local variable for each parameter (e.g., $l, $w, etc.)
    foreach key [dict keys $parameters] {
        set $key [dict get $parameters $key]
    }

    pushbox
    box values 0 0 0 0

    # Determine the base device dimensions by drawing one device
    # while all layers are locked (nothing drawn).  This allows the
    # base drawing routine to do complicated geometry without having
    # to duplicate it here with calculations.

    tech lock *
    set bbox [sky130::photodiode_device $parameters]
    # puts stdout "Diagnostic: Device bounding box e $bbox (um)"
    tech unlock *

    set fw [- [lindex $bbox 2] [lindex $bbox 0]]
    set fh [- [lindex $bbox 3] [lindex $bbox 1]]
    set lw [+ [lindex $bbox 2] [lindex $bbox 0]]
    set lh [+ [lindex $bbox 3] [lindex $bbox 1]]

    # Determine tile width and height

    set dx [+ $fw $end_spacing]
    set dy [+ $fh $end_spacing]

    # Determine core width and height
    set corex [+ [* [- $nx 1] $dx] $fw]
    set corey [+ [* [- $ny 1] $dy] $fh]
    set corellx [/ [+ [- $corex $fw] $lw] 2.0]
    set corelly [/ [+ [- $corey $fh] $lh] 2.0]

    # Calculate guard ring size (measured to contact center)
    # Spacing between photodiode (deep nwell) and deep nwell (other) is 5.3um
    set gx [+ $corex 15.965]
    set gy [+ $corey 15.965]

    pushbox

    # The deep nwell is offset 0.315 from the nwell ring center to get the
    # right overlap.  The deep nwell ring has a minimum width of 3um.
    set hgx [/ $gx 2.0]
    set hgy [/ $gy 2.0]
    set dwx [+ $hgx 0.315]
    set dwy [+ $hgy 0.315]
    box grow e ${dwx}um
    box grow w ${dwx}um
    box grow n ${dwy}um
    box grow s ${dwy}um
    paint dnwell
    box grow e -3.0um
    box grow w -3.0um
    box grow n -3.0um
    box grow s -3.0um
    erase dnwell

    popbox

    # Draw the guard ring first.  0.63 is the amount nwell surrounds contact;
    # 0.63 * 2 + 0.17 = total nwell width 1.43um, needed to cover dnwell edge.
    set newdict [dict create	 \
	sub_type    space	 \
	guard_sub_type	 nwell	 \
	guard_sub_surround  0.63 \
	plus_diff_type   nsd	 \
	plus_contact_type nsc	 \
    ]
    set guarddict [dict merge $parameters $newdict]
    sky130::guard_ring $gx $gy $guarddict

    # Draw outside P-ring and generated the 2nd ring
    set gx [+ $gx [* 2.0 [+ 0.56 $diff_spacing $diff_surround]] $contact_size]
    set gy [+ $gy [* 2.0 [+ 0.56 $diff_spacing $diff_surround]] $contact_size]
    sky130::guard_ring $gx $gy $parameters

    pushbox
    box move w ${corellx}um
    box move s ${corelly}um

    for {set xp 0} {$xp < $nx} {incr xp} {
	pushbox
	for {set yp 0} {$yp < $ny} {incr yp} {
	    sky130::photodiode_device $parameters
            box move n ${dy}um
        }
	popbox
        box move e ${dx}um
    }
    popbox
    popbox

    tech revert
}

#----------------------------------------------------------------

proc sky130::sky130_fd_pr__diode_pw2nd_05v5_draw {parameters} {

    # Set a local variable for each rule in ruleset
    foreach key [dict keys $sky130::ruleset] {
        set $key [dict get $sky130::ruleset $key]
    }

    set newdict [dict create \
	    dev_type		ndiode \
	    dev_contact_type	ndic \
	    end_type		psd \
	    end_contact_type	psc \
	    end_sub_type	psub \
	    dev_spacing		${diff_spacing} \
	    dev_surround	${diff_surround} \
	    end_spacing		${diff_spacing} \
	    end_surround	0 \
    ]
    set drawdict [dict merge $sky130::ruleset $newdict $parameters]
    return [sky130::diode_draw $drawdict]
} 

#----------------------------------------------------------------
# NOTE:  Use ppd instead of psd so that there is additional
# diffusion around the contact, allowing more space for the
# implant (likewise sky130_fd_pr__diode_pd2nw_05v5_lvt and
# sky130_fd_pr__diode_pd2nw_11v0).

proc sky130::sky130_fd_pr__diode_pw2nd_05v5_lvt_draw {parameters} {

    # Set a local variable for each rule in ruleset
    foreach key [dict keys $sky130::ruleset] {
        set $key [dict get $sky130::ruleset $key]
    }

    set newdict [dict create \
	    dev_type		ndiodelvt \
	    dev_contact_type	ndilvtc \
	    end_type		ppd \
	    end_contact_type	psc \
	    end_sub_type	psub \
	    dev_spacing		${diff_spacing} \
	    dev_surround	${diff_surround} \
	    end_spacing		${diff_spacing} \
	    end_surround	${diff_surround} \
    ]
    set drawdict [dict merge $sky130::ruleset $newdict $parameters]
    return [sky130::diode_draw $drawdict]
} 

proc sky130::sky130_fd_pr__diode_pw2nd_05v5_nvt_draw {parameters} {

    # Set a local variable for each rule in ruleset
    foreach key [dict keys $sky130::ruleset] {
        set $key [dict get $sky130::ruleset $key]
    }

    set newdict [dict create \
	    dev_type		nndiode \
	    dev_contact_type	nndic \
	    end_type		mvpsd \
	    end_contact_type	mvpsc \
	    end_sub_type	psub \
	    dev_spacing		0.37 \
	    dev_surround	${diff_surround} \
	    end_spacing		0.30 \
	    end_surround	${diff_surround} \
    ]
    set drawdict [dict merge $sky130::ruleset $newdict $parameters]
    return [sky130::diode_draw $drawdict]
} 

proc sky130::sky130_fd_pr__diode_pw2nd_11v0_draw {parameters} {

    # Set a local variable for each rule in ruleset
    foreach key [dict keys $sky130::ruleset] {
        set $key [dict get $sky130::ruleset $key]
    }

    set newdict [dict create \
	    dev_type		mvndiode \
	    dev_contact_type	mvndic \
	    end_type		mvpsd \
	    end_contact_type	mvpsc \
	    end_sub_type	psub \
	    diff_spacing	0.37 \
	    dev_spacing		0.39 \
	    dev_surround	${diff_surround} \
	    end_spacing		0.36 \
	    end_surround	${diff_surround} \
    ]
    set drawdict [dict merge $sky130::ruleset $newdict $parameters]
    return [sky130::diode_draw $drawdict]
}


#----------------------------------------------------------------

proc sky130::sky130_fd_pr__diode_pd2nw_05v5_draw {parameters} {

    # Set a local variable for each rule in ruleset
    foreach key [dict keys $sky130::ruleset] {
        set $key [dict get $sky130::ruleset $key]
    }

    set newdict [dict create \
	    dev_type		pdiode \
	    guard		1 \
	    dev_contact_type	pdic \
	    end_type		nsd \
	    end_contact_type	nsc \
	    end_sub_type	nwell \
	    plus_diff_type	psd \
	    plus_contact_type	psc \
	    sub_type		psub \
	    dev_spacing		${diff_spacing} \
	    dev_surround	${diff_surround} \
	    end_spacing		${diff_spacing} \
	    end_surround	0 \
    ]
    set drawdict [dict merge $sky130::ruleset $newdict $parameters]
    return [sky130::diode_draw $drawdict]
}

#----------------------------------------------------------------

proc sky130::sky130_fd_pr__diode_pd2nw_05v5_lvt_draw {parameters} {

    # Set a local variable for each rule in ruleset
    foreach key [dict keys $sky130::ruleset] {
        set $key [dict get $sky130::ruleset $key]
    }

    set newdict [dict create \
	    dev_type		pdiodelvt \
	    guard		1 \
	    dev_contact_type	pdilvtc \
	    end_type		nnd \
	    end_contact_type	nsc \
	    end_sub_type	nwell \
	    plus_diff_type	psd \
	    plus_contact_type	psc \
	    sub_type		psub \
	    dev_spacing		${diff_spacing} \
	    dev_surround	${diff_surround} \
	    end_spacing		${diff_spacing} \
	    end_surround	${diff_surround} \
    ]
    set drawdict [dict merge $sky130::ruleset $newdict $parameters]
    return [sky130::diode_draw $drawdict]
}

#----------------------------------------------------------------

proc sky130::sky130_fd_pr__diode_pd2nw_05v5_hvt_draw {parameters} {

    # Set a local variable for each rule in ruleset
    foreach key [dict keys $sky130::ruleset] {
        set $key [dict get $sky130::ruleset $key]
    }

    set newdict [dict create \
	    dev_type		pdiodehvt \
	    guard		1 \
	    dev_contact_type	pdihvtc \
	    end_type		nnd \
	    end_contact_type	nsc \
	    end_sub_type	nwell \
	    plus_diff_type	psd \
	    plus_contact_type	psc \
	    sub_type		psub \
	    dev_spacing		${diff_spacing} \
	    dev_surround	${diff_surround} \
	    end_spacing		${diff_spacing} \
	    end_surround	${diff_surround} \
    ]
    set drawdict [dict merge $sky130::ruleset $newdict $parameters]
    return [sky130::diode_draw $drawdict]
}


#----------------------------------------------------------------

proc sky130::sky130_fd_pr__diode_pd2nw_11v0_draw {parameters} {

    # Set a local variable for each rule in ruleset
    foreach key [dict keys $sky130::ruleset] {
        set $key [dict get $sky130::ruleset $key]
    }

    set newdict [dict create \
	    guard		1 \
	    dev_type 		mvpdiode \
	    dev_contact_type	mvpdic \
	    end_type		mvnsd \
	    end_contact_type	mvnsc \
	    end_sub_type	nwell \
	    plus_diff_type	mvpsd \
	    plus_contact_type	mvpsc \
	    sub_type		psub \
	    diff_spacing	0.58 \
	    dev_spacing		0.37 \
	    dev_surround	${diff_surround} \
	    end_spacing		0.30 \
	    end_sub_surround	0.33 \
	    end_surround	${diff_surround} \
    ]
    set drawdict [dict merge $sky130::ruleset $newdict $parameters]
    return [sky130::diode_draw $drawdict]
}

#----------------------------------------------------------------
# The photodiode has its own drawing routine, so
#----------------------------------------------------------------

proc sky130::sky130_fd_pr__photodiode_draw {parameters} {
    # Set a local variable for each rule in ruleset
    foreach key [dict keys $sky130::ruleset] {
        set $key [dict get $sky130::ruleset $key]
    }

    set newdict [dict create \
	    guard		1	\
	    sub_type		space	\
	    end_spacing		5.0	\
	    end_surround	1.0	\
	    sub_spacing		5.3	\
	    guard_sub_type	pwell	\
	    guard_sub_surround  0.18	\
	    plus_diff_type	psd	\
	    plus_contact_type	psc	\
    ]
    set drawdict [dict merge $sky130::ruleset $newdict $parameters]
    return [sky130::photodiode_draw $drawdict]
}
