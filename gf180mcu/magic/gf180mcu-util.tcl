###
###     Source file gf180mcu-util.tcl
###     Process this file with the preprocessor script
###
#-----------------------------------------------------
# Magic/TCL design kit for GF TECHNAME:  basic utility functions
#-----------------------------------------------------

#----------------------------------------------------------------
# Menu callback function to read a SPICE netlist and generate an
# initial layout using the GF180MCU gf180mcu gencells.
#----------------------------------------------------------------

proc gf180mcu::importspice {} {
   global CAD_ROOT

   set Layoutfilename [ tk_getOpenFile -filetypes \
	    {{SPICE {.spice .spc .spi .ckt .cir .sp \
	    {.spice .spc .spi .ckt .cir .sp}}} {"All files" {*}}}]
   if {$Layoutfilename != ""} {
      magic::netlist_to_layout $Layoutfilename gf180mcu
   }
}

#----------------------------------------------------------------
# getbox:  Get the current cursor box, in microns
#----------------------------------------------------------------

proc gf180mcu::getbox {} {
    set curbox [box values]
    set newbox []
    set oscale [cif scale out]
    for {set i 0} {$i < 4} {incr i} {
        set v [* [lindex $curbox $i] $oscale]
        lappend newbox $v
    }
    return $newbox
}

#----------------------------------------------------------------
# unionbox:  Get the union bounding box of box1 and box2
#----------------------------------------------------------------

proc gf180mcu::unionbox {box1 box2} {
    set newbox []
    for {set i 0} {$i < 2} {incr i} {
        set v [lindex $box1 $i]
        set o [lindex $box2 $i]
        if {$v < $o} {
            lappend newbox $v
        } else {
            lappend newbox $o
        }
    }
    for {set i 2} {$i < 4} {incr i} {
        set v [lindex $box1 $i]
        set o [lindex $box2 $i]
        if {$v > $o} {
            lappend newbox $v
        } else {
            lappend newbox $o
        }
    }
    return $newbox
}

#----------------------------------------------------------------
# Draw a contact
#----------------------------------------------------------------

proc gf180mcu::draw_contact {w h s o x atype ctype mtype {orient vert}} {

    # Draw a minimum-size diff contact centered at current position
    # w is width, h is height.  Minimum size ensured.
    # x is contact size
    # s is contact diffusion (or poly) surround
    # o is contact metal surround
    # atype is active (e.g., ndiff) or bottom metal if a via
    # ctype is contact (e.g., ndc)
    # mtype is metal (e.g., m1) or top metal if a via
    # cover is percent maximum coverage of contact

    pushbox
    box size 0 0
    if {$w < $x} {set w $x}
    if {$h < $x} {set h $x}
    set hw [/ $w 2.0]
    set hh [/ $h 2.0]
    # Bottom layer surrounded on all sides
    box grow e ${hw}um
    box grow w ${hw}um
    box grow n ${hh}um
    box grow s ${hh}um
    pushbox
    paint ${ctype}
    popbox
    pushbox
    box grow c ${s}um
    paint ${atype}
    set extents [gf180mcu::getbox]
    popbox
    if {($orient == "vert") || ($orient == "full")} {
        box grow n ${o}um
        box grow s ${o}um
    }
    if {($orient == "horz") || ($orient == "full")} {
        box grow e ${o}um
        box grow w ${o}um
    }
    paint ${mtype}
    popbox
    return $extents
}

#----------------------------------------------------------------
# Draw a guard ring
#----------------------------------------------------------------

proc gf180mcu::guard_ring {gw gh parameters} {

    # Set local default values if they are not in parameters
    set rlcov 100	;# Right-left contact coverage percentage
    set tbcov 100	;# Top-bottom contact coverage percentage
    set grc 1		;# Draw right side contact
    set glc 1		;# Draw left side contact
    set gtc 0		;# Draw right side contact
    set gbc 0		;# Draw left side contact
    set full_metal 0	;# Draw full (continuous) metal ring
    set viagb 0		;# Draw bottom side via
    set viagt 0		;# Draw top side via
    set viagr 0		;# Draw right side via
    set viagl 0		;# Draw left side via

    set bulk ""		;# Default no port label

    # Set a local variable for each parameter (e.g., $l, $w, etc.)
    foreach key [dict keys $parameters] {
        set $key [dict get $parameters $key]
    }

    set hx [/ $contact_size 2.0]
    set hw [/ $gw 2.0]
    set hh [/ $gh 2.0]

    # Compute diffusion width
    set difft [+ $contact_size $diff_surround $diff_surround]
    set hdifft [/ $difft 2.0]
    # Compute guard ring diffusion width and height
    set hdiffw [/ [+ $gw $difft] 2.0]
    set hdiffh [/ [+ $gh $difft] 2.0]

    pushbox
    box size 0 0

    pushbox
    box move n ${hh}um
    box grow n ${hdifft}um
    box grow s ${hdifft}um
    box grow e ${hdiffw}um
    box grow w ${hdiffw}um
    paint $plus_diff_type
    popbox
    pushbox
    box move s ${hh}um
    box grow n ${hdifft}um
    box grow s ${hdifft}um
    box grow e ${hdiffw}um
    box grow w ${hdiffw}um
    paint $plus_diff_type
    popbox
    # At guard ring bottom center, place a port if requested
    if {$bulk != ""} {
        label $bulk c $plus_diff_type
        select area label
        port make
    }
    pushbox
    box move e ${hw}um
    box grow e ${hdifft}um
    box grow w ${hdifft}um
    box grow n ${hdiffh}um
    box grow s ${hdiffh}um
    paint $plus_diff_type
    popbox
    pushbox
    box move w ${hw}um
    box grow e ${hdifft}um
    box grow w ${hdifft}um
    box grow n ${hdiffh}um
    box grow s ${hdiffh}um
    paint $plus_diff_type
    popbox

    if {$full_metal} {
	set hmetw [/ [+ $gw $contact_size] 2.0]
	set hmeth [/ [+ $gh $contact_size] 2.0]
	pushbox
	box move n ${hh}um
	box grow n ${hx}um
	box grow s ${hx}um
	box grow e ${hmetw}um
	box grow w ${hmetw}um
	paint m1
	popbox
	pushbox
	box move s ${hh}um
	box grow n ${hx}um
	box grow s ${hx}um
	box grow e ${hmetw}um
	box grow w ${hmetw}um
	paint m1
	popbox
	pushbox
	box move e ${hw}um
	box grow e ${hx}um
	box grow w ${hx}um
	box grow n ${hmeth}um
	box grow s ${hmeth}um
	paint m1
	popbox
	pushbox
	box move w ${hw}um
	box grow e ${hx}um
	box grow w ${hx}um
	box grow n ${hmeth}um
	box grow s ${hmeth}um
	paint m1
	popbox
    }

    # Set guard ring height so that contact metal reaches to end, scale by $per
    # set ch [* [+ $gh $contact_size [* $metal_surround -2.0]] [/ $rlcov 100.0]]
    set ch [* [- $gh $contact_size [* [+ $metal_surround $metal_spacing] \
		2.0]] [/ $rlcov 100.0]]
    if {$ch < $contact_size} {set ch $contact_size}

    # Set guard ring width so that contact metal reaches to side contacts
    set cw [* [- $gw $contact_size [* [+ $metal_surround $metal_spacing] \
		2.0]] [/ $tbcov 100.0]]
    if {$cw < $contact_size} {set cw $contact_size}

    if {$tbcov > 0.0} {
        if {$gtc == 1} {
            pushbox
            box move n ${hh}um
            gf180mcu::draw_contact $cw 0 $diff_surround $metal_surround \
		$contact_size $plus_diff_type $plus_contact_type m1 horz
            popbox
	}
	if {$gbc == 1} {
	    pushbox
	    box move s ${hh}um
	    gf180mcu::draw_contact $cw 0 $diff_surround $metal_surround \
		$contact_size $plus_diff_type $plus_contact_type m1 horz
	    popbox
	}
    }
    if {$rlcov > 0.0} {
        if {$grc == 1} {
            pushbox
            box move e ${hw}um
            gf180mcu::draw_contact 0 $ch $diff_surround $metal_surround \
		$contact_size $plus_diff_type $plus_contact_type m1 vert
            popbox
        }
        if {$glc == 1} {
            pushbox
            box move w ${hw}um
            gf180mcu::draw_contact 0 $ch $diff_surround $metal_surround \
		$contact_size $plus_diff_type $plus_contact_type m1 vert
            popbox
        }
    }

    # Vias
    if {$viagb != 0} {
        pushbox
        set ch $via_size
        set cw [* [- $gw $via_size] [/ [expr abs($viagb)] 100.0]]
        if {$cw < $via_size} {set cw $via_size}
        box move s ${hh}um
        box grow n [/ $ch 2]um
        box grow s [/ $ch 2]um
        set anchor [string index $viagb 0]
        if {$anchor == "+"} {
            box move w [/ [- $gw $via_size] 2]um
            box grow e ${cw}um
        } elseif {$anchor == "-"} {
            box move e [/ [- $gw $via_size] 2]um
            box grow w ${cw}um
        } else {
            box grow e [/ $cw 2]um
            box grow w [/ $cw 2]um
        }
        gf180mcu::via1_draw
        popbox
    }
    if {$viagt != 0} {
        pushbox
        set ch $via_size
        set cw [* [- $gw $via_size] [/ [expr abs($viagt)] 100.0]]
        if {$cw < $via_size} {set cw $via_size}
        box move n ${hh}um
        box grow n [/ $ch 2]um
        box grow s [/ $ch 2]um
        set anchor [string index $viagt 0]
        if {$anchor == "+"} {
            box move w [/ [- $gw $via_size] 2]um
            box grow e ${cw}um
        } elseif {$anchor == "-"} {
            box move e [/ [- $gw $via_size] 2]um
            box grow w ${cw}um
        } else {
            box grow e [/ $cw 2]um
            box grow w [/ $cw 2]um
        }
        gf180mcu::via1_draw
        popbox
    }
    if {$viagr != 0} {
        pushbox
        set ch [* [- $gh $via_size] [/ [expr abs($viagr)] 100.0]]
        if {$ch < $via_size} {set ch $via_size}
        set cw $via_size
        box move e ${hw}um
        box grow e [/ $cw 2]um
        box grow w [/ $cw 2]um
        set anchor [string index $viagr 0]
        if {$anchor == "+"} {
            box move s [/ [- $gh $via_size] 2]um
            box grow n ${ch}um
        } elseif {$anchor == "-"} {
            box move n [/ [- $gh $via_size] 2]um
            box grow s ${ch}um
        } else {
            box grow n [/ $ch 2]um
            box grow s [/ $ch 2]um
        }
        gf180mcu::via1_draw
        popbox
    }
    if {$viagl != 0} {
        pushbox
        set ch [* [- $gh $via_size] [/ [expr abs($viagl)] 100.0]]
        if {$ch < $via_size} {set ch $via_size}
        set cw $via_size
        box move w ${hw}um
        box grow e [/ $cw 2]um
        box grow w [/ $cw 2]um
        set anchor [string index $viagl 0]
        if {$anchor == "+"} {
            box move s [/ [- $gh $via_size] 2]um
            box grow n ${ch}um
        } elseif {$anchor == "-"} {
            box move n [/ [- $gh $via_size] 2]um
            box grow s ${ch}um
        } else {
            box grow n [/ $ch 2]um
            box grow s [/ $ch 2]um
        }
        gf180mcu::via1_draw
        popbox
    }

    pushbox
    box grow e ${hw}um
    box grow w ${hw}um
    box grow n ${hh}um
    box grow s ${hh}um
    property FIXED_BBOX [box values]
    box grow c ${hx}um  ;# to edge of contact
    box grow c ${diff_surround}um  ;# to edge of diffusion
    box grow c ${sub_surround}um  ;# sub/well overlap of diff
    paint $sub_type
    set cext [gf180mcu::getbox]
    popbox
    popbox

    return $cext
}
