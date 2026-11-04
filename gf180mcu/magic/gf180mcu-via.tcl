###
###     Source file gf180mcu-via.tcl
###     Process this file with the preprocessor script
###
#-----------------------------------------------------
# Magic/TCL design kit for GF TECHNAME:  via stacks
#-----------------------------------------------------

#----------------------------------------------------------------
# Draw a via.  By default, metal1 extends horizontally while
# metal2 extends vertically.  If argument "orient" is "vert",
# then both metals extend vertically;  if "horz", both metals
# extend horizontally, and if "rev", the metal1 extends
# vertically while the metal2 extends horizontally.  The
# default orientation matches standard digital routing.
#----------------------------------------------------------------

proc gf180mcu::via1_draw {{orient default}} {
    set w [magic::i2u [box width]]
    set h [magic::i2u [box height]]
    if {$w < 0.26} {
	puts stderr "Via1 width must be at least 0.26um"
	return
    }
    if {$h < 0.26} {
	puts stderr "Via1 height must be at least 0.26um"
	return
    }
    paint via1
    pushbox
    pushbox
    box grow c 0.01um
    if {$orient == "horz" || $orient == "rev"} {
	box grow e 0.05um
	box grow w 0.05um
    } else {
	box grow n 0.05um
	box grow s 0.05um
    }
    paint m2
    popbox
    if {$orient == "vert" || $orient == "rev"} {
	box grow n 0.06um
	box grow s 0.06um
    } else {
	box grow e 0.06um
	box grow w 0.06um
    }
    paint m1
    popbox
}

#ifdef METALS3 || METALS4 || METALS5 || METALS6
proc gf180mcu::via2_draw {} {
   set w [magic::i2u [box width]]
   set h [magic::i2u [box height]]
   if {$w < 0.28} {
      puts stderr "Via2 width must be at least 0.28um"
      return
   }
   if {$h < 0.28} {
      puts stderr "Via2 height must be at least 0.28um"
      return
   }
   paint via2
   box grow n 0.05um
   box grow s 0.05um
   paint m2
   box grow n -0.05um
   box grow s -0.05um
   box grow e 0.05um
   box grow w 0.05um
   paint m3
   box grow e -0.05um
   box grow w -0.05um
}
#endif (METALS3 || METALS4 || METALS5 || METALS6)

#ifdef METALS4 || METALS5 || METALS6
proc gf180mcu::via3_draw {} {
   set w [magic::i2u [box width]]
   set h [magic::i2u [box height]]
   if {$w < 0.28} {
      puts stderr "Via3 width must be at least 0.28um"
      return
   }
   if {$h < 0.28} {
      puts stderr "Via3 height must be at least 0.28um"
      return
   }
   paint via3
   box grow n 0.05um
   box grow s 0.05um
   paint m4
   box grow n -0.05um
   box grow s -0.05um
   box grow e 0.05um
   box grow w 0.05um
   paint m3
   box grow e -0.05um
   box grow w -0.05um
}
#endif (METALS4 || METALS5 || METALS6)

#ifdef METALS5 || METALS6
proc gf180mcu::via4_draw {} {
   set w [magic::i2u [box width]]
   set h [magic::i2u [box height]]
   if {$w < 0.28} {
      puts stderr "Via4 width must be at least 0.28um"
      return
   }
   if {$h < 0.28} {
      puts stderr "Via4 height must be at least 0.28um"
      return
   }
   paint via4
   box grow n 0.05um
   box grow s 0.05um
   paint m5
   box grow n -0.05um
   box grow s -0.05um
   box grow e 0.05um
   box grow w 0.05um
   paint m4
   box grow e -0.05um
   box grow w -0.05um
}
#endif (METALS5 || METALS6)

#ifdef METALS6
proc gf180mcu::viatp_draw {} {
   set w [magic::i2u [box width]]
   set h [magic::i2u [box height]]
   if {$w < 0.28} {
      puts stderr "ViaTP width must be at least 0.28um"
      return
   }
   if {$h < 0.28} {
      puts stderr "ViaTP height must be at least 0.28um"
      return
   }
   paint viatp
   box grow c 0.08um
   paint mtp
   box grow c -0.08um
   box grow e 0.05um
   box grow w 0.05um
   paint m5
   box grow e -0.05um
   box grow w -0.05um
}
#endif (METALS6)
