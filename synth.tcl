# Import all Yosys commands into the Tcl environment
yosys -import

# Define the list of widths you want to sweep
set widths {8 16 32 64 72}

# Loop through each width
foreach w $widths {
    
    puts "========================================================="
    puts "   STARTING SYNTHESIS FOR WIDTH: $w BITS"
    puts "========================================================="

    # 1. Clear Yosys memory so the previous loop doesn't conflict
    design -reset

    # 2. Read the physics dictionary (WITH THE -lib FLAG!) and Verilog
    read_liberty -lib ./lib/45nm_stdcells.lib
    read_verilog convert_to_v/full_adder.v convert_to_v/rca.v

    # 3. Check hierarchy
    hierarchy -check -top adder

    # 4. Override the SystemVerilog parameter
    chparam -set WIDTH $w adder

    # 1. Aggressive Generic Synthesis (Flattening the hierarchy)
    synth -top adder -flatten

    # 2. Pre-mapping cleanup
    opt -full -purge

    # 3. Technology Mapping 
    abc -liberty ./lib/45nm_stdcells.lib

    # 4. Final Aggressive Cleanup
    opt -full -purge
    clean

    # --- ADD THE COMMANDS HERE ---
    # Extract area and topological logic levels, appending the width to the filename
    tee -o ./synth/area_report_${w}bit.txt stat -liberty ./lib/45nm_stdcells.lib
    tee -o ./synth/path_report_${w}bit.txt ltp
    # -----------------------------

    # 8. Write the final netlist using the loop variable
    write_verilog -noattr -noexpr ./synth/synth_netlist_nangate45_${w}bit.v  

    puts "Finished synthesis for $w bits!"
}