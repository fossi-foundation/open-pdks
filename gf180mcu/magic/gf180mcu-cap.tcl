###
###     Source file gf180mcu-cap.tcl
###     Process this file with the preprocessor script
###
#-----------------------------------------------------
# Magic/TCL design kit for GF TECHNAME:  Capacitors
#-----------------------------------------------------

#----------------------------------------------------------------
# Drawn capactitor routines
#----------------------------------------------------------------
# MiM minimum size set to 2.165 to prevent isolated via

#ifdef MIM
proc gf180mcu::cap_mim_2p0fF_defaults {} {
    return {w 5.00 l 5.00 val 54.516 carea 1.99 cperi 0.2383 \
		class capacitor \
		nx 1 ny 1 dummy 0 square 0 lmin 5.00 wmin 5.00 \
		lmax 100.0 wmax 100.0 dc 0 bconnect 1 tconnect 1}
}
#endif MIM

#----------------------------------------------------------------
# Recalculate capacitor values from GUI entries.
# Recomputes W/L and Value as long as 2 of them are present
# (To be completed)
#----------------------------------------------------------------

proc gf180mcu::cap_recalc {field parameters} {
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
#  carea  Area capacitance (per um^2)
#  cperi  Perimeter capacitange (per um)
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

proc gf180mcu::cap_convert {parameters} {
    set pdkparams [dict create]
    dict for {key value} $parameters {
	set canonkey $key
	switch -nocase $key {
	    c_length -
	    c_width -
	    l -
	    w {
		switch -nocase $key {
		    c_length {
			set canonkey l
		    }
		    c_width {
			set canonkey w
		    }
		}
		# Length and width are converted to units of microns
		set value [magic::spice2float $value]
		set value [expr $value * 1e6]
		set value [magic::3digitpastdecimal $value]
		dict set pdkparams [string tolower $canonkey] $value
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
proc gf180mcu::cap_mim_2p0fF_convert {parameters} {
    return [cap_convert $parameters]
}
#endif

#----------------------------------------------------------------
# capacitor: Interactively specifies the fixed layout parameters
#----------------------------------------------------------------

proc gf180mcu::cap_dialog {device parameters} {
    # Editable fields:      w, l, nx, ny, val
    # Checked fields:  	    square, dummy

    magic::add_entry val "Value (fF)" $parameters
    gf180mcu::compute_ctot $parameters
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

    magic::add_dependency gf180mcu::cap_recalc $device gf180mcu l w val

    # magic::add_checkbox dummy "Add dummy" $parameters
}

#ifdef MIM
proc gf180mcu::cap_mim_2p0fF_dialog {parameters} {
    gf180mcu::cap_dialog cap_mim_2p0fF $parameters
}
#endif

#----------------------------------------------------------------
# Capacitor total capacitance computation
#----------------------------------------------------------------

proc gf180mcu::compute_ctot {parameters} {
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

proc gf180mcu::cap_device {parameters} {
    # Epsilon for avoiding round-off errors
    set eps  0.0005

    # Set local default values if they are not in parameters
    set cap_surround 0
    set bot_surround 0
    set top_surround 0

    # Set a local variable for each parameter (e.g., $l, $w, etc.)
    foreach key [dict keys $parameters] {
        set $key [dict get $parameters $key]
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
    box grow n -${cap_surround}um
    box grow s -${cap_surround}um
    box grow e -${cap_surround}um
    box grow w -${cap_surround}um
    paint ${cap_contact_type}
    pushbox
    box grow n ${top_surround}um
    box grow s ${top_surround}um
    box grow e ${top_surround}um
    box grow w ${top_surround}um
    paint ${top_type}
    set cext [gf180mcu::getbox]
    popbox
    popbox
    pushbox
    box grow n ${bot_surround}um
    box grow s ${bot_surround}um
    box grow e ${bot_surround}um
    box grow w ${bot_surround}um

    paint ${bot_type}
    property FIXED_BBOX [box values]
    set cext [gf180mcu::unionbox $cext [gf180mcu::getbox]]

    # Extend bottom metal under contact to right
    box grow e ${end_spacing}um
    set chw [/ ${contact_size} 2.0]
    box grow e ${chw}um
    box grow e ${end_surround}um
    paint ${bot_type}

    popbox
    popbox

    # Draw contact to right
    pushbox
    box move e ${hw}um
    box move e ${bot_surround}um
    box move e ${end_spacing}um
    set cl [- [+ ${l} [* ${bot_surround} 2.0]] [* ${end_surround} 2.0]]
    set cl [- ${cl} ${metal_surround}]  ;# see below
    set cext [gf180mcu::unionbox $cext [gf180mcu::draw_contact 0 ${cl} \
		${end_surround} ${metal_surround} ${contact_size} \
		${bot_type} ${top_contact_type} ${top_type} vert]]
    popbox
    popbox

    return $cext

    # cl shrinks top and bottom to accomodate larger bottom metal
    # surround rule for contacts near a MiM cap.  This should be its
    # own variable, but metal_surround is sufficient.
}

#----------------------------------------------------------------
# Metal plate sandwich capacitor:  Draw a single device
#----------------------------------------------------------------

proc gf180mcu::sandwich_cap_device {parameters} {

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
	    gf180mcu::draw_contact 0 0 \
			${cont_surround} ${cont_surround} ${via_size} \
			${layer} ${contact} ${toplayer} full
	    popbox
	    pushbox
	    box move w ${hw}um
	    box move n ${hl}um
	    gf180mcu::draw_contact 0 0 \
			${cont_surround} ${cont_surround} ${via_size} \
			${layer} ${contact} ${toplayer} full
	    popbox
	    pushbox
	    box move e ${hw}um
	    box move s ${hl}um
	    gf180mcu::draw_contact 0 0 \
			${cont_surround} ${cont_surround} ${via_size} \
			${layer} ${contact} ${toplayer} full
	    popbox
	    pushbox
	    box move w ${hw}um
	    box move s ${hl}um
	    gf180mcu::draw_contact 0 0 \
			${cont_surround} ${cont_surround} ${via_size} \
			${layer} ${contact} ${toplayer} full
	    popbox

	    # Draw side contacts (except on poly)
	    if {$i > 0} {
		pushbox
		box move w ${hw}um
		gf180mcu::draw_contact 0 ${cl} \
			${cont_surround} ${cont_surround} ${via_size} \
			${layer} ${contact} ${toplayer} full
		popbox
		pushbox
		box move e ${hw}um
		gf180mcu::draw_contact 0 ${cl} \
			${cont_surround} ${cont_surround} ${via_size} \
			${layer} ${contact} ${toplayer} full
		popbox
		pushbox
		box move n ${hl}um
		gf180mcu::draw_contact ${cw} 0 \
			${cont_surround} ${cont_surround} ${via_size} \
			${layer} ${contact} ${toplayer} full
		popbox
		pushbox
		box move s ${hl}um
		gf180mcu::draw_contact ${cw} 0 \
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

proc gf180mcu::cap_draw {parameters} {
    tech unlock *

    # Set defaults if they are not in parameters
    set coverlap 0	;# overlap capacitors at contacts
    set guard 0		;# draw a guard ring
    set sandwich 0	;# this is not a plate sandwich capacitor
    set cap_spacing 0	;# abutted caps if spacing is zero
    set wide_cap_spacing 0  ;# additional spacing for wide metal rule
    set wide_cap_width 0
    set end_spacing 0
    set end_surround 0
    set bot_surround 0
    set top_metal_width 0
    set bconnect 0	;# connect bottom plates in array
    set tconnect 0	;# connect top plates in array
    set top_type ""

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
	set bbox [gf180mcu::sandwich_cap_device $parameters]
    } else {
	set bbox [gf180mcu::cap_device $parameters]
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
    set dx [+ $fw $end_spacing $dwide]

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
	gf180mcu::guard_ring $gx $gy $parameters
    }

    set top_metal_width [+ ${contact_size} ${end_surround} ${end_surround}]
    set hmw [/ $top_metal_width 2.0]
    set hdy [/ $dy 2.0]
    set cdx [+ [/ ${w} 2.0] ${bot_surround} ${end_spacing}]

    pushbox
    box move w ${corellx}um
    box move s ${corelly}um
    for {set xp 0} {$xp < $nx} {incr xp} {
	pushbox
	for {set yp 0} {$yp < $ny} {incr yp} {
	    if {$sandwich == 1} {
		gf180mcu::sandwich_cap_device $parameters
	    } else {
		gf180mcu::cap_device $parameters
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

    tech revert
}

#----------------------------------------------------------------

#ifdef MIM
proc gf180mcu::cap_mim_2p0fF_draw {parameters} {
    set newdict [dict create \
#ifdef METALS6
	    top_type 		mtp \
	    top_contact_type	viatp \
	    bot_type 		m5 \
#endif
#ifdef METALS5
	    top_type 		m5 \
	    top_contact_type	via4 \
	    bot_type 		m4 \
#endif
#ifdef METALS4
	    top_type 		m4 \
	    top_contact_type	via3 \
	    bot_type 		m3 \
#endif
#ifdef METALS3
	    top_type 		m3 \
	    top_contact_type	via2 \
	    bot_type 		m2 \
#endif
	    cap_type 		mimcap \
	    cap_contact_type	mimcc \
	    bot_surround	0.6 \
	    cap_spacing		0.6 \
	    cap_surround	0.4 \
	    top_surround	0.0 \
	    end_surround	0.31 \
#ifdef THICKMET3P0
	    metal_surround	0.11 \
	    contact_size	1.80 \
	    end_spacing		1.28 \
#elseif (THICKMET1P1 || THICKMET0P9)
	    metal_surround	0.05 \
	    contact_size	0.44 \
	    end_spacing		0.67 \
#else
	    metal_surround	0.05 \
	    contact_size	0.36 \
	    end_spacing		0.60 \
#endif (!(THICKMET3P0 || THICKMET1P1 || THICKMET0P9))
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::cap_draw $drawdict]
}
#endif (MIM)

#----------------------------------------------------------------
# capacitor: Check device parameters for out-of-bounds values
#----------------------------------------------------------------

proc gf180mcu::cap_check {parameters} {
    # In case wmax and/or lmax are undefined
    set lmax 0
    set wmax 0

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
    # Calculate value from L and W
    set cval [expr ($l * $w * $carea + 2 * ($l + $w) * $cperi - 4 * $dc)]
    dict set parameters val [magic::float2spice $cval]
    gf180mcu::compute_ctot $parameters

    return $parameters
}

#ifdef MIM
proc gf180mcu::cap_mim_2p0fF_check {parameters} {
    return [gf180mcu::cap_check $parameters]
}
#endif
