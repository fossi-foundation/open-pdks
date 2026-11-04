###
###     Source file gf180mcu-misc.tcl
###     Process this file with the preprocessor script
###
#-----------------------------------------------------
# Magic/TCL design kit for GF TECHNAME:  substrate taps
#-----------------------------------------------------

proc gf180mcu::subcon_3p3_draw {} {
   set w [magic::i2u [box width]]
   set h [magic::i2u [box height]]
   if {$w < 0.23} {
      puts stderr "Substrate tap width must be at least 0.23um"
      return
   }
   if {$h < 0.23} {
      puts stderr "Substrate tap height must be at least 0.23um"
      return
   }
   paint subdiffc
   box grow c 0.1um
   paint subdiff
   box grow c 0.1um
   paint pwell
   box grow c -0.2um
}

#----------------------------------------------------------------

proc gf180mcu::subcon_06v0_draw {} {
   set w [magic::i2u [box width]]
   set h [magic::i2u [box height]]
   if {$w < 0.23} {
      puts stderr "Substrate tap width must be at least 0.23um"
      return
   }
   if {$h < 0.23} {
      puts stderr "Substrate tap height must be at least 0.23um"
      return
   }
   paint mvsubdiffc
   box grow c 0.1um
   paint mvsubdiff
   box grow c 0.1um
   paint pwell
   box grow c -0.2um
}
