###
###     Source file gf013.tcl
###     Process this file with the preprocessor script
###
#-----------------------------------------------------
# Magic/TCL design kit for GF TECHNAME
#-----------------------------------------------------
# Tim Edwards
# Revision 0	4/25/2022
#-----------------------------------------------------

if {[catch {set TECHPATH $env(PDK_ROOT)}]} {
    set TECHPATH STAGING_PATH
}
if [catch {set PDKPATH}] {set PDKPATH ${TECHPATH}/TECHNAME}
set PDKNAME TECHNAME
# "gf180mcu" is the namespace used for all devices
set PDKNAMESPACE gf180mcu
puts stdout "Loading TECHNAME Device Generator Menu ..."

# Initialize toolkit menus to the wrapper window

global Opts
namespace eval gf180mcu {}

# Set the window callback
if [catch {set Opts(callback)}] {set Opts(callback) ""}
set Opts(callback) [subst {gf180mcu::addtechmenu \$framename; $Opts(callback)}]

# if {![info exists Opts(cmdentry)]} {set Opts(cmdentry) 1}

# Set options specific to this PDK
set Opts(hidelocked) 1
set Opts(hidespecial) 0

# Wrap the closewrapper procedure so that closing the last
# window is equivalent to quitting.
if {[info commands closewrapper] == "closewrapper"} {
   rename closewrapper closewrapperonly
   proc closewrapper { framename } {
      if {[llength [windownames all]] <= 1} {
         magic::quit
      } else {
         closewrapperonly $framename
      }
   }
}

# Remove maze router layers from the toolbar by locking them
catch {tech lock fence,magnet,rotate}

namespace eval gf180mcu {
    namespace path {::tcl::mathop ::tcl::mathfunc}

    set ruleset [dict create]

    # Process DRC rules (magic style)

    dict set ruleset poly_surround    0.065     ;# Poly surrounds contact
    dict set ruleset diff_surround    0.065     ;# Diffusion surrounds contact
    dict set ruleset gate_to_diffcont 0.26      ;# Gate to diffusion contact center
    dict set ruleset gate_to_polycont 0.28      ;# Gate to poly contact center
    dict set ruleset gate_extension   0.22      ;# Poly extension beyond gate
    dict set ruleset diff_extension   0.23      ;# Diffusion extension beyond gate
    dict set ruleset contact_size     0.23      ;# Minimum contact size
    dict set ruleset via_size         0.26      ;# Minimum via size
    dict set ruleset metal_surround   0.055     ;# Metal1 overlaps contact
    dict set ruleset sub_surround     0.12      ;# Sub/well surrounds diffusion
    dict set ruleset diff_spacing     0.33      ;# Diffusion spacing rule
    dict set ruleset poly_spacing     0.24      ;# Poly spacing rule
    dict set ruleset diffres_spacing  0.40      ;# Diffusion resistor spacing rule
    dict set ruleset polyres_spacing  0.40      ;# Poly resistor spacing rule
    dict set ruleset diff_poly_space  0.10      ;# Diffusion to poly spacing rule
    dict set ruleset diff_gate_space  0.11      ;# Diffusion to gate poly spacing rule
    dict set ruleset metal_spacing    0.23      ;# Metal1 spacing rule
    dict set ruleset mmetal_spacing   0.38      ;# Metal spacing rule (above metal1)
    dict set ruleset sblk_to_cont     0.33      ;# resistor to contact center
    dict set ruleset sblk_diff_space  0.44      ;# resistor to guard ring
    dict set ruleset sblk_diff_space  0.60      ;# resistor to guard ring
}

#-----------------------------------------------------
# magic::addtechmenu
#-----------------------------------------------------

proc gf180mcu::addtechmenu {framename} {
   global Winopts Opts
   
   # Check for difference between magic 8.1.125 and earlier, and 8.1.126 and later
   if {[catch {${framename}.titlebar cget -height}]} {
      set layoutframe ${framename}.pane.top
   } else {
      set layoutframe ${framename}
   }

   # List of devices is long.  Divide into two sections for active and passive deivces
   magic::add_toolkit_menu $layoutframe "Devices 1" pdk1

   magic::add_toolkit_command $layoutframe "nmos - nMOSFET" "magic::gencell gf180mcu::nfet_03v3" pdk1
   magic::add_toolkit_command $layoutframe "pmos - pMOSFET" "magic::gencell gf180mcu::pfet_03v3" pdk1

# (NOT ADDED YET---DRAW ROUTINE IS INCOMPLETE)
#   magic::add_toolkit_separator	$layoutframe pdk1
#   magic::add_toolkit_command $layoutframe "nfet_dss - mosfet (unsalicided drain)" "magic::gencell gf180mcu::nfet_03v3_dss" pdk1
#   magic::add_toolkit_command $layoutframe "pfet_dss - mosfet (unsalicided drain)" "magic::gencell gf180mcu::pfet_03v3_dss" pdk1

# (NOT ADDED YET---DRAW ROUTINE IS INCOMPLETE)
# magic::add_toolkit_separator	$layoutframe pdk1
#   magic::add_toolkit_command $layoutframe "ldnmos - nMOSFET" "magic::gencell gf180mcu::nfet_10v0_asym" pdk1
#   magic::add_toolkit_command $layoutframe "ldpmos - nMOSFET" "magic::gencell gf180mcu::pfet_10v0_asym" pdk1

   magic::add_toolkit_separator	$layoutframe pdk1
   magic::add_toolkit_command $layoutframe "diode_nd2ps_03v3 - n-diode" "magic::gencell gf180mcu::diode_nd2ps_03v3" pdk1
   magic::add_toolkit_command $layoutframe "diode_pd2nw_03v3 - p-diode" "magic::gencell gf180mcu::diode_pd2nw_03v3" pdk1

   magic::add_toolkit_separator	$layoutframe pdk1
   magic::add_toolkit_command $layoutframe "npn_10p00x10p00  (3.3V) - 10.0um x 10.0um " "magic::gencell gf180mcu::npn_10p00x10p00" pdk1
   magic::add_toolkit_command $layoutframe "npn_05p00x05p00  (3.3V) - 5.0um x 5.0um " "magic::gencell gf180mcu::npn_05p00x05p00" pdk1
   magic::add_toolkit_command $layoutframe "npn_10p00x10p00  (3.3V) - 10.0um x 10.0um " "magic::gencell gf180mcu::npn_00p54x04p00" pdk1
   magic::add_toolkit_command $layoutframe "npn_00p54x10p00  (3.3V) - 0.54um x 10.0um " "magic::gencell gf180mcu::npn_00p54x10p00" pdk1
   magic::add_toolkit_command $layoutframe "npn_00p54x08p00  (3.3V) - 0.54um x 8.0um " "magic::gencell gf180mcu::npn_00p54x08p00" pdk1
   magic::add_toolkit_command $layoutframe "npn_00p54x02p00  (3.3V) - 0.54um x 2.0um " "magic::gencell gf180mcu::npn_00p54x02p00" pdk1
   magic::add_toolkit_command $layoutframe "pnp_10p00x10p00  (3.3V) - 10.0um x 10.0um " "magic::gencell gf180mcu::pnp_10p00x10p00" pdk1
   magic::add_toolkit_command $layoutframe "pnp_05p00x05p00  (3.3V) - 5.0um x 5.0um " "magic::gencell gf180mcu::pnp_05p00x05p00" pdk1
   magic::add_toolkit_command $layoutframe "pnp_10p00x00p42  (3.3V) - 10.0um x 0.42um " "magic::gencell gf180mcu::pnp_10p00x00p42" pdk1
   magic::add_toolkit_command $layoutframe "pnp_05p00x00p42  (3.3V) - 5.0um x 0.42um " "magic::gencell gf180mcu::pnp_05p00x00p42" pdk1
   magic::add_toolkit_command $layoutframe "eFuse" "magic::gencell gf180mcu::eFuse" pdk1

   magic::add_toolkit_separator	$layoutframe pdk1
   magic::add_toolkit_command $layoutframe "nMOS capacitor" "magic::gencell gf180mcu::nmoscap_3p3" pdk1
   magic::add_toolkit_command $layoutframe "pMOS capacitor" "magic::gencell gf180mcu::pmoscap_3p3" pdk1
   magic::add_toolkit_command $layoutframe "nMOS varactor" "magic::gencell gf180mcu::nvaractor_3p3" pdk1
   magic::add_toolkit_command $layoutframe "pMOS varactor" "magic::gencell gf180mcu::pvaractor_3p3" pdk1

   magic::add_toolkit_menu $layoutframe "Devices 2" pdk2

   magic::add_toolkit_command $layoutframe "ppolyf_s        - 7 Ohm/sq " "magic::gencell gf180mcu::ppolyf_s" pdk2 
   magic::add_toolkit_command $layoutframe "npolyf_s        - 7 Ohm/sq " "magic::gencell gf180mcu::ppolyf_s" pdk2 
   magic::add_toolkit_command $layoutframe "nplus_u   (3.3V) -  85 Ohm/sq " "magic::gencell gf180mcu::nplus_u" pdk2
   magic::add_toolkit_command $layoutframe "pplus_u   (3.3V) - 128 Ohm/sq " "magic::gencell gf180mcu::pplus_u" pdk2
   magic::add_toolkit_command $layoutframe "nplus_u  (6.0V) -  85 Ohm/sq " "magic::gencell gf180mcu::nplus_u_6p0" pdk2
   magic::add_toolkit_command $layoutframe "pplus_u  (6.0V) - 128 Ohm/sq " "magic::gencell gf180mcu::pplus_u_6p0" pdk2

   magic::add_toolkit_command $layoutframe "npolyf_u -  300 Ohm/sq " "magic::gencell gf180mcu::npolyf_u" pdk2
   magic::add_toolkit_command $layoutframe "ppolyf_u - 315 Ohm/sq " "magic::gencell gf180mcu::ppolyf_u" pdk2
#ifdef HRPOLY1K
   magic::add_toolkit_command $layoutframe "ppolyf_u_1k - 1.0k Ohm/sq " "magic::gencell gf180mcu::ppolyf_u_1k" pdk2
#endif (HRPOLY1K)
   magic::add_toolkit_command $layoutframe "nwell  (3.3V) -1680 Ohm/sq " "magic::gencell gf180mcu::nwell_3p3" pdk2
   magic::add_toolkit_separator	$layoutframe pdk2

   magic::add_toolkit_command $layoutframe "rm1 - 90  mOhm/sq " "magic::gencell gf180mcu::rm1" pdk2
   magic::add_toolkit_command $layoutframe "rm2 - 90  mOhm/sq " "magic::gencell gf180mcu::rm2" pdk2

#ifdef METALS3
#ifdef THICKMET3P0
   magic::add_toolkit_command $layoutframe "rm3 - 9.5  mOhm/sq " "magic::gencell gf180mcu::rm3" pdk2
#elseif (THICKMET1P1 || THICKMET0P9)
   magic::add_toolkit_command $layoutframe "rm3 - 40  mOhm/sq " "magic::gencell gf180mcu::rm3" pdk2
#else (!(THICKMET3P0 || THICKMET1P1 || THICKMET0P9))
   magic::add_toolkit_command $layoutframe "rm3 - 60  mOhm/sq " "magic::gencell gf180mcu::rm3" pdk2
#endif (!(THICKMET3P0 || THICKMET1P1 || THICKMET0P9))
#endif (METALS3)
#ifdef METALS4 || METALS5 || METALS6
   magic::add_toolkit_command $layoutframe "rm3 - 90  mOhm/sq " "magic::gencell gf180mcu::rm3" pdk2
#endif (METALS4 || METALS5 || METALS6)

#ifdef METALS4
#ifdef THICKMET3P0
   magic::add_toolkit_command $layoutframe "rm4 - 9.5  mOhm/sq " "magic::gencell gf180mcu::rm4" pdk2
#elseif (THICKMET1P1 || THICKMET0P9)
   magic::add_toolkit_command $layoutframe "rm4 - 40  mOhm/sq " "magic::gencell gf180mcu::rm4" pdk2
#else (!(THICKMET3P0 || THICKMET1P1 || THICKMET0P9))
   magic::add_toolkit_command $layoutframe "rm4 - 60  mOhm/sq " "magic::gencell gf180mcu::rm4" pdk2
#endif (!(THICKMET3P0 || THICKMET1P1 || THICKMET0P9))
#endif (METALS4)
#ifdef METALS5 || METALS6
   magic::add_toolkit_command $layoutframe "rm4 - 90  mOhm/sq " "magic::gencell gf180mcu::rm4" pdk2
#endif (METALS5 || METALS6)

#ifdef METALS5
#ifdef THICKMET3P0
   magic::add_toolkit_command $layoutframe "rm5 - 9.5  mOhm/sq " "magic::gencell gf180mcu::rm5" pdk2
#elseif (THICKMET1P1 || THICKMET0P9)
   magic::add_toolkit_command $layoutframe "rm5 - 40  mOhm/sq " "magic::gencell gf180mcu::rm5" pdk2
#else (!(THICKMET3P0 || THICKMET1P1 || THICKMET0P9))
   magic::add_toolkit_command $layoutframe "rm5 - 60  mOhm/sq " "magic::gencell gf180mcu::rm5" pdk2
#endif (!(THICKMET3P0 || THICKMET1P1 || THICKMET0P9))
#endif (METALS3)
#ifdef METALS6
   magic::add_toolkit_command $layoutframe "rm5 - 90  mOhm/sq " "magic::gencell gf180mcu::rm5" pdk2
#endif (METALS5)
#ifdef METALS6
#ifdef THICKMET3P0
   magic::add_toolkit_command $layoutframe "rmtp - 9.5  mOhm/sq " "magic::gencell gf180mcu::rmtp" pdk2
#elseif (THICKMET1P1 || THICKMET0P9)
   magic::add_toolkit_command $layoutframe "rmtp - 40  mOhm/sq " "magic::gencell gf180mcu::rmtp" pdk2
#else (!(THICKMET3P0 || THICKMET1P1 || THICKMET0P9))
   magic::add_toolkit_command $layoutframe "rmtp - 60  mOhm/sq " "magic::gencell gf180mcu::rmtp" pdk2
#endif (!(THICKMET3P0 || THICKMET1P1 || THICKMET0P9))
#endif (METALS6)

   magic::add_toolkit_separator	$layoutframe pdk2

#ifdef MIM
   magic::add_toolkit_command $layoutframe "cap_mim_2p0fF - MiM cap " "magic::gencell gf180mcu::cap_mim_2p0fF" pdk2
#endif (MIM)
   magic::add_toolkit_separator	$layoutframe pdk2

   magic::add_toolkit_command $layoutframe "substrate contact (3.3V) " "gf180mcu::subcon_3p3_draw" pdk2
   magic::add_toolkit_command $layoutframe "substrate contact (6.0V) " "gf180mcu::subcon_6p0_draw" pdk2
   magic::add_toolkit_command $layoutframe "via1              " "gf180mcu::via1_draw" pdk2
#ifdef METALS3 || METALS4 || METALS5 || METALS6
   magic::add_toolkit_command $layoutframe "via2              " "gf180mcu::via2_draw" pdk2
#endif (METALS3 || METALS4 || METALS5 || METALS6)
#ifdef METALS4 || METALS5 || METALS6
   magic::add_toolkit_command $layoutframe "via3              " "gf180mcu::via3_draw" pdk2
#endif (METALS4 || METALS5 || METALS6)
#ifdef METALS5 || METALS6
   magic::add_toolkit_command $layoutframe "via4              " "gf180mcu::via4_draw" pdk2
#endif (METALS5 || METALS6)
#ifdef METALS6
   magic::add_toolkit_command $layoutframe "viatp             " "gf180mcu::viatp_draw" pdk2
#endif (METALS6)

   ${layoutframe}.titlebar.mbuttons.drc.toolmenu add command -label "DRC Routing" -command {drc style drc(routing)}

   # Add SPICE import function to File menu
   ${layoutframe}.titlebar.mbuttons.file.toolmenu insert 4 command -label "Import SPICE" -command {gf180mcu::importspice}
   ${layoutframe}.titlebar.mbuttons.file.toolmenu insert 4 separator

   # Add command entry window by default if enabled
   if {[info exists Opts(cmdentry)]} {
      set Winopts(${framename},cmdentry) $Opts(cmdentry)
   } else {
      set Winopts(${framename},cmdentry) 0
   }
   if {$Winopts(${framename},cmdentry) == 1} {
      addcommandentry $framename
   }
}

#----------------------------------------------------------------
# Source the various files for the device generator
#----------------------------------------------------------------

set script_file [info script]
set script_path [file dirname $script_file]
source ${script_path}/TECHNAME-util.tcl	;# basic utility functions
source ${script_path}/TECHNAME-misc.tcl	;# substrate taps
source ${script_path}/TECHNAME-via.tcl	;# via stacks
source ${script_path}/TECHNAME-fet.tcl	;# MOSFETs, MOS capacitors, varactors
source ${script_path}/TECHNAME-cap.tcl	;# Capacitors
source ${script_path}/TECHNAME-res.tcl	;# Resistors
source ${script_path}/TECHNAME-dio.tcl	;# Diodes
source ${script_path}/TECHNAME-bjt.tcl	;# Bipolar transistors and eFuse

