###
###     Source file sky130-via.tcl
###     Process this file with the preprocessor script
###
#-----------------------------------------------------
# Magic/TCL design kit for SKYWATER TECHNAME:  via stacks
#-----------------------------------------------------

#----------------------------------------------------------------

proc sky130::mcon_draw {{dir default}} {
   set w [magic::i2u [box width]]
   set h [magic::i2u [box height]]
   if {$w < 0.17} {
      puts stderr "Mcon width must be at least 0.17um"
      return
   }
   if {$h < 0.17} {
      puts stderr "Mcon height must be at least 0.17um"
      return
   }
   suspendall
   paint mcon
   pushbox
   if {($w < $h) || ($dir == "vert")} {
       box grow e 0.03um
       box grow w 0.03um
       box grow n 0.06um
       box grow s 0.06um
       paint m1
   } else {
       box grow n 0.03um
       box grow s 0.03um
       box grow e 0.06um
       box grow w 0.06um
       paint m1
   }
   popbox
   resumeall
}

proc sky130::via1_draw {} {
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
   suspendall
   paint via1
   box grow n 0.05um
   box grow s 0.05um
   paint m2
   box grow n -0.05um
   box grow s -0.05um
   box grow e 0.05um
   box grow w 0.05um
   paint m1
   box grow e -0.05um
   box grow w -0.05um
   resumeall
}

proc sky130::via2_draw {} {
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
   suspendall
   pushbox
   paint via2
   box grow n 0.05um
   box grow s 0.05um
   paint m2
   popbox
   pushbox
   box grow n 0.025um
   box grow s 0.025um
   box grow e 0.05um
   box grow w 0.05um
   paint m3
   popbox
   resumeall
}

#ifdef METAL5
proc sky130::via3_draw {} {
   set w [magic::i2u [box width]]
   set h [magic::i2u [box height]]
   if {$w < 0.32} {
      puts stderr "Via3 width must be at least 0.32um"
      return
   }
   if {$h < 0.32} {
      puts stderr "Via3 height must be at least 0.32um"
      return
   }
   suspendall
   pushbox
   paint via3
   box grow n 0.005um
   box grow s 0.005um
   box grow e 0.005um
   box grow w 0.005um
   paint m4
   popbox
   pushbox
   box grow e 0.05um
   box grow w 0.05um
   paint m3
   popbox
   resumeall
}

proc sky130::via4_draw {} {
   set w [magic::i2u [box width]]
   set h [magic::i2u [box height]]
   if {$w < 1.18} {
      puts stderr "Via3 width must be at least 1.18um"
      return
   }
   if {$h < 1.18} {
      puts stderr "Via3 height must be at least 1.18um"
      return
   }
   suspendall
   paint via4
   pushbox
   box grow n 0.12um
   box grow s 0.12um
   box grow e 0.12um
   box grow w 0.12um
   paint m5
   popbox
   resumeall
}
#endif (METAL5)
