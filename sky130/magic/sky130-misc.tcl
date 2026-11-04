###
###     Source file sky130-misc.tcl
###     Process this file with the preprocessor script
###
#-----------------------------------------------------
# Magic/TCL design kit for SKYWATER TECHNAME:  substrate taps, guard rings, wells
#-----------------------------------------------------

proc sky130::subconn_draw {} {
   set w [magic::i2u [box width]]
   set h [magic::i2u [box height]]
   if {$w < 0.17} {
      puts stderr "Substrate tap width must be at least 0.17um"
      return
   }
   if {$h < 0.17} {
      puts stderr "Substrate tap height must be at least 0.17um"
      return
   }
   suspendall
   paint psc
   pushbox
   if {$w > $h} {
      box grow e 0.08um
      box grow w 0.08um
      paint li
      box grow e 0.04um
      box grow w 0.04um
   } else {
      box grow n 0.08um
      box grow s 0.08um
      paint li
      box grow n 0.04um
      box grow s 0.04um
   }
   paint psd
   popbox
   resumeall
}

#----------------------------------------------------------------

proc sky130::mvsubconn_draw {} {
   set w [magic::i2u [box width]]
   set h [magic::i2u [box height]]
   if {$w < 0.17} {
      puts stderr "Substrate tap width must be at least 0.17um"
      return
   }
   if {$h < 0.17} {
      puts stderr "Substrate tap height must be at least 0.17um"
      return
   }
   suspendall
   paint mvpsc
   pushbox
   if {$w > $h} {
      box grow e 0.08um
      box grow w 0.08um
      paint li
      box grow e 0.04um
      box grow w 0.04um
   } else {
      box grow n 0.08um
      box grow s 0.08um
      paint li
      box grow n 0.04um
      box grow s 0.04um
   }
   paint mvpsd
   popbox
   resumeall
}

#----------------------------------------------------------------
# Helper function for drawing guard rings.
# Assumes that a box exists and defines the centerlines of the
# guard ring contacts.
# ctype = type to paint for contact
# dtype = type to paint for diffusion
#----------------------------------------------------------------

proc sky130::guard_ring_draw {ctype dtype} {
   pushbox
   box width 0
   box grow c 0.085um
   paint li
   pushbox
   box grow n -0.3um
   box grow s -0.3um
   paint $ctype
   popbox
   paint $dtype
   popbox

   pushbox
   box height 0
   box grow c 0.085um
   paint li
   pushbox
   box grow e -0.3um
   box grow w -0.3um
   paint $ctype
   popbox
   paint $dtype
   popbox

   pushbox
   box move n [box height]i
   box height 0
   box grow c 0.085um
   paint li
   pushbox
   box grow e -0.3um
   box grow w -0.3um
   paint $ctype
   popbox
   paint $dtype
   popbox

   pushbox
   box move e [box width]i
   box width 0
   box grow c 0.085um
   paint li
   pushbox
   box grow n -0.3um
   box grow s -0.3um
   paint $ctype
   popbox
   paint $dtype
   popbox
}

#----------------------------------------------------------------

proc sky130::subconn_guard_draw {} {
   set w [magic::i2u [box width]]
   set h [magic::i2u [box height]]
   # NOTE:  Width and height are determined by the requirement for
   # a contact on each side.  There is not much that can be done
   # with an guarded nwell smaller than that, anyway.
   if {$w < 0.6} {
      puts stderr "Substrate guard ring width must be at least 0.6um"
      return
   }
   if {$h < 0.6} {
      puts stderr "Substrate guard ring height must be at least 0.6um"
      return
   }
   suspendall
   tech unlock *
   pushbox

   sky130::guard_ring_draw psc psd

   popbox
   tech revert
   resumeall
}

#----------------------------------------------------------------

proc sky130::mvsubconn_guard_draw {} {
   set w [magic::i2u [box width]]
   set h [magic::i2u [box height]]
   # NOTE:  Width and height are determined by the requirement for
   # a contact on each side.  There is not much that can be done
   # with an guarded nwell smaller than that, anyway.
   if {$w < 0.6} {
      puts stderr "Substrate guard ring width must be at least 0.6um"
      return
   }
   if {$h < 0.6} {
      puts stderr "Substrate guard ring height must be at least 0.6um"
      return
   }
   suspendall
   tech unlock *
   pushbox

   sky130::guard_ring_draw mvpsc mvpsd

   popbox
   tech revert
   resumeall
}

#----------------------------------------------------------------

proc sky130::nwell_draw {} {
   set w [magic::i2u [box width]]
   set h [magic::i2u [box height]]
   # NOTE:  Width and height are determined by the requirement for
   # a contact on each side.  There is not much that can be done
   # with an guarded nwell smaller than that, anyway.
   if {$w < 0.6} {
      puts stderr "N-well region width must be at least 0.6um"
      return
   }
   if {$h < 0.6} {
      puts stderr "N-well region height must be at least 0.6um"
      return
   }
   suspendall
   tech unlock *
   pushbox
   pushbox
   box grow c 0.265um
   paint nwell
   popbox

   sky130::guard_ring_draw nsc nsd

   popbox
   tech revert
   resumeall
}

#----------------------------------------------------------------

proc sky130::mvnwell_draw {} {
   set w [magic::i2u [box width]]
   set h [magic::i2u [box height]]
   # NOTE:  Width and height are determined by the requirement for
   # a contact on each side.  There is not much that can be done
   # with an guarded nwell smaller than that, anyway.
   if {$w < 0.6} {
      puts stderr "MV N-well region width must be at least 0.6um"
      return
   }
   if {$h < 0.6} {
      puts stderr "MV N-well region height must be at least 0.6um"
      return
   }
   suspendall
   tech unlock *
   pushbox
   pushbox
   box grow c 0.415um
   paint nwell
   popbox

   sky130::guard_ring_draw mvnsc mvnsd

   popbox
   tech revert
   resumeall
}

#----------------------------------------------------------------

proc sky130::deep_nwell_draw {} {
   set w [magic::i2u [box width]]
   set h [magic::i2u [box height]]
   if {$w < 3.0} {
      puts stderr "Deep-nwell region width must be at least 3.0um"
      return
   }
   if {$h < 3.0} {
      puts stderr "Deep-nwell region height must be at least 3.0um"
      return
   }
   suspendall
   tech unlock *
   paint dnwell
   pushbox
   pushbox
   box grow c 0.4um
   # Note:  Previous implementation was to draw nwell over the whole
   # area and then erase it from the center.  That can interact with
   # any layout already drawn in the center area.  Instead, draw four
   # separate rectangles.
   # -----------------
   # paint nwell
   # box grow c -1.43um
   # erase nwell
   # -----------------
   pushbox
   box width 1.43um
   paint nwell
   popbox
   pushbox
   box height 1.43um
   paint nwell
   popbox
   pushbox
   box move n ${h}um
   box move n 0.8um
   box move s 1.43um
   box height 1.43um
   paint nwell
   popbox
   pushbox
   box move e ${w}um
   box move e 0.8um
   box move w 1.43um
   box width 1.43um
   paint nwell
   popbox

   popbox
   box grow c 0.03um

   pushbox
   box width 0
   box grow c 0.085um
   paint li
   pushbox
   box grow n -0.3um
   box grow s -0.3um
   paint nsc
   popbox
   box grow c 0.1um
   paint nsd
   popbox

   pushbox
   box height 0
   box grow c 0.085um
   paint li
   pushbox
   box grow e -0.3um
   box grow w -0.3um
   paint nsc
   popbox
   box grow c 0.1um
   paint nsd
   popbox

   pushbox
   box move n [box height]i
   box height 0
   box grow c 0.085um
   paint li
   pushbox
   box grow e -0.3um
   box grow w -0.3um
   paint nsc
   popbox
   box grow c 0.1um
   paint nsd
   popbox

   pushbox
   box move e [box width]i
   box width 0
   box grow c 0.085um
   paint li
   pushbox
   box grow n -0.3um
   box grow s -0.3um
   paint nsc
   box grow c 0.1um
   paint nsd
   popbox

   popbox
   tech revert
   resumeall
}

#----------------------------------------------------------------

proc sky130::mvdeep_nwell_draw {} {
   set w [magic::i2u [box width]]
   set h [magic::i2u [box height]]
   if {$w < 3.0} {
      puts stderr "MV Deep-nwell region width must be at least 3.0um"
      return
   }
   if {$h < 3.0} {
      puts stderr "MV Deep-nwell region height must be at least 3.0um"
      return
   }
   suspendall
   tech unlock *
   paint dnwell
   pushbox
   pushbox
   box grow c 0.55um
   pushbox
   box width 1.58um
   paint nwell
   popbox
   pushbox
   box height 1.58um
   paint nwell
   popbox
   pushbox
   box move n ${h}um
   box move n 1.1um
   box move s 1.58um
   box height 1.58um
   paint nwell
   popbox
   pushbox
   box move e ${w}um
   box move e 1.1um
   box move w 1.58um
   box width 1.58um
   paint nwell
   popbox

   popbox
   box grow c 0.03um

   pushbox
   box width 0
   box grow c 0.085um
   paint li
   pushbox
   box grow n -0.3um
   box grow s -0.3um
   paint mvnsc
   popbox
   box grow c 0.1um
   paint mvnsd
   popbox

   pushbox
   box height 0
   box grow c 0.085um
   paint li
   pushbox
   box grow e -0.3um
   box grow w -0.3um
   paint mvnsc
   popbox
   box grow c 0.1um
   paint mvnsd
   popbox

   pushbox
   box move n [box height]i
   box height 0
   box grow c 0.085um
   paint li
   pushbox
   box grow e -0.3um
   box grow w -0.3um
   paint mvnsc
   popbox
   box grow c 0.1um
   paint mvnsd
   popbox

   pushbox
   box move e [box width]i
   box width 0
   box grow c 0.085um
   paint li
   pushbox
   box grow n -0.3um
   box grow s -0.3um
   paint mvnsc
   box grow c 0.1um
   paint mvnsd
   popbox

   popbox
   tech revert
   resumeall
}
