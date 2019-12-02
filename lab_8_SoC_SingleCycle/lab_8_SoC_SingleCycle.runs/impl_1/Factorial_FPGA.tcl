# 
# Report generation script generated by Vivado
# 

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
proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}


start_step init_design
set ACTIVE_STEP init_design
set rc [catch {
  create_msg_db init_design.pb
  create_project -in_memory -part xc7a35tcpg236-1
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.cache/wt [current_project]
  set_property parent.project_path C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.xpr [current_project]
  set_property ip_output_repo C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.cache/ip [current_project]
  set_property ip_cache_permissions {read write} [current_project]
  add_files -quiet C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.runs/synth_1/Factorial_FPGA.dcp
  add_files -quiet {{C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/sources_1/imports/CMPE140/LAB 1/CMPE140_project_1.runs/impl_1/Factorial_TOP_routed.dcp}}
  read_xdc {{C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/constrs_1/imports/CMPE140/LAB 1/CMPE140_project_1.srcs/constrs_1/new/factorial_FPGA.xdc}}
  read_xdc C:/Programming/CMPE140/lab_8_SoC_SingleCycle/lab_8_SoC_SingleCycle.srcs/constrs_1/imports/CMPE140/processor_design/processor_design.srcs/constrs_1/imports/basys3_single_cycle_mips_validation/mips_fpga.xdc
  link_design -top Factorial_FPGA -part xc7a35tcpg236-1
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
  unset ACTIVE_STEP 
}

start_step opt_design
set ACTIVE_STEP opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force Factorial_FPGA_opt.dcp
  create_report "impl_1_opt_report_drc_0" "report_drc -file Factorial_FPGA_drc_opted.rpt -pb Factorial_FPGA_drc_opted.pb -rpx Factorial_FPGA_drc_opted.rpx"
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
  unset ACTIVE_STEP 
}

start_step place_design
set ACTIVE_STEP place_design
set rc [catch {
  create_msg_db place_design.pb
  if { [llength [get_debug_cores -quiet] ] > 0 }  { 
    implement_debug_core 
  } 
  place_design 
  write_checkpoint -force Factorial_FPGA_placed.dcp
  create_report "impl_1_place_report_io_0" "report_io -file Factorial_FPGA_io_placed.rpt"
  create_report "impl_1_place_report_utilization_0" "report_utilization -file Factorial_FPGA_utilization_placed.rpt -pb Factorial_FPGA_utilization_placed.pb"
  create_report "impl_1_place_report_control_sets_0" "report_control_sets -verbose -file Factorial_FPGA_control_sets_placed.rpt"
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
  unset ACTIVE_STEP 
}

start_step route_design
set ACTIVE_STEP route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force Factorial_FPGA_routed.dcp
  create_report "impl_1_route_report_drc_0" "report_drc -file Factorial_FPGA_drc_routed.rpt -pb Factorial_FPGA_drc_routed.pb -rpx Factorial_FPGA_drc_routed.rpx"
  create_report "impl_1_route_report_methodology_0" "report_methodology -file Factorial_FPGA_methodology_drc_routed.rpt -pb Factorial_FPGA_methodology_drc_routed.pb -rpx Factorial_FPGA_methodology_drc_routed.rpx"
  create_report "impl_1_route_report_power_0" "report_power -file Factorial_FPGA_power_routed.rpt -pb Factorial_FPGA_power_summary_routed.pb -rpx Factorial_FPGA_power_routed.rpx"
  create_report "impl_1_route_report_route_status_0" "report_route_status -file Factorial_FPGA_route_status.rpt -pb Factorial_FPGA_route_status.pb"
  create_report "impl_1_route_report_timing_summary_0" "report_timing_summary -max_paths 10 -file Factorial_FPGA_timing_summary_routed.rpt -pb Factorial_FPGA_timing_summary_routed.pb -rpx Factorial_FPGA_timing_summary_routed.rpx -warn_on_violation "
  create_report "impl_1_route_report_incremental_reuse_0" "report_incremental_reuse -file Factorial_FPGA_incremental_reuse_routed.rpt"
  create_report "impl_1_route_report_clock_utilization_0" "report_clock_utilization -file Factorial_FPGA_clock_utilization_routed.rpt"
  create_report "impl_1_route_report_bus_skew_0" "report_bus_skew -warn_on_violation -file Factorial_FPGA_bus_skew_routed.rpt -pb Factorial_FPGA_bus_skew_routed.pb -rpx Factorial_FPGA_bus_skew_routed.rpx"
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  write_checkpoint -force Factorial_FPGA_routed_error.dcp
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
  unset ACTIVE_STEP 
}

start_step write_bitstream
set ACTIVE_STEP write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  catch { write_mem_info -force Factorial_FPGA.mmi }
  write_bitstream -force Factorial_FPGA.bit 
  catch {write_debug_probes -quiet -force Factorial_FPGA}
  catch {file copy -force Factorial_FPGA.ltx debug_nets.ltx}
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
  unset ACTIVE_STEP 
}

