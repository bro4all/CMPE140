# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.cache/wt [current_project]
set_property parent.project_path C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo c:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib {
  C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/sources_1/imports/new/SOC_AddressDecoder.v
  C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/sources_1/new/SoC_mux.v
  C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/sources_1/new/SoC_singleCycle_top.v
  C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/sources_1/imports/CMPE140/processor_design/processor_design.srcs/sources_1/imports/single_cycle_mips_source_initial/datapath/adder.v
  C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/sources_1/imports/CMPE140/processor_design/processor_design.srcs/sources_1/imports/single_cycle_mips_source_initial/datapath/alu.v
  C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/sources_1/imports/CMPE140/processor_design/processor_design.srcs/sources_1/imports/single_cycle_mips_source_initial/control_unit/auxdec.v
  C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/sources_1/imports/new/buff.v
  C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/sources_1/imports/CMPE140/processor_design/processor_design.srcs/sources_1/imports/basys3_single_cycle_mips_validation/button_debouncer.v
  C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/sources_1/imports/CMPE140/processor_design/processor_design.srcs/sources_1/imports/basys3_single_cycle_mips_validation/clk_gen.v
  C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/sources_1/imports/new/comp.v
  C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/sources_1/imports/new/control_unit.v
  C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/sources_1/imports/CMPE140/processor_design/processor_design.srcs/sources_1/imports/single_cycle_mips_source_initial/control_unit/controlunit.v
  C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/sources_1/imports/new/counter.v
  C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/sources_1/imports/CMPE140/processor_design/processor_design.srcs/sources_1/imports/single_cycle_mips_source_initial/datapath/datapath.v
  C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/sources_1/imports/CMPE140/processor_design/processor_design.srcs/sources_1/imports/single_cycle_mips_source_initial/memory/dmem.v
  C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/sources_1/imports/new/dreg.v
  C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/sources_1/imports/new/fact_ad.v
  C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/sources_1/imports/new/fact_reg.v
  C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/sources_1/imports/new/fact_res.v
  C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/sources_1/imports/new/fact_top.v
  C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/sources_1/imports/new/gpio_ad.v
  C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/sources_1/imports/new/gpio_top.v
  C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/sources_1/imports/CMPE140/processor_design/processor_design.srcs/sources_1/imports/basys3_single_cycle_mips_validation/hex_to_7seg.v
  C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/sources_1/imports/CMPE140/processor_design/processor_design.srcs/sources_1/imports/single_cycle_mips_source_initial/memory/imem.v
  C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/sources_1/imports/CMPE140/processor_design/processor_design.srcs/sources_1/imports/basys3_single_cycle_mips_validation/led_mux.v
  C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/sources_1/imports/CMPE140/processor_design/processor_design.srcs/sources_1/imports/single_cycle_mips_source_initial/control_unit/maindec.v
  C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/sources_1/imports/CMPE140/processor_design/processor_design.srcs/sources_1/new/mf_reg.v
  C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/sources_1/imports/CMPE140/processor_design/processor_design.srcs/sources_1/imports/single_cycle_mips_source_initial/mips/mips.v
  C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/sources_1/imports/new/mux2.v
  C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/sources_1/imports/new/mux4.v
  C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/sources_1/imports/new/nfactorial.v
  C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/sources_1/imports/new/nfactorial_dp.v
  C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/sources_1/imports/CMPE140/processor_design/processor_design.srcs/sources_1/imports/single_cycle_mips_source_initial/datapath/regfile.v
  C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/sources_1/imports/new/register.v
  C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/sources_1/imports/CMPE140/processor_design/processor_design.srcs/sources_1/imports/single_cycle_mips_source_initial/datapath/signext.v
  C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/sources_1/new/SoC_singleCycle_FPGA.v
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc {{C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/constrs_1/imports/CMPE140/LAB 1/CMPE140_project_1.srcs/constrs_1/new/factorial_FPGA.xdc}}
set_property used_in_implementation false [get_files {{C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/constrs_1/imports/CMPE140/LAB 1/CMPE140_project_1.srcs/constrs_1/new/factorial_FPGA.xdc}}]

read_xdc C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/constrs_1/imports/CMPE140/processor_design/processor_design.srcs/constrs_1/imports/basys3_single_cycle_mips_validation/mips_fpga.xdc
set_property used_in_implementation false [get_files C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/constrs_1/imports/CMPE140/processor_design/processor_design.srcs/constrs_1/imports/basys3_single_cycle_mips_validation/mips_fpga.xdc]

set_param ips.enableIPCacheLiteLoad 0
close [open __synthesis_is_running__ w]

synth_design -top SoC_singleCycle_FPGA -part xc7a35tcpg236-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef SoC_singleCycle_FPGA.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file SoC_singleCycle_FPGA_utilization_synth.rpt -pb SoC_singleCycle_FPGA_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
