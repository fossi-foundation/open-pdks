###
###     Source file gf180mcu-dio.tcl
###     Process this file with the preprocessor script
###
#-----------------------------------------------------
# Magic/TCL design kit for GF TECHNAME:  Diodes
#-----------------------------------------------------

#----------------------------------------------------------------
# Drawn diode routines
#----------------------------------------------------------------

proc gf180mcu::diode_recalc {field parameters} {
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

proc gf180mcu::diode_convert {parameters} {
    set pdkparams [dict create]
    dict for {key value} $parameters {
	switch -nocase $key {
	    l -
	    w -
	    peri {
		# Length, width, and perimeter are converted to units of microns
		set value [magic::spice2float $value]
		set value [expr $value * 1e6]
		set value [magic::3digitpastdecimal $value]
		dict set pdkparams [string tolower $key] $value
	    }
	    area {
		# area also converted to units of microns
		set value [magic::spice2float $value]
		set value [expr $value * 1e12]
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

proc gf180mcu::diode_dialog {device parameters} {
    # Editable fields:      w, l, area, perim, nx, ny

    magic::add_entry area "Area (um^2)" $parameters
    magic::add_entry peri "Perimeter (um)" $parameters
    gf180mcu::compute_aptot $parameters
    magic::add_message atot "Total area (um^2)" $parameters
    magic::add_message ptot "Total perimeter (um)" $parameters
    magic::add_entry l "Length (um)" $parameters
    magic::add_entry w "Width (um)" $parameters
    magic::add_entry nx "X Repeat" $parameters
    magic::add_entry ny "Y Repeat" $parameters

    if {[dict exists $parameters compatible]} {
       set sellist [dict get $parameters compatible]
       # Reserved word "gencell" has special behavior to change the
       # underlying device type 
       dict set parameters gencell $device
       magic::add_selectlist gencell "Device type" $sellist $parameters
    }

    magic::add_checkbox doverlap "Overlap at end contact" $parameters

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

    if {[dict exists $parameters full_metal]} {
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

    magic::add_dependency gf180mcu::diode_recalc $device gf180mcu l w area peri

    # magic::add_checkbox dummy "Add dummy" $parameters
}

#----------------------------------------------------------------
# Diode total area and perimeter computation
#----------------------------------------------------------------

proc gf180mcu::compute_aptot {parameters} {
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

proc gf180mcu::diode_check {parameters} {

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
    # Calculate area and perimeter from L and W
    set area [expr ($l * $w)]
    dict set parameters area [magic::float2spice $area]
    set peri [expr (2 * ($l + $w))]
    dict set parameters peri [magic::float2spice $peri]
    gf180mcu::compute_aptot $parameters

    return $parameters
}

#----------------------------------------------------------------

proc gf180mcu::diode_nd2ps_03v3_defaults {} {
    return {w 0.45 l 0.45 area 0.2025 peri 1.8 \
	nx 1 ny 1 dummy 0 lmin 0.45 wmin 0.45 class diode \
	elc 1 erc 1 etc 1 ebc 1 doverlap 0 full_metal 1 \
	compatible {diode_nd2ps_03v3 diode_nd2ps_06v0}}
}

proc gf180mcu::diode_pd2nw_03v3_defaults {} {
    return {w 0.45 l 0.45 area 0.2025 peri 1.8 \
	nx 1 ny 1 dummy 0 lmin 0.45 wmin 0.45 class diode \
	elc 1 erc 1 etc 1 ebc 1 \
	glc 1 grc 1 gtc 0 gbc 0 doverlap 0 full_metal 1 \
	compatible {diode_pd2nw_03v3 diode_pd2nw_06v0}}
}

proc gf180mcu::diode_nd2ps_06v0_defaults {} {
    return {w 0.45 l 0.45 area 0.2025 peri 1.8 \
	nx 1 ny 1 dummy 0 lmin 0.45 wmin 0.45 class diode \
	elc 1 erc 1 etc 1 ebc 1 doverlap 0 \
	full_metal 1 \
	compatible {diode_nd2ps_03v3 diode_nd2ps_06v0}}
}

proc gf180mcu::diode_pd2nw_06v0_defaults {} {
    return {w 0.45 l 0.45 area 0.2025 peri 1.8 \
	nx 1 ny 1 dummy 0 lmin 0.45 wmin 0.45 class diode \
	elc 1 erc 1 etc 1 ebc 1 \
	glc 1 grc 1 gtc 0 gbc 0 doverlap 0 \
	full_metal 1 \
	compatible {diode_pd2nw_03v3 diode_pd2nw_06v0}}
}

#----------------------------------------------------------------

proc gf180mcu::diode_nd2ps_03v3_convert {parameters} {
    return [gf180mcu::diode_convert $parameters]
}

proc gf180mcu::diode_pd2nw_03v3_convert {parameters} {
    return [gf180mcu::diode_convert $parameters]
}

proc gf180mcu::diode_nd2ps_06v0_convert {parameters} {
    return [gf180mcu::diode_convert $parameters]
}

proc gf180mcu::diode_pd2nw_06v0_convert {parameters} {
    return [gf180mcu::diode_convert $parameters]
}

#----------------------------------------------------------------

proc gf180mcu::diode_nd2ps_03v3_dialog {parameters} {
    gf180mcu::diode_dialog diode_nd2ps_03v3 $parameters
}

proc gf180mcu::diode_pd2nw_03v3_dialog {parameters} {
    gf180mcu::diode_dialog diode_pd2nw_03v3 $parameters
}

proc gf180mcu::diode_nd2ps_06v0_dialog {parameters} {
    gf180mcu::diode_dialog diode_nd2ps_06v0 $parameters
}

proc gf180mcu::diode_pd2nw_06v0_dialog {parameters} {
    gf180mcu::diode_dialog diode_pd2nw_06v0 $parameters
}

#----------------------------------------------------------------

proc gf180mcu::diode_nd2ps_03v3_check {parameters} {
    gf180mcu::diode_check $parameters
}

proc gf180mcu::diode_pd2nw_03v3_check {parameters} {
    gf180mcu::diode_check $parameters
}

proc gf180mcu::diode_nd2ps_06v0_check {parameters} {
    gf180mcu::diode_check $parameters
}

proc gf180mcu::diode_pd2nw_06v0_check {parameters} {
    gf180mcu::diode_check $parameters
}

#----------------------------------------------------------------
# Diode: Draw a single device
#----------------------------------------------------------------

proc gf180mcu::diode_device {parameters} {
    # Epsilon for avoiding round-off errors
    set eps  0.0005

    # Set local default values if they are not in parameters
    set dev_surround 0
    set dev_sub_type ""

    # Set a local variable for each parameter (e.g., $l, $w, etc.)
    foreach key [dict keys $parameters] {
        set $key [dict get $parameters $key]
    }

    if {![dict exists $parameters end_contact_size]} {
	set end_contact_size $contact_size
    }

    # Draw the device
    pushbox
    box size 0 0

    set hw [/ $w 2.0]
    set hl [/ $l 2.0]

    # Calculate ring size (measured to contact center)
    set gx [+ $w [* 2.0 [+ $dev_spacing $dev_surround]] $end_contact_size]
    set gy [+ $l [* 2.0 [+ $dev_spacing $dev_surround]] $end_contact_size]

    # Draw the ring first, because diode may occupy well/substrate plane
    set guardparams $parameters
    dict set guardparams plus_diff_type $end_type
    dict set guardparams plus_contact_type $end_contact_type
    dict set guardparams contact_size $end_contact_size
    dict set guardparams diff_surround $end_surround
    dict set guardparams sub_type $end_sub_type
    dict set guardparams glc $elc
    dict set guardparams grc $erc
    dict set guardparams gtc $etc
    dict set guardparams gbc $ebc
    set cext [gf180mcu::guard_ring $gx $gy $guardparams]

    pushbox
    box grow n ${hl}um
    box grow s ${hl}um
    box grow e ${hw}um
    box grow w ${hw}um
    paint ${dev_type}
    set cext [gf180mcu::unionbox $cext [gf180mcu::getbox]]

    if {$dev_sub_type != ""} {
	box grow n ${sub_surround}um
	box grow s ${sub_surround}um
	box grow e ${sub_surround}um
	box grow w ${sub_surround}um
	paint ${dev_sub_type}
    }
    popbox

    if {${w} < ${l}} {
	set orient vert
    } else {
	set orient horz
    }

    # Reduce width by surround amount
    set w [- $w [* ${dev_surround} 2.0]]
    set l [- $l [* ${dev_surround} 2.0]]

    set cext [gf180mcu::unionbox $cext [gf180mcu::draw_contact ${w} ${l} \
		${dev_surround} ${metal_surround} ${contact_size} \
		${dev_type} ${dev_contact_type} m1 ${orient}]]

    popbox
    return $cext
}

#----------------------------------------------------------------
# Diode: Draw the tiled device
#----------------------------------------------------------------

proc gf180mcu::diode_draw {parameters} {
    tech unlock *

    # Set defaults if they are not in parameters
    set doverlap 0	;# overlap diodes at contacts
    set guard 0		;# draw a guard ring

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
    set bbox [gf180mcu::diode_device $parameters]
    # puts stdout "Diagnostic: Device bounding box e $bbox (um)"
    tech unlock *

    set fw [- [lindex $bbox 2] [lindex $bbox 0]]
    set fh [- [lindex $bbox 3] [lindex $bbox 1]]
    set lw [+ [lindex $bbox 2] [lindex $bbox 0]]
    set lh [+ [lindex $bbox 3] [lindex $bbox 1]]

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
	gf180mcu::guard_ring $gx $gy $parameters
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
	    gf180mcu::diode_device $parameters
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

proc gf180mcu::diode_nd2ps_03v3_draw {parameters} {

    # Set a local variable for each rule in ruleset
    foreach key [dict keys $gf180mcu::ruleset] {
        set $key [dict get $gf180mcu::ruleset $key]
    }

    set newdict [dict create \
	    dev_type		ndiode \
	    dev_contact_type	ndic \
	    end_type		psd \
	    end_contact_type	psc \
	    end_contact_size	0.25 \
	    end_sub_type	pwell \
	    dev_spacing		0.30 \
	    dev_surround	${diff_surround} \
	    end_spacing		${diff_spacing} \
	    end_surround	${diff_surround} \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::diode_draw $drawdict]
} 

#----------------------------------------------------------------

proc gf180mcu::diode_pd2nw_03v3_draw {parameters} {

    # Set a local variable for each rule in ruleset
    foreach key [dict keys $gf180mcu::ruleset] {
        set $key [dict get $gf180mcu::ruleset $key]
    }

    set newdict [dict create \
	    guard		1 \
	    dev_type		pdiode \
	    dev_contact_type	pdic \
	    end_type		nsd \
	    end_contact_type	nsc \
	    end_contact_size	0.25 \
	    end_sub_type	nwell \
	    plus_diff_type	psd \
	    plus_contact_type	psc \
	    sub_type		pwell \
	    dev_spacing		0.30 \
	    dev_surround	${diff_surround} \
	    end_spacing		${diff_spacing} \
	    end_surround	${diff_surround} \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::diode_draw $drawdict]
}

#----------------------------------------------------------------

proc gf180mcu::diode_nd2ps_06v0_draw {parameters} {

    # Set a local variable for each rule in ruleset
    foreach key [dict keys $gf180mcu::ruleset] {
        set $key [dict get $gf180mcu::ruleset $key]
    }

    set newdict [dict create \
	    diff_poly_space	0.30 \
	    diff_gate_space	0.30 \
	    diff_spacing	0.36 \
	    dev_type 		mvndiode \
	    dev_contact_type	mvndic \
	    end_type		mvpsd \
	    end_contact_type	mvpsc \
	    end_sub_type	pwell \
	    dev_spacing		0.40 \
	    dev_surround	${diff_surround} \
	    end_spacing		0.17 \
	    end_surround	${diff_surround} \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::diode_draw $drawdict]
}

#----------------------------------------------------------------

proc gf180mcu::diode_pd2nw_06v0_draw {parameters} {

    # Set a local variable for each rule in ruleset
    foreach key [dict keys $gf180mcu::ruleset] {
        set $key [dict get $gf180mcu::ruleset $key]
    }

    set newdict [dict create \
	    diff_poly_space	0.30 \
	    diff_gate_space	0.30 \
	    diff_spacing	0.36 \
	    guard		1 \
	    dev_type 		mvpdiode \
	    dev_contact_type	mvpdic \
	    end_type		mvnsd \
	    end_contact_type	mvnsc \
	    end_sub_type	nwell \
	    sub_surround	0.16 \
	    plus_diff_type	mvpsd \
	    plus_contact_type	mvpsc \
	    sub_type		pwell \
	    dev_spacing		0.36 \
	    dev_surround	${diff_surround} \
	    end_spacing		${diff_spacing} \
	    end_surround	${diff_surround} \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::diode_draw $drawdict]
}
