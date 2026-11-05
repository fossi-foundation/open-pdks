###
###     Source file gf180mcu-res.tcl
###     Process this file with the preprocessor script
###
#-----------------------------------------------------
# Magic/TCL design kit for GF TECHNAME:  Resistors
#-----------------------------------------------------

#----------------------------------------------------------------

proc gf180mcu::res_recalc {field parameters} {
    set snake 0
    set sterm 0.0
    set caplen 0
    # Set a local variable for each parameter (e.g., $l, $w, etc.)
    foreach key [dict keys $parameters] {
        set $key [dict get $parameters $key]
    }
    set val [magic::spice2float $val]
    set l [magic::spice2float $l]
    set w [magic::spice2float $w]

    if {$snake == 0} {
	# Straight resistor calculation
	switch  $field {
	    val { set l [expr ($val * ($w - $dw) - (2 * $term)) / $rho]
		  set w [expr ((2 * $term + $l * $rho) / $val) + $dw]
		}
	    w   { set val [expr (2 * $term + $l * $rho) / ($w - $dw)]
		  set l [expr ($val * ($w - $dw) - (2 * $term)) / $rho]
		}
	    l   { set val [expr (2 * $term + $l * $rho) / ($w - $dw)]
		  set w [expr ((2 * $term + $l * $rho) / $val) + $dw]
		}
	}
    } else {
        set term [expr $term + $sterm]
	# Snake resistor calculation
	switch  $field {
	    val { set l [expr (($val - $rho * ($nx - 1)) * ($w - $dw) \
			- (2 * $term) - ($rho * $caplen * ($nx - 1))) \
			/ ($rho * $nx)]

		  set w [expr ((2 * $term + $l * $rho * $nx \
			+ $caplen * $rho * ($nx - 1)) \
			/ ($val - $rho * ($nx - 1))) + $dw]
		}
	    w   { set val [expr $rho * ($nx - 1) + ((2 * $term) \
			+ ($rho * $l * $nx) + ($rho * $caplen * ($nx - 1))) \
			/ ($w - $dw)]

		  set l [expr (($val - $rho * ($nx - 1)) * ($w - $dw) \
			- (2 * $term) - ($rho * $caplen * ($nx - 1))) \
			/ ($rho * $nx)]
		}
	    l   { set val [expr $rho * ($nx - 1) + ((2 * $term) \
			+ ($rho * $l * $nx) + ($rho * $caplen * ($nx - 1))) \
			/ ($w - $dw)]

		  set w [expr ((2 * $term + $l * $rho * $nx \
			+ $caplen * $rho * ($nx - 1)) \
			/ ($val - $rho * ($nx - 1))) + $dw]
		}
	}
    }

    set val [magic::3digitpastdecimal $val]
    set w [magic::3digitpastdecimal $w]
    set l [magic::3digitpastdecimal $l]

    dict set parameters val $val
    dict set parameters w $w
    dict set parameters l $l

    return $parameters
}

#----------------------------------------------------------------
# Drawn resistors
#----------------------------------------------------------------

#----------------------------------------------------------------
# Resistor defaults:
#----------------------------------------------------------------
# User editable values:
#
#  val   Resistor value in ohms
#  w	 Width
#  l	 Length
#  t	 Number of turns
#  m	 Number devices in Y
#  nx	 Number devices in X
#  snake Use snake geometry
#  dummy Flag to mark addition of dummy resistor
#
# Non-user editable values:
#
#  wmin  Minimum allowed width
#  lmin  Minimum allowed length
#  rho	 Resistance in ohms per square
#  dw    Delta width
#  term  Resistance per terminal
#  sterm Additional resistance per terminal for snake geometry
#----------------------------------------------------------------

#----------------------------------------------------------------
# rnw: Specify all user-editable default values and those
# needed by nwell_check
#----------------------------------------------------------------

proc gf180mcu::nwell_defaults {} {
    return {w 2.000 l 10.00 m 1 nx 1 wmin 2.000 lmin 2.00 class resistor \
	 	rho 1680 val 8400 dummy 0 dw 0.25 term 1.0 snake 0 \
		glc 1 grc 1 gtc 0 gbc 0 roverlap 0 endcov 100 \
		full_metal 1}
}

#----------------------------------------------------------------
# rpp1: Specify all user-editable default values and those
# needed by rp1_check
#----------------------------------------------------------------

proc gf180mcu::ppolyf_u_defaults {} {
    return {w 0.80 l 1.00 m 1 nx 1 wmin 0.80 lmin 1.00 class resistor \
		rho 315 val 394 dummy 0 dw 0.057 term 0.0 \
		sterm 0.0 caplen 0.4 snake 0 guard 1 guard_type pwell \
		glc 1 grc 1 gtc 0 gbc 0 roverlap 0 endcov 100 \
		full_metal 1}
}

proc gf180mcu::npolyf_u_defaults {} {
    return {w 0.80 l 1.00 m 1 nx 1 wmin 0.80 lmin 1.00 class resistor \
		rho 300 val 375 dummy 0 dw 0.053 term 0.0 \
		sterm 0.0 caplen 0.4 snake 0 guard 1 guard_type pwell \
		glc 1 grc 1 gtc 0 gbc 0 roverlap 0 endcov 100 \
		full_metal 1}
}

#----------------------------------------------------------------
# rpp1s: Specify all user-editable default values and those
# needed by rp1_check
#----------------------------------------------------------------

proc gf180mcu::ppolyf_s_defaults {} {
    return {w 0.80 l 1.00 m 1 nx 1 wmin 0.80 lmin 1.00 class resistor \
		rho 7 val 8.75 dummy 0 dw 0.0 term 0.0 \
		sterm 0.0 caplen 0.4 snake 0 guard 1 guard_type pwell \
		glc 1 grc 1 gtc 0 gbc 0 roverlap 0 endcov 100 \
		full_metal 1}
}

proc gf180mcu::npolyf_s_defaults {} {
    return {w 0.80 l 1.00 m 1 nx 1 wmin 0.80 lmin 1.00 class resistor \
		rho 7 val 8.75 dummy 0 dw 0.0 term 0.0 \
		sterm 0.0 caplen 0.4 snake 0 guard 1 guard_type pwell \
		glc 1 grc 1 gtc 0 gbc 0 roverlap 0 endcov 100 \
		full_metal 1}
}

#----------------------------------------------------------------
# nplus_u: Specify all user-editable default values and those
# needed by nplus_u_check 
#----------------------------------------------------------------

proc gf180mcu::nplus_u_defaults {} {
    return {w 1.000 l 1.000 m 1 nx 1 wmin 1.00 lmin 1.00 class resistor \
		rho 85 val 85.0 dummy 0 dw 0.01 term 0.0 \
		sterm 0.0 caplen 0.4 snake 0 guard 1 \
		glc 1 grc 1 gtc 0 gbc 0 roverlap 0 endcov 100 \
		full_metal 1}
}

proc gf180mcu::nplus_u_6p0_defaults {} {
    return {w 1.000 l 1.000 m 1 nx 1 wmin 1.00 lmin 1.00 class resistor \
		rho 85 val 85.0 dummy 0 dw 0.01 term 0.0 \
		sterm 0.0 caplen 0.4 snake 0 guard 1 \
		glc 1 grc 1 gtc 0 gbc 0 roverlap 0 endcov 100 \
		full_metal 1}
}

#----------------------------------------------------------------
# pplus_u: Specify all user-editable default values and those
# needed by pplus_u_check
#----------------------------------------------------------------

proc gf180mcu::pplus_u_defaults {} {
    return {w 1.000 l 1.000 m 1 nx 1 wmin 1.00 lmin 1.00 class resistor \
		rho 128 val 128.0 dummy 0 dw 0.0055 term 0.0 \
		sterm 0.0 caplen 0.60 snake 0 guard 1 \
		glc 1 grc 1 gtc 0 gbc 0 roverlap 0 endcov 100 \
		full_metal 1}
}

proc gf180mcu::pplus_u_6p0_defaults {} {
    return {w 1.000 l 1.000 m 1 nx 1 wmin 1.00 lmin 1.00 class resistor \
		rho 128 val 128.0 dummy 0 dw 0.0055 term 0.0 \
		sterm 0.0 caplen 0.60 snake 0 guard 1 \
		glc 1 grc 1 gtc 0 gbc 0 roverlap 0 endcov 100 \
		full_metal 1}
}

#----------------------------------------------------------------
# rm1: Specify all user-editable default values and those needed
# by rm1_check
#----------------------------------------------------------------

proc gf180mcu::rm1_defaults {} {
    return {w 0.230 l 0.10 m 1 nx 1 wmin 0.23 lmin 0.1 class resistor \
		rho 0.090 val 0.039 dummy 0 dw 0.0 term 0.0 \
		roverlap 0}
}

#----------------------------------------------------------------
# rm2: Specify all user-editable default values and those needed
# by rm2_check
#----------------------------------------------------------------

proc gf180mcu::rm2_defaults {} {
    return {w 0.280 l 0.10 m 1 nx 1 wmin 0.28 lmin 0.10 class resistor \
		rho 0.090 val 0.032 dummy 0 dw 0.0 term 0.0 \
		roverlap 0}
}

#----------------------------------------------------------------
# Additional entries for rm3, rm4, rm5, and rmtp, depending on
# the back-end metal stack.
#----------------------------------------------------------------

#ifdef METALS3
#ifdef THICKMET3P0
proc gf180mcu::rm3_defaults {} {
    return {w 1.800 l 0.100 m 1 nx 1 wmin 1.80 lmin 0.10 class resistor \
		rho 0.0095 val 0.0005 dummy 0 dw 0.0 term 0.0 \
		roverlap 0}
}
#elseif (THICKMET1P1 || THICKMET0P9)
proc gf180mcu::rm3_defaults {} {
    return {w 0.440 l 0.100 m 1 nx 1 wmin 0.44 lmin 0.10 class resistor \
		rho 0.040 val 0.009 dummy 0 dw 0.0 term 0.0 \
		roverlap 0}
}
#else (!(THICKMET3P0 || THICKMET3P1 || THICKMET0P9))
proc gf180mcu::rm3_defaults {} {
    return {w 0.360 l 0.100 m 1 nx 1 wmin 0.36 lmin 0.10 class resistor \
		rho 0.060 val 0.017 dummy 0 dw 0.0 term 0.0 \
		roverlap 0}
}
#endif (!(THICKMET3P0 || THICKMET1P1 || THICKMET0P9))
#endif (METALS3)
#ifdef METALS4 || METALS5 || METALS6
proc gf180mcu::rm3_defaults {} {
    return {w 0.280 l 0.100 m 1 nx 1 wmin 0.28 lmin 0.10 class resistor \
		rho 0.090 val 0.032 dummy 0 dw 0.0 term 0.0 \
		roverlap 0}
}
#endif (METALS4 || METALS5 || METALS6)

#ifdef METALS4
#ifdef THICKMET3P0
proc gf180mcu::rm4_defaults {} {
    return {w 1.800 l 0.100 m 1 nx 1 wmin 1.80 lmin 0.10 class resistor \
		rho 0.0095 val 0.0005 dummy 0 dw 0.0 term 0.0 \
		roverlap 0}
}
#elseif (THICKMET1P1 || THICKMET0P9)
proc gf180mcu::rm4_defaults {} {
    return {w 0.440 l 0.100 m 1 nx 1 wmin 0.44 lmin 0.10 class resistor \
		rho 0.040 val 0.009 dummy 0 dw 0.0 term 0.0 \
		roverlap 0}
}
#else (!(THICKMET3P0 || THICKMET1P1 || THICKMET0P9))
proc gf180mcu::rm4_defaults {} {
    return {w 0.360 l 0.100 m 1 nx 1 wmin 0.36 lmin 0.10 class resistor \
		rho 0.060 val 0.017 dummy 0 dw 0.0 term 0.0 \
		roverlap 0}
}
#endif (!(THICKMET3P0 || THICKMET1P1 || THICKMET0P9))
#endif (METALS4)
#ifdef METALS5 || METALS6
proc gf180mcu::rm4_defaults {} {
    return {w 0.280 l 0.100 m 1 nx 1 wmin 0.28 lmin 0.10 class resistor \
		rho 0.090 val 0.032 dummy 0 dw 0.0 term 0.0 \
		roverlap 0}
}
#endif (METALS5 || METALS6)

#ifdef METALS5
#ifdef THICKMET3P0
proc gf180mcu::rm5_defaults {} {
    return {w 1.800 l 0.100 m 1 nx 1 wmin 1.80 lmin 0.10 class resistor \
		rho 0.0095 val 0.0005 dummy 0 dw 0.0 term 0.0 \
		roverlap 0}
}
#elseif (THICKMET1P1 || THICKMET0P9)
proc gf180mcu::rm5_defaults {} {
    return {w 0.440 l 0.100 m 1 nx 1 wmin 0.44 lmin 0.10 class resistor \
		rho 0.040 val 0.009 dummy 0 dw 0.0 term 0.0 \
		roverlap 0}
}
#else (!(THICKMET3P0 || THICKMET1P1 || THICKMET0P9))
proc gf180mcu::rm5_defaults {} {
    return {w 0.360 l 0.100 m 1 nx 1 wmin 0.36 lmin 0.10 class resistor \
		rho 0.060 val 0.017 dummy 0 dw 0.0 term 0.0 \
		roverlap 0}
}
#endif (!(THICKMET3P0 || THICKMET1P1 || THICKMET0P9))
#endif (METALS5)
#ifdef METALS6
proc gf180mcu::rm5_defaults {} {
    return {w 0.280 l 0.100 m 1 nx 1 wmin 0.28 lmin 0.10 class resistor \
		rho 0.090 val 0.032 dummy 0 dw 0.0 term 0.0 \
		roverlap 0}
}
#endif (METALS6)

#ifdef METALS6
#ifdef THICKMET3P0
proc gf180mcu::rmtp_defaults {} {
    return {w 1.800 l 0.100 m 1 nx 1 wmin 1.80 lmin 0.10 class resistor \
		rho 0.0095 val 0.0005 dummy 0 dw 0.0 term 0.0 \
		roverlap 0}
}
#elseif (THICKMET1P1 || THICKMET0P9)
proc gf180mcu::rmtp_defaults {} {
    return {w 0.440 l 0.100 m 1 nx 1 wmin 0.44 lmin 0.10 class resistor \
		rho 0.040 val 0.009 dummy 0 dw 0.0 term 0.0 \
		roverlap 0}
}
#else (!(THICKMET3P0 || THICKMET1P1 || THICKMET0P9))
proc gf180mcu::rmtp_defaults {} {
    return {w 0.360 l 0.100 m 1 nx 1 wmin 0.36 lmin 0.10 class resistor \
		rho 0.060 val 0.017 dummy 0 dw 0.0 term 0.0 \
		roverlap 0}
}
#endif (!(THICKMET3P0 || THICKMET1P1 || THICKMET0P9))
#endif (METALS6)

#ifdef HRPOLY1K

#----------------------------------------------------------------
# ppolyf_u_1k: Specify all user-editable default values and those
# needed by npolyf_u_check
#----------------------------------------------------------------

proc gf180mcu::ppolyf_u_1k_defaults {} {
    return {w 1.000 l 2.000 m 1 nx 1 wmin 1.000 lmin 1.000 class resistor \
		rho 1000 val 2000 dummy 0 dw 0.0296 term 0.0 \
		sterm 0.0 caplen 0.4 snake 0 \
		glc 1 grc 1 gtc 0 gbc 0 roverlap 0 endcov 100 \
		full_metal 1 guard 1 guard_type pwell \
		compatible {ppolyf_u_1k ppolyf_u_1k_6p0}}
}

proc gf180mcu::ppolyf_u_1k_6p0_defaults {} {
    return {w 1.000 l 2.000 m 1 nx 1 wmin 1.000 lmin 1.000 class resistor \
		rho 1000 val 2000 dummy 0 dw 0.0296 term 0.0 \
		sterm 0.0 caplen 0.4 snake 0 \
		glc 1 grc 1 gtc 0 gbc 0 roverlap 0 endcov 100 \
		full_metal 1 guard 1 guard_type pwell \
		compatible {ppolyf_u_1k ppolyf_u_1k_6p0}}
}
#endif (HRPOLY1K)
 
#----------------------------------------------------------------
# resistor: Conversion from SPICE netlist parameters to toolkit
#----------------------------------------------------------------

proc gf180mcu::res_convert {parameters} {
    set pdkparams [dict create]
    dict for {key value} $parameters {
	set canonkey $key
	switch -nocase $key {
	    r_length -
	    r_width -
	    l -
	    w {
		switch -nocase $key {
		    r_length {
			set canonkey l
		    }
		    r_width {
			set canonkey w
		    }
		}
		# Length and width are converted to units of microns
		set value [magic::spice2float $value]
		set value [expr $value * 1e6]
		set value [magic::3digitpastdecimal $value]
		dict set pdkparams [string tolower $canonkey] $value
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

proc gf180mcu::nwell_convert {parameters} {
    return [gf180mcu::res_convert $parameters]
}

proc gf180mcu::ppolyf_u_convert {parameters} {
    return [gf180mcu::res_convert $parameters]
}

proc gf180mcu::ppolyf_s_convert {parameters} {
    return [gf180mcu::res_convert $parameters]
}

proc gf180mcu::npolyf_s_convert {parameters} {
    return [gf180mcu::res_convert $parameters]
}

proc gf180mcu::npolyf_u_convert {parameters} {
    return [gf180mcu::res_convert $parameters]
}

proc gf180mcu::nplus_u_convert {parameters} {
    return [gf180mcu::res_convert $parameters]
}

proc gf180mcu::nplus_u_6p0_convert {parameters} {
    return [gf180mcu::res_convert $parameters]
}

proc gf180mcu::pplus_u_convert {parameters} {
    return [gf180mcu::res_convert $parameters]
}

proc gf180mcu::pplus_u_6p0_convert {parameters} {
    return [gf180mcu::res_convert $parameters]
}

proc gf180mcu::rm1_convert {parameters} {
    return [gf180mcu::res_convert $parameters]
}

proc gf180mcu::rm2_convert {parameters} {
    return [gf180mcu::res_convert $parameters]
}

#ifdef METALS3 || METALS4 || METALS5 || METALS6
proc gf180mcu::rm3_convert {parameters} {
    return [gf180mcu::res_convert $parameters]
}
#endif (METALS3 || METALS4 || METALS5 || METALS6)

#ifdef METALS4 || METALS5 || METALS6
proc gf180mcu::rm4_convert {parameters} {
    return [gf180mcu::res_convert $parameters]
}
#endif (METALS4 || METALS5 || METALS6)
#ifdef METALS5 || METALS6
proc gf180mcu::rm5_convert {parameters} {
    return [gf180mcu::res_convert $parameters]
}
#endif (METALS5 || METALS6)
#ifdef METALS6
proc gf180mcu::rmtp_convert {parameters} {
    return [gf180mcu::res_convert $parameters]
}
#endif (METALS6)

#ifdef HRPOLY1K
proc gf180mcu::ppolyf_u_1k_convert {parameters} {
    return [gf180mcu::res_convert $parameters]
}

proc gf180mcu::ppolyf_u_1k_6p0_convert {parameters} {
    return [gf180mcu::res_convert $parameters]
}
#endif (HRPOLY1K)

#----------------------------------------------------------------
# resistor: Interactively specifies the fixed layout parameters
#----------------------------------------------------------------

proc gf180mcu::res_dialog {device parameters} {
    # Editable fields:      w, l, t, nx, m, val
    # Checked fields:  

    magic::add_entry val "Value (ohms)" $parameters
    if {[dict exists $parameters snake]} {
	gf180mcu::compute_ltot $parameters
	magic::add_message ltot "Total length (um)" $parameters
    }
    magic::add_entry l "Length (um)" $parameters
    magic::add_entry w "Width (um)" $parameters
    magic::add_entry nx "X Repeat" $parameters
    magic::add_entry m "Y Repeat" $parameters
    if {[dict exists $parameters endcov]} {
	magic::add_entry endcov "End contact coverage (%)" $parameters
    }

    if {[dict exists $parameters compatible]} {
       set sellist [dict get $parameters compatible]
       # Reserved word "gencell" has special behavior to change the
       # underlying device type 
       dict set parameters gencell $device
       magic::add_selectlist gencell "Device type" $sellist $parameters
    }

    # magic::add_checkbox dummy "Add dummy" $parameters

    if {[dict exists $parameters snake]} {
	magic::add_checkbox snake "Use snake geometry" $parameters
    }
    if {[dict exists $parameters roverlap]} {
	if {[dict exists $parameters endcov]} {
            magic::add_checkbox roverlap "Overlap at end contact" $parameters
	} else {
            magic::add_checkbox roverlap "Overlap at ends" $parameters
	}
    }
    if {[dict exists $parameters guard]} {
	magic::add_checkbox guard "Add guard ring" $parameters

	if {[dict exists $parameters guard_type]} {
	    set sellist {nwell pwell}
	    magic::add_selectlist guard_type "Guard ring type" $sellist $parameters pwell
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
    }

    if {[dict exists $parameters snake]} {
       magic::add_dependency gf180mcu::res_recalc $device gf180mcu l w val nx snake
    } else {
       magic::add_dependency gf180mcu::res_recalc $device gf180mcu l w val nx
    }
}

#----------------------------------------------------------------

proc gf180mcu::nwell_dialog {parameters} {
    gf180mcu::res_dialog nwell $parameters
}

proc gf180mcu::ppolyf_u_dialog {parameters} {
    gf180mcu::res_dialog ppolyf_u $parameters
}

proc gf180mcu::npolyf_u_dialog {parameters} {
    gf180mcu::res_dialog npolyf_u $parameters
}

proc gf180mcu::ppolyf_s_dialog {parameters} {
    gf180mcu::res_dialog ppolyf_s $parameters
}

proc gf180mcu::npolyf_s_dialog {parameters} {
    gf180mcu::res_dialog npolyf_s $parameters
}

proc gf180mcu::nplus_u_dialog {parameters} {
    gf180mcu::res_dialog nplus_u $parameters
}

proc gf180mcu::nplus_u_6p0_dialog {parameters} {
    gf180mcu::res_dialog nplus_u $parameters
}

proc gf180mcu::pplus_u_dialog {parameters} {
    gf180mcu::res_dialog pplus_u $parameters
}

proc gf180mcu::pplus_u_6p0_dialog {parameters} {
    gf180mcu::res_dialog pplus_u $parameters
}

proc gf180mcu::nplus_u_3p3_dialog {parameters} {
    gf180mcu::res_dialog nplus_u_3p3 $parameters
}

proc gf180mcu::pplus_u_3p3_dialog {parameters} {
    gf180mcu::res_dialog pplus_u_3p3 $parameters
}

proc gf180mcu::rm1_dialog {parameters} {
    gf180mcu::res_dialog rm1 $parameters
}

proc gf180mcu::rm2_dialog {parameters} {
    gf180mcu::res_dialog rm2 $parameters
}

#ifdef METALS3 || METALS4 || METALS5 || METALS6
proc gf180mcu::rm3_dialog {parameters} {
    gf180mcu::res_dialog rm3 $parameters
}
#endif (METALS3 || METALS4 || METALS5 || METALS6)

#ifdef METALS4 || METALS5 || METALS6
proc gf180mcu::rm4_dialog {parameters} {
    gf180mcu::res_dialog rm4 $parameters
}
#endif (METALS4 || METALS5 || METALS6)
#ifdef METALS5 || METALS6
proc gf180mcu::rm5_dialog {parameters} {
    gf180mcu::res_dialog rm5 $parameters
}
#endif (METALS5 || METALS6)
#ifdef METALS6
proc gf180mcu::rmtp_dialog {parameters} {
    gf180mcu::res_dialog rmtp $parameters
}
#endif (METALS6)

#ifdef HRPOLY1K
proc gf180mcu::ppolyf_u_1k_dialog {parameters} {
    gf180mcu::res_dialog ppolyf_u_1k $parameters
}

proc gf180mcu::ppolyf_u_1k_6p0_dialog {parameters} {
    gf180mcu::res_dialog ppolyf_u_1k_6p0 $parameters
}
#endif (HRPOLY1K)

#----------------------------------------------------------------
# Resistor: Draw a single device in straight geometry
#----------------------------------------------------------------

proc gf180mcu::res_device {parameters} {
    # Epsilon for avoiding round-off errors
    set eps  0.0005

    # Set local default values if they are not in parameters
    set endcov 0	 	;# percent coverage of end contacts
    set well_res_overlap 0 	;# not a well resistor
    set end_contact_type ""	;# no contacts for metal resistors

    # Set a local variable for each parameter (e.g., $l, $w, etc.)
    foreach key [dict keys $parameters] {
        set $key [dict get $parameters $key]
    }

    # Draw the resistor and endcaps
    pushbox
    box size 0 0
    pushbox
    set hw [/ $w 2.0]
    set hl [/ $l 2.0]
    box grow n ${hl}um
    box grow s ${hl}um
    box grow e ${hw}um
    box grow w ${hw}um

    pushbox
    box grow n ${res_to_endcont}um
    box grow s ${res_to_endcont}um
    if {$well_res_overlap > 0} {
	set well_extend [+ ${well_res_overlap} [/ ${contact_size} 2.0] ${end_surround}]
	box grow n ${well_extend}um
	box grow s ${well_extend}um
	paint ${well_res_type}
    } else {
	paint ${end_type}
    }
    set cext [gf180mcu::getbox]
    popbox

    if {$well_res_overlap > 0} {
	erase ${well_res_type}
    } else {
	erase ${end_type}
    }
    paint ${res_type}
    popbox

    # Reduce contact sizes by (end type) surround so that
    # the contact area edges match the device type width.
    # (Minimum dimensions will be enforced by the contact drawing routine)
    set epl [- ${w} [* ${end_surround} 2]]     	    ;# end contact width

    # Reduce end material size for well resistor types
    if {$well_res_overlap > 0} {
	set epl [- ${epl} [* ${well_res_overlap} 2]]
    }

    # Reduce by coverage percentage unless overlapping at contacts
    if {(${roverlap} == 0) && (${endcov} > 0)} {
	set cpl [* ${epl} [/ ${endcov} 100.0]]
    } else {
	set cpl $epl
    }

    set hepl [+ [/ ${epl} 2.0] ${end_surround}]
    set hesz [+ [/ ${contact_size} 2.0] ${end_surround}]

    # Top end material & contact
    pushbox
    box move n ${hl}um
    box move n ${res_to_endcont}um

    pushbox
    box size 0 0
    box grow n ${hesz}um
    box grow s ${hesz}um
    box grow e ${hepl}um
    box grow w ${hepl}um
    paint ${end_type}
    set cext [gf180mcu::unionbox $cext [gf180mcu::getbox]]
    popbox

    if {${end_contact_type} != ""} {
	set cext [gf180mcu::unionbox $cext [gf180mcu::draw_contact ${cpl} 0 \
		${end_surround} ${metal_surround} ${contact_size} \
		${end_type} ${end_contact_type} m1 horz]]
    }
    popbox

    # Bottom end material & contact
    pushbox
    box move s ${hl}um
    box move s ${res_to_endcont}um

    pushbox
    box size 0 0
    box grow n ${hesz}um
    box grow s ${hesz}um
    box grow e ${hepl}um
    box grow w ${hepl}um
    paint ${end_type}
    set cext [gf180mcu::unionbox $cext [gf180mcu::getbox]]
    popbox

    if {${end_contact_type} != ""} {
	set cext [gf180mcu::unionbox $cext [gf180mcu::draw_contact ${cpl} 0 \
		${end_surround} ${metal_surround} ${contact_size} \
		${end_type} ${end_contact_type} m1 horz]]
    }
    popbox

    popbox
    return $cext
}

#----------------------------------------------------------------
# Resistor: Draw a single device in snake geometry
#----------------------------------------------------------------

proc gf180mcu::res_snake_device {nf parameters} {
    # nf is the number of fingers of the snake geometry

    # Epsilon for avoiding round-off errors
    set eps  0.0005

    # Set local default values if they are not in parameters
    set endcov 100	 	;# percent coverage of end contacts
    set well_res_overlap 0 	;# not a well resistor
    set end_contact_type ""	;# no contacts for metal resistors
    set mask_clearance 0	;# additional length to clear mask

    # Set a local variable for each parameter (e.g., $l, $w, etc.)
    foreach key [dict keys $parameters] {
        set $key [dict get $parameters $key]
    }

    # Compute half width and length
    set hw [/ $w 2.0]
    set hl [/ $l 2.0]

    # Reduce contact sizes by (end type) surround so that
    # the contact area edges match the device type width.
    # (Minimum dimensions will be enforced by the contact drawing routine)
    set epl [- ${w} [* ${end_surround} 2]]     	    ;# end contact width

    # Reduce contact size for well resistor types
    if {$well_res_overlap > 0} {
	set epl [- ${epl} [* ${well_res_overlap} 2]]
    }

    # Reduce contact part of end by coverage percentage
    if {${endcov} > 0} {
	set cpl [* ${epl} [/ ${endcov} 100.0]]
    } else {
	set cpl $epl
    }

    set hepl [+ [/ ${epl} 2.0] ${end_surround}]
    set hesz [+ [/ ${contact_size} 2.0] ${end_surround}]

    pushbox
    box size 0 0	;# Position is taken from caller

    # Front end contact (always bottom)
    pushbox
    box move s ${hl}um
    pushbox
    box move s ${mask_clearance}um
    box move s ${res_to_endcont}um

    pushbox
    box size 0 0
    box grow n ${hesz}um
    box grow s ${hesz}um
    box grow e ${hepl}um
    box grow w ${hepl}um
    paint ${end_type}
    set cext [gf180mcu::getbox]
    popbox

    if {${end_contact_type} != ""} {
	set cext [gf180mcu::draw_contact ${cpl} 0 \
		${end_surround} ${metal_surround} ${contact_size} \
		${end_type} ${end_contact_type} m1 horz]
    }
    popbox

    # Draw portion between resistor end and contact.
    box grow e ${hw}um
    box grow w ${hw}um
    pushbox
    box grow s ${mask_clearance}um
    paint ${res_type}
    popbox
    box move s ${mask_clearance}um
    box grow s ${res_to_endcont}um
    if {$well_res_overlap > 0} {
	set well_extend [+ ${well_res_overlap} [/ ${contact_size} 2.0] ${end_surround}]
	box grow s ${well_extend}um
	paint ${well_res_type}
    } else {
	paint ${end_type}
    }
    set cext [gf180mcu::unionbox $cext [gf180mcu::getbox]]
    popbox

    # Draw the resistor and endcaps
    pushbox
    box grow n ${hl}um
    box grow s ${hl}um
    box grow e ${hw}um
    box grow w ${hw}um

    # Capture these extents in the bounding box in case both contacts
    # are on one side.
    set cext [gf180mcu::unionbox $cext [gf180mcu::getbox]]

    set deltax [+ ${res_spacing} ${w}]
    set deltay [- ${l} ${w}]
    for {set i 0} {$i < [- $nf 1]} {incr i} {
	paint ${res_type}
 	pushbox
	if {[% $i 2] == 0} {
	    box move n ${deltay}um
	}
	box height ${w}um
	box width ${deltax}um
	paint ${res_type}
 	popbox
	box move e ${deltax}um
    }
    paint ${res_type}
    # Capture these extents in the bounding box
    set cext [gf180mcu::unionbox $cext [gf180mcu::getbox]]
    popbox

    # Move box to last finger
    set lastf [* [- $nf 1] $deltax]
    box move e ${lastf}um

    # Back-end contact (top or bottom, depending if odd or even turns)
    pushbox

    if {[% $nf 2] == 1} {
	set dir n
    } else {
	set dir s
    }
    box move $dir ${hl}um
    pushbox
    box move $dir ${mask_clearance}um
    box move $dir ${res_to_endcont}um

    pushbox
    box size 0 0
    box grow n ${hesz}um
    box grow s ${hesz}um
    box grow e ${hepl}um
    box grow w ${hepl}um
    paint ${end_type}
    set cext [gf180mcu::unionbox $cext [gf180mcu::getbox]]
    popbox

    if {${end_contact_type} != ""} {
	set cext [gf180mcu::unionbox $cext [gf180mcu::draw_contact ${cpl} 0 \
		${end_surround} ${metal_surround} ${contact_size} \
		${end_type} ${end_contact_type} m1 horz]]
    }
    popbox
    # Draw portion between resistor end and contact.
    box grow e ${hw}um
    box grow w ${hw}um
    pushbox
    box grow $dir ${mask_clearance}um
    paint ${res_type}
    popbox
    box move $dir ${mask_clearance}um
    box grow $dir ${res_to_endcont}um

    if {$well_res_overlap > 0} {
	set well_extend [+ ${well_res_overlap} [/ ${contact_size} 2.0] ${end_surround}]
	box grow $dir ${well_extend}um
	paint ${well_res_type}
    } else {
	paint ${end_type}
    }
    popbox

    popbox
    return $cext
}

#----------------------------------------------------------------
# Resistor: Draw the tiled device
#----------------------------------------------------------------

proc gf180mcu::res_draw {parameters} {
    tech unlock *

    # Set defaults if they are not in parameters
    set snake 0		;# some resistors don't allow snake geometry
    set roverlap 0	;# overlap resistors at contacts
    set guard 1		;# draw a guard ring
    set overlap_compress 0	;# special Y distance compression
    set well_res_overlap 0	;# additional well extension behind contact

    # Set a local variable for each parameter (e.g., $l, $w, etc.)
    foreach key [dict keys $parameters] {
        set $key [dict get $parameters $key]
    }

    # For devices where inter-device space is smaller than device-to-guard ring
    if {![dict exists $parameters end_to_end_space]} {
	set end_to_end_space $end_spacing
    }

    # If device has a "guard_type" parameter, then use this to set sub_type,
    # overriding any existing sub_type value.
    if {[dict exists $parameters guard_type]} {
	dict set parameters sub_type $guard_type
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
    set nf $nx
    if {($snake == 1) && ($nx == 1)} {set snake 0}
    if {$snake == 1} {
	set bbox [gf180mcu::res_snake_device $nf $parameters]
	set nx 1
    } else {
	set bbox [gf180mcu::res_device $parameters]
    }
    # puts stdout "Diagnostic: Device bounding box e $bbox (um)"
    tech unlock *

    set fw [- [lindex $bbox 2] [lindex $bbox 0]]
    set fh [- [lindex $bbox 3] [lindex $bbox 1]]
    set lw [+ [lindex $bbox 2] [lindex $bbox 0]]
    set lh [+ [lindex $bbox 3] [lindex $bbox 1]]

    # Determine tile width and height (depends on overlap)
    # Snake resistors cannot overlap.
    # However, snake resistors with an odd number of fingers can
    # compress the space if overlap_compress is defined

    if {($roverlap == 1) && ($snake == 1) && ([% $nf 2] == 1) && ($m > 1)} {
        set dy [- $fh $overlap_compress]
    } elseif {($roverlap == 0) || ($snake == 1)} {
        set dy [+ $fh $end_to_end_space]
    } else {
        # overlap poly
        set dy [- $fh [+ [* [+ $end_surround $well_res_overlap] 2.0] $contact_size]]
    }
    set dx [+ $fw $res_spacing]

    # Determine core width and height
    set corex [+ [* [- $nx 1] $dx] $fw]
    set corey [+ [* [- $m 1] $dy] $fh]
    set corellx [/ [+ [- $corex $fw] $lw] 2.0]
    set corelly [/ [+ [- $corey $fh] $lh] 2.0]

    if {$guard != 0} {
	# Calculate guard ring size (measured to contact center)
	set gx [+ $corex [* 2.0 [+ $res_diff_spacing $diff_surround]] $contact_size]
	set gy [+ $corey [* 2.0 [+ $end_spacing $diff_surround]] $contact_size]

	# Draw the guard ring first, because well resistors are on the substrate plane
	gf180mcu::guard_ring $gx $gy $parameters
    }

    pushbox
    box move w ${corellx}um
    box move s ${corelly}um
    # puts "Device position at = [gf180mcu::getbox]"
    for {set xp 0} {$xp < $nx} {incr xp} {
	pushbox
	for {set yp 0} {$yp < $m} {incr yp} {
	    if {$snake == 1} {
		gf180mcu::res_snake_device $nf $parameters
	    } else {
		gf180mcu::res_device $parameters
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

proc gf180mcu::ppolyf_u_draw {parameters} {

    # Set a local variable for each rule in ruleset
    foreach key [dict keys $gf180mcu::ruleset] {
        set $key [dict get $gf180mcu::ruleset $key]
    }

    set newdict [dict create \
	    res_type		rpp \
	    end_type 		poly \
	    end_contact_type	pc \
	    plus_diff_type	nsd \
	    plus_contact_type	nsc \
	    sub_type		nwell \
	    end_surround	$poly_surround \
	    end_spacing		0.60 \
	    end_to_end_space	0.52 \
	    res_to_endcont	$sblk_to_cont \
	    res_spacing		$polyres_spacing \
	    res_diff_spacing	0.60 \
	    mask_clearance	0.52 \
	    overlap_compress	0.36 \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::res_draw $drawdict]
}

#----------------------------------------------------------------

proc gf180mcu::npolyf_u_draw {parameters} {

    # Set a local variable for each rule in ruleset
    foreach key [dict keys $gf180mcu::ruleset] {
        set $key [dict get $gf180mcu::ruleset $key]
    }

    set newdict [dict create \
	    res_type		rnp \
	    end_type 		poly \
	    end_contact_type	pc \
	    plus_diff_type	psd \
	    plus_contact_type	psc \
	    sub_type		pwell \
	    end_surround	$poly_surround \
	    end_spacing		0.60 \
	    end_to_end_space	0.52 \
	    res_to_endcont	$sblk_to_cont \
	    res_spacing		$polyres_spacing \
	    res_diff_spacing	0.60 \
	    mask_clearance	0.52 \
	    overlap_compress	0.36 \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::res_draw $drawdict]
}

#----------------------------------------------------------------

proc gf180mcu::ppolyf_s_draw {parameters} {

    # Set a local variable for each rule in ruleset
    foreach key [dict keys $gf180mcu::ruleset] {
        set $key [dict get $gf180mcu::ruleset $key]
    }

    # Distance from resistor to end contact is different between straight
    # and snake geometry.

    set res_to_endcont [+ $poly_surround [/ $contact_size 2.0]]
    if {[dict exists $parameters snake]} {
	if {[dict get $parameters snake] == 1} {
	    set res_to_endcont [+ $res_to_endcont $poly_spacing]
	}
    }

    set newdict [dict create \
	    res_type		rpps \
	    end_type 		poly \
	    end_contact_type	pc \
	    plus_diff_type	nsd \
	    plus_contact_type	nsc \
	    sub_type		nwell \
	    end_surround	$poly_surround \
	    end_spacing		0.28 \
	    end_to_end_space	0.41 \
	    res_to_endcont	$res_to_endcont \
	    res_spacing		$polyres_spacing \
	    res_diff_spacing	0.41 \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::res_draw $drawdict]
}

#----------------------------------------------------------------

proc gf180mcu::npolyf_s_draw {parameters} {

    # Set a local variable for each rule in ruleset
    foreach key [dict keys $gf180mcu::ruleset] {
        set $key [dict get $gf180mcu::ruleset $key]
    }

    # Distance from resistor to end contact is different between straight
    # and snake geometry.

    set res_to_endcont [+ $poly_surround [/ $contact_size 2.0]]
    if {[dict exists $parameters snake]} {
	if {[dict get $parameters snake] == 1} {
	    set res_to_endcont [+ $res_to_endcont $poly_spacing]
	}
    }

    set newdict [dict create \
	    res_type		rnps \
	    end_type 		poly \
	    end_contact_type	pc \
	    plus_diff_type	nsd \
	    plus_contact_type	nsc \
	    sub_type		nwell \
	    end_surround	$poly_surround \
	    end_spacing		0.28 \
	    end_to_end_space	0.41 \
	    res_to_endcont	$res_to_endcont \
	    res_spacing		$polyres_spacing \
	    res_diff_spacing	0.28 \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::res_draw $drawdict]
}

#----------------------------------------------------------------

proc gf180mcu::nplus_u_draw {parameters} {

    # Set a local variable for each rule in ruleset
    foreach key [dict keys $gf180mcu::ruleset] {
        set $key [dict get $gf180mcu::ruleset $key]
    }

    set newdict [dict create \
	    res_type		rnd \
	    end_type 		ndiff \
	    end_contact_type	ndc \
	    plus_diff_type	psd \
	    plus_contact_type	psc \
	    sub_type		pwell \
	    end_surround	$diff_surround \
	    end_spacing		0.45 \
	    res_to_endcont	0.45 \
	    res_spacing		$diffres_spacing \
	    res_diff_spacing	0.45 \
	    mask_clearance	0.22 \
	    overlap_compress	0.36 \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::res_draw $drawdict]
}

#----------------------------------------------------------------

proc gf180mcu::pplus_u_draw {parameters} {

    # Set a local variable for each rule in ruleset
    foreach key [dict keys $gf180mcu::ruleset] {
        set $key [dict get $gf180mcu::ruleset $key]
    }

    set newdict [dict create \
	    res_type		rpd \
	    end_type 		pdiff \
	    end_contact_type	pdc \
	    plus_diff_type	nsd \
	    plus_contact_type	nsc \
	    sub_type		nwell \
	    end_surround	$diff_surround \
	    end_spacing		0.45 \
	    res_to_endcont	0.45 \
	    res_spacing		$diffres_spacing \
	    res_diff_spacing	0.45 \
	    mask_clearance	0.22 \
	    overlap_compress	0.36 \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::res_draw $drawdict]
}

#----------------------------------------------------------------

proc gf180mcu::nplus_u_6p0_draw {parameters} {

    # Set a local variable for each rule in ruleset
    foreach key [dict keys $gf180mcu::ruleset] {
        set $key [dict get $gf180mcu::ruleset $key]
    }

    set newdict [dict create \
	    res_type		mvrnd \
	    end_type 		mvndiff \
	    end_contact_type	mvndc \
	    plus_diff_type	mvpsd \
	    plus_contact_type	mvpsc \
	    sub_type		pwell \
	    end_surround	$diff_surround \
	    end_spacing		0.45 \
	    res_to_endcont	0.45 \
	    res_spacing		$diffres_spacing \
	    res_diff_spacing	0.45 \
	    mask_clearance	0.22 \
	    overlap_compress	0.36 \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::res_draw $drawdict]
}

#----------------------------------------------------------------

proc gf180mcu::pplus_u_6p0_draw {parameters} {

    # Set a local variable for each rule in ruleset
    foreach key [dict keys $gf180mcu::ruleset] {
        set $key [dict get $gf180mcu::ruleset $key]
    }

    set newdict [dict create \
	    res_type		mvrpd \
	    end_type 		mvpdiff \
	    end_contact_type	mvpdc \
	    plus_diff_type	mvnsd \
	    plus_contact_type	mvnsc \
	    sub_type		nwell \
	    end_surround	$diff_surround \
	    end_spacing		0.45 \
	    res_to_endcont	0.45 \
	    res_spacing		$diffres_spacing \
	    res_diff_spacing	0.45 \
	    mask_clearance	0.22 \
	    overlap_compress	0.36 \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::res_draw $drawdict]
}

#----------------------------------------------------------------

proc gf180mcu::nwell_draw {parameters} {

    # Set a local variable for each rule in ruleset
    foreach key [dict keys $gf180mcu::ruleset] {
        set $key [dict get $gf180mcu::ruleset $key]
    }

    set newdict [dict create \
	    well_res_type	nwell \
	    res_type		rnw \
	    end_type 		nsd \
	    end_contact_type	nsc \
	    plus_diff_type	psd \
	    plus_contact_type	psc \
	    sub_type		pwell \
	    end_surround	$diff_surround \
	    end_spacing		1.4 \
	    overlap_compress	-0.84 \
	    res_to_endcont	0.38 \
	    res_spacing		1.4 \
	    res_diff_spacing	0.28 \
	    well_res_overlap	0.24 \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::res_draw $drawdict]
}

#----------------------------------------------------------------

#ifdef HRPOLY1K
proc gf180mcu::ppolyf_u_1k_draw {parameters} {
    # Set a local variable for each rule in ruleset
    foreach key [dict keys $gf180mcu::ruleset] {
        set $key [dict get $gf180mcu::ruleset $key]
    }

    set newdict [dict create \
	    res_type		hires \
	    end_type 		poly \
	    end_contact_type	pc \
	    plus_diff_type	psd \
	    plus_contact_type	psc \
	    sub_type		pwell \
	    end_surround	$poly_surround \
	    end_spacing		0.7 \
	    res_to_endcont	0.43 \
	    res_spacing		$polyres_spacing \
	    res_diff_spacing	0.7 \
	    mask_clearance	0.22 \
	    overlap_compress	0.36 \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::res_draw $drawdict]
}

proc gf180mcu::ppolyf_u_1k_6p0_draw {parameters} {
    # Set a local variable for each rule in ruleset
    foreach key [dict keys $gf180mcu::ruleset] {
        set $key [dict get $gf180mcu::ruleset $key]
    }

    set newdict [dict create \
	    diff_poly_space	0.30 \
	    diff_gate_space	0.30 \
	    diff_spacing	0.36 \
	    res_type		mvhires \
	    end_type 		poly \
	    end_contact_type	pc \
	    plus_diff_type	mvpsd \
	    plus_contact_type	mvpsc \
	    sub_type		pwell \
	    sub_surround	0.16 \
	    end_surround	$poly_surround \
	    end_spacing		0.7 \
	    res_to_endcont	0.43 \
	    res_spacing		$polyres_spacing \
	    res_diff_spacing	0.7 \
	    mask_clearance	0.22 \
	    overlap_compress	0.36 \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::res_draw $drawdict]
}
#endif (HRPOLY1K)

#----------------------------------------------------------------

proc gf180mcu::rm1_draw {parameters} {

    # Set a local variable for each rule in ruleset
    foreach key [dict keys $gf180mcu::ruleset] {
        set $key [dict get $gf180mcu::ruleset $key]
    }

    set newdict [dict create \
	    guard		0 \
	    res_type		rm1 \
	    end_type 		m1 \
	    end_surround	0.0 \
	    end_spacing		0.0 \
	    res_to_endcont	0.2 \
	    res_spacing		$metal_spacing \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::res_draw $drawdict]
}

#----------------------------------------------------------------

proc gf180mcu::rm2_draw {parameters} {

    # Set a local variable for each rule in ruleset
    foreach key [dict keys $gf180mcu::ruleset] {
        set $key [dict get $gf180mcu::ruleset $key]
    }

    set newdict [dict create \
	    guard		0 \
	    res_type		rm2 \
	    end_type 		m2 \
	    end_surround	0.0 \
	    end_spacing		0.0 \
	    res_to_endcont	0.2 \
	    res_spacing		$mmetal_spacing \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::res_draw $drawdict]
}

#----------------------------------------------------------------

#ifdef METALS3 || METALS4 || METALS5 || METALS6
proc gf180mcu::rm3_draw {parameters} {

    # Set a local variable for each rule in ruleset
    foreach key [dict keys $gf180mcu::ruleset] {
        set $key [dict get $gf180mcu::ruleset $key]
    }

    set newdict [dict create \
	    guard		0 \
	    res_type		rm3 \
	    end_type 		m3 \
	    end_surround	0.0 \
	    end_spacing		0.0 \
	    res_to_endcont	0.2 \
	    res_spacing		$mmetal_spacing \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::res_draw $drawdict]
}

#----------------------------------------------------------------
#endif (METALS3 || METALS4 || METALS5 || METALS6)

#ifdef METALS4 || METALS5 || METALS6
proc gf180mcu::rm4_draw {parameters} {

    # Set a local variable for each rule in ruleset
    foreach key [dict keys $gf180mcu::ruleset] {
        set $key [dict get $gf180mcu::ruleset $key]
    }

    set newdict [dict create \
	    guard		0 \
	    res_type		rm4 \
	    end_type 		m4 \
	    end_surround	0.0 \
	    end_spacing		0.0 \
	    res_to_endcont	0.2 \
	    res_spacing		$mmetal_spacing \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::res_draw $drawdict]
}
#endif (METALS4 || METALS5 || METALS6)

#ifdef METALS5 || METALS6
proc gf180mcu::rm5_draw {parameters} {
    # Set a local variable for each rule in ruleset
    foreach key [dict keys $gf180mcu::ruleset] {
        set $key [dict get $gf180mcu::ruleset $key]
    }

    set newdict [dict create \
	    guard		0 \
	    res_type		rm5 \
	    end_type 		m5 \
	    end_surround	0.0 \
	    end_spacing		0.0 \
	    res_to_endcont	0.265 \
	    res_spacing		$mmetal_spacing \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::res_draw $drawdict]
}
#endif (METALS5 || METALS6)
#ifdef METALS6
proc gf180mcu::rmtp_draw {parameters} {
    # Set a local variable for each rule in ruleset
    foreach key [dict keys $gf180mcu::ruleset] {
        set $key [dict get $gf180mcu::ruleset $key]
    }

    set newdict [dict create \
	    guard		0 \
	    res_type		rmtp \
	    end_type 		mtp \
	    end_surround	0.0 \
	    end_spacing		0.0 \
	    res_to_endcont	0.2 \
	    res_spacing		$mmetal_spacing \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::res_draw $drawdict]
}
#endif (METALS6)

#----------------------------------------------------------------
# Resistor total length computation
#----------------------------------------------------------------

proc gf180mcu::compute_ltot {parameters} {
    # In case snake not defined
    set snake 0
    set caplen 0

    foreach key [dict keys $parameters] {
        set $key [dict get $parameters $key]
    }

    set l [magic::spice2float $l]
    set l [magic::3digitpastdecimal $l]

    # Compute total length.  Use catch to prevent error in batch/scripted mode.
    if {$snake == 1} {
	catch {set magic::ltot_val [expr ($caplen * ($nx - 1)) + ($l * $nx) + ($nx - 1)]}
    } else {
	catch {set magic::ltot_val $l}
    }
}

#----------------------------------------------------------------
# resistor: Check device parameters for out-of-bounds values
#----------------------------------------------------------------

proc gf180mcu::res_check {device parameters} {

    # Set a local variable for each parameter (e.g., $l, $w, etc.)
    set snake 0
    set sterm 0.0
    set caplen 0
    foreach key [dict keys $parameters] {
        set $key [dict get $parameters $key]
    }

    # Normalize distance units to microns
    set w [magic::spice2float $w]
    set w [magic::3digitpastdecimal $w]
    set l [magic::spice2float $l]
    set l [magic::3digitpastdecimal $l]

    set val  [magic::spice2float $val]
    set rho  [magic::spice2float $rho]

    # nf, m must be integer
    if {![string is int $nx]} {
	puts stderr "X repeat must be an integer!"
        dict set parameters nx 1
    }
    if {![string is int $m]} {
	puts stderr "Y repeat must be an integer!"
        dict set parameters m 1
    }

    # Width always needs to be specified
    if {$w < $wmin} {
	puts stderr "Resistor width must be >= $wmin um"
	dict set parameters w $wmin
    } 
    # Val and W specified - no L
    if {$l == 0}  {
   	set l [expr ($w - $dw) * $val / $rho]
        set l [magic::3digitpastdecimal $l]
        set stringval [magic::float2spice $val]
	dict set parameters l [magic::float2spice [expr $l * 1e-6]]
	# L and W specified - ignore Val if specified
    } else {
	if {$snake == 0} {
	    set val [expr (2 * $term + $l * $rho) / ($w - $dw)]
	} else {
	    set val [expr $rho * ($nx - 1) + ((2 * ($term + $sterm)) \
			+ ($rho * $l * $nx) + ($rho * $caplen * ($nx - 1))) \
			/ ($w - $dw)]
	}
	set val [magic::float2spice $val]
        dict set parameters val $val
    }
    if {$l < $lmin} {
	puts stderr "Resistor length must be >= $lmin um"
	dict set parameters l $lmin
    } 
    if {$nx < 1} {
	puts stderr "X repeat must be >= 1"
	dict set parameters nx 1
    } 
    if {$m < 1} {
	puts stderr "Y repeat must be >= 1"
	dict set parameters m 1
    } 

    # Snake resistors cannot have width greater than length
    if {$snake == 1} {
	if {$w > $l} {
	    puts stderr "Snake resistor width must be < length"
	    dict set parameters w $l
	}
    }

    # Diffusion resistors must satisfy diffusion-to-tap spacing of 20um.
    # Therefore the maximum of guard ring width or height cannot exceed 40um.
    # If in violation, reduce counts first, as these are easiest to recover
    # by duplicating the device and overlapping the wells.
    if {$device == "rdn" || $device == "rdp"} {
       set origm $m
       set orignx $nx
       while true {
	  set xext [expr ($w + 0.8) * $nx + 1.0]
	  set yext [expr ($l + 1.7) * $m + 1.7]
          if {[expr min($xext, $yext)] > 40.0} {
              if {$yext > 40.0 && $m > 1} {
		 incr m -1
	      } elseif {$xext > 40.0 && $nx > 1} {
		 incr nx -1
	      } elseif {$yext > 40.0} {
		 set l 36.6
		 puts -nonewline stderr "Diffusion resistor length must be < 36.6 um"
		 puts stderr " to avoid tap spacing violation."
		 dict set parameters l $l
	      } elseif {$xext > 40.0} {
		 set w 38.2
		 puts -nonewline stderr "Diffusion resistor width must be < 38.2 um"
		 puts stderr " to avoid tap spacing violation."
		 dict set parameters w $w
	      }
          } else {
	      break
	  }
       }
       if {$m != $origm} {
	  puts stderr "Y repeat reduced to prevent tap distance violation"
	  dict set parameters m $m
       }
       if {$nx != $orignx} {
	  puts stderr "X repeat reduced to prevent tap distance violation"
	  dict set parameters nx $nx
       }
    }
    gf180mcu::compute_ltot $parameters
    return $parameters
}

#----------------------------------------------------------------

proc gf180mcu::nwell_check {parameters} {
    return [gf180mcu::res_check nwell $parameters]
}

proc gf180mcu::ppolyf_u_check {parameters} {
    return [gf180mcu::res_check ppolyf_u $parameters]
}

proc gf180mcu::npolyf_u_check {parameters} {
    return [gf180mcu::res_check npolyf_u $parameters]
}

proc gf180mcu::ppolyf_s_check {parameters} {
    return [gf180mcu::res_check rpp1s $parameters]
}

proc gf180mcu::npolyf_s_check {parameters} {
    return [gf180mcu::res_check rpp1s $parameters]
}

proc gf180mcu::nplus_u_check {parameters} {
    return [gf180mcu::res_check nplus_u $parameters]
}

proc gf180mcu::nplus_u_6p0_check {parameters} {
    return [gf180mcu::res_check nplus_u $parameters]
}

proc gf180mcu::pplus_u_check {parameters} {
    return [gf180mcu::res_check pplus_u $parameters]
}

proc gf180mcu::pplus_u_6p0_check {parameters} {
    return [gf180mcu::res_check pplus_u $parameters]
}

proc gf180mcu::rm1_check {parameters} {
    return [gf180mcu::res_check rm1 $parameters]
}

proc gf180mcu::rm2_check {parameters} {
    return [gf180mcu::res_check rm2 $parameters]
}

#ifdef METALS3 || METALS4 || METALS5 || METALS6
proc gf180mcu::rm3_check {parameters} {
    return [gf180mcu::res_check rm3 $parameters]
}
#endif (METALS3 || METALS4 || METALS5 || METALS6)

#ifdef METALS4 || METALS5 || METALS6
proc gf180mcu::rm4_check {parameters} {
    return [gf180mcu::res_check rm4 $parameters]
}
#endif (METALS4 || METALS5 || METALS6)

#ifdef METALS5 || METALS6
proc gf180mcu::rm5_check {parameters} {
    return [gf180mcu::res_check rm5 $parameters]
}
#endif (METALS5 || METALS6)
#ifdef METALS6
proc gf180mcu::rmtp_check {parameters} {
    return [gf180mcu::res_check rmtp $parameters]
}
#endif (METALS6)

#ifdef HRPOLY1K
proc gf180mcu::ppolyf_u_1k_check {parameters} {
    return [gf180mcu::res_check ppolyf_u_1k $parameters]
}

proc gf180mcu::ppolyf_u_1k_6p0_check {parameters} {
    return [gf180mcu::res_check ppolyf_u_1k_6p0 $parameters]
}
#endif (HRPOLY1K)
