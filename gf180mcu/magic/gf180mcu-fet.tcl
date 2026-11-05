###
###     Source file gf180mcu-fet.tcl
###     Process this file with the preprocessor script
###
#-----------------------------------------------------
# Magic/TCL design kit for GF TECHNAME:  MOSFETs, MOS capacitors, varactors
#-----------------------------------------------------

#----------------------------------------------------------------
# MOS defaults:
#----------------------------------------------------------------
#    w       = Gate width
#    l       = Gate length
#    m	     = Multiplier
#    nf	     = Number of fingers
#    diffcov = Diffusion contact coverage
#    polycov = Poly contact coverage
#    topc    = Top gate contact
#    botc    = Bottom gate contact
#    guard   = Guard ring
#
# (not user-editable)
#
#    lmin    = Gate minimum length
#    wmin    = Gate minimum width
#----------------------------------------------------------------

#----------------------------------------------------------------
# pmos: Specify all user-editable default values and those
# needed by pmos_check
#----------------------------------------------------------------

proc gf180mcu::pfet_03v3_defaults {} {
    return {w 0.220 l 0.280 m 1 nf 1 diffcov 100 polycov 100 \
		guard 1 glc 1 grc 1 gtc 0 gbc 0 tbcov 100 rlcov 100 \
		topc 1 botc 1 poverlap 0 doverlap 1 lmin 0.28 wmin 0.22 \
		class mosfet full_metal 1 \
		viasrc 0 viadrn 0 viagate 0 \
		viagb 0 viagr 0 viagl 0 viagt 0 doports 1 \
		compatible {pfet_03v3 pfet_05v0 pfet_06v0}}
}

proc gf180mcu::pfet_05v0_defaults {} {
    return {w 0.3 l 0.5 m 1 nf 1 diffcov 100 polycov 100 \
		guard 1 glc 1 grc 1 gtc 0 gbc 0 tbcov 100 rlcov 100 \
		topc 1 botc 1 poverlap 0 doverlap 1 lmin 0.5 wmin 0.3 \
		class mosfet full_metal 1 \
		viasrc 0 viadrn 0 viagate 0 \
		viagb 0 viagr 0 viagl 0 viagt 0 doports 1 \
		compatible {pfet_03v3 pfet_05v0 pfet_06v0}}
}

proc gf180mcu::pfet_06v0_defaults {} {
    return {w 0.3 l 0.55 m 1 nf 1 diffcov 100 polycov 100 \
		guard 1 glc 1 grc 1 gtc 0 gbc 0 tbcov 100 rlcov 100 \
		topc 1 botc 1 poverlap 0 doverlap 1 lmin 0.55 wmin 0.3 \
		class mosfet full_metal 1 \
		viasrc 0 viadrn 0 viagate 0 \
		viagb 0 viagr 0 viagl 0 viagt 0 doports 1 \
		compatible {pfet_03v3 pfet_05v0 pfet_06v0}}
}

proc gf180mcu::pfet_03v3_dss_defaults {} {
    return {w 0.220 l 0.280 m 1 nf 1 diffcov 100 polycov 100 \
		guard 1 glc 1 grc 1 gtc 0 gbc 0 tbcov 100 rlcov 100 \
		topc 1 botc 1 poverlap 0 doverlap 1 lmin 0.28 wmin 0.22 \
		class mosfet full_metal 1 \
		viasrc 0 viadrn 0 viagate 0 \
		viagb 0 viagr 0 viagl 0 viagt 0 doports 1 \
		compatible {pfet_03v3_dss pfet_05v0 pfet_06v0_dss}}
}

proc gf180mcu::pfet_06v0_dss_defaults {} {
    return {w 0.3 l 0.5 m 1 nf 1 diffcov 100 polycov 100 \
		guard 1 glc 1 grc 1 gtc 0 gbc 0 tbcov 100 rlcov 100 \
		topc 1 botc 1 poverlap 0 doverlap 1 lmin 0.5 wmin 0.3 \
		class mosfet full_metal 1 \
		viasrc 0 viadrn 0 viagate 0 \
		viagb 0 viagr 0 viagl 0 viagt 0 doports 1 \
		compatible {pfet_03v3_dss pfet_06v0_dss}}
}
#----------------------------------------------------------------
# nmos: Specify all user-editable default values and those
# needed by nmos_check
#----------------------------------------------------------------

proc gf180mcu::nfet_03v3_defaults {} {
    return {w 0.220 l 0.280 m 1 nf 1 diffcov 100 polycov 100 \
		guard 1 glc 1 grc 1 gtc 0 gbc 0 tbcov 100 rlcov 100 \
		topc 1 botc 1 poverlap 0 doverlap 1 lmin 0.28 wmin 0.22 \
		class mosfet full_metal 1 \
		viasrc 0 viadrn 0 viagate 0 \
		viagb 0 viagr 0 viagl 0 viagt 0 doports 1 \
		compatible {nfet_03v3 nfet_05v0 nfet_06v0 nfet_06v0_nvt}}
}

proc gf180mcu::nfet_05v0_defaults {} {
    return {w 0.3 l 0.6 m 1 nf 1 diffcov 100 polycov 100 \
		guard 1 glc 1 grc 1 gtc 0 gbc 0 tbcov 100 rlcov 100 \
		topc 1 botc 1 poverlap 0 doverlap 1 lmin 0.6 wmin 0.3 \
		class mosfet full_metal 1 \
		viasrc 0 viadrn 0 viagate 0 \
		viagb 0 viagr 0 viagl 0 viagt 0 doports 1 \
		compatible {nfet_03v3 nfet_05v0 nfet_06v0 nfet_06v0_nvt}}
}

proc gf180mcu::nfet_06v0_defaults {} {
    return {w 0.3 l 0.7 m 1 nf 1 diffcov 100 polycov 100 \
		guard 1 glc 1 grc 1 gtc 0 gbc 0 tbcov 100 rlcov 100 \
		topc 1 botc 1 poverlap 0 doverlap 1 lmin 0.7 wmin 0.3 \
		class mosfet full_metal 1 \
		viasrc 0 viadrn 0 viagate 0 \
		viagb 0 viagr 0 viagl 0 viagt 0 doports 1 \
		compatible {nfet_03v3 nfet_05v0 nfet_06v0 nfet_06v0_nvt}}
}

proc gf180mcu::nfet_06v0_nvt_defaults {} {
    return {w 0.8 l 1.8 m 1 nf 1 diffcov 100 polycov 100 \
		guard 1 glc 1 grc 1 gtc 0 gbc 0 tbcov 100 rlcov 100 \
		topc 1 botc 1 poverlap 0 doverlap 1 lmin 1.8 wmin 0.8 \
		class mosfet full_metal 1 \
		compatible {nfet_03v3 nfet_05v0 nfet_06v0 nfet_06v0_nvt}}
}

proc gf180mcu::nfet_10v0_asym_defaults {} {
    return {w 4.0 l 0.6 m 1 nf 1 diffcov 100 polycov 100 \
		guard 1 glc 1 grc 1 gtc 0 gbc 0 tbcov 100 rlcov 100 \
		topc 1 botc 1 poverlap 0 doverlap 1 lmin 0.6 wmin 4.0 \
		viasrc 0 viadrn 0 viagate 0 \
		viagb 0 viagr 0 viagl 0 viagt 0 doports 1 \
		full_metal 1 }
}

proc gf180mcu::pfet_10v0_asym_defaults {} {
    return {w 4.0 l 0.6 m 1 nf 1 diffcov 100 polycov 100 \
		guard 1 glc 1 grc 1 gtc 0 gbc 0 tbcov 100 rlcov 100 \
		topc 1 botc 1 poverlap 0 doverlap 1 lmin 0.6 wmin 4.0 \
		viasrc 0 viadrn 0 viagate 0 \
		viagb 0 viagr 0 viagl 0 viagt 0 doports 1 \
		class mosfet full_metal 1 }
}

proc gf180mcu::nfet_03v3_dss_defaults {} {
    return {w 0.220 l 0.280 m 1 nf 1 diffcov 100 polycov 100 \
		guard 1 glc 1 grc 1 gtc 0 gbc 0 tbcov 100 rlcov 100 \
		topc 1 botc 1 poverlap 0 doverlap 1 lmin 0.28 wmin 0.22 \
		class mosfet full_metal 1 \
		viasrc 0 viadrn 0 viagate 0 \
		viagb 0 viagr 0 viagl 0 viagt 0 doports 1 \
		compatible {nfet_03v3_dss nfet_06v0_dss}}
}

proc gf180mcu::nfet_06v0_dss_defaults {} {
    return {w 0.3 l 0.6 m 1 nf 1 diffcov 100 polycov 100 \
		guard 1 glc 1 grc 1 gtc 0 gbc 0 tbcov 100 rlcov 100 \
		topc 1 botc 1 poverlap 0 doverlap 1 lmin 0.6 wmin 0.3 \
		class mosfet full_metal 1 \
		viasrc 0 viadrn 0 viagate 0 \
		viagb 0 viagr 0 viagl 0 viagt 0 doports 1 \
		compatible {nfet_03v3_dss nfet_06v0_dss}}
}

#----------------------------------------------------------------
# moscap: Specify all user-editable default values and those
# needed by nmoscap_3p3_check
#----------------------------------------------------------------

proc gf180mcu::nmoscap_3p3_defaults {} {
    return {w 1.0 l 1.0 m 1 nf 1 diffcov 100 polycov 100 \
		guard 1 glc 1 grc 1 gtc 0 gbc 0 tbcov 100 rlcov 100 \
		topc 1 botc 1 poverlap 0 doverlap 1 lmin 0.28 wmin 0.22 \
		viasrc 0 viadrn 0 viagate 0 \
		viagb 0 viagr 0 viagl 0 viagt 0 doports 1 \
		class mosfet full_metal 1 compatible {nmoscap_3p3 nmoscap_6p0}}
}

proc gf180mcu::nmoscap_6p0_defaults {} {
    return {w 1.0 l 1.0 m 1 nf 1 diffcov 100 polycov 100 \
		guard 1 glc 1 grc 1 gtc 0 gbc 0 tbcov 100 rlcov 100 \
		topc 1 botc 1 poverlap 0 doverlap 1 lmin 0.28 wmin 0.3 \
		viasrc 0 viadrn 0 viagate 0 \
		viagb 0 viagr 0 viagl 0 viagt 0 doports 1 \
		class mosfet full_metal 1 compatible {nmoscap_3p3 nmoscap_6p0}}
}

proc gf180mcu::pmoscap_3p3_defaults {} {
    return {w 1.0 l 1.0 m 1 nf 1 diffcov 100 polycov 100 \
		guard 1 glc 1 grc 1 gtc 0 gbc 0 tbcov 100 rlcov 100 \
		topc 1 botc 1 poverlap 0 doverlap 1 lmin 0.28 wmin 0.22 \
		viasrc 0 viadrn 0 viagate 0 \
		viagb 0 viagr 0 viagl 0 viagt 0 doports 1 \
		class mosfet full_metal 1 compatible {pmoscap_3p3 pmoscap_6p0}}
}

proc gf180mcu::pmoscap_6p0_defaults {} {
    return {w 1.0 l 1.0 m 1 nf 1 diffcov 100 polycov 100 \
		guard 1 glc 1 grc 1 gtc 0 gbc 0 tbcov 100 rlcov 100 \
		topc 1 botc 1 poverlap 0 doverlap 1 lmin 0.28 wmin 0.3 \
		viasrc 0 viadrn 0 viagate 0 \
		viagb 0 viagr 0 viagl 0 viagt 0 doports 1 \
		class mosfet full_metal 1 compatible {pmoscap_3p3 pmoscap_6p0}}
}

#----------------------------------------------------------------
# Varactors (called moscaps by the foundry)
#----------------------------------------------------------------

proc gf180mcu::nvaractor_3p3_defaults {} {
    return {w 1.0 l 1.0 m 1 nf 1 diffcov 100 polycov 100 \
		guard 1 glc 1 grc 1 gtc 0 gbc 0 tbcov 100 rlcov 100 \
		topc 1 botc 1 poverlap 0 doverlap 1 lmin 0.28 wmin 0.22 \
		viasrc 0 viadrn 0 viagate 0 \
		viagb 0 viagr 0 viagl 0 viagt 0 doports 1 \
		class mosfet full_metal 1 compatible {nvaractor_3p3 nvaractor_6p0}}
}

proc gf180mcu::nvaractor_6p0_defaults {} {
    return {w 1.0 l 1.0 m 1 nf 1 diffcov 100 polycov 100 \
		guard 1 glc 1 grc 1 gtc 0 gbc 0 tbcov 100 rlcov 100 \
		topc 1 botc 1 poverlap 0 doverlap 1 lmin 0.28 wmin 0.3 \
		viasrc 0 viadrn 0 viagate 0 \
		viagb 0 viagr 0 viagl 0 viagt 0 doports 1 \
		class mosfet full_metal 1 compatible {nvaractor_3p3 nvaractor_6p0}}
}

proc gf180mcu::pvaractor_3p3_defaults {} {
    return {w 1.0 l 1.0 m 1 nf 1 diffcov 100 polycov 100 \
		guard 1 glc 1 grc 1 gtc 0 gbc 0 tbcov 100 rlcov 100 \
		topc 1 botc 1 poverlap 0 doverlap 1 lmin 0.28 wmin 0.22 \
		viasrc 0 viadrn 0 viagate 0 \
		viagb 0 viagr 0 viagl 0 viagt 0 doports 1 \
		class mosfet full_metal 1 compatible {pvaractor_3p3 pvaractor_6p0}}
}

proc gf180mcu::pvaractor_6p0_defaults {} {
    return {w 1.0 l 1.0 m 1 nf 1 diffcov 100 polycov 100 \
		guard 1 glc 1 grc 1 gtc 0 gbc 0 tbcov 100 rlcov 100 \
		topc 1 botc 1 poverlap 0 doverlap 1 lmin 0.28 wmin 0.3 \
		viasrc 0 viadrn 0 viagate 0 \
		viagb 0 viagr 0 viagl 0 viagt 0 doports 1 \
		class mosfet full_metal 1 compatible {pvaractor_3p3 pvaractor_6p0}}
}

#----------------------------------------------------------------
# mos: Conversion from SPICE netlist parameters to toolkit
#----------------------------------------------------------------

proc gf180mcu::mos_convert {parameters} {
    set pdkparams [dict create]
    set nf 1
    dict for {key value} $parameters {
	switch -nocase $key {
	    l -
	    w {
		# Length and width are converted to units of microns
		set value [magic::spice2float $value]
		set value [expr $value * 1e6]
		set value [magic::3digitpastdecimal $value]
		dict set pdkparams [string tolower $key] $value
	    }
	    m {
		# M value in an expression like '1*1' convert to
		# NF and M, and do not overlap fingers.
		if {[regexp {\'([0-9]+)\*([0-9]+)\'} $value valid mx my]} {
		    dict set pdkparams [string tolower $key] $my
		} else {
		    dict set pdkparams [string tolower $key] $value
		}
	    }
	    nf {
		# Adjustment of W will be handled after parsing
		dict set pdkparams $key $value
	    }
	    default {
		# Allow unrecognized parameters to be passed unmodified
		dict set pdkparams $key $value
	    }
	}
    }

    # Magic does not understand "nf" as a parameter, but expands to
    # "nf" number of devices connected horizontally.  The "w" value
    # must be divided down accordingly, as the "nf" parameter implies
    # that the total width "w" is divided into "nf" fingers.

    catch {
	set w [dict get $pdkparams w]
	set nf [dict get $pdkparams nf]
	if {$nf > 1} {
	    dict set pdkparams w [expr $w / $nf]
	}
    }
    catch {
	set nf [expr $nf * $mx]
	if {$nf > 1} {
	    dict set pdkparams nf $nf
	}
	if {$mx > 1} {
	    dict set pdkparams doverlap 0
	}
    }

    return $pdkparams
}

#----------------------------------------------------------------

proc gf180mcu::nfet_03v3_convert {parameters} {
    return [gf180mcu::mos_convert $parameters]
}

proc gf180mcu::nfet_05v0_convert {parameters} {
    return [gf180mcu::mos_convert $parameters]
}

proc gf180mcu::nfet_06v0_convert {parameters} {
    return [gf180mcu::mos_convert $parameters]
}

proc gf180mcu::nfet_06v0_nvt_convert {parameters} {
    return [gf180mcu::mos_convert $parameters]
}

proc gf180mcu::pfet_03v3_convert {parameters} {
    return [gf180mcu::mos_convert $parameters]
}

proc gf180mcu::pfet_05v0_convert {parameters} {
    return [gf180mcu::mos_convert $parameters]
}

proc gf180mcu::pfet_06v0_convert {parameters} {
    return [gf180mcu::mos_convert $parameters]
}

proc gf180mcu::nmoscap_3p3_convert {parameters} {
    return [gf180mcu::mos_convert $parameters]
}

proc gf180mcu::nmoscap_6p0_convert {parameters} {
    return [gf180mcu::mos_convert $parameters]
}

proc gf180mcu::pmoscap_3p3_convert {parameters} {
    return [gf180mcu::mos_convert $parameters]
}

proc gf180mcu::pmoscap_6p0_convert {parameters} {
    return [gf180mcu::mos_convert $parameters]
}

proc gf180mcu::nvaractor_3p3_convert {parameters} {
    return [gf180mcu::mos_convert $parameters]
}

proc gf180mcu::nvaractor_6p0_convert {parameters} {
    return [gf180mcu::mos_convert $parameters]
}

proc gf180mcu::pvaractor_3p3_convert {parameters} {
    return [gf180mcu::mos_convert $parameters]
}

proc gf180mcu::pvaractor_6p0_convert {parameters} {
    return [gf180mcu::mos_convert $parameters]
}

proc gf180mcu::nfet_10v0_asym_convert {parameters} {
    return [gf180mcu::mos_convert $parameters]
}

proc gf180mcu::pfet_10v0_asym_convert {parameters} {
    return [gf180mcu::mos_convert $parameters]
}

proc gf180mcu::nfet_03v3_dss_convert {parameters} {
    return [gf180mcu::mos_convert $parameters]
}

proc gf180mcu::pfet_03v3_dss_convert {parameters} {
    return [gf180mcu::mos_convert $parameters]
}

proc gf180mcu::nfet_06v0_dss_convert {parameters} {
    return [gf180mcu::mos_convert $parameters]
}

proc gf180mcu::pfet_06v0_dss_convert {parameters} {
    return [gf180mcu::mos_convert $parameters]
}

#----------------------------------------------------------------
# mos: Interactively specifies the fixed layout parameters
#----------------------------------------------------------------

proc gf180mcu::mos_dialog {device parameters} {
    # Editable fields:      w, l, nf, m, diffcov, polycov
    # Checked fields:  topc, botc

    magic::add_entry w "Width (um)" $parameters
    magic::add_entry l "Length (um)" $parameters
    magic::add_entry nf "Fingers" $parameters
    magic::add_entry m "M" $parameters

    if {[dict exists $parameters compatible]} {
       set sellist [dict get $parameters compatible]
       # Reserved word "gencell" has special behavior to change the
       # underlying device type 
       dict set parameters gencell $device
       magic::add_selectlist gencell "Device type" $sellist $parameters
    }

    magic::add_entry diffcov "Diffusion contact coverage (%)" $parameters
    magic::add_entry polycov "Poly contact coverage (%)" $parameters
    magic::add_entry rlcov "Guard ring contact coverage (%)" $parameters
    if {[dict exists $parameters gbc]} {
	magic::add_entry tbcov "Guard ring top/bottom contact coverage (%)" $parameters
    }

    magic::add_checkbox poverlap "Overlap at poly contact" $parameters
    magic::add_checkbox doverlap "Overlap at diffusion contact" $parameters
    magic::add_checkbox topc "Add top gate contact" $parameters
    magic::add_checkbox botc "Add bottom gate contact" $parameters

    magic::add_checkbox guard "Add guard ring" $parameters
    magic::add_checkbox full_metal "Full metal guard ring" $parameters
    magic::add_checkbox glc "Add left guard ring contact" $parameters
    magic::add_checkbox grc "Add right guard ring contact" $parameters
    if {[dict exists $parameters gbc]} {
	magic::add_checkbox gbc "Add bottom guard ring contact" $parameters
    }
    if {[dict exists $parameters gtc]} {
	magic::add_checkbox gtc "Add top guard ring contact" $parameters
    }

    magic::add_entry viasrc "Source via coverage \[+/-\](%)" $parameters
    magic::add_entry viadrn "Drain via coverage \[+/-\](%)" $parameters
    magic::add_entry viagate "Gate via coverage \[+/-\](%)" $parameters
    magic::add_entry viagb "Bottom guard ring via coverage \[+/-\](%)" $parameters
    magic::add_entry viagt "Top guard ring via coverage \[+/-\](%)" $parameters
    magic::add_entry viagr "Right guard ring via coverage \[+/-\](%)" $parameters
    magic::add_entry viagl "Left guard ring via coverage \[+/-\](%)" $parameters

    if {[dict exists $parameters doports]} {
	magic::add_checkbox doports "Add ports" $parameters
    }
}

#----------------------------------------------------------------

proc gf180mcu::nfet_03v3_dialog {parameters} {
    gf180mcu::mos_dialog nfet_03v3 $parameters
}

proc gf180mcu::nfet_05v0_dialog {parameters} {
    gf180mcu::mos_dialog nfet_05v0 $parameters
}

proc gf180mcu::nfet_06v0_dialog {parameters} {
    gf180mcu::mos_dialog nfet_06v0 $parameters
}

proc gf180mcu::nfet_06v0_nvt_dialog {parameters} {
    gf180mcu::mos_dialog nfet_06v0_nvt $parameters
}

proc gf180mcu::pfet_03v3_dialog {parameters} {
    gf180mcu::mos_dialog pfet_03v3 $parameters
}

proc gf180mcu::pfet_05v0_dialog {parameters} {
    gf180mcu::mos_dialog pfet_05v0 $parameters
}

proc gf180mcu::pfet_06v0_dialog {parameters} {
    gf180mcu::mos_dialog pfet_06v0 $parameters
}

proc gf180mcu::nmoscap_3p3_dialog {parameters} {
    gf180mcu::mos_dialog nmoscap_3p3 $parameters
}

proc gf180mcu::nmoscap_6p0_dialog {parameters} {
    gf180mcu::mos_dialog nmoscap_6p0 $parameters
}

proc gf180mcu::pmoscap_3p3_dialog {parameters} {
    gf180mcu::mos_dialog pmoscap_3p3 $parameters
}

proc gf180mcu::pmoscap_6p0_dialog {parameters} {
    gf180mcu::mos_dialog pmoscap_6p0 $parameters
}

proc gf180mcu::nvaractor_3p3_dialog {parameters} {
    gf180mcu::mos_dialog nvaractor_3p3 $parameters
}

proc gf180mcu::nvaractor_6p0_dialog {parameters} {
    gf180mcu::mos_dialog nvaractor_6p0 $parameters
}

proc gf180mcu::pvaractor_3p3_dialog {parameters} {
    gf180mcu::mos_dialog pvaractor_3p3 $parameters
}

proc gf180mcu::pvaractor_6p0_dialog {parameters} {
    gf180mcu::mos_dialog pvaractor_6p0 $parameters
}

proc gf180mcu::nfet_10v0_asym_dialog {parameters} {
    gf180mcu::mos_dialog nfet_10v0_asym $parameters
}

proc gf180mcu::pfet_10v0_asym_dialog {parameters} {
    gf180mcu::mos_dialog pfet_10v0_asym $parameters
}

proc gf180mcu::nfet_03v3_dss_dialog {parameters} {
    gf180mcu::mos_dialog nfet_03v3_dss $parameters
}

proc gf180mcu::nfet_06v0_dss_dialog {parameters} {
    gf180mcu::mos_dialog nfet_06v0_dss $parameters
}

proc gf180mcu::pfet_03v3_dss_dialog {parameters} {
    gf180mcu::mos_dialog pfet_03v3_dss $parameters
}

proc gf180mcu::pfet_06v0_dss_dialog {parameters} {
    gf180mcu::mos_dialog pfet_06v0_dss $parameters
}
#----------------------------------------------------------------
# MOSFET: Draw a single device
#----------------------------------------------------------------

proc gf180mcu::mos_device {parameters} {

    # Epsilon for avoiding round-off errors
    set eps  0.0005

    # Set local default values if they are not in parameters
    set diffcov 100	;# percent coverage of diffusion contact
    set polycov 100	;# percent coverage of poly contact
    set topc 1		;# draw top poly contact
    set botc 1		;# draw bottom poly contact
    set dev_sub_type ""	;# device substrate type (if different from guard ring)
    set evens 1		;# even or odd (evens = 1 means drain is on left)
    set viasrc 0	;# don't draw source vias
    set viadrn 0	;# don't draw drain vias
    set viagate 0	;# don't draw gate vias

    set drain ""
    set source ""
    set gate ""

    # Set a local variable for each parameter (e.g., $l, $w, etc.)
    foreach key [dict keys $parameters] {
        set $key [dict get $parameters $key]
    }

    # For symmetric devices, set the drain-specific parameters to be the
    # same as the generic parameters.

    if {![dict exists $parameters drain_diff_type]} {
	set drain_diff_type $diff_type
    }
    if {![dict exists $parameters drain_diff_contact_type]} {
	set drain_diff_contact_type $diff_contact_type
    }
    if {![dict exists $parameters drain_diff_extension]} {
	set drain_diff_extension $diff_extension
    }

    # Draw the diffusion and poly
    pushbox
    box size 0 0
    pushbox
    set hw [/ $w 2.0]
    set hl [/ $l 2.0]
    box grow n ${hw}um
    box grow s ${hw}um
    box grow e ${hl}um
    box grow w ${hl}um
    # Set drain and source sides based on "evens".
    if {$evens == 0} {
	set dside e
	set sside w
    } else {
	set dside w
	set sside e
    }
    pushbox
    if {${drain_diff_extension} > ${gate_to_diffcont}} {
        box grow $dside ${drain_diff_extension}um
    } else {
        box grow $dside ${gate_to_diffcont}um
        # Grow to far side of contact;  avoids diffusion separation if
	# the contact is a dogbone and is moved outward to meet the DRC
	# diffusion to gate spacing rule.
	set hc [/ ${contact_size} 2.0]
        box grow $dside ${hc}um
    }
    paint ${drain_diff_type}
    popbox
    pushbox
    if {${diff_extension} > ${gate_to_diffcont}} {
        box grow $sside ${diff_extension}um
    } else {
        box grow $sside ${gate_to_diffcont}um
        # Grow to far side of contact;  avoids diffusion separation if
	# the contact is a dogbone and is moved outward to meet the DRC
	# diffusion to gate spacing rule.
	set hc [/ ${contact_size} 2.0]
        box grow $sside ${hc}um
    }
    paint ${diff_type}
    popbox
    pushbox
    if {${gate_extension} > ${gate_to_polycont}} {
	box grow n ${gate_extension}um
	box grow s ${gate_extension}um
    } else {
	if {$topc} {
	    box grow n ${gate_to_polycont}um
	} else {
	    box grow n ${gate_extension}um
	}
	if {$botc} {
	    box grow s ${gate_to_polycont}um
	} else {
	    box grow s ${gate_extension}um
	}
    }
    paint ${poly_type}
    set cext [gf180mcu::getbox]
    popbox
    # save gate area now and paint later, so that diffusion surrounding the
    # contact does not paint over the gate area, in case the gate type is
    # not part of a "compose" entry in the techfile.
    set gaterect [box values]
    popbox

    # Adjust position of contacts for dogbone geometry
    # Rule 1: Minimize diffusion length.  Contacts only move out
    # if width <  contact diffusion height.  They move out enough
    # that the diffusion-to-poly spacing is satisfied.  Change the
    # orientation of the diffusion contact from vertical to horizontal

    set diffcont_orient vert
    set ddover 0
    set cdwmin [+ ${contact_size} [* ${diff_surround} 2]]
    set cstem [- ${gate_to_diffcont} [/ ${cdwmin} 2.0]]
    set cgrow [- ${diff_poly_space} ${cstem}]
    if {[+ ${w} ${eps}] < ${cdwmin}} {
        if {${cgrow} > 0} {
            set gate_to_diffcont [+ ${gate_to_diffcont} ${cgrow}]
	    set diffcont_orient horz
        }
	set ddover [/ [- ${cdwmin} ${w}] 2.0]
    }

    # Rule 2: Minimum poly width.  Poly contacts only move out
    # if length < contact poly width.  They move out enough
    # that the diffusion-to-poly spacing is satisfied.

    set gporig ${gate_to_polycont}
    set cplmin [+ ${contact_size} [* ${poly_surround} 2]]
    set cstem [- ${gate_to_polycont} [/ ${cplmin} 2.0]]
    set cgrow [- ${diff_poly_space} ${cstem}]
    if {[+ ${l} ${eps}] < ${cplmin}} {
        if {${cgrow} > 0} {
            set gate_to_polycont [+ ${gate_to_polycont} ${cgrow}]
        }
    }

    # Rule 3: If both poly and diffusion are dogboned, then move
    # poly out further to clear spacing to the diffusion contact.

    if {[+ ${w} ${eps}] < ${cdwmin}} {
        if {[+ ${l} ${eps}] < ${cplmin}} {
            set cgrow [/ [- ${cplmin} ${w}] 2.0]
            set gate_to_polycont [+ ${gate_to_polycont} ${cgrow}]
        }
    }

    # Rule 4: If M > 1 and poly contacts overlap, then increase the
    # transistor-to-poly-contact distance by the amount of any
    # diffusion dogbone overhang.

    if {($poverlap == 1) && ($m > 1)} {
	if {${gate_to_polycont} - $gporig < $ddover} {
	    set gate_to_polycont [+ ${gporig} ${ddover}]
	}
    }

    # Reduce contact sizes by poly or diffusion surround so that
    # the contact area edges match the device diffusion or poly.
    # (Minimum dimensions will be enforced by the contact drawing routine)
    set cdw [- ${w} [* ${diff_surround} 2]]     ;# diff contact height
    set cpl [- ${l} [* ${poly_surround} 2]]     ;# poly contact width

    # Save the full diffusion (source/drain) and poly (gate) lengths
    set cdwfull $cdw
    set cplfull $cpl

    # Reduce by coverage percentage.  NOTE:  If overlapping multiple devices,
    # keep maximum poly contact coverage.

    set cdw [* ${cdw} [/ ${diffcov} 100.0]]
    if {($poverlap == 0) || ($m == 1)} {
	set cpl [* ${cpl} [/ ${polycov} 100.0]]
    }

    # Drain diffusion contact
    pushbox
    box move $dside ${hl}um
    box move $dside ${gate_to_diffcont}um

    # Drain via on top of contact
    set viatype $viadrn
    if {$viatype != 0} {
        pushbox
        set cw $via_size
        set ch [* $cdwfull [/ [expr abs($viatype)] 100.0]]
        if {$ch < $via_size} {set ch $via_size}
        box grow $dside [/ $cw 2]um
        box grow $sside [/ $cw 2]um
        set anchor [string index $viatype 0]
        if {$anchor == "+"} {
            box move s [/ [- $cdwfull $via_size] 2]um
            box grow n ${ch}um
        } elseif {$anchor == "-"} {
            box move n [/ [- $cdwfull $via_size] 2]um
            box grow s ${ch}um
        } else {
            box grow n [/ $ch 2]um
            box grow s [/ $ch 2]um
        }
        gf180mcu::via1_draw vert
        popbox
    }
    set cext [gf180mcu::unionbox $cext [gf180mcu::draw_contact 0 ${cdw} \
		${diff_surround} ${metal_surround} ${contact_size}\
		${drain_diff_type} ${drain_diff_contact_type} m1 ${diffcont_orient}]]
    if {$drain != ""} {
        label $drain c $diff_contact_type
        select area label
        port make
    }
    popbox

    # Source diffusion contact
    pushbox
    box move $sside ${hl}um
    box move $sside ${gate_to_diffcont}um

    # Source via on top of contact
    set viatype $viasrc
    if {$viatype != 0} {
        pushbox
        set cw $via_size
        set ch [* $cdwfull [/ [expr abs($viatype)] 100.0]]
        if {$ch < $via_size} {set ch $via_size}
        box grow $sside [/ $cw 2]um
        box grow $dside [/ $cw 2]um
        set anchor [string index $viatype 0]
        if {$anchor == "+"} {
            box move s [/ [- $cdwfull $via_size] 2]um
            box grow n ${ch}um
        } elseif {$anchor == "-"} {
            box move n [/ [- $cdwfull $via_size] 2]um
            box grow s ${ch}um
        } else {
            box grow n [/ $ch 2]um
            box grow s [/ $ch 2]um
        }
        gf180mcu::via1_draw vert
        popbox
    }
    set cext [gf180mcu::unionbox $cext [gf180mcu::draw_contact 0 ${cdw} \
		${diff_surround} ${metal_surround} ${contact_size} \
		${diff_type} ${diff_contact_type} m1 ${diffcont_orient}]]
    if {$source != ""} {
        label $source c $diff_contact_type
        select area label
        port make
    }
    popbox

    # Top poly contact
    if {$topc} {
       pushbox
       box move n ${hw}um
       box move n ${gate_to_polycont}um

       # Gate via on top of contact
       if {$viagate != 0} {
           pushbox
           set ch $via_size
           set cw [* $cplfull [/ [expr abs($viagate)] 100.0]]
           if {$cw < $via_size} {set cw $via_size}
           box grow n [/ $ch 2]um
           box grow s [/ $ch 2]um
           set anchor [string index $viagate 0]
           if {$anchor == "+"} {
               box move w [/ [- $cplfull $via_size] 2]um
               box grow e ${cw}um
           } elseif {$anchor == "-"} {
               box move e [/ [- $cplfull $via_size] 2]um
               box grow w ${cw}um
           } else {
               box grow e [/ $cw 2]um
               box grow w [/ $cw 2]um
           }
	   box move s 0.005um
	   if {($poverlap == 0) && ($m > 1)} {
	       box move s 0.055um
	   }
           gf180mcu::via1_draw
           popbox
	}
        set cext [gf180mcu::unionbox $cext [gf180mcu::draw_contact ${cpl} 0 \
		${poly_surround} ${metal_surround} ${contact_size} \
		${poly_type} ${poly_contact_type} m1 horz]]
	if {$gate != ""} {
	    label $gate c $poly_contact_type
            select area label
            port make
	}
        popbox
    }
    # Bottom poly contact
    if {$botc} {
       pushbox
       box move s ${hw}um
       box move s ${gate_to_polycont}um

       # Gate via on top of contact
       if {$viagate != 0} {
           pushbox
           set ch $via_size
           set cw [* $cplfull [/ [expr abs($viagate)] 100.0]]
           if {$cw < $via_size} {set cw $via_size}
           box grow n [/ $ch 2]um
           box grow s [/ $ch 2]um
           set anchor [string index $viagate 0]
           if {$anchor == "+"} {
               box move w [/ [- $cplfull $via_size] 2]um
               box grow e ${cw}um
           } elseif {$anchor == "-"} {
               box move e [/ [- $cplfull $via_size] 2]um
               box grow w ${cw}um
           } else {
               box grow e [/ $cw 2]um
               box grow w [/ $cw 2]um
           }
	   box move n 0.005um
	   if {($poverlap == 0) && ($m > 1)} {
	       box move n 0.055um
	   }
           gf180mcu::via1_draw
           popbox
	}
        set cext [gf180mcu::unionbox $cext [gf180mcu::draw_contact ${cpl} 0 \
		${poly_surround} ${metal_surround} ${contact_size} \
		${poly_type} ${poly_contact_type} m1 horz]]
	if {($gate != "") && ($topc == 0)} {
            label $gate c $poly_contact_type
            select area label
            port make
	}
        popbox
    }

    # Now draw the gate, after contacts have been drawn
    pushbox
    box values {*}${gaterect}
    # gate_type need not be defined if poly over diff paints the right type.
    catch {paint ${gate_type}}
    popbox

    if {$dev_sub_type != ""} {
        # puts stdout "Diagnostic:  bounding box is $cext"
	set llx [lindex $cext 0]
	set lly [lindex $cext 1]
	set urx [lindex $cext 2]
	set ury [lindex $cext 3]
	box values ${llx}um ${lly}um ${urx}um ${ury}um
	box grow n ${sub_surround}um
	box grow s ${sub_surround}um
	box grow e ${sub_surround}um
	box grow w ${sub_surround}um
	paint ${dev_sub_type}
	set cext [gf180mcu::getbox]
        # puts stdout "Diagnostic:  bounding box is $cext"
    }

    popbox
    return $cext
}

#----------------------------------------------------------------
# MOSFET: Draw the tiled device
#----------------------------------------------------------------

proc gf180mcu::mos_draw {parameters} {
    tech unlock *

    # Set defaults if they are not in parameters
    set poverlap 0	;# overlap poly contacts when tiling
    set doverlap 1	;# overlap diffusion contacts when tiling
    set dev_sub_dist 0	;# substrate to guard ring, if dev_sub_type defined
    set dev_surround 0	;# substrate/well surrounds device, if no guard ring

    # Set a local variable for each parameter (e.g., $l, $w, etc.)
    foreach key [dict keys $parameters] {
        set $key [dict get $parameters $key]
    }

    # If poverlap is 1 then both poly contacts must be present
    if {$poverlap == 1} {
	set topc 1
	set botc 1
	dict set parameters topc 1
	dict set parameters botc 1
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
    set bbox [gf180mcu::mos_device $parameters]
    # puts stdout "Diagnostic: Device bounding box e $bbox (um)"
    tech unlock *

    set fw [- [lindex $bbox 2] [lindex $bbox 0]]
    set fh [- [lindex $bbox 3] [lindex $bbox 1]]
    set lw [+ [lindex $bbox 2] [lindex $bbox 0]]
    set lh [+ [lindex $bbox 3] [lindex $bbox 1]]

    # Determine tile width and height (depends on overlap)
    if {$poverlap == 0} {
        set dy [+ $fh $poly_spacing]
    } else {
        # overlap poly
        set dy [- $fh [+ $poly_surround $poly_surround $contact_size]]
    }

    if {$doverlap == 0} {
        set dx [+ $fw $diff_spacing]
    } else {
        # overlap diffusions
        set dx [- $fw [+ $diff_surround $diff_surround $contact_size]]
    }

    # Determine core width and height
    set corex [+ [* [- $nf 1] $dx] $fw]
    set corey [+ [* [- $m 1] $dy] $fh]
    set corellx [/ [+ [- $corex $fw] $lw] 2.0]
    set corelly [/ [+ [- $corey $fh] $lh] 2.0]

    # If there is a diffusion dogbone, and no top poly contact, then
    # increase the core height by the amount of the dogbone overhang.

    if {$topc == 0} {
	set cdwmin [+ ${contact_size} [* ${diff_surround} 2]]
	if {${w} < ${cdwmin}} {
	    set corey [+ $corey [/ [- ${cdwmin} ${w}] 2.0]]
	}
    }

    # Calculate guard ring size (measured to contact center)
    if {($dev_sub_dist > 0) && ([+ $dev_sub_dist $sub_surround] > $diff_spacing)} {
	set gx [+ $corex [* 2.0 [+ $dev_sub_dist $diff_surround]] $contact_size]
    } else {
	set gx [+ $corex [* 2.0 [+ $diff_spacing $diff_surround]] $contact_size]
    }
    if {($dev_sub_dist > 0) && ([+ $dev_sub_dist $sub_surround] > $diff_gate_space)} {
	set gy [+ $corey [* 2.0 [+ $dev_sub_dist $diff_surround]] $contact_size]
    } else {
	set gy [+ $corey [* 2.0 [+ $diff_gate_space $diff_surround]] $contact_size]
    }

    if {($guard != 0)} {
        # Somewhat tricky. . . if the width is small and the diffusion is 
        # a dogbone, and the top or bottom poly contact is missing, then
        # the spacing to the guard ring may be limited by diffusion spacing, not
        # poly to diffusion.

        set inset [/ [+ $contact_size [* 2.0 $diff_surround] -$w] 2.0]
        set sdiff [- [+ $inset $diff_spacing] [+ $gate_extension $diff_gate_space]]

        if {$sdiff > 0} {
	    if {$topc == 0} {
	        set gy [+ $gy $sdiff]
	        set corelly [+ $corelly [/ $sdiff 2.0]]
	    }
	    if {$botc == 0} {
	        set gy [+ $gy $sdiff]
	        set corelly [- $corelly [/ $sdiff 2.0]]
	    }
        }
    }
    if {$guard != 0} {
	# Draw the guard ring first, as MOS well may interact with guard ring substrate
	gf180mcu::guard_ring $gx $gy $parameters
    } else {
	pushbox
	if {$dev_surround == 0} {set dev_surround $sub_surround}
	set hgx [+ $dev_surround [/ $corex 2]]
	set hgy [+ $dev_surround [/ $corey 2]]
	box grow e ${hgx}um
	box grow w ${hgx}um
	box grow n ${hgy}um
	box grow s ${hgy}um
	paint $sub_type
	popbox
    }

    pushbox
    box move w ${corellx}um
    box move s ${corelly}um
    set evens 1
    for {set xp 0} {$xp < $nf} {incr xp} {
	dict set parameters evens $evens
	set evens [- 1 $evens]
        pushbox
        for {set yp 0} {$yp < $m} {incr yp} {
            # Apply rules for source/drain/gate port labeling
            if {$doports && ($m == 1)} {
                if {$nf == 1} {
                    dict set parameters drain D
                    dict set parameters source S
                    dict set parameters gate G
                } else {
                    if {$doverlap && $evens && ($xp > 0)} {
                        dict set parameters drain ""
                    } else {
                        dict set parameters drain D$xp
                    }
                    if {$doverlap  && ($evens == 0) && ($xp < $nf-1)} {
                        dict set parameters source ""
                    } else {
                        dict set parameters source S$xp
                    }
		    dict set parameters gate G$xp
                }
            } elseif {$doports} {
                if {$nf == 1} {
                    dict set parameters drain D$yp
                    dict set parameters source S$yp
                    if {$poverlap && ($yp == 0)} {
                        dict set parameters gate G
                    } elseif {$poverlap} {
                        dict set parameters gate ""
                    } else {
                        dict set parameters gate G$yp
                    }
                } else {
                    if {$doverlap && $evens && ($xp > 0)} {
                        dict set parameters drain ""
                    } else {
                        dict set parameters drain D${xp}_$yp
                    }
                    if {$doverlap && ($evens == 0) && ($xp < $nf-1)} {
                        dict set parameters source ""
                    } else {
                        dict set parameters source S${xp}_$yp
                    }
                    if {$poverlap && ($yp == 0)} {
                        dict set parameters gate G$xp
                    } elseif {$poverlap} {
                        dict set parameters gate ""
                    } else {
                        dict set parameters gate G${xp}_$yp
                    }
                }
	    }
            gf180mcu::mos_device $parameters
            box move n ${dy}um
        }
        popbox
        box move e ${dx}um
    }
    popbox
    popbox

    tech revert
}

#-------------------
# nMOS 3.3V
#-------------------

proc gf180mcu::nfet_03v3_draw {parameters} {
    set newdict [dict create \
	    gate_type		nfet \
	    diff_type 		ndiff \
	    diff_contact_type	ndc \
	    plus_diff_type	psd \
	    plus_contact_type	psc \
	    poly_type		poly \
	    poly_contact_type	pc \
	    sub_type		pwell \
	    sub_surround	0.12 \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::mos_draw $drawdict]
}

#-------------------
# pMOS 3.3V
#-------------------

proc gf180mcu::pfet_03v3_draw {parameters} {
    set newdict [dict create \
	    gate_type		pfet \
	    diff_type 		pdiff \
	    diff_contact_type	pdc \
	    plus_diff_type	nsd \
	    plus_contact_type	nsc \
	    poly_type		poly \
	    poly_contact_type	pc \
	    dev_surround	0.43 \
	    sub_type		nwell \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::mos_draw $drawdict]
}

#-------------------
# pMOS 5.0V
#-------------------

proc gf180mcu::pfet_05v0_draw {parameters} {
    set newdict [dict create \
	    diff_poly_space	0.30 \
	    diff_gate_space	0.30 \
	    diff_spacing	0.36 \
	    diff_extension	0.40 \
	    gate_type		mvpfet \
	    diff_type 		mvpdiff \
	    diff_contact_type	mvpdc \
	    plus_diff_type	mvnsd \
	    plus_contact_type	mvnsc \
	    poly_type		poly \
	    poly_contact_type	pc \
	    sub_surround	0.16 \
	    dev_surround	0.43 \
	    sub_type		nwell \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::mos_draw $drawdict]
}

#-------------------
# pMOS 6.0V
#-------------------

proc gf180mcu::pfet_06v0_draw {parameters} {
    set newdict [dict create \
	    diff_poly_space	0.30 \
	    diff_gate_space	0.30 \
	    diff_spacing	0.36 \
	    diff_extension	0.40 \
	    gate_type		hvpfet \
	    diff_type 		mvpdiff \
	    diff_contact_type	mvpdc \
	    plus_diff_type	mvnsd \
	    plus_contact_type	mvnsc \
	    poly_type		poly \
	    poly_contact_type	pc \
	    sub_surround	0.16 \
	    dev_surround	0.43 \
	    sub_type		nwell \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::mos_draw $drawdict]
}

#-------------------
# nMOS 5.0V
#-------------------

proc gf180mcu::nfet_05v0_draw {parameters} {
    set newdict [dict create \
	    diff_poly_space	0.30 \
	    diff_gate_space	0.30 \
	    diff_spacing	0.36 \
	    diff_extension	0.40 \
	    gate_type		mvnfet \
	    diff_type 		mvndiff \
	    diff_contact_type	mvndc \
	    plus_diff_type	mvpsd \
	    plus_contact_type	mvpsc \
	    poly_type		poly \
	    poly_contact_type	pc \
	    sub_type		pwell \
	    sub_surround	0.16 \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::mos_draw $drawdict]
}

#-------------------
# nMOS 6.0V
#-------------------

proc gf180mcu::nfet_06v0_draw {parameters} {
    set newdict [dict create \
	    diff_poly_space	0.30 \
	    diff_gate_space	0.30 \
	    diff_spacing	0.36 \
	    diff_extension	0.40 \
	    gate_type		hvnfet \
	    diff_type 		mvndiff \
	    diff_contact_type	mvndc \
	    plus_diff_type	mvpsd \
	    plus_contact_type	mvpsc \
	    poly_type		poly \
	    poly_contact_type	pc \
	    sub_type		pwell \
	    sub_surround	0.16 \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::mos_draw $drawdict]
}

proc gf180mcu::nfet_06v0_nvt_draw {parameters} {
    set newdict [dict create \
	    gate_type		mvnnfet \
	    diff_type 		mvndiff \
	    diff_contact_type	mvndc \
	    plus_diff_type	mvpsd \
	    plus_contact_type	mvpsc \
	    poly_type		poly \
	    poly_contact_type	pc \
	    sub_type		pwell \
	    sub_surround	0.16 \
	    gate_extension	0.35 \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::mos_draw $drawdict]
}
#-------------------
# nMOS dss 3.0V
#-------------------
proc gf180mcu::nfet_03v3_dss_draw {parameters} {
    set newdict [dict create \
	    gate_type		nfet \
	    diff_type 		ndiffres \
	    diff_contact_type	ndc \
	    plus_diff_type	psd \
	    plus_contact_type	psc \
	    poly_type		poly \
	    poly_contact_type	pc \
	    sub_type		pwell \
	    sub_surround	0.12 \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::mos_draw $drawdict]
}

proc gf180mcu::pfet_03v3_dss_draw {parameters} {
    set newdict [dict create \
	    gate_type		pfet \
	    diff_type 		pdiffres \
	    diff_contact_type	pdc \
	    plus_diff_type	nsd \
	    plus_contact_type	nsc \
	    poly_type		poly \
	    poly_contact_type	pc \
	    dev_surround	0.43 \
	    sub_type		nwell \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::mos_draw $drawdict]
}

#-------------------
# pMOS 6.0V dss
#-------------------

proc gf180mcu::pfet_06v0_dss_draw {parameters} {
    set newdict [dict create \
	    diff_poly_space	0.30 \
	    diff_gate_space	0.30 \
	    diff_spacing	0.36 \
	    gate_type		hvpfet \
	    diff_type 		mvpdiffres \
	    diff_contact_type	mvpdc \
	    plus_diff_type	mvnsd \
	    plus_contact_type	mvnsc \
	    poly_type		poly \
	    poly_contact_type	pc \
	    sub_surround	0.16 \
	    dev_surround	0.43 \
	    sub_type		nwell \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::mos_draw $drawdict]
}

#-------------------
# nMOS 6.0V dss
#-------------------

proc gf180mcu::nfet_06v0_dss_draw {parameters} {
    set newdict [dict create \
	    diff_poly_space	0.30 \
	    diff_gate_space	0.30 \
	    diff_spacing	0.36 \
	    gate_type		hvnfet \
	    diff_type 		mvndiffres \
	    diff_contact_type	mvndc \
	    plus_diff_type	mvpsd \
	    plus_contact_type	mvpsc \
	    poly_type		poly \
	    poly_contact_type	pc \
	    sub_type		pwell \
	    sub_surround	0.16 \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::mos_draw $drawdict]
}
#-----------------------
# 10V LDNMOS
#-----------------------

proc gf180mcu::nfet_10v0_asym_draw {parameters} {
    set newdict [dict create \
	    diff_poly_space	0.30 \
	    diff_gate_space	0.30 \
	    diff_spacing	0.36 \
	    gate_type		mvnfet \
	    diff_type 		mvndiff \
	    diff_contact_type	mvndc \
	    drain_diff_type	ldndiff \
	    drain_diff_contact_type ldndiffc \
	    plus_diff_type	mvpsd \
	    plus_contact_type	mvpsc \
	    poly_type		poly \
	    poly_contact_type	pc \
	    sub_type		pwell \
	    sub_surround	0.16 \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::mos_draw $drawdict]
}

#-----------------------
# 10V LDPMOS
#-----------------------

proc gf180mcu::pfet_10v0_asym_draw {parameters} {
    set newdict [dict create \
	    diff_poly_space	0.30 \
	    diff_gate_space	0.30 \
	    diff_spacing	0.36 \
	    gate_type		mvpfet \
	    diff_type 		mvpdiff \
	    diff_contact_type	mvpdc \
	    drain_diff_type	ldpdiff \
	    drain_diff_contact_type ldpdiffc \
	    plus_diff_type	mvnsd \
	    plus_contact_type	mvnsc \
	    poly_type		poly \
	    poly_contact_type	pc \
	    sub_type		nwell \
        sub_surround    0.16 \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::mos_draw $drawdict]
}

#------------------------
# nMOS cap (3.3V)
#------------------------

proc gf180mcu::nmoscap_3p3_draw {parameters} {
    set newdict [dict create \
	    gate_type		ncap \
	    diff_type 		ndiff \
	    diff_contact_type	ndc \
	    plus_diff_type	psd \
	    plus_contact_type	psc \
	    poly_type		poly \
	    poly_contact_type	pc \
	    sub_type		pwell \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::mos_draw $drawdict]
}

#------------------------
# nMOS cap (6.0V)
#------------------------

proc gf180mcu::nmoscap_6p0_draw {parameters} {
    set newdict [dict create \
	    diff_poly_space	0.30 \
	    diff_gate_space	0.30 \
	    diff_spacing	0.36 \
	    gate_type		mvncap \
	    diff_type 		mvndiff \
	    diff_contact_type	mvndc \
	    plus_diff_type	mvpsd \
	    plus_contact_type	mvpsc \
	    poly_type		poly \
	    poly_contact_type	pc \
	    sub_type		pwell \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::mos_draw $drawdict]
}

#------------------------
# pMOS cap (3.3V)
#------------------------

proc gf180mcu::pmoscap_3p3_draw {parameters} {
    set newdict [dict create \
	    gate_type		pcap \
	    diff_type 		pdiff \
	    diff_contact_type	pdc \
	    plus_diff_type	nsd \
	    plus_contact_type	nsc \
	    poly_type		poly \
	    poly_contact_type	pc \
	    sub_type		nwell \
	    dev_surround	0.43 \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::mos_draw $drawdict]
}

#------------------------
# pMOS cap (6.0V)
#------------------------

proc gf180mcu::pmoscap_6p0_draw {parameters} {
    set newdict [dict create \
	    diff_poly_space	0.30 \
	    diff_gate_space	0.30 \
	    diff_spacing	0.36 \
	    gate_type		mvpcap \
	    diff_type 		mvpdiff \
	    diff_contact_type	mvpdc \
	    plus_diff_type	mvnsd \
	    plus_contact_type	mvnsc \
	    poly_type		poly \
	    poly_contact_type	pc \
	    sub_type		nwell \
	    sub_surround	0.16 \
	    dev_surround	0.60 \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::mos_draw $drawdict]
}

#------------------------
# n-varactor (3.3V)
#------------------------

proc gf180mcu::nvaractor_3p3_draw {parameters} {
    set newdict [dict create \
	    gate_type		nvar \
	    diff_type 		nsd \
	    diff_contact_type	nsc \
	    plus_diff_type	psd \
	    plus_contact_type	psc \
	    poly_type		poly \
	    poly_contact_type	pc \
	    sub_type		pwell \
	    dev_sub_type	nwell \
	    dev_sub_dist	0.12 \
	    dev_surround	-0.01 \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::mos_draw $drawdict]
}

#------------------------
# n-varactor (6.0V)
#------------------------

proc gf180mcu::nvaractor_6p0_draw {parameters} {
    set newdict [dict create \
	    diff_poly_space	0.30 \
	    diff_gate_space	0.30 \
	    diff_spacing	0.36 \
	    gate_type		mvnvar \
	    diff_type 		mvnsd \
	    diff_contact_type	mvnsc \
	    plus_diff_type	mvpsd \
	    plus_contact_type	mvpsc \
	    poly_type		poly \
	    poly_contact_type	pc \
	    sub_type		pwell \
	    sub_surround	0.16 \
	    dev_sub_type	nwell \
	    dev_sub_dist	0.16 \
	    dev_surround	-0.01 \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::mos_draw $drawdict]
}

#------------------------
# p-varactor (3.3V)
#------------------------

proc gf180mcu::pvaractor_3p3_draw {parameters} {
    set newdict [dict create \
	    gate_type		pvar \
	    diff_type 		psd \
	    diff_contact_type	psc \
	    plus_diff_type	nsd \
	    plus_contact_type	nsc \
	    poly_type		poly \
	    poly_contact_type	pc \
	    sub_type		nwell \
	    sub_surround	0.26 \
	    dev_sub_type	pwell \
	    dev_sub_dist	0.24 \
	    dev_surround	-0.01 \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::mos_draw $drawdict]
}

#------------------------
# p-varactor (6.0V)
#------------------------

proc gf180mcu::pvaractor_6p0_draw {parameters} {
    set newdict [dict create \
	    diff_poly_space	0.30 \
	    diff_gate_space	0.30 \
	    diff_spacing	0.36 \
	    gate_type		mvpvar \
	    diff_type 		mvpsd \
	    diff_contact_type	mvpsc \
	    plus_diff_type	mvnsd \
	    plus_contact_type	mvnsc \
	    poly_type		poly \
	    poly_contact_type	pc \
	    sub_type		nwell \
	    sub_surround	0.20 \
	    dev_sub_type	pwell \
	    dev_surround	-0.01 \
    ]
    set drawdict [dict merge $gf180mcu::ruleset $newdict $parameters]
    return [gf180mcu::mos_draw $drawdict]
}

#----------------------------------------------------------------
# nmos: Check device parameters for out-of-bounds values
#----------------------------------------------------------------

proc gf180mcu::mos_check {parameters} {
    set lmax 0

    # Set a local variable for each parameter (e.g., $l, $w, etc.)
    foreach key [dict keys $parameters] {
        set $key [dict get $parameters $key]
    }

    # Normalize distance units to microns
    set l [magic::spice2float $l] 
    set l [magic::3digitpastdecimal $l]
    set w [magic::spice2float $w] 
    set w [magic::3digitpastdecimal $w]

    # nf, m must be integer
    if {![string is int $nf]} {
	puts stderr "NF must be an integer!"
        dict set parameters nf 1
    }
    if {![string is int $m]} {
	puts stderr "M must be an integer!"
        dict set parameters m 1
    }
    # diffcov, polycov must be numeric
    if {[catch {expr abs($diffcov)}]} {
	puts stderr "diffcov must be numeric!"
	set diffcov 100
    }
    if {[catch {expr abs($polycov)}]} {
	puts stderr "polycov must be numeric!"
	set polycov 100
    }

    if {$l < $lmin} {
	puts stderr "Mos length must be >= $lmin um"
        dict set parameters l $lmin
    } 
    if {($lmax > 0) && ($l > $lmax)} {
	puts stderr "MOS length must be <= $lmax"
	dict set parameters l $lmax
	set l $lmax
    } 
    if {$w < $wmin} {
	puts stderr "Mos width must be >= $wmin um"
        dict set parameters w $wmin
    } 
    if {$nf < 1} {
	puts stderr "NF must be >= 1"
        dict set parameters nf 1
    } 
    if {$m < 1} {
	puts stderr "M must be >= 1"
        dict set parameters m 1
    } 
    if {$diffcov < 20 } {
	puts stderr "Diffusion contact coverage must be at least 20%"
        dict set parameters diffcov 20
    } elseif {$diffcov > 100 } {
	puts stderr "Diffusion contact coverage can't be more than 100%"
        dict set parameters diffcov 100
    }
    if {$polycov < 20 } {
	puts stderr "Poly contact coverage must be at least 20%"
        dict set parameters polycov 20
    } elseif {$polycov > 100 } {
	puts stderr "Poly contact coverage can't be more than 100%"
        dict set parameters polycov 100
    }

    # Values must satisfy diffusion-to-tap spacing of 20um.
    # Therefore the maximum of guard ring width or height cannot exceed 40um.
    # If in violation, reduce counts first, as these are easiest to recover
    # by duplicating the device and overlapping the wells.
    set origm $m
    set orignf $nf
    while true {
       set yext [expr ($w + 3.0) * $m]
       set xext [expr ($l + 1.0) * $nf + 1.1]
       if {[expr min($xext, $yext)] > 40.0} {
          if {$yext > 40.0 && $m > 1} {
	     incr m -1
	  } elseif {$xext > 40.0 && $nf > 1} {
	     incr nf -1
	  } elseif {$yext > 40.0} {
	     set w 37
	     puts -nonewline stderr "Transistor width must be < 37 um"
	     puts stderr " to avoid tap spacing violation."
	     dict set parameters w $w
	  } elseif {$xext > 40.0} {
	     set l 37.9
	     puts -nonewline stderr "Transistor length must be < 37.9 um"
	     puts stderr " to avoid tap spacing violation."
	     dict set parameters l $l
	  }
       } else {
	  break
       }
    }
    if {$m != $origm} {
       puts stderr "Y repeat reduced to prevent tap distance violation"
       dict set parameters m $m
    }
    if {$nf != $orignf} {
       puts stderr "X repeat reduced to prevent tap distance violation"
       dict set parameters nf $nf
    }

    return $parameters
}

#----------------------------------------------------------------

proc gf180mcu::nfet_03v3_check {parameters} {
   return [gf180mcu::mos_check $parameters]
}

proc gf180mcu::nfet_05v0_check {parameters} {
   return [gf180mcu::mos_check $parameters]
}

proc gf180mcu::nfet_06v0_check {parameters} {
   return [gf180mcu::mos_check $parameters]
}

proc gf180mcu::nfet_06v0_nvt_check {parameters} {
    return [gf180mcu::mos_check $parameters]
}

proc gf180mcu::pfet_03v3_check {parameters} {
   return [gf180mcu::mos_check $parameters]
}

proc gf180mcu::pfet_05v0_check {parameters} {
   return [gf180mcu::mos_check $parameters]
}

proc gf180mcu::pfet_06v0_check {parameters} {
   return [gf180mcu::mos_check $parameters]
}

proc gf180mcu::nmoscap_3p3_check {parameters} {
   return [gf180mcu::mos_check $parameters]
}

proc gf180mcu::nmoscap_6p0_check {parameters} {
   return [gf180mcu::mos_check $parameters]
}

proc gf180mcu::pmoscap_3p3_check {parameters} {
   return [gf180mcu::mos_check $parameters]
}

proc gf180mcu::pmoscap_6p0_check {parameters} {
   return [gf180mcu::mos_check $parameters]
}

proc gf180mcu::nvaractor_3p3_check {parameters} {
   return [gf180mcu::mos_check $parameters]
}

proc gf180mcu::nvaractor_6p0_check {parameters} {
   return [gf180mcu::mos_check $parameters]
}

proc gf180mcu::pvaractor_3p3_check {parameters} {
   return [gf180mcu::mos_check $parameters]
}

proc gf180mcu::pvaractor_6p0_check {parameters} {
   return [gf180mcu::mos_check $parameters]
}

proc gf180mcu::nfet_10v0_asym_check {parameters} {
   return [gf180mcu::mos_check $parameters]
}

proc gf180mcu::pfet_10v0_asym_check {parameters} {
   return [gf180mcu::mos_check $parameters]
}

proc gf180mcu::nfet_03v3_dss_check {parameters} {
   return [gf180mcu::mos_check $parameters]
}

proc gf180mcu::nfet_06v0_dss_check {parameters} {
   return [gf180mcu::mos_check $parameters]
}

proc gf180mcu::pfet_03v3_dss_check {parameters} {
   return [gf180mcu::mos_check $parameters]
}

proc gf180mcu::pfet_06v0_dss_check {parameters} {
   return [gf180mcu::mos_check $parameters]
}
