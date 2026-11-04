###
###     Source file sky130-fet.tcl
###     Process this file with the preprocessor script
###
#-----------------------------------------------------
# Magic/TCL design kit for SKYWATER TECHNAME:  MOSFETs and varactors
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
# needed by mos_check
#----------------------------------------------------------------

proc sky130::sky130_fd_pr__pfet_01v8_defaults {} {
    return {w 0.42 l 0.15 m 1 nf 1 diffcov 100 polycov 100 \
		guard 1 glc 1 grc 1 gtc 1 gbc 1 tbcov 100 rlcov 100 \
		topc 1 botc 1 poverlap 0 doverlap 1 lmin 0.15 wmin 0.42 \
		class mosfet compatible {sky130_fd_pr__pfet_01v8 \
		sky130_fd_pr__pfet_01v8_lvt sky130_fd_pr__pfet_01v8_hvt \
		sky130_fd_pr__pfet_g5v0d10v5} full_metal 1 conn_gates 0 \
		viasrc 100 viadrn 100 viagate 100 \
		viagb 0 viagr 0 viagl 0 viagt 0 doports 1}
}

proc sky130::sky130_fd_pr__pfet_01v8_lvt_defaults {} {
    return {w 0.42 l 0.35 m 1 nf 1 diffcov 100 polycov 100 \
		guard 1 glc 1 grc 1 gtc 1 gbc 1 tbcov 100 rlcov 100 \
		topc 1 botc 1 poverlap 0 doverlap 1 lmin 0.35 wmin 0.42 \
		class mosfet compatible {sky130_fd_pr__pfet_01v8 \
		sky130_fd_pr__pfet_01v8_lvt sky130_fd_pr__pfet_01v8_hvt \
		sky130_fd_pr__pfet_g5v0d10v5} full_metal 1 conn_gates 0 \
		viasrc 100 viadrn 100 viagate 100 \
		viagb 0 viagr 0 viagl 0 viagt 0 doports 1}
}

proc sky130::sky130_fd_pr__pfet_01v8_hvt_defaults {} {
    return {w 0.42 l 0.15 m 1 nf 1 diffcov 100 polycov 100 \
		guard 1 glc 1 grc 1 gtc 1 gbc 1 tbcov 100 rlcov 100 \
		topc 1 botc 1 poverlap 0 doverlap 1 lmin 0.15 wmin 0.42 \
		class mosfet compatible {sky130_fd_pr__pfet_01v8 \
		sky130_fd_pr__pfet_01v8_lvt sky130_fd_pr__pfet_01v8_hvt \
		sky130_fd_pr__pfet_g5v0d10v5} full_metal 1 conn_gates 0 \
		viasrc 100 viadrn 100 viagate 100 \
		viagb 0 viagr 0 viagl 0 viagt 0 doports 1}
}

proc sky130::sky130_fd_pr__pfet_g5v0d10v5_defaults {} {
    return {w 0.42 l 0.50 m 1 nf 1 diffcov 100 polycov 100 \
		guard 1 glc 1 grc 1 gtc 1 gbc 1 tbcov 100 rlcov 100 \
		topc 1 botc 1 poverlap 0 doverlap 1 lmin 0.50 wmin 0.42 \
		class mosfet compatible {sky130_fd_pr__pfet_01v8 \
		sky130_fd_pr__pfet_01v8_lvt sky130_fd_pr__pfet_01v8_hvt \
		sky130_fd_pr__pfet_g5v0d10v5} full_metal 1 conn_gates 0 \
		viasrc 100 viadrn 100 viagate 100 \
		viagb 0 viagr 0 viagl 0 viagt 0 doports 1}
}

proc sky130::sky130_fd_pr__pfet_g5v0d16v0_defaults {} {
    return {w 5.00 l 1.050 m 1 nf 1 diffcov 100 polycov 100 \
		guard 1 glc 1 grc 1 gtc 1 gbc 1 tbcov 100 rlcov 100 \
		topc 1 botc 1 poverlap 0 doverlap 0 lmin 1.050 wmin 5.00 \
		class mosfet full_metal 1 conn_gates 0 \
		viasrc 100 viadrn 100 viagate 100 \
		viagb 0 viagr 0 viagl 0 viagt 0 doports 1}
}

#----------------------------------------------------------------
# nmos: Specify all user-editable default values and those
# needed by mos_check
#----------------------------------------------------------------

proc sky130::sky130_fd_pr__nfet_01v8_defaults {} {
    return {w 0.420 l 0.150 m 1 nf 1 diffcov 100 polycov 100 \
		guard 1 glc 1 grc 1 gtc 1 gbc 1 tbcov 100 rlcov 100 \
		topc 1 botc 1 poverlap 0 doverlap 1 lmin 0.15 wmin 0.42 \
		class mosfet \
		compatible {sky130_fd_pr__nfet_01v8 sky130_fd_pr__nfet_01v8_lvt \
		sky130_fd_bs_flash__special_sonosfet_star \
		sky130_fd_pr__nfet_g5v0d10v5 sky130_fd_pr__nfet_05v0_nvt \
		sky130_fd_pr__nfet_03v3_nvt} full_metal 1 conn_gates 0 \
		viasrc 100 viadrn 100 viagate 100 \
		viagb 0 viagr 0 viagl 0 viagt 0 doports 1}
}

proc sky130::sky130_fd_pr__nfet_01v8_lvt_defaults {} {
    return {w 0.420 l 0.150 m 1 nf 1 diffcov 100 polycov 100 \
		guard 1 glc 1 grc 1 gtc 1 gbc 1 tbcov 100 rlcov 100 \
		topc 1 botc 1 poverlap 0 doverlap 1 lmin 0.15 wmin 0.42 \
		class mosfet \
		compatible {sky130_fd_pr__nfet_01v8 sky130_fd_pr__nfet_01v8_lvt \
		sky130_fd_bs_flash__special_sonosfet_star \
		sky130_fd_pr__nfet_g5v0d10v5 sky130_fd_pr__nfet_05v0_nvt \
		sky130_fd_pr__nfet_03v3_nvt} full_metal 1 conn_gates 0 \
		viasrc 100 viadrn 100 viagate 100 \
		viagb 0 viagr 0 viagl 0 viagt 0 doports 1}
}

proc sky130::sky130_fd_bs_flash__special_sonosfet_star_defaults {} {
    return {w 0.420 l 0.150 m 1 nf 1 diffcov 100 polycov 100 \
		guard 1 glc 1 grc 1 gtc 1 gbc 1 tbcov 100 rlcov 100 \
		topc 1 botc 1 poverlap 0 doverlap 1 lmin 0.15 wmin 0.42 \
		class mosfet \
		compatible {sky130_fd_pr__nfet_01v8 sky130_fd_pr__nfet_01v8_lvt \
		sky130_fd_bs_flash__special_sonosfet_star \
		sky130_fd_pr__nfet_g5v0d10v5 sky130_fd_pr__nfet_05v0_nvt \
		sky130_fd_pr__nfet_03v3_nvt} full_metal 1 conn_gates 0 \
		viasrc 100 viadrn 100 viagate 100 \
		viagb 0 viagr 0 viagl 0 viagt 0 doports 1}
}

proc sky130::sky130_fd_pr__nfet_g5v0d10v5_defaults {} {
    return {w 0.42 l 0.50 m 1 nf 1 diffcov 100 polycov 100 \
		guard 1 glc 1 grc 1 gtc 1 gbc 1 tbcov 100 rlcov 100 \
		topc 1 botc 1 poverlap 0 doverlap 1 lmin 0.50 wmin 0.42 \
		class mosfet \
		compatible {sky130_fd_pr__nfet_01v8 sky130_fd_pr__nfet_01v8_lvt \
		sky130_fd_bs_flash__special_sonosfet_star \
		sky130_fd_pr__nfet_g5v0d10v5 sky130_fd_pr__nfet_05v0_nvt \
		sky130_fd_pr__nfet_03v3_nvt} full_metal 1 conn_gates 0 \
		viasrc 100 viadrn 100 viagate 100 \
		viagb 0 viagr 0 viagl 0 viagt 0 doports 1}
}

proc sky130::sky130_fd_pr__nfet_05v0_nvt_defaults {} {
    return {w 0.42 l 0.90 m 1 nf 1 diffcov 100 polycov 100 \
		guard 1 glc 1 grc 1 gtc 1 gbc 1 tbcov 100 rlcov 100 \
		topc 1 botc 1 poverlap 0 doverlap 1 lmin 0.90 wmin 0.42 \
		class mosfet \
		compatible {sky130_fd_pr__nfet_01v8 sky130_fd_pr__nfet_01v8_lvt \
		sky130_fd_bs_flash__special_sonosfet_star \
		sky130_fd_pr__nfet_g5v0d10v5 sky130_fd_pr__nfet_05v0_nvt \
		sky130_fd_pr__nfet_03v3_nvt} full_metal 1 conn_gates 0 \
		viasrc 100 viadrn 100 viagate 100 \
		viagb 0 viagr 0 viagl 0 viagt 0 doports 1}
}

proc sky130::sky130_fd_pr__nfet_03v3_nvt_defaults {} {
    return {w 0.42 l 0.50 m 1 nf 1 diffcov 100 polycov 100 \
		guard 1 glc 1 grc 1 gtc 1 gbc 1 tbcov 100 rlcov 100 \
		topc 1 botc 1 poverlap 0 doverlap 1 lmin 0.50 wmin 0.42 \
		class mosfet \
		compatible {sky130_fd_pr__nfet_01v8 sky130_fd_pr__nfet_01v8_lvt \
		sky130_fd_bs_flash__special_sonosfet_star \
		sky130_fd_pr__nfet_g5v0d10v5 sky130_fd_pr__nfet_05v0_nvt \
		sky130_fd_pr__nfet_03v3_nvt} full_metal 1 conn_gates 0 \
		viasrc 100 viadrn 100 viagate 100 \
		viagb 0 viagr 0 viagl 0 viagt 0 doports 1}
}

proc sky130::sky130_fd_pr__nfet_g5v0d16v0_defaults {} {
    return {w 5.00 l 1.055 m 1 nf 1 diffcov 100 polycov 100 \
		guard 1 glc 1 grc 1 gtc 1 gbc 1 tbcov 100 rlcov 100 \
		topc 1 botc 1 poverlap 0 doverlap 0 lmin 1.050 wmin 5.00 \
		full_metal 1 conn_gates 0 \
		viasrc 100 viadrn 100 viagate 100 \
		viagb 0 viagr 0 viagl 0 viagt 0 doports 1}
}

#----------------------------------------------------------------
# mos varactor: Specify all user-editable default values and those
# needed by mosvc_check
#----------------------------------------------------------------

proc sky130::sky130_fd_pr__cap_var_lvt_defaults {} {
    return {w 1.0 l 0.18 m 1 nf 1 diffcov 100 polycov 100 \
		guard 1 glc 1 grc 1 gtc 1 gbc 1 tbcov 100 rlcov 100 \
		topc 1 botc 1 poverlap 0 doverlap 1 lmin 0.18 wmin 1.0 \
		class mosfet compatible {sky130_fd_pr__cap_var_lvt \
		sky130_fd_pr__cap_var_hvt sky130_fd_pr__cap_var} \
		full_metal 1 viasrc 100 viadrn 100 viagate 100 \
		viagb 0 viagr 0 viagl 0 viagt 0 gshield 1}
}

proc sky130::sky130_fd_pr__cap_var_hvt_defaults {} {
    return {w 1.0 l 0.18 m 1 nf 1 diffcov 100 polycov 100 \
		guard 1 glc 1 grc 1 gtc 1 gbc 1 tbcov 100 rlcov 100 \
		topc 1 botc 1 poverlap 0 doverlap 1 lmin 0.18 wmin 1.0 \
		class mosfet compatible {sky130_fd_pr__cap_var_lvt \
		sky130_fd_pr__cap_var_hvt sky130_fd_pr__cap_var} \
		full_metal 1 conn_gates 0 \
		viasrc 100 viadrn 100 viagate 100 \
		viagb 0 viagr 0 viagl 0 viagt 0 gshield 1}
}

proc sky130::sky130_fd_pr__cap_var_defaults {} {
    return {w 1.0 l 0.50 m 1 nf 1 diffcov 100 polycov 100 \
		guard 1 glc 1 grc 1 gtc 1 gbc 1 tbcov 100 rlcov 100 \
		topc 1 botc 1 poverlap 0 doverlap 1 lmin 0.50 wmin 1.0 \
		class mosfet compatible {sky130_fd_pr__cap_var_lvt \
		sky130_fd_pr__cap_var_hvt sky130_fd_pr__cap_var} \
		full_metal 1 conn_gates 0 \
		viasrc 100 viadrn 100 viagate 100 \
		viagb 0 viagr 0 viagl 0 viagt 0 gshield 1}
}

#----------------------------------------------------------------
# mos: Conversion from SPICE netlist parameters to toolkit
#----------------------------------------------------------------

proc sky130::mos_convert {parameters} {
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
		dict set pdkparams [string tolower $key] $value
	    }
	    nf {
		# Adjustment ot W will be handled below
		dict set pdkparams [string tolower $key] $value
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

    return $pdkparams
}

#----------------------------------------------------------------

proc sky130::sky130_fd_pr__nfet_01v8_convert {parameters} {
    return [sky130::mos_convert $parameters]
}

proc sky130::sky130_fd_pr__nfet_01v8_lvt_convert {parameters} {
    return [sky130::mos_convert $parameters]
}

proc sky130::sky130_fd_bs_flash__special_sonosfet_star_convert {parameters} {
    return [sky130::mos_convert $parameters]
}

proc sky130::sky130_fd_pr__nfet_g5v0d10v5_convert {parameters} {
    return [sky130::mos_convert $parameters]
}

proc sky130::sky130_fd_pr__nfet_g5v0d16v0_convert {parameters} {
    return [sky130::mos_convert $parameters]
}

proc sky130::sky130_fd_pr__nfet_05v0_nvt_convert {parameters} {
    return [sky130::mos_convert $parameters]
}

proc sky130::sky130_fd_pr__nfet_03v3_nvt_convert {parameters} {
    return [sky130::mos_convert $parameters]
}

proc sky130::sky130_fd_pr__pfet_01v8_convert {parameters} {
    return [sky130::mos_convert $parameters]
}

proc sky130::sky130_fd_pr__pfet_01v8_lvt_convert {parameters} {
    return [sky130::mos_convert $parameters]
}

proc sky130::sky130_fd_pr__pfet_01v8_hvt_convert {parameters} {
    return [sky130::mos_convert $parameters]
}

proc sky130::sky130_fd_pr__pfet_g5v0d10v5_convert {parameters} {
    return [sky130::mos_convert $parameters]
}

proc sky130::sky130_fd_pr__pfet_g5v0d16v0_convert {parameters} {
    return [sky130::mos_convert $parameters]
}

proc sky130::sky130_fd_pr__cap_var_lvt_convert {parameters} {
    return [sky130::mos_convert $parameters]
}

proc sky130::sky130_fd_pr__cap_var_hvt_convert {parameters} {
    return [sky130::mos_convert $parameters]
}

proc sky130::sky130_fd_pr__cap_var_convert {parameters} {
    return [sky130::mos_convert $parameters]
}

#----------------------------------------------------------------
# mos: Interactively specifies the fixed layout parameters
#----------------------------------------------------------------

proc sky130::mos_dialog {device parameters} {
    # Editable fields:      w, l, nf, m, diffcov, polycov
    # Checked fields:  topc, botc
    # For specific devices, gate type is a selection list

    magic::add_entry w "Width (um)" $parameters
    magic::add_entry l "Length (um)" $parameters
    magic::add_entry nf "Fingers" $parameters
    magic::add_entry m "M" $parameters

    if {[dict exists $parameters compatible]} {
       set sellist [dict get $parameters compatible]
       magic::add_selectlist gencell "Device type" $sellist $parameters $device
    }

    # Default-empty message area, used by the varactor dialog.
    magic::add_message minfo "" $parameters brown

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
    if {[dict exists $parameters conn_gates]} {
	magic::add_checkbox conn_gates "Connect gates together" $parameters
    }

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

    if {[string first "cap_var" $device] != -1} {
	magic::add_checkbox gshield "Metal shield over gate" $parameters
    }

    magic::add_entry viasrc "Source via coverage \[+/-\](%)" $parameters
    magic::add_entry viadrn "Drain via coverage \[+/-\](%)" $parameters
    magic::add_entry viagate "Gate via coverage \[+/-\](%)" $parameters
    magic::add_entry viagb "Bottom guard ring via coverage \[+/-\](%)" $parameters
    magic::add_entry viagt "Top guard ring via coverage \[+/-\](%)" $parameters
    magic::add_entry viagr "Right guard ring via coverage \[+/-\](%)" $parameters
    magic::add_entry viagl "Left guard ring via coverage \[+/-\](%)" $parameters

    if {[dict exists $parameters addports]} {
	magic::add_checkbox doports "Add ports" $parameters
    }

    # magic::add_checkbox dummy "Add dummy" $parameters
}

#----------------------------------------------------------------

proc sky130::sky130_fd_pr__nfet_01v8_dialog {parameters} {
    sky130::mos_dialog sky130_fd_pr__nfet_01v8 $parameters
}

proc sky130::sky130_fd_pr__nfet_01v8_lvt_dialog {parameters} {
    sky130::mos_dialog sky130_fd_pr__nfet_01v8_lvt $parameters
}

proc sky130::sky130_fd_bs_flash__special_sonosfet_star_dialog {parameters} {
    sky130::mos_dialog sky130_fd_bs_flash__special_sonosfet_star $parameters
}

proc sky130::sky130_fd_pr__nfet_g5v0d10v5_dialog {parameters} {
    sky130::mos_dialog sky130_fd_pr__nfet_g5v0d10v5 $parameters
}

proc sky130::sky130_fd_pr__nfet_g5v0d16v0_dialog {parameters} {
    sky130::mos_dialog sky130_fd_pr__nfet_g5v0d16v0 $parameters
}

proc sky130::sky130_fd_pr__nfet_05v0_nvt_dialog {parameters} {
    sky130::mos_dialog sky130_fd_pr__nfet_05v0_nvt $parameters
}

proc sky130::sky130_fd_pr__nfet_03v3_nvt_dialog {parameters} {
    sky130::mos_dialog sky130_fd_pr__nfet_03v3_nvt $parameters
}

proc sky130::sky130_fd_pr__pfet_01v8_dialog {parameters} {
    sky130::mos_dialog sky130_fd_pr__pfet_01v8 $parameters
}

proc sky130::sky130_fd_pr__pfet_01v8_lvt_dialog {parameters} {
    sky130::mos_dialog sky130_fd_pr__pfet_01v8_lvt $parameters
}

proc sky130::sky130_fd_pr__pfet_01v8_hvt_dialog {parameters} {
    sky130::mos_dialog sky130_fd_pr__pfet_01v8_hvt $parameters
}

proc sky130::sky130_fd_pr__pfet_g5v0d10v5_dialog {parameters} {
    sky130::mos_dialog sky130_fd_pr__pfet_g5v0d10v5 $parameters
}

proc sky130::sky130_fd_pr__pfet_g5v0d16v0_dialog {parameters} {
    sky130::mos_dialog sky130_fd_pr__pfet_g5v0d16v0 $parameters
}

proc sky130::sky130_fd_pr__cap_var_lvt_dialog {parameters} {
    sky130::mos_dialog sky130_fd_pr__cap_var_lvt $parameters
}

proc sky130::sky130_fd_pr__cap_var_hvt_dialog {parameters} {
    sky130::mos_dialog sky130_fd_pr__cap_var_hvt $parameters
}

proc sky130::sky130_fd_pr__cap_var_dialog {parameters} {
    sky130::mos_dialog sky130_fd_pr__cap_var $parameters
}

#----------------------------------------------------------------
# LDNMOS:  Sub-procedure to draw the extended drain
#----------------------------------------------------------------

proc sky130::draw_ldnmos_drain {parameters} {

    # Set a local variable for each parameter (e.g., $l, $w, etc.)
    foreach key [dict keys $parameters] {
        set $key [dict get $parameters $key]
    }

    # Need to regenerate some values from mos_device
    set hl [/ $l 2.0]
    set hw [/ $w 2.0]

    # Extension is fixed at 1.585um and we assume a fixed
    # underlap of the gate of 0.13um, which is not in the
    # drawn device, so subtracted from the extension distance.
    set extension 1.455

    pushbox
    # Starts with point at the device center
    box grow n ${hw}um
    box grow s ${hw}um
    box move $dside ${hl}um
    pushbox
    box grow $dside ${extension}um
    paint ed
    set cext [sky130::getbox]
    popbox
    box move $dside ${extension}um
    box move $dside 0.13um
    box grow e 0.13um
    box grow w 0.13um
    paint mvnsd
    # Test:  Do not include nwell in bounding box
    set cext [sky130::unionbox $cext [sky130::getbox]]
    pushbox
    box grow c 0.66um
    paint nwell
    popbox
    popbox
    # Back to the center point
    pushbox
    box move $dside ${hl}um
    box move $dside ${extension}um
    box move $dside 0.13um

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
	sky130::mcon_draw vert
	popbox
    }
    # cdwfull was calculated for the source side and is too long for
    # the drain side by 0.06um on top and bottom.
    set cdwfull [- $cdwfull 0.12]
    if {$cdw > $cdwfull} [set cdw $cdwfull]

    set cext [sky130::unionbox $cext [sky130::draw_contact 0 ${cdw} \
		${drain_diff_surround} ${metal_surround} ${contact_size}\
		mvnsd mvnsc li vert]]
    popbox
    return $cext
}

#----------------------------------------------------------------
# LDPMOS:  Sub-procedure to draw the extended drain
#----------------------------------------------------------------

proc sky130::draw_ldpmos_drain {parameters} {

    # Set a local variable for each parameter (e.g., $l, $w, etc.)
    foreach key [dict keys $parameters] {
        set $key [dict get $parameters $key]
    }

    # Need to regenerate some values from mos_device
    set hl [/ $l 2.0]
    set hw [/ $w 2.0]

    # Extension is fixed at 1.19um and we assume a fixed
    # underlap of the gate of 0.13um, which is not in the
    # drawn device, so subtracted from the extension distance.
    set extension 1.06

    pushbox
    # Starts with point at the device center
    box grow n ${hw}um
    box grow s ${hw}um
    box move $dside ${hl}um
    pushbox
    box grow $dside ${extension}um
    paint ed
    set cext [sky130::getbox]
    popbox
    box move $dside ${extension}um
    box move $dside 0.13um
    box grow e 0.13um
    box grow w 0.13um
    paint mvpsd
    pushbox
    box grow c 0.86um
    # Shorter than necessary to avoid DRC error;  actual
    # nwell is erased under gate by GDS generation rules.
    box grow e -0.15um
    box grow w -0.15um
    paint pwell
    popbox
    popbox
    # Back to the center point
    pushbox
    box move $dside ${hl}um
    box move $dside ${extension}um
    box move $dside 0.13um

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
	sky130::mcon_draw vert
	popbox
    }
    # cdwfull was calculated for the source side and is too long for
    # the drain side by 0.06um on top and bottom.
    set cdwfull [- $cdwfull 0.12]
    if {$cdw > $cdwfull} [set cdw $cdwfull]

    set cext [sky130::unionbox $cext [sky130::draw_contact 0 ${cdw} \
		${drain_diff_surround} ${metal_surround} ${contact_size}\
		mvpsd mvpsc li vert]]
    popbox
    return $cext
}

#----------------------------------------------------------------
# MOSFET: Draw a single device
#----------------------------------------------------------------

proc sky130::mos_device {parameters} {

    # Epsilon for avoiding round-off errors
    set eps  0.0005

    # Set local default values if they are not in parameters
    set doports 0	;# no port labels by default
    set diffcov 100	;# percent coverage of diffusion contact
    set polycov 100	;# percent coverage of poly contact
    set topc 1		;# draw top poly contact
    set botc 1		;# draw bottom poly contact
    set viasrc 100	;# draw source vias
    set viadrn 100	;# draw drain vias
    set viagate 100	;# draw gate vias
    set evens 1		;# even or odd (evens = 1 means drain is on the left)
    set dev_sub_type ""	;# device substrate type (if different from guard ring)
    set dev_sub_dist 0	;# device substrate distance (if nondefault dev_sub_type)
    set min_effl 0	;# gate length below which finger pitch must be stretched
    set diff_overlap_cont 0	;# extra overlap of end contact by diffusion
    set gshield 0	;# no metal shield over gate (used for varactors)
    set conn_gates 0	;# do not extend metal to connect to neighboring gates
    set poly_merge 0	;# do not extend poly to connect to neighboring gates
    set drain_proc {}	;# no special procedure to draw the drain

    set drain ""
    set source ""
    set gate ""

    # Set a local variable for each parameter (e.g., $l, $w, etc.)
    foreach key [dict keys $parameters] {
        set $key [dict get $parameters $key]
    }

    # "topc" and "botc" may be modified for alternating top-bottom gate
    # contacts.  If so, original values are in "oldtopc" and "oldbotc".
    if {![dict exists $parameters oldtopc]} {set oldtopc $topc}
    if {![dict exists $parameters oldbotc]} {set oldbotc $botc}

    # Draw the diffusion and poly
    pushbox
    box size 0 0
    pushbox
    set hw [/ $w 2.0]
    set hl [/ $l 2.0]
    set he [/ $min_effl 2.0]
    if {$nf == 1 || $he < $hl} {set he $hl}
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
    if {${diff_extension} > ${gate_to_diffcont}} {
        box grow $dside ${diff_extension}um
        box grow $sside ${diff_extension}um
    } else {
        box grow $dside ${gate_to_diffcont}um
        box grow $sside ${gate_to_diffcont}um
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
    set cext [sky130::getbox]
    popbox
    # save gate area now and paint later, so that diffusion surrounding the
    # contact does not paint over the gate area, in case the gate type is
    # not part of a "compose" entry in the techfile.
    set gaterect [box values]
    popbox

    # Adjust position of contacts for dogbone geometry
    # Rule 1: Minimize diffusion length.  Contacts only move out
    # if width <  contact diffusion height.  They move out enough
    # that the diffusion-to-poly spacing is satisfied.

    set ddover 0
    set cdwmin [+ ${contact_size} [* ${diff_surround} 2]]
    set cstem [- ${gate_to_diffcont} [/ ${cdwmin} 2.0]]
    set cgrow [- ${diff_poly_space} ${cstem}]
    if {[+ ${w} ${eps}] < ${cdwmin}} {
        if {${cgrow} > 0} {
            set gate_to_diffcont [+ ${gate_to_diffcont} ${cgrow}]
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
    # poly out further to clear spacing to the diffusion contact

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
    set tsurround [+ ${diff_surround} ${diff_overlap_cont}]
    set cdw [- ${w} [* ${tsurround} 2]]		;# diff contact height
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

    if {$drain_proc != {}} {
	# Add variables to the parameters dictionary that we'll need
	dict set parameters cdw $cdw
	dict set parameters cdwfull $cdwfull
	dict set parameters dside $dside
	dict set parameters sside $sside
	dict set parameters doports $doports
	set cext [sky130::unionbox $cext [eval $drain_proc {$parameters}]]
    } else {
	# Drain diffusion contact
	pushbox
	box move $dside ${he}um
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
	    sky130::mcon_draw vert
	    popbox
	}
	set cext [sky130::unionbox $cext [sky130::draw_contact 0 ${cdw} \
		${diff_surround} ${metal_surround} ${contact_size}\
		${diff_type} ${diff_contact_type} li vert]]
	if {$drain != ""} {
	    label $drain c $diff_contact_type
	    select area label
	    port make
	}
	popbox
    }

    # Source diffusion contact
    pushbox
    box move $sside ${he}um
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
        sky130::mcon_draw vert
        popbox
    }
    set cext [sky130::unionbox $cext [sky130::draw_contact 0 ${cdw} \
		${diff_surround} ${metal_surround} ${contact_size} \
		${diff_type} ${diff_contact_type} li vert]]
    if {$source != ""} {
	label $source c $diff_contact_type
	select area label
	port make
    }
    set diffarea $cext
    popbox
    # Gate shield (only on varactors)
    if {$gshield == 1} {
 	pushbox
	box move w ${he}um
	box move w ${gate_to_diffcont}um
	box width [* 2 [+ ${he} ${gate_to_diffcont}]]um
	box grow n [/ $cdwfull 2]um
	box grow s [/ $cdwfull 2]um
	paint m1
	# Enforce slotting of large metal
	set gsh [magic::i2u [box height]]
	if {$gsh > 25} {
	   box move n [/ $gsh 2]um
	   box move s 1.15um
	   box height 2.3um	;# Minimum m1 slot width
	   box grow w -${via_size}um
	   box grow e -${via_size}um
	   erase m1
	}
	popbox
    }
    # Top poly contact
    if {$topc && $oldtopc} {
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
           sky130::mcon_draw horz
	   popbox
	   pushbox

	   if {$conn_gates == 1} {
	       box grow n [/ $ch 2]um
	       box grow s [/ $ch 2]um
	       box grow w [+ ${he} ${gate_to_diffcont}]um
	       box grow e [+ ${he} ${gate_to_diffcont}]um
	       paint m1
	   }
	   popbox
       }
       set cext [sky130::unionbox $cext [sky130::draw_contact ${cpl} 0 \
		${poly_surround} ${metal_surround} ${contact_size} \
		${poly_type} ${poly_contact_type} li horz]]
       if {$conn_gates == 1} {
	   pushbox
	   box grow n [/ $contact_size 2]um
	   box grow s [/ $contact_size 2]um
	   box grow w [+ ${he} ${gate_to_diffcont}]um
	   box grow e [+ ${he} ${gate_to_diffcont}]um
	   paint li 
	   if {$poly_merge == 1} {
	      box grow n ${poly_surround}um
	      box grow s ${poly_surround}um
	      paint poly 
	   }
	   popbox
       }
       if {$gate != ""} {
	   label $gate c $poly_contact_type
	   select area label
	   port make
       }
       popbox
    }
    # Bottom poly contact
    if {$botc && $oldbotc} {
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
           sky130::mcon_draw horz
           popbox
	   pushbox

	   if {$conn_gates == 1} {
	       box grow n [/ $ch 2]um
	       box grow s [/ $ch 2]um
	       box grow w [+ ${he} ${gate_to_diffcont}]um
	       box grow e [+ ${he} ${gate_to_diffcont}]um
	       paint m1
	   }
	   popbox
       }
       set cext [sky130::unionbox $cext [sky130::draw_contact ${cpl} 0 \
		${poly_surround} ${metal_surround} ${contact_size} \
		${poly_type} ${poly_contact_type} li horz]]
       if {$conn_gates == 1} {
	   pushbox
	   box grow n [/ $contact_size 2]um
	   box grow s [/ $contact_size 2]um
	   box grow w [+ ${he} ${gate_to_diffcont}]um
	   box grow e [+ ${he} ${gate_to_diffcont}]um
	   paint li 
	   if {$poly_merge == 1} {
	      box grow n ${poly_surround}um
	      box grow s ${poly_surround}um
	      paint poly 
	   }
	   popbox
       }
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
    # sub_surround_dev, if defined, may create a larger area around the gate
    # than sub_surround creates around the diffusion/poly area.
    if [dict exists $parameters sub_surround_dev] {
	box grow n ${sub_surround_dev}um
	box grow s ${sub_surround_dev}um
	box grow e ${sub_surround_dev}um
	box grow w ${sub_surround_dev}um
	paint ${dev_sub_type}
	set cext [sky130::unionbox $cext [sky130::getbox]]
    }
    popbox

    if {$dev_sub_type != ""} {
	box values [lindex $diffarea 0]um [lindex $diffarea 1]um \
	    [lindex $diffarea 2]um [lindex $diffarea 3]um
	box grow n ${sub_surround}um
	box grow s ${sub_surround}um
	box grow e ${sub_surround}um
	box grow w ${sub_surround}um
	paint ${dev_sub_type}
	if {$dev_sub_dist > 0} {
	    set cext [sky130::unionbox $cext [sky130::getbox]]
	}
        # puts stdout "Diagnostic:  bounding box is $cext"
    }

    popbox
    return $cext
}

#----------------------------------------------------------------
# MOSFET: Draw the tiled device
#----------------------------------------------------------------

proc sky130::mos_draw {parameters} {
    tech unlock *
    set savesnap [snap]
    snap internal

    # Set defaults if they are not in parameters
    set poverlap 0	;# overlap poly contacts when tiling
    set doverlap 1	;# overlap diffusion contacts when tiling
    set dev_sub_dist 0	;# substrate to guard ring, if dev_sub_type defined
    set dev_sub_space 0	;# distance between substrate areas for arrayed devices
    set min_allc 0	;# gate length below which poly contacts must be interleaved
    set id_type ""	;# additional type covering everything
    set id_surround 0	;# amount of surround on above type
    set id2_type ""	;# additional type covering everything
    set id2_surround 0	;# amount of surround on above type
    set conn_gates 0	;# do not connect multiple gates together
    set poly_merge 0	;# do not merge poly between gates
    set doports 0	;# no port labels unless requested

    set set_x_to_guard ""	;# override x distance to guard ring
    set set_y_to_guard ""	;# override y distance to guard ring

    # Set a local variable for each parameter (e.g., $l, $w, etc.)
    foreach key [dict keys $parameters] {
        set $key [dict get $parameters $key]
    }

    # Diff surround on drain is by default the same as diff surround
    if {![dict exist $parameters drain_diff_surround]} {
	set drain_diff_surround $diff_surround
    }

    # Diff-to-tap spacing is by default the same as diff spacing
    if {![dict exist $parameters diff_tap_space]} {
	set diff_tap_space $diff_spacing
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

    # If dx < (poly contact space + poly contact width), then there is not
    # enough room for a row of contacts, so force alternating contacts;
    # However, if conn_gates is set, just set a flag noting that poly
    # needs to be drawn over all of the gates, connecting them together,
    # but the positions will not alternate.

    set evens 1
    if {$nf > 1 && $l < $min_allc} {
	if {$conn_gates == 1 } {
	    set intc 0
	    set poly_merge 1
	} else {
	    set intc 1
	    set evenodd 1
	    dict set parameters oldtopc $topc
	    dict set parameters oldbotc $botc
	    set topc 1
	    set botc 1
	    dict set parameters topc 1
	    dict set parameters botc 1
	    set poverlap 0
	    set poly_merge 0
	}
    } else {
	set intc 0
	set poly_merge 0
    }
    dict set parameters poly_merge $poly_merge

    # Determine the base device dimensions by drawing one device
    # while all layers are locked (nothing drawn).  This allows the
    # base drawing routine to do complicated geometry without having
    # to duplicate it here with calculations.

    tech lock *
    set bbox [sky130::mos_device $parameters]
    puts stdout "Diagnostic: Device bounding box e $bbox (um)"
    tech unlock *

    set fw [- [lindex $bbox 2] [lindex $bbox 0]]
    set fh [- [lindex $bbox 3] [lindex $bbox 1]]
    set lw [+ [lindex $bbox 2] [lindex $bbox 0]]
    set lh [+ [lindex $bbox 3] [lindex $bbox 1]]

    # If the bounding box is not symmetric about x=0, then find the
    # offset.  Assumed to be needed only for X (asymmetric drain)
    set xoffset [+ [lindex $bbox 0] [lindex $bbox 2]]
    
    # If dev_sub_dist > 0 then each device must be in its own substrate
    # (well) area, and overlaps are disallowed.  dev_sub_space determines
    # the distance between individual devices in an array.

    if {$dev_sub_dist > 0} {
        set poverlap 0
        set doverlap 0

	if {$dev_sub_space > $poly_spacing} {
	    set dx [+ $fw $dev_sub_space]
	    set dy [+ $fh $dev_sub_space]
	} else {
	    set dx [+ $fw $poly_spacing]
	    set dy [+ $fh $poly_spacing]
	}

    } else {

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
	    set dx [- $fw [+ $drain_diff_surround $drain_diff_surround $contact_size]]
	}
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
    if {($guard != 0) || (${id_type} != "")} {
	if {($dev_sub_dist > 0) && ([+ $dev_sub_dist $sub_surround] > $diff_tap_space)} {
	    set gx [+ $corex [* 2.0 [+ $dev_sub_dist $diff_surround]] $contact_size]
	} else {
	    set gx [+ $corex [* 2.0 [+ $diff_tap_space $diff_surround]] $contact_size]
	}
	if {($dev_sub_dist > 0) && ([+ $dev_sub_dist $sub_surround] > $diff_gate_space)} {
	    set gy [+ $corey [* 2.0 [+ $dev_sub_dist $diff_surround]] $contact_size]
	} else {
	    set gy [+ $corey [* 2.0 [+ $diff_gate_space $diff_surround]] $contact_size]
	}

	# Somewhat tricky. . . if the width is small and the diffusion is 
	# a dogbone, and the top or bottom poly contact is missing, then
	# the spacing to the guard ring may be limited by diffusion spacing, not
	# poly to diffusion.

	set inset [/ [+ $contact_size [* 2.0 $diff_surround] -$w] 2.0]
	set sdiff [- [+ $inset $diff_tap_space] [+ $gate_extension $diff_gate_space]]

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

	# set_x|y_to_guard overrides the above calculations if present.
	if {$set_x_to_guard != ""} {
	    set gx [+ $corex [* 2.0 $set_x_to_guard]]
	}
	if {$set_y_to_guard != ""} {
	    set gy [+ $corey [* 2.0 $set_y_to_guard]]
	}
    }
    if {$guard != 0} {
	if {$doports} {dict set parameters bulk B}
	# Draw the guard ring first, as MOS well may interact with guard ring substrate
	sky130::guard_ring $gx $gy $parameters
    }

    pushbox
    # If any surrounding identifier type is defined, draw it
    if {${id_type} != ""} {
	set hw [/ $gx 2]
	set hh [/ $gy 2]
	box grow e ${hw}um
	box grow w ${hw}um
	box grow n ${hh}um
	box grow s ${hh}um
	box grow c ${id_surround}um
	paint ${id_type}
    }
    popbox
    pushbox
    box move w ${corellx}um
    box move s ${corelly}um

    for {set xp 0} {$xp < $nf} {incr xp} {
	dict set parameters evens $evens
	set evens [- 1 $evens]
        pushbox
	if {$intc == 1} {
	    set evenodd [- 1 $evenodd]
	    if {$evenodd == 1} {
		dict set parameters topc 1
		dict set parameters botc 0
	    } else {
		dict set parameters topc 0
		dict set parameters botc 1
	    }
	    set saveeo $evenodd
	}
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
		    if {$conn_gates == 0} {
			dict set parameters gate G$xp
		    } else {
			dict set parameters gate G
		    }
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
			if {$conn_gates == 0} {
			    dict set parameters gate G$xp
			} else {
			    dict set parameters gate G
			}
		    } elseif {$poverlap} {
			dict set parameters gate ""
		    } else {
			if {$conn_gates == 0} {
			    dict set parameters gate G${xp}_$yp
			} else {
			    dict set parameters gate G$yp
			}
		    }
		}
	    }
            if {$evens != 0} {box move e ${xoffset}um}
            sky130::mos_device $parameters
            if {$evens != 0} {box move w ${xoffset}um}
            box move n ${dy}um
	    if {$intc == 1} {
		set evenodd [- 1 $evenodd]
		if {$evenodd == 1} {
		    dict set parameters topc 1
		    dict set parameters botc 0
		} else {
		    dict set parameters topc 0
		    dict set parameters botc 1
		}
	    }
        }
	if {$intc == 1} {
	    set evenodd $saveeo
	}
        popbox
        box move e ${dx}um
    }
    popbox
    popbox

    snap $savesnap
    tech revert
}

#-------------------
# nMOS 1.8V
#-------------------

proc sky130::sky130_fd_pr__nfet_01v8_draw {parameters} {
    set newdict [dict create \
	    gate_type		nfet \
	    diff_type 		ndiff \
	    diff_contact_type	ndc \
	    plus_diff_type	psd \
	    plus_contact_type	psc \
	    poly_type		poly \
	    poly_contact_type	pc \
	    sub_type		psub \
	    min_effl		0.185 \
	    min_allc		0.26 \
    ]
    set drawdict [dict merge $sky130::ruleset $newdict $parameters]
    return [sky130::mos_draw $drawdict]
}

proc sky130::sky130_fd_pr__nfet_01v8_lvt_draw {parameters} {
    set newdict [dict create \
	    gate_type		nfetlvt \
	    diff_type 		ndiff \
	    diff_contact_type	ndc \
	    plus_diff_type	psd \
	    plus_contact_type	psc \
	    poly_type		poly \
	    poly_contact_type	pc \
	    sub_type		psub \
	    min_effl		0.185 \
	    min_allc		0.26 \
    ]
    set drawdict [dict merge $sky130::ruleset $newdict $parameters]
    return [sky130::mos_draw $drawdict]
}

proc sky130::sky130_fd_bs_flash__special_sonosfet_star_draw {parameters} {
    set newdict [dict create \
	    gate_type		nsonos \
	    diff_type 		ndiff \
	    diff_contact_type	ndc \
	    plus_diff_type	psd \
	    plus_contact_type	psc \
	    poly_type		poly \
	    poly_contact_type	pc \
	    sub_type		psub \
	    id_type		dnwell \
	    id_surround		1.355 \
	    min_effl		0.185 \
	    min_allc		0.26 \
    ]
    set drawdict [dict merge $sky130::ruleset $newdict $parameters]
    return [sky130::mos_draw $drawdict]
}

#-------------------
# pMOS 1.8V
#-------------------

proc sky130::sky130_fd_pr__pfet_01v8_draw {parameters} {
    set newdict [dict create \
	    gate_type		pfet \
	    diff_type 		pdiff \
	    diff_contact_type	pdc \
	    plus_diff_type	nsd \
	    plus_contact_type	nsc \
	    poly_type		poly \
	    poly_contact_type	pc \
	    sub_type		nwell \
	    dev_sub_type	nwell \
	    gate_to_polycont	0.32 \
	    min_effl		0.185 \
	    min_allc		0.26 \
    ]
    set drawdict [dict merge $sky130::ruleset $newdict $parameters]
    return [sky130::mos_draw $drawdict]
}

proc sky130::sky130_fd_pr__pfet_01v8_lvt_draw {parameters} {
    set newdict [dict create \
	    gate_type		pfetlvt \
	    diff_type 		pdiff \
	    diff_contact_type	pdc \
	    plus_diff_type	nsd \
	    plus_contact_type	nsc \
	    poly_type		poly \
	    poly_contact_type	pc \
	    sub_type		nwell \
	    dev_sub_type	nwell \
	    gate_to_polycont	0.32 \
	    min_effl		0.185 \
	    min_allc		0.26 \
    ]
    set drawdict [dict merge $sky130::ruleset $newdict $parameters]
    return [sky130::mos_draw $drawdict]
}

proc sky130::sky130_fd_pr__pfet_01v8_hvt_draw {parameters} {
    set newdict [dict create \
	    gate_type		pfethvt \
	    diff_type 		pdiff \
	    diff_contact_type	pdc \
	    plus_diff_type	nsd \
	    plus_contact_type	nsc \
	    poly_type		poly \
	    poly_contact_type	pc \
	    sub_type		nwell \
	    dev_sub_type	nwell \
	    gate_to_polycont	0.32 \
	    min_effl		0.185 \
	    min_allc		0.26 \
    ]
    set drawdict [dict merge $sky130::ruleset $newdict $parameters]
    return [sky130::mos_draw $drawdict]
}

#-------------------
# pMOS 5.0V
#-------------------

proc sky130::sky130_fd_pr__pfet_g5v0d10v5_draw {parameters} {
    set newdict [dict create \
	    gate_type		mvpfet \
	    diff_type 		mvpdiff \
	    diff_contact_type	mvpdc \
	    plus_diff_type	mvnsd \
	    plus_contact_type	mvnsc \
	    poly_type		poly \
	    poly_contact_type	pc \
	    sub_type		nwell \
	    dev_sub_type	nwell \
	    guard_sub_surround	0.33 \
	    gate_to_polycont	0.32 \
	    diff_spacing	0.31 \
	    diff_tap_space	0.38 \
	    diff_gate_space	0.38 \
    ]
    set drawdict [dict merge $sky130::ruleset $newdict $parameters]
    return [sky130::mos_draw $drawdict]
}

#-------------------
# nMOS 5.0V
#-------------------

proc sky130::sky130_fd_pr__nfet_g5v0d10v5_draw {parameters} {
    set newdict [dict create \
	    gate_type		mvnfet \
	    diff_type 		mvndiff \
	    diff_contact_type	mvndc \
	    plus_diff_type	mvpsd \
	    plus_contact_type	mvpsc \
	    poly_type		poly \
	    poly_contact_type	pc \
	    sub_type		psub \
	    diff_spacing	0.31 \
	    diff_tap_space	0.38 \
	    diff_gate_space	0.38 \
	    set_x_to_guard	0.535 \
    ]
    set drawdict [dict merge $sky130::ruleset $newdict $parameters]
    return [sky130::mos_draw $drawdict]
}

proc sky130::sky130_fd_pr__nfet_05v0_nvt_draw {parameters} {
    set newdict [dict create \
	    gate_type		mvnnfet \
	    diff_type 		mvndiff \
	    diff_contact_type	mvndc \
	    plus_diff_type	mvpsd \
	    plus_contact_type	mvpsc \
	    poly_type		poly \
	    poly_contact_type	pc \
	    sub_type		psub \
	    diff_spacing	0.30 \
	    diff_tap_space	0.38 \
	    diff_gate_space	0.38 \
    ]
    set drawdict [dict merge $sky130::ruleset $newdict $parameters]
    return [sky130::mos_draw $drawdict]
}

proc sky130::sky130_fd_pr__nfet_03v3_nvt_draw {parameters} {
    set newdict [dict create \
	    gate_type		nnfet \
	    diff_type 		mvndiff \
	    diff_contact_type	mvndc \
	    plus_diff_type	mvpsd \
	    plus_contact_type	mvpsc \
	    poly_type		poly \
	    poly_contact_type	pc \
	    sub_type		psub \
	    diff_spacing	0.30 \
	    diff_tap_space	0.38 \
	    diff_gate_space	0.38 \
    ]
    set drawdict [dict merge $sky130::ruleset $newdict $parameters]
    return [sky130::mos_draw $drawdict]
}

#------------------------
# MOS varactor (1.8V)
#------------------------

proc sky130::sky130_fd_pr__cap_var_lvt_draw {parameters} {
    set newdict [dict create \
	    gate_type		var \
	    diff_type 		nnd \
	    diff_contact_type	nsc \
	    plus_diff_type	psd \
	    plus_contact_type	psc \
	    poly_type		poly \
	    poly_contact_type	pc \
	    sub_type		psub \
	    dev_sub_type	nwell \
	    diff_overlap_cont	0.06 \
	    dev_sub_dist	0.14 \
	    dev_sub_space	1.27 \
	    gate_to_diffcont	0.34 \
	    diff_extension	0.485 \
    ]
    set drawdict [dict merge $sky130::ruleset $newdict $parameters]
    return [sky130::mos_draw $drawdict]
}

proc sky130::sky130_fd_pr__cap_var_hvt_draw {parameters} {
    set newdict [dict create \
	    gate_type		varhvt \
	    diff_type 		nnd \
	    diff_contact_type	nsc \
	    plus_diff_type	psd \
	    plus_contact_type	psc \
	    poly_type		poly \
	    poly_contact_type	pc \
	    sub_type		psub \
	    dev_sub_type	nwell \
	    diff_overlap_cont	0.06 \
	    dev_sub_dist	0.14 \
	    dev_sub_space	1.27 \
	    gate_to_diffcont	0.34 \
	    diff_extension	0.485 \
    ]
    set drawdict [dict merge $sky130::ruleset $newdict $parameters]
    return [sky130::mos_draw $drawdict]
}

#---------------------------------------------------------
# MOS varactor (5.0V)
# NOTE:  dev_sub_space set to 2.0 assuming different nets.
# Should have option for same-net with merged wells.
#---------------------------------------------------------

proc sky130::sky130_fd_pr__cap_var_draw {parameters} {
    set newdict [dict create \
	    gate_type		mvvar \
	    diff_type 		mvnsd \
	    diff_contact_type	mvnsc \
	    plus_diff_type	mvpsd \
	    plus_contact_type	mvpsc \
	    poly_type		poly \
	    poly_contact_type	pc \
	    sub_type		psub \
	    dev_sub_type	nwell \
	    sub_surround	0.38 \
	    sub_surround_dev	0.56 \
	    guard_sub_surround	0.18 \
	    diff_overlap_cont	0.06 \
	    dev_sub_dist	0.785 \
	    dev_sub_space	2.0 \
	    gate_to_diffcont	0.34 \
	    diff_extension	0.485 \
    ]
    set drawdict [dict merge $sky130::ruleset $newdict $parameters]
    return [sky130::mos_draw $drawdict]
}

#----------------------------------------------------------------
# 16V extended-drain devices LDNMOS and LDPMOS
#----------------------------------------------------------------

proc sky130::sky130_fd_pr__nfet_g5v0d16v0_draw {parameters} {
    set newdict [dict create \
	    gate_type		mvnfet \
	    diff_type 		mvndiff \
	    diff_contact_type	mvndc \
	    plus_diff_type	mvpsd \
	    plus_contact_type	mvpsc \
	    poly_type		poly \
	    poly_contact_type	pc \
	    sub_type		psub \
	    diff_spacing	0.31 \
	    diff_tap_space	0.38 \
	    diff_gate_space	0.38 \
	    drain_diff_surround 0.045 \
	    set_x_to_guard	1.665 \
	    set_y_to_guard	1.225 \
	    drain_proc		sky130::draw_ldnmos_drain \
    ]
    set drawdict [dict merge $sky130::ruleset $newdict $parameters]
    return [sky130::mos_draw $drawdict]
}

proc sky130::sky130_fd_pr__pfet_g5v0d16v0_draw {parameters} {
    set newdict [dict create \
	    gate_type		mvpfet \
	    diff_type 		mvpdiff \
	    diff_contact_type	mvpdc \
	    plus_diff_type	mvnsd \
	    plus_contact_type	mvnsc \
	    poly_type		poly \
	    poly_contact_type	pc \
	    sub_type		nwell \
	    id_type		nwell \
	    id_surround		0.035 \
	    guard_sub_surround	0.33 \
	    gate_to_polycont	0.32 \
	    diff_spacing	0.31 \
	    diff_tap_space	0.38 \
	    diff_gate_space	0.38 \
	    drain_diff_surround 0.045 \
	    set_x_to_guard	1.665 \
	    set_y_to_guard	1.180 \
	    drain_proc		sky130::draw_ldpmos_drain \
    ]
    set drawdict [dict merge $sky130::ruleset $newdict $parameters]
    return [sky130::mos_draw $drawdict]
}

#----------------------------------------------------------------
# MOSFET: Check device parameters for out-of-bounds values
#----------------------------------------------------------------

proc sky130::mos_check {device parameters} {

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
	dict set parameters diffcov $diffcov
    }
    if {[catch {expr abs($polycov)}]} {
	puts stderr "polycov must be numeric!"
	set polycov 100
	dict set parameters polycov $polycov
    }

    if {$l < $lmin} {
	puts stderr "Mos length must be >= $lmin um"
        dict set parameters l $lmin
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

    if {[catch {expr abs($viasrc)}]} {
	puts stderr "Source via coverage must be numeric!"
        dict set parameters viasrc 100
    } elseif {[expr abs($viasrc)] > 100} {
	puts stderr "Source via coverage can't be more than 100%"
        dict set parameters viasrc 100
    }
    if {[catch {expr abs($viadrn)}]} {
	puts stderr "Drain via coverage must be numeric!"
        dict set parameters viadrn 100
    } elseif {[expr abs($viadrn)] > 100} {
	puts stderr "Drain via coverage can't be more than 100%"
        dict set parameters viadrn 100
    }
    if {[catch {expr abs($viagate)}]} {
	puts stderr "Gate via coverage must be numeric!"
        dict set parameters viagate 100
    } elseif {[expr abs($viagate)] > 100} {
	puts stderr "Gate via coverage can't be more than 100%"
        dict set parameters viagate 100
    }
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

    # Values must satisfy diffusion-to-tap spacing of 15um.
    # Therefore the maximum of guard ring width or height cannot exceed 30um.
    # This requires detailed knowledge of the layout, so can only be estimated
    # here.  Since the estimate may be off, do not enforce the rule but just
    # generate a warning.

    # "clearance" is an estimation of the amount of space taken up by the
    # gate or source/drain contacts.
    set clearance 1.0

    set origm $m
    set orignf $nf
    while true {
       set yext [expr ($w + $clearance) * $m + $clearance]
       set xext [expr ($l + $clearance) * $nf + $clearance]
       if {[expr min($xext, $yext)] > 30.0} {
          if {$yext > 30.0 && $m > 1} {
	     incr m -1
	  } elseif {$xext > 30.0 && $nf > 1} {
	     incr nf -1
	  } elseif {$yext > 30.0} {
	     set w 29
	     puts -nonewline stderr "Transistor width must be < 29 um"
	     puts stderr " to avoid tap spacing violation."
	     dict set parameters w $w
	  } elseif {$xext > 30.0} {
	     set l 29
	     puts -nonewline stderr "Transistor length must be < 29 um"
	     puts stderr " to avoid tap spacing violation."
	     dict set parameters l $l
	  }
       } else {
	  break
       }
    }
    if {$m != $origm} {
       puts stderr "Warning: M may need to be reduced to prevent tap distance violation"
       # dict set parameters m $m
    }
    if {$nf != $orignf} {
       puts stderr "Warning: Fingers may need to be reduced to prevent tap distance violation"
       # dict set parameters nf $nf
    }

    # Used by varactor only
    if {$device == "sky130_fd_pr__cap_var"} {
        catch {set magic::minfo_val "Warning:  No model exists for this device!"}
    } else {
        catch {set magic::minfo_val ""}
    }

    return $parameters
}

#----------------------------------------------------------------

proc sky130::sky130_fd_pr__nfet_01v8_check {parameters} {
   return [sky130::mos_check sky130_fd_pr__nfet_01v8 $parameters]
}

proc sky130::sky130_fd_pr__nfet_01v8_lvt_check {parameters} {
   return [sky130::mos_check sky130_fd_pr__nfet_01v8_lvt $parameters]
}

proc sky130::sky130_fd_bs_flash__special_sonosfet_star_check {parameters} {
   return [sky130::mos_check sky130_fd_bs_flash__special_sonosfet_star $parameters]
}

proc sky130::sky130_fd_pr__nfet_g5v0d10v5_check {parameters} {
   return [sky130::mos_check sky130_fd_pr__nfet_g5v0d10v5 $parameters]
}

proc sky130::sky130_fd_pr__nfet_g5v0d16v0_check {parameters} {
   return [sky130::mos_check sky130_fd_pr__nfet_g5v0d16v0 $parameters]
}

proc sky130::sky130_fd_pr__nfet_05v0_nvt_check {parameters} {
   return [sky130::mos_check sky130_fd_pr__nfet_05v0_nvt $parameters]
}

proc sky130::sky130_fd_pr__nfet_03v3_nvt_check {parameters} {
   return [sky130::mos_check sky130_fd_pr__nfet_03v3_nvt $parameters]
}

proc sky130::sky130_fd_pr__pfet_01v8_check {parameters} {
   return [sky130::mos_check sky130_fd_pr__pfet_01v8 $parameters]
}

proc sky130::sky130_fd_pr__pfet_01v8_lvt_check {parameters} {
   return [sky130::mos_check sky130_fd_pr__pfet_01v8_lvt $parameters]
}

proc sky130::sky130_fd_pr__pfet_01v8_hvt_check {parameters} {
   return [sky130::mos_check sky130_fd_pr__pfet_01v8_hvt $parameters]
}

proc sky130::sky130_fd_pr__pfet_g5v0d10v5_check {parameters} {
   return [sky130::mos_check sky130_fd_pr__pfet_g5v0d10v5 $parameters]
}

proc sky130::sky130_fd_pr__pfet_g5v0d16v0_check {parameters} {
   return [sky130::mos_check sky130_fd_pr__pfet_g5v0d16v0 $parameters]
}

proc sky130::sky130_fd_pr__cap_var_lvt_check {parameters} {
   return [sky130::mos_check sky130_fd_pr__cap_var_lvt $parameters]
}

proc sky130::sky130_fd_pr__cap_var_hvt_check {parameters} {
   return [sky130::mos_check sky130_fd_pr__cap_var_hvt $parameters]
}

proc sky130::sky130_fd_pr__cap_var_check {parameters} {
   return [sky130::mos_check sky130_fd_pr__cap_var $parameters]
}
