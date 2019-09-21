## SETUP
puts "Info: HDL Designer Synthesis run started"

## Set current project and folder
if {[string length [info commands new_project]]} {
   open_project "D:/CAD/cad_lib/ps/Counter_Structure/Counter_Structure.psp"
   new_impl
} else {
   set_working_dir "D:/CAD/cad_lib/ps/Counter_Structure"
}

## Implementation settings
MGS_Gui::notify_gui lock
setup_design -manufacturer "Altera" -family "MAX V " -part "5M2210ZF324A" -speed "5" 

## Design Settings
setup_design -addio=true
setup_design -safe_fsm_type=none
setup_design -retiming=false
if {[catch {setup_design -2004c_compile_mode=false}]} {
catch {setup_design -frontend_2004=false}
}

setup_design -vhdl=false
setup_design -verilog=false
setup_design -edif=true

## Read in source files
catch {source "D:/CAD/cad_lib/ps/Counter_Structure/hds/add_files.tcl"}
MGS_Gui::notify_gui unlock

## Compile & Synthesize
MGS_Gui::notify_gui lock
if {[catch compile]} {
   MGS_Gui::notify_gui unlock
} elseif {[catch synthesize]} {
   MGS_Gui::notify_gui unlock
} else {
   MGS_Gui::notify_gui unlock
}

puts "Info: HDL Designer Synthesis run finished"


