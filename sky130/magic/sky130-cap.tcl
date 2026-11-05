###
###     Source file sky130-cap.tcl
###     Process this file with the preprocessor script
###
#-----------------------------------------------------
# Magic/TCL design kit for SKYWATER TECHNAME:  Capacitors
#-----------------------------------------------------

#----------------------------------------------------------------
# Drawn capacitor routines
# NOTE:  Work in progress.  These values need to be corrected.
#----------------------------------------------------------------

#ifdef MIM
proc sky130::sky130_fd_pr__cap_mim_m3_1_defaults {} {
    return {w 2.00 l 2.00 val 8.0 carea 2.00 cperi 0.19 class capacitor \
		nx 1 ny 1 dummy 0 square 0 lmin 2.00 wmin 2.00 \
		lmax 30.0 wmax 30.0 dc 0 bconnect 1 tconnect 1 \
		ccov 100 stack 1 doports 1}
}
proc sky130::sky130_fd_pr__cap_mim_m3_2_defaults {} {
    return {w 2.00 l 2.00 val 8.0 carea 2.00 cperi 0.19 class capacitor \
		nx 1 ny 1 dummy 0 square 0 lmin 2.00 wmin 2.00 \
		lmax 30.0 wmax 30.0 dc 0 bconnect 1 tconnect 1 \
		ccov 100 doports 1}
}
#endif (MIM)


#----------------------------------------------------------------
# Recalculate capacitor values from GUI entries.
# Recomputes W/L and Value as long as 2 of them are present
# (To be completed)
#----------------------------------------------------------------

proc sky130::cap_recalc {field parameters} {
    # Set a local variable for each parameter (e.g., $l, $w, etc.)
    foreach key [dict keys $parameters] {
        set $key [dict get $parameters $key]
    }
    switch  $field {
	val { puts stdout "value changed" }
	w   { puts stdout "width changed" }
	l   { puts stdout "length changed" }
    }
    dict set parameters val $val
    dict set parameters w $w
    dict set parameters l $l
}

#----------------------------------------------------------------
# Capacitor defaults:
#----------------------------------------------------------------
#  w      Width of drawn cap
#  l      Length of drawn cap
#  nx     Number of devices in X
#  ny     Number of devices in Y
#  val    Default cap value
#  carea  Area
#  cperi  Perimeter
#  dummy  Add dummy cap
#  square Make square capacitor
#
#  (not user-editable)
#
#  wmin   Minimum allowed width
#  lmin   Minimum allowed length
#  dc     Area to remove to calculated area 
#----------------------------------------------------------------

#----------------------------------------------------------------
# capacitor: Conversion from SPICE netlist parameters to toolkit
#----------------------------------------------------------------

proc sky130::cap_convert {parameters} {
    set pdkparams [dict create]
    dict for {key value} $parameters {
	switch -nocase $key {
	    l -
	    w {
		# Length and width are converted to units of microns
		set value [magic::spice2float $value]
		# set value [expr $value * 1e6]
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

#ifdef MIM
proc sky130::sky130_fd_pr__cap_mim_m3_1_convert {parameters} {
    return [cap_convert $parameters]
}
proc sky130::sky130_fd_pr__cap_mim_m3_2_convert {parameters} {
    return [cap_convert $parameters]
}
#endif (MIM)

#----------------------------------------------------------------
# capacitor: Interactively specifies the fixed layout parameters
#----------------------------------------------------------------

proc sky130::cap_dialog {device parameters} {
    # Editable fields:      w, l, nx, ny, val
    # Checked fields:  	    square, dummy

    magic::add_entry val "Value (fF)" $parameters
    sky130::compute_ctot $parameters
    magic::add_message ctot "Total capacitance (pF)" $parameters
    magic::add_entry l "Length (um)" $parameters
    magic::add_entry w "Width (um)" $parameters
    magic::add_entry nx "X Repeat" $parameters
    magic::add_entry ny "Y Repeat" $parameters

    if {[dict exists $parameters square]} {
	magic::add_checkbox square "Square capacitor" $parameters
    }
    if {[dict exists $parameters bconnect]} {
	magic::add_checkbox bconnect "Connect bottom plates in array" $parameters
    }
    if {[dict exists $parameters tconnect]} {
	magic::add_checkbox tconnect "Connect top plates in array" $parameters
    }
    if {[dict exists $parameters ccov]} {
    	magic::add_entry ccov "Capacitor contact coverage \[+/-\](%)" $parameters
    }
    if {[dict exists $parameters guard]} {
	magic::add_checkbox guard "Add guard ring" $parameters
    }
    if {[dict exists $parameters stack]} {
	magic::add_checkbox stack "Stacked cap compatibility" $parameters
    }

    magic::add_dependency sky130::cap_recalc $device sky130 l w val

    if {[dict exists $parameters addports]} {
	magic::add_checkbox doports "Add ports" $parameters
    }

    # magic::add_checkbox dummy "Add dummy" $parameters
}

#ifdef MIM
proc sky130::sky130_fd_pr__cap_mim_m3_1_dialog {parameters} {
    sky130::cap_dialog sky130_fd_pr__cap_mim_m3_1 $parameters
}
proc sky130::sky130_fd_pr__cap_mim_m3_2_dialog {parameters} {
    sky130::cap_dialog sky130_fd_pr__cap_mim_m3_2 $parameters
}
#endif (MIM)

#----------------------------------------------------------------
# Capacitor total capacitance computation
#----------------------------------------------------------------

proc sky130::compute_ctot {parameters} {
    foreach key [dict keys $parameters] {
        set $key [dict get $parameters $key]
    }
    set val [magic::spice2float $val]
    set val [magic::3digitpastdecimal $val]

    # Compute total capacitance (and convert fF to pF)
    catch {set magic::ctot_val [expr (0.001 * $val * $nx * $ny)]}
}

#----------------------------------------------------------------
# Capacitor: Draw a single device
#----------------------------------------------------------------

proc sky130::cap_device {parameters} {
    # Epsilon for avoiding round-off errors
    set eps  0.0005

    # Set local default values if they are not in parameters
    set doports 0	;# no port labels by default
    set cap_surround 0
    set bot_surround 0
    set top_surround 0
    set end_spacing 0
    set bconnect 0	    ;# bottom plates are connected in array
    set cap_spacing 0	    ;# cap spacing in array
    set top_metal_space 0   ;# top metal spacing (if larger than cap spacing)
    set top_metal_width 0   ;# top metal minimum width
    set contact_size 0	    ;# cap contact minimum size
    set ccov 100	    ;# amount of contact coverage

    set term_t ""
    set term_b ""

    # Set a local variable for each parameter (e.g., $l, $w, etc.)
    foreach key [dict keys $parameters] {
        set $key [dict get $parameters $key]
    }

    if {![dict exists $parameters top_metal_space]} {
	set top_metal_space $metal_spacing
    }

    # Draw the device
    pushbox
    box size 0 0

    pushbox
    set hw [/ $w 2.0]
    set hl [/ $l 2.0]
    box grow e ${hw}um
    box grow w ${hw}um
    box grow n ${hl}um
    box grow s ${hl}um
    paint ${cap_type}
    pushbox

    # Find contact width if ccov is other than 100
    set cmaxw [- $w [* $cap_surround 2]]
    set cw [* $cmaxw [/ [expr abs($ccov)] 100.0]]
    # Contact width must meet minimum
    if {$cw < $contact_size} {set cw $contact_size}
    if {$cw < $top_metal_width} {set cw $top_metal_width}
    # Difference between maximum contact width and actual contact width
    set cdif [- $cmaxw $cw]

    # Reduce the box to the maximum contact area
    box grow n -${cap_surround}um
    box grow s -${cap_surround}um
    box grow e -${cap_surround}um
    box grow w -${cap_surround}um

    set anchor [string index $ccov 0]
    if {$anchor == "+"} {
	box grow e -${cdif}um
    } elseif {$anchor == "-"} {
	box grow w -${cdif}um
    } else {
        set cdif [/ ${cdif} 2]
	box grow w -${cdif}um
	box grow e -${cdif}um
    }
    paint ${cap_contact_type}

    pushbox
    box grow n ${top_surround}um
    box grow s ${top_surround}um
    box grow e ${top_surround}um
    box grow w ${top_surround}um
    paint ${top_type}
    set cext [sky130::getbox]
    popbox
    popbox
    pushbox
    box grow n ${bot_surround}um
    box grow s ${bot_surround}um
    box grow e ${bot_surround}um
    box grow w ${bot_surround}um

    paint ${bot_type}
    # Create boundary using properties
    property FIXED_BBOX [box values]
    set cext [sky130::unionbox $cext [sky130::getbox]]

    # Calculate the distance from the top metal on the cap contact
    # to the top metal on the end contact.
    set top_met_sep [+ $end_spacing [- $cdif $top_surround]]

    # Diagnostic!
    # puts stdout "cdif = $cdif"
    # puts stdout "top_met_sep = $top_met_sep"

    # Increase end spacing if top metal spacing rule is not met
    set loc_end_spacing $end_spacing
    if {$top_met_sep < $top_metal_space} {
	set loc_end_spacing [+ $loc_end_spacing [- $top_metal_space $top_met_sep]]
    }
    # Diagnostic!
    # puts stdout "loc_end_spacing = $loc_end_spacing"

    # Extend bottom metal under contact to right
    box grow e ${loc_end_spacing}um
    set chw [/ ${contact_size} 2.0]
    box grow e ${chw}um
    box grow e ${end_surround}um
    paint ${bot_type}

    popbox
    popbox

    # Draw contact to right.  Reduce contact extent if devices are not
    # wired together and the top metal spacing rule limits the distance
    set lcont $l
    if {($bconnect == 0) && ($ny > 1)} {
	if {$cap_spacing < $top_metal_space} {
	    set cspace [- $top_metal_space $cap_spacing]
	    set lcont [- $l $cspace]
	}
    }

    pushbox
    box move e ${hw}um
    box move e ${bot_surround}um
    box move e ${loc_end_spacing}um
    set cl [- [+ ${lcont} [* ${bot_surround} 2.0]] [* ${end_surround} 2.0]]
    set cl [- ${cl} ${metal_surround}]  ;# see below
    set cext [sky130::unionbox $cext [sky130::draw_contact 0 ${cl} \
		${end_surround} ${metal_surround} ${contact_size} \
		${bot_type} ${top_contact_type} ${top_type} full]]
    # Bottom plate port label
    if {$term_b != ""} {
	label $term_b c $bot_type
	select area label
	port make
    }
    popbox
    popbox

    # Top plate port label
    if {$term_t != ""} {
	label $term_t c $top_type
	select area label
	port make
    }
    return $cext

    # cl shrinks top and bottom to accomodate larger bottom metal
    # surround rule for contacts near a MiM cap.  This should be its
    # own variable, but metal_surround is sufficient.
}

#----------------------------------------------------------------
# Metal plate sandwich capacitor:  Draw a single device
#----------------------------------------------------------------

proc sky130::sandwich_cap_device {parameters} {

    set doports 0	;# no port labels by default

    # Set a local variable for each parameter (e.g., $l, $w, etc.)
    foreach key [dict keys $parameters] {
        set $key [dict get $parameters $key]
    }

    pushbox
    box size 0 0

    set hw [/ $w 2.0]
    set hl [/ $l 2.0]

    set cw [- [* $hw [/ 2.0 3]] [* $cont_surround 2.0]]
    set cl [- [* $hl [/ 2.0 3]] [* $cont_surround 2.0]]

    # plate capacitor defines layers p0, p1, etc.
    for {set i 0} {$i < 20} {incr i} {
        if {[catch {set layer [subst \$p${i}_type]}]} {break}  ;# no more layers defined
	pushbox
	box grow e ${hw}um
	box grow w ${hw}um
	box grow n ${hl}um
	box grow s ${hl}um
        if {![catch {set shrink [subst \$p${i}_shrink]}]} {
	    box grow e -${shrink}um
	    box grow w -${shrink}um
	    box grow n -${shrink}um
	    box grow s -${shrink}um
	    set cutout_spacing [+ [* ${shrink} 2.0] [/ $via_size 2.0] $cont_surround]
	} else {
	    set cutout_spacing 0
	}

	paint ${layer}

	if {$i == 1} {
	    # Note that cap_type geometry is coincident with p1_type.
	    # Typically, this will define a layer that outputs as both
	    # poly and a capacitor definition layer.
	    if {[dict exists $parameters cap_type]} {
		paint $cap_type
	    }
	}
	popbox

	# Even layers connect at corners, odd layers connect at sides.
	# Even layers cut out the sides, odd layers cut out the corners.
	# Layer zero has no side contacts or cutout.

	if {[% $i 2] == 0} {
	    set cornercmd  paint
	    set cornersize $cutout_spacing
	    set sidecmd    erase
	    set nssidelong   [+ $cutout_spacing [/ $hw 3.0]]
	    set ewsidelong   [+ $cutout_spacing [/ $hl 3.0]]
	    set sideshort    $cutout_spacing
	} else {
	    set cornercmd  erase
	    set cornersize $cutout_spacing
	    set sidecmd    paint
	    set nssidelong   [/ $hw 3.0]
	    set ewsidelong   [/ $hl 3.0]
	    set sideshort    $cutout_spacing
	}

	if {$i > 0} {
	    pushbox
	    box move e ${hw}um
	    box grow n ${ewsidelong}um
	    box grow s ${ewsidelong}um
	    box grow w ${sideshort}um
	    ${sidecmd} ${layer}
	    popbox
	    pushbox
	    box move n ${hl}um
	    box grow e ${nssidelong}um
	    box grow w ${nssidelong}um
	    box grow s ${sideshort}um
	    ${sidecmd} ${layer}
	    popbox
	    pushbox
	    box move w ${hw}um
	    box grow n ${ewsidelong}um
	    box grow s ${ewsidelong}um
	    box grow e ${sideshort}um
	    ${sidecmd} ${layer}
	    popbox
	    pushbox
	    box move s ${hl}um
	    box grow e ${nssidelong}um
	    box grow w ${nssidelong}um
	    box grow n ${sideshort}um
	    ${sidecmd} ${layer}
	    popbox

	    pushbox
	    box move n ${hl}um
	    box move e ${hw}um
	    box grow s ${cornersize}um
	    box grow w ${cornersize}um
	    ${cornercmd} ${layer}
	    popbox
	    pushbox
	    box move n ${hl}um
	    box move w ${hw}um
	    box grow s ${cornersize}um
	    box grow e ${cornersize}um
	    ${cornercmd} ${layer}
	    popbox
	    pushbox
	    box move s ${hl}um
	    box move e ${hw}um
	    box grow n ${cornersize}um
	    box grow w ${cornersize}um
	    ${cornercmd} ${layer}
	    popbox
	    pushbox
	    box move s ${hl}um
	    box move w ${hw}um
	    box grow n ${cornersize}um
	    box grow e ${cornersize}um
	    ${cornercmd} ${layer}
	    popbox
	}
    }

    # Draw contacts after all layers have been drawn, so that erasing
    # layers does not affect the contacts.

    for {set i 0} {$i < 20} {incr i} {
        if {![catch {set contact [subst \$p${i}_contact_type]}]} {
	    set layer [subst \$p${i}_type]
	    set j [+ $i 1]
	    set toplayer [subst \$p${j}_type]

	    # Draw corner contacts
	    pushbox
	    box move e ${hw}um
	    box move n ${hl}um
	    sky130::draw_contact 0 0 \
			${cont_surround} ${cont_surround} ${via_size} \
			${layer} ${contact} ${toplayer} full
	    popbox
	    pushbox
	    box move w ${hw}um
	    box move n ${hl}um
	    sky130::draw_contact 0 0 \
			${cont_surround} ${cont_surround} ${via_size} \
			${layer} ${contact} ${toplayer} full
	    popbox
	    pushbox
	    box move e ${hw}um
	    box move s ${hl}um
	    sky130::draw_contact 0 0 \
			${cont_surround} ${cont_surround} ${via_size} \
			${layer} ${contact} ${toplayer} full
	    popbox
	    pushbox
	    box move w ${hw}um
	    box move s ${hl}um
	    sky130::draw_contact 0 0 \
			${cont_surround} ${cont_surround} ${via_size} \
			${layer} ${contact} ${toplayer} full
	    popbox

	    # Draw side contacts (except on poly)
	    if {$i > 0} {
		pushbox
		box move w ${hw}um
		sky130::draw_contact 0 ${cl} \
			${cont_surround} ${cont_surround} ${via_size} \
			${layer} ${contact} ${toplayer} full
		popbox
		pushbox
		box move e ${hw}um
		sky130::draw_contact 0 ${cl} \
			${cont_surround} ${cont_surround} ${via_size} \
			${layer} ${contact} ${toplayer} full
		popbox
		pushbox
		box move n ${hl}um
		sky130::draw_contact ${cw} 0 \
			${cont_surround} ${cont_surround} ${via_size} \
			${layer} ${contact} ${toplayer} full
		popbox
		pushbox
		box move s ${hl}um
		sky130::draw_contact ${cw} 0 \
			${cont_surround} ${cont_surround} ${via_size} \
			${layer} ${contact} ${toplayer} full
		popbox
	    }
	} else {
	    break
	}
    }

    popbox
    # Bounding box is the same as the device length and width
    set cext [list -$hw -$hl $hw $hl]
    return $cext
}

#----------------------------------------------------------------
# Capacitor: Draw the tiled device
#----------------------------------------------------------------

proc sky130::cap_draw {parameters} {
    tech unlock *
    set savesnap [snap]
    snap internal

    # Set defaults if they are not in parameters
    set coverlap 0	;# overlap capacitors at contacts
    set guard 0		;# draw a guard ring
    set sandwich 0	;# this is not a plate sandwich capacitor
    set cap_spacing 0	;# abutted caps if spacing is zero
    set cap_diff_spacing 0
    set wide_cap_spacing 0  ;# additional spacing for wide metal rule
    set wide_cap_width 0
    set end_spacing 0
    set extra_spacing 0
    set end_surround 0
    set bot_surround 0
    set top_metal_width 0
    set bconnect 0	;# connect bottom plates in array
    set tconnect 0	;# connect top plates in array
    set top_type ""
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
    if {$sandwich == 1} {
	set bbox [sky130::sandwich_cap_device $parameters]
    } else {
	set bbox [sky130::cap_device $parameters]
    }
    # puts stdout "Diagnostic: Device bounding box e $bbox (um)"
    tech unlock *

    set fw [- [lindex $bbox 2] [lindex $bbox 0]]
    set fh [- [lindex $bbox 3] [lindex $bbox 1]]
    set lw [+ [lindex $bbox 2] [lindex $bbox 0]]
    set lh [+ [lindex $bbox 3] [lindex $bbox 1]]

    set dwide 0
    if {($fw >= $wide_cap_width) && ($fh >= $wide_cap_width)} {
	set dwide $wide_cap_spacing
    }

    # Determine tile width and height (depends on overlap)
    if {$coverlap == 0} {
        set dy [+ $fh $cap_spacing $dwide]
    } else {
        # overlap at end contact
        set dy [- $fh [+ $end_surround $end_surround $contact_size]]
    }
    # Contact is placed on right so spacing is determined by end_spacing.
    set dx [+ $fw $end_spacing $extra_spacing $dwide]

    # Determine core width and height
    set corex [+ [* [- $nx 1] $dx] $fw]
    set corey [+ [* [- $ny 1] $dy] $fh]
    set corellx [/ [+ [- $corex $fw] $lw] 2.0]
    set corelly [/ [+ [- $corey $fh] $lh] 2.0]

    if {$guard != 0} {
	# Calculate guard ring size (measured to contact center)
	set gx [+ $corex [* 2.0 [+ $cap_diff_spacing $diff_surround]] $contact_size]
	set gy [+ $corey [* 2.0 [+ $end_spacing $diff_surround]] $contact_size]

	# Draw the guard ring first.
	if {$doports} {dict set parameters bulk B}
	sky130::guard_ring $gx $gy $parameters
    }

    set twidth [+ ${contact_size} ${end_surround} ${end_surround}]
    if {${twidth} < ${top_metal_width}} {
	set twidth ${top_metal_width}
    }
    set hmw [/ $twidth 2.0]
    set hdy [/ $dy 2.0]
    set cdx [+ [/ ${w} 2.0] ${bot_surround} ${end_spacing}]

    pushbox
    box move w ${corellx}um
    box move s ${corelly}um
    for {set xp 0} {$xp < $nx} {incr xp} {
	pushbox
	for {set yp 0} {$yp < $ny} {incr yp} {
	    if {$doports} {
		if {($ny == 1) && ($nx == 1)} {
		    dict set parameters term_t C1
		    dict set parameters term_b C2
		} elseif {$ny == 1} {
		    dict set parameters term_t C1_$xp
		    dict set parameters term_b C2_$xp
		} elseif {$nx == 1} {
		    if {$tconnect} {
			dict set parameters term_t C1
		    } else {
			dict set parameters term_t C1_$yp
		    }
		    if {$bconnect} {
			dict set parameters term_b C2
		    } else {
			dict set parameters term_b C2_$yp
		    }
		} else {
		    if {$tconnect} {
		    	dict set parameters term_t C1_$xp
		    } else {
		    	dict set parameters term_t C1_${xp}_$yp
		    }
		    if {$bconnect} {
		    	dict set parameters term_b C2_$xp
		    } else {
		    	dict set parameters term_b C2_${xp}_$yp
		    }
		}
		if {$yp > 0} {
		    if {$tconnect} {dict set parameters term_t ""}
		    if {$bconnect} {dict set parameters term_b ""}
		}
	    }
	    if {$sandwich == 1} {
		sky130::sandwich_cap_device $parameters
	    } else {
		sky130::cap_device $parameters
	    }
	    if {$ny > 1} {
		pushbox
		box grow e ${hmw}um
		box grow w ${hmw}um
		box grow n ${hdy}um
		box grow s ${hdy}um
		if {($top_type != "") && ($tconnect == 1)} {
		    paint ${top_type}
		}
		if {($top_type != "") && ($bconnect == 1)} {
		    box move e ${cdx}um
		    paint ${top_type}
		}
		popbox
	    }
            box move n ${dy}um
        }
	popbox
        box move e ${dx}um
    }
    popbox
    popbox

    snap $savesnap
    tech revert
}

#----------------------------------------------------------------

#ifdef MIM
proc sky130::sky130_fd_pr__cap_mim_m3_1_draw {parameters} {
    set stack 0

    # Set a local variable for each parameter
    foreach key [dict keys $parameters] {
        set $key [dict get $parameters $key]
    }
    if {$stack} {
	# For cap stacking, dimensions are increased to match the mim2 device
	set capspace 1.6
	set capextra 1.83
	set endspace 1.5
    } else {
	set capspace 1.2
	set capextra 0.0
	set endspace 1.2
    }

    set newdict [dict create \
	    top_type 		m4 \
	    top_contact_type	via3 \
	    cap_type 		mimcap \
	    cap_contact_type	mimcc \
	    bot_type 		m3 \
	    bot_surround	0.2 \
	    cap_spacing		${capspace} \
	    extra_spacing	${capextra} \
	    cap_surround	0.2 \
	    top_surround	0.005 \
	    end_surround	0.1 \
	    end_spacing		${endspace} \
	    contact_size	0.32 \
	    metal_surround	0.08 \
    ]
    set drawdict [dict merge $sky130::ruleset $newdict $parameters]
    return [sky130::cap_draw $drawdict]
}

proc sky130::sky130_fd_pr__cap_mim_m3_2_draw {parameters} {
    set newdict [dict create \
	    top_type 		m5 \
	    top_contact_type	via4 \
	    cap_type 		mimcap2 \
	    cap_contact_type	mim2cc \
	    bot_type 		m4 \
	    bot_surround	0.4 \
	    cap_spacing		1.2 \
	    cap_surround	0.2 \
	    top_surround	0.12 \
	    end_surround	0.1 \
	    end_spacing		2.0 \
	    contact_size	1.18 \
	    metal_surround	0.21 \
	    top_metal_width	1.6 \
	    top_metal_space	0.7 \
    ]
    set drawdict [dict merge $sky130::ruleset $newdict $parameters]
    return [sky130::cap_draw $drawdict]
}

#endif (MIM)

#----------------------------------------------------------------
# capacitor: Check device parameters for out-of-bounds values
#----------------------------------------------------------------

proc sky130::cap_check {parameters} {
    # In case wmax and/or lmax are undefined
    set lmax 0
    set wmax 0
    set ccov 100

    # Set a local variable for each parameter (e.g., $l, $w, etc.)
    foreach key [dict keys $parameters] {
        set $key [dict get $parameters $key]
    }

    # Normalize distance units to microns
    set l [magic::spice2float $l]
    set l [magic::3digitpastdecimal $l] 
    set w [magic::spice2float $w]
    set w [magic::3digitpastdecimal $w] 

    set val   [magic::spice2float $val]
    set carea [magic::spice2float $carea]
    set cperi [magic::spice2float $cperi]
    set dc    [magic::spice2float $dc]

    if {$square == 1} {
        # Calculate L and W from value
	set a $carea
	set b [expr $cperi * 4]
	set c [expr -4 * $dc - $val]
	set l [expr ((-$b + sqrt($b * $b - (4 * $a * $c))) / (2 * $a))]
	dict set parameters l [magic::float2spice $l]
	set w $l
	dict set parameters w [magic::float2spice $w]
    } elseif {$l == 0} {
        # Calculate L from W and value
	set l [expr (($val + 4 * $dc - 2 * $w * $cperi) / ($w * $carea + 2 * $cperi))]
	dict set parameters l [magic::float2spice $l]
    } elseif {$w == 0} {
        # Calculate W from L and value
	set w [expr (($val + 4 * $dc - 2 * $l * $cperi) / ($l * $carea + 2 * $cperi))]
	dict set parameters w [magic::float2spice $w]
    }
    if {$w < $wmin} {
	puts stderr "Capacitor width must be >= $wmin"
	dict set parameters w $wmin
	set w $wmin
    } 
    if {$l < $lmin} {
	puts stderr "Capacitor length must be >= $lmin"
	dict set parameters l $lmin
	set l $lmin
    } 
    if {($wmax > 0) && ($w > $wmax)} {
	puts stderr "Capacitor width must be <= $wmax"
	dict set parameters w $wmax
	set w $wmax
    } 
    if {($lmax > 0) && ($l > $lmax)} {
	puts stderr "Capacitor length must be <= $lmax"
	dict set parameters l $lmax
	set l $lmax
    } 
    if {[catch {expr abs($ccov)}]} {
	puts stderr "Capacitor contact coverage must be numeric!"
        dict set parameters ccov 100
    } elseif {[expr abs($ccov)] > 100} {
	puts stderr "Capaitor contact coverage can't be more than 100%"
        dict set parameters ccov 100
    }

    # Calculate value from L and W
    set cval [expr ($l * $w * $carea + 2 * ($l + $w) * $cperi - 4 * $dc)]
    dict set parameters val [magic::float2spice $cval]
    sky130::compute_ctot $parameters

    return $parameters
}

#ifdef MIM
proc sky130::sky130_fd_pr__cap_mim_m3_1_check {parameters} {
    return [sky130::cap_check $parameters]
}
proc sky130::sky130_fd_pr__cap_mim_m3_2_check {parameters} {
    return [sky130::cap_check $parameters]
}
#endif (MIM)
