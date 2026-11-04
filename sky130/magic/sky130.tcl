###
###     Source file sky130.tcl
###     Process this file with the preprocessor script
###
#-----------------------------------------------------
# Magic/TCL design kit for SKYWATER TECHNAME
#-----------------------------------------------------
# Tim Edwards
# Revision 1	ALPHA   9/10/2020
#-----------------------------------------------------

if {[catch {set TECHPATH $env(PDK_ROOT)}]} {
    set TECHPATH STAGING_PATH
}
if [catch {set PDKPATH}] {set PDKPATH ${TECHPATH}/TECHNAME}
set PDKNAME TECHNAME
# "sky130" is the namespace used for all devices
set PDKNAMESPACE sky130
puts stdout "Loading TECHNAME Device Generator Menu ..."

# Initialize toolkit menus to the wrapper window

global Opts
namespace eval sky130 {}

# Set the window callback
if [catch {set Opts(callback)}] {set Opts(callback) ""}
set Opts(callback) [subst {sky130::addtechmenu \$framename; $Opts(callback)}]

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

namespace eval sky130 {
    namespace path {::tcl::mathop ::tcl::mathfunc}

    set ruleset [dict create]

    # Process DRC rules (magic style)

    dict set ruleset poly_surround    0.08      ;# Poly surrounds contact
    dict set ruleset diff_surround    0.06      ;# Diffusion surrounds contact
    dict set ruleset gate_to_diffcont 0.145     ;# Gate to diffusion contact center
    dict set ruleset gate_to_polycont 0.275     ;# Gate to poly contact center
    dict set ruleset gate_extension   0.13      ;# Poly extension beyond gate
    dict set ruleset diff_extension   0.29      ;# Diffusion extension beyond gate
    dict set ruleset contact_size     0.17      ;# Minimum contact size
    dict set ruleset via_size         0.17      ;# Minimum via size
    dict set ruleset metal_surround   0.08      ;# Local interconnect overlaps contact
    dict set ruleset sub_surround     0.18      ;# Sub/well surrounds diffusion
    dict set ruleset diff_spacing     0.28      ;# Diffusion spacing rule
    dict set ruleset poly_spacing     0.21      ;# Poly spacing rule
    dict set ruleset diff_poly_space  0.075     ;# Diffusion to poly spacing rule
    dict set ruleset diff_gate_space  0.20      ;# Diffusion to gate poly spacing rule
    dict set ruleset metal_spacing    0.23      ;# Local interconnect spacing rule
    dict set ruleset mmetal_spacing   0.14      ;# Metal spacing rule (above local interconnect)
    dict set ruleset res_to_cont      0.20      ;# resistor to contact center
    dict set ruleset res_diff_spacing 0.20      ;# resistor to guard ring
}

#-----------------------------------------------------
# magic::addtechmenu
#-----------------------------------------------------

proc sky130::addtechmenu {framename} {
   global Winopts Opts
   
   # Check for difference between magic 8.1.125 and earlier, and 8.1.126 and later
   if {[catch {${framename}.titlebar cget -height}]} {
      set layoutframe ${framename}.pane.top
   } else {
      set layoutframe ${framename}
   }

   # List of devices is long.  Divide into two sections for active and passive deivces
   magic::add_toolkit_menu $layoutframe "Devices 1" pdk1

   magic::add_toolkit_command $layoutframe "nmos (MOSFET)" \
	    "magic::gencell sky130::sky130_fd_pr__nfet_01v8" pdk1
   magic::add_toolkit_command $layoutframe "pmos (MOSFET)" \
	    "magic::gencell sky130::sky130_fd_pr__pfet_01v8" pdk1

   magic::add_toolkit_separator	$layoutframe pdk1
   magic::add_toolkit_command $layoutframe "LDNMOS (extended drain)" \
   	    "magic::gencell sky130::sky130_fd_pr__nfet_g5v0d16v0" pdk1
   magic::add_toolkit_command $layoutframe "LDPMOS (extended drain)" \
   	    "magic::gencell sky130::sky130_fd_pr__pfet_g5v0d16v0" pdk1

   magic::add_toolkit_separator	$layoutframe pdk1
   magic::add_toolkit_command $layoutframe "n-diode" \
	    "magic::gencell sky130::sky130_fd_pr__diode_pw2nd_05v5" pdk1
   magic::add_toolkit_command $layoutframe "p-diode" \
	    "magic::gencell sky130::sky130_fd_pr__diode_pd2nw_05v5" pdk1
   magic::add_toolkit_command $layoutframe "photodiode" \
	    "magic::gencell sky130::sky130_fd_pr__photodiode" pdk1

   magic::add_toolkit_separator	$layoutframe pdk1
   magic::add_toolkit_command $layoutframe "MOS varactor" \
	    "magic::gencell sky130::sky130_fd_pr__cap_var_lvt" pdk1
   magic::add_toolkit_separator	$layoutframe pdk1

   magic::add_toolkit_command $layoutframe "NPN 1.0 x 1.0" \
	    "magic::gencell sky130::sky130_fd_pr__npn_05v5_W1p00L1p00" pdk1
   magic::add_toolkit_command $layoutframe "NPN 1.0 x 2.0" \
	    "magic::gencell sky130::sky130_fd_pr__npn_05v5_W1p00L2p00" pdk1
   magic::add_toolkit_command $layoutframe "PNP 0.68 x 0.68" \
	    "magic::gencell sky130::sky130_fd_pr__pnp_05v5_W0p68L0p68" pdk1
   magic::add_toolkit_command $layoutframe "PNP 3.4 x 3.4" \
	    "magic::gencell sky130::sky130_fd_pr__pnp_05v5_W3p40L3p40" pdk1
   magic::add_toolkit_command $layoutframe "NPN 11V 1.0 x 1.0" \
	    "magic::gencell sky130::sky130_fd_pr__npn_11v0_W1p00L1p00" pdk1

   magic::add_toolkit_separator	$layoutframe pdk1

   magic::add_toolkit_command $layoutframe "inductor 1" \
	    "magic::gencell sky130::sky130_fd_pr__rf_test_coil1" pdk1
   magic::add_toolkit_command $layoutframe "inductor 2" \
	    "magic::gencell sky130::sky130_fd_pr__rf_test_coil2" pdk1
   magic::add_toolkit_command $layoutframe "inductor 3" \
	    "magic::gencell sky130::sky130_fd_pr__rf_test_coil3" pdk1

   magic::add_toolkit_separator	$layoutframe pdk1

   magic::add_toolkit_command $layoutframe "substrate contact (1.8V)" \
	    "sky130::subconn_draw" pdk1
   magic::add_toolkit_command $layoutframe "substrate guard ring (1.8V)" \
	    "sky130::subconn_guard_draw" pdk1
   magic::add_toolkit_command $layoutframe "substrate contact (5.0V)" \
	    "sky130::mvsubconn_draw" pdk1
   magic::add_toolkit_command $layoutframe "substrate guard ring (5.0V)" \
	    "sky130::mvsubconn_guard_draw" pdk1
   magic::add_toolkit_command $layoutframe "deep n-well region (1.8V)" \
	    "sky130::deep_nwell_draw" pdk1
   magic::add_toolkit_command $layoutframe "deep n-well region (5.0V)" \
	    "sky130::mvdeep_nwell_draw" pdk1
   magic::add_toolkit_command $layoutframe "n-well region with guard ring (1.8V)" \
	    "sky130::nwell_draw" pdk1
   magic::add_toolkit_command $layoutframe "n-well region with guard ring (5.0V)" \
	    "sky130::mvnwell_draw" pdk1
   magic::add_toolkit_command $layoutframe "mcon" \
	    "sky130::mcon_draw" pdk1
   magic::add_toolkit_command $layoutframe "via1" \
	    "sky130::via1_draw" pdk1
   magic::add_toolkit_command $layoutframe "via2" \
	    "sky130::via2_draw" pdk1
#ifdef METAL5
   magic::add_toolkit_command $layoutframe "via3" \
	    "sky130::via3_draw" pdk1
   magic::add_toolkit_command $layoutframe "via4" \
	    "sky130::via4_draw" pdk1
#endif (METAL5)
   

   magic::add_toolkit_menu $layoutframe "Devices 2" pdk2

   magic::add_toolkit_command $layoutframe "n-diff resistor (1.8V) - 120 Ohm/sq" \
	    "magic::gencell sky130::sky130_fd_pr__res_generic_nd" pdk2
   magic::add_toolkit_command $layoutframe "p-diff resistor (1.8V) - 197 Ohm/sq" \
	    "magic::gencell sky130::sky130_fd_pr__res_generic_pd" pdk2
   magic::add_toolkit_command $layoutframe "n-diff resistor (5.0V) - 114 Ohm/sq" \
	    "magic::gencell sky130::sky130_fd_pr__res_generic_nd__hv" pdk2
   magic::add_toolkit_command $layoutframe "p-diff resistor (5.0V) - 191 Ohm/sq" \
	    "magic::gencell sky130::sky130_fd_pr__res_generic_pd__hv" pdk2

   magic::add_toolkit_command $layoutframe "poly resistor - 48.2 Ohm/sq" \
	    "magic::gencell sky130::sky130_fd_pr__res_generic_po" pdk2
   magic::add_toolkit_command $layoutframe "poly resistor - 319.8 Ohm/sq" \
	    "magic::gencell sky130::sky130_fd_pr__res_high_po_0p35" pdk2
   magic::add_toolkit_command $layoutframe "poly resistor - 2000 Ohm/sq" \
	    "magic::gencell sky130::sky130_fd_pr__res_xhigh_po_0p35" pdk2
   magic::add_toolkit_command $layoutframe "p-well resistor - 3050 Ohm/sq" \
	    "magic::gencell sky130::sky130_fd_pr__res_iso_pw" pdk2
   magic::add_toolkit_separator	$layoutframe pdk2

   magic::add_toolkit_command $layoutframe "l1 metal resistor - 12.2 Ohm/sq" \
	    "magic::gencell sky130::sky130_fd_pr__res_generic_l1" pdk2
   magic::add_toolkit_command $layoutframe "m1 metal resistor - 125 mOhm/sq" \
	    "magic::gencell sky130::sky130_fd_pr__res_generic_m1" pdk2
   magic::add_toolkit_command $layoutframe "m2 metal resistor - 125 mOhm/sq" \
	    "magic::gencell sky130::sky130_fd_pr__res_generic_m2" pdk2
   magic::add_toolkit_command $layoutframe "m3 metal resistor - 47 mOhm/sq" \
	    "magic::gencell sky130::sky130_fd_pr__res_generic_m3" pdk2
#ifdef METAL5
   magic::add_toolkit_command $layoutframe "m4 metal resistor - 47 mOhm/sq" \
	    "magic::gencell sky130::sky130_fd_pr__res_generic_m4" pdk2
   magic::add_toolkit_command $layoutframe "m5 metal resistor - 29 mOhm/sq" \
	    "magic::gencell sky130::sky130_fd_pr__res_generic_m5" pdk2
#endif (METAL5)

#ifdef MIM
   magic::add_toolkit_command $layoutframe "MiM cap - 2fF/um^2 (metal3)" \
	    "magic::gencell sky130::sky130_fd_pr__cap_mim_m3_1" pdk2
   magic::add_toolkit_command $layoutframe "MiM cap - 2fF/um^2 (metal4)" \
	    "magic::gencell sky130::sky130_fd_pr__cap_mim_m3_2" pdk2
#endif (MIM)
   magic::add_toolkit_separator	$layoutframe pdk2

   magic::add_toolkit_command $layoutframe "vpp 11.5x11.7 m1-m4, li/m5 shield" \
	    "magic::gencell sky130::sky130_fd_pr__cap_vpp_11p5x11p7_m1m2m3m4_shieldl1m5" pdk2
   magic::add_toolkit_command $layoutframe "vpp 11.5x11.7 m1-m2" \
	    "magic::gencell sky130::sky130_fd_pr__cap_vpp_11p5x11p7_m1m2_noshield" pdk2
   magic::add_toolkit_command $layoutframe "vpp 8.6x7.8 m1-m2 l1 shield" \
	    "magic::gencell sky130::sky130_fd_pr__cap_vpp_08p6x07p8_m1m2_shieldl1" pdk2
   magic::add_toolkit_command $layoutframe "vpp 4.4x4.6 m1-m2 l1 shield" \
	    "magic::gencell sky130::sky130_fd_pr__cap_vpp_04p4x04p6_m1m2_shieldl1" pdk2

   # Additional DRC style for routing only---add this to the DRC menu
   ${layoutframe}.titlebar.mbuttons.drc.toolmenu add command -label "DRC Routing" -command {drc style drc(routing)}

   # Add SPICE import function to File menu
   ${layoutframe}.titlebar.mbuttons.file.toolmenu insert 4 command -label "Import SPICE" -command {sky130::importspice}
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
source ${script_path}/TECHNAME-misc.tcl	;# substrate taps, guard rings, wells
source ${script_path}/TECHNAME-via.tcl	;# via stacks
source ${script_path}/TECHNAME-fet.tcl	;# MOSFETs and varactors
source ${script_path}/TECHNAME-cap.tcl	;# Capacitors
source ${script_path}/TECHNAME-res.tcl	;# Resistors
source ${script_path}/TECHNAME-dio.tcl	;# Diodes
source ${script_path}/TECHNAME-fix.tcl	;# Fixed-layout devices

