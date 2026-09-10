# 100 MHz Clock from Carrier
set_property PACKAGE_PIN K17 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name sys_clk [get_ports clk]

# Clock Enable
set_property PACKAGE_PIN K18 [get_ports clk_en]
set_property IOSTANDARD LVCMOS33 [get_ports clk_en]

# Reset button (not used, but constrained)
set_property PACKAGE_PIN G19 [get_ports reset_n]
set_property IOSTANDARD LVCMOS33 [get_ports reset_n]

# User LEDs
set_property PACKAGE_PIN U14 [get_ports {led[7]}]
set_property PACKAGE_PIN U15 [get_ports {led[6]}]
set_property PACKAGE_PIN U18 [get_ports {led[5]}]
set_property PACKAGE_PIN U19 [get_ports {led[4]}]
set_property PACKAGE_PIN R19 [get_ports {led[3]}]
set_property PACKAGE_PIN V13 [get_ports {led[2]}]
set_property PACKAGE_PIN P14 [get_ports {led[1]}]
set_property PACKAGE_PIN R14 [get_ports {led[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[*]}]

create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list clk_IBUF_BUFG]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 32 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {cpu/PC_out[0]} {cpu/PC_out[1]} {cpu/PC_out[2]} {cpu/PC_out[3]} {cpu/PC_out[4]} {cpu/PC_out[5]} {cpu/PC_out[6]} {cpu/PC_out[7]} {cpu/PC_out[8]} {cpu/PC_out[9]} {cpu/PC_out[10]} {cpu/PC_out[11]} {cpu/PC_out[12]} {cpu/PC_out[13]} {cpu/PC_out[14]} {cpu/PC_out[15]} {cpu/PC_out[16]} {cpu/PC_out[17]} {cpu/PC_out[18]} {cpu/PC_out[19]} {cpu/PC_out[20]} {cpu/PC_out[21]} {cpu/PC_out[22]} {cpu/PC_out[23]} {cpu/PC_out[24]} {cpu/PC_out[25]} {cpu/PC_out[26]} {cpu/PC_out[27]} {cpu/PC_out[28]} {cpu/PC_out[29]} {cpu/PC_out[30]} {cpu/PC_out[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 32 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {cpu/MemData_out[0]} {cpu/MemData_out[1]} {cpu/MemData_out[2]} {cpu/MemData_out[3]} {cpu/MemData_out[4]} {cpu/MemData_out[5]} {cpu/MemData_out[6]} {cpu/MemData_out[7]} {cpu/MemData_out[8]} {cpu/MemData_out[9]} {cpu/MemData_out[10]} {cpu/MemData_out[11]} {cpu/MemData_out[12]} {cpu/MemData_out[13]} {cpu/MemData_out[14]} {cpu/MemData_out[15]} {cpu/MemData_out[16]} {cpu/MemData_out[17]} {cpu/MemData_out[18]} {cpu/MemData_out[19]} {cpu/MemData_out[20]} {cpu/MemData_out[21]} {cpu/MemData_out[22]} {cpu/MemData_out[23]} {cpu/MemData_out[24]} {cpu/MemData_out[25]} {cpu/MemData_out[26]} {cpu/MemData_out[27]} {cpu/MemData_out[28]} {cpu/MemData_out[29]} {cpu/MemData_out[30]} {cpu/MemData_out[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 32 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {cpu/ALUResult_out[0]} {cpu/ALUResult_out[1]} {cpu/ALUResult_out[2]} {cpu/ALUResult_out[3]} {cpu/ALUResult_out[4]} {cpu/ALUResult_out[5]} {cpu/ALUResult_out[6]} {cpu/ALUResult_out[7]} {cpu/ALUResult_out[8]} {cpu/ALUResult_out[9]} {cpu/ALUResult_out[10]} {cpu/ALUResult_out[11]} {cpu/ALUResult_out[12]} {cpu/ALUResult_out[13]} {cpu/ALUResult_out[14]} {cpu/ALUResult_out[15]} {cpu/ALUResult_out[16]} {cpu/ALUResult_out[17]} {cpu/ALUResult_out[18]} {cpu/ALUResult_out[19]} {cpu/ALUResult_out[20]} {cpu/ALUResult_out[21]} {cpu/ALUResult_out[22]} {cpu/ALUResult_out[23]} {cpu/ALUResult_out[24]} {cpu/ALUResult_out[25]} {cpu/ALUResult_out[26]} {cpu/ALUResult_out[27]} {cpu/ALUResult_out[28]} {cpu/ALUResult_out[29]} {cpu/ALUResult_out[30]} {cpu/ALUResult_out[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 32 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {cpu/x1_out[0]} {cpu/x1_out[1]} {cpu/x1_out[2]} {cpu/x1_out[3]} {cpu/x1_out[4]} {cpu/x1_out[5]} {cpu/x1_out[6]} {cpu/x1_out[7]} {cpu/x1_out[8]} {cpu/x1_out[9]} {cpu/x1_out[10]} {cpu/x1_out[11]} {cpu/x1_out[12]} {cpu/x1_out[13]} {cpu/x1_out[14]} {cpu/x1_out[15]} {cpu/x1_out[16]} {cpu/x1_out[17]} {cpu/x1_out[18]} {cpu/x1_out[19]} {cpu/x1_out[20]} {cpu/x1_out[21]} {cpu/x1_out[22]} {cpu/x1_out[23]} {cpu/x1_out[24]} {cpu/x1_out[25]} {cpu/x1_out[26]} {cpu/x1_out[27]} {cpu/x1_out[28]} {cpu/x1_out[29]} {cpu/x1_out[30]} {cpu/x1_out[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 32 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {cpu/x2_out[0]} {cpu/x2_out[1]} {cpu/x2_out[2]} {cpu/x2_out[3]} {cpu/x2_out[4]} {cpu/x2_out[5]} {cpu/x2_out[6]} {cpu/x2_out[7]} {cpu/x2_out[8]} {cpu/x2_out[9]} {cpu/x2_out[10]} {cpu/x2_out[11]} {cpu/x2_out[12]} {cpu/x2_out[13]} {cpu/x2_out[14]} {cpu/x2_out[15]} {cpu/x2_out[16]} {cpu/x2_out[17]} {cpu/x2_out[18]} {cpu/x2_out[19]} {cpu/x2_out[20]} {cpu/x2_out[21]} {cpu/x2_out[22]} {cpu/x2_out[23]} {cpu/x2_out[24]} {cpu/x2_out[25]} {cpu/x2_out[26]} {cpu/x2_out[27]} {cpu/x2_out[28]} {cpu/x2_out[29]} {cpu/x2_out[30]} {cpu/x2_out[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 32 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {alu_result[0]} {alu_result[1]} {alu_result[2]} {alu_result[3]} {alu_result[4]} {alu_result[5]} {alu_result[6]} {alu_result[7]} {alu_result[8]} {alu_result[9]} {alu_result[10]} {alu_result[11]} {alu_result[12]} {alu_result[13]} {alu_result[14]} {alu_result[15]} {alu_result[16]} {alu_result[17]} {alu_result[18]} {alu_result[19]} {alu_result[20]} {alu_result[21]} {alu_result[22]} {alu_result[23]} {alu_result[24]} {alu_result[25]} {alu_result[26]} {alu_result[27]} {alu_result[28]} {alu_result[29]} {alu_result[30]} {alu_result[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 32 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {cpu/x3_out[0]} {cpu/x3_out[1]} {cpu/x3_out[2]} {cpu/x3_out[3]} {cpu/x3_out[4]} {cpu/x3_out[5]} {cpu/x3_out[6]} {cpu/x3_out[7]} {cpu/x3_out[8]} {cpu/x3_out[9]} {cpu/x3_out[10]} {cpu/x3_out[11]} {cpu/x3_out[12]} {cpu/x3_out[13]} {cpu/x3_out[14]} {cpu/x3_out[15]} {cpu/x3_out[16]} {cpu/x3_out[17]} {cpu/x3_out[18]} {cpu/x3_out[19]} {cpu/x3_out[20]} {cpu/x3_out[21]} {cpu/x3_out[22]} {cpu/x3_out[23]} {cpu/x3_out[24]} {cpu/x3_out[25]} {cpu/x3_out[26]} {cpu/x3_out[27]} {cpu/x3_out[28]} {cpu/x3_out[29]} {cpu/x3_out[30]} {cpu/x3_out[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 32 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list {mem_data[0]} {mem_data[1]} {mem_data[2]} {mem_data[3]} {mem_data[4]} {mem_data[5]} {mem_data[6]} {mem_data[7]} {mem_data[8]} {mem_data[9]} {mem_data[10]} {mem_data[11]} {mem_data[12]} {mem_data[13]} {mem_data[14]} {mem_data[15]} {mem_data[16]} {mem_data[17]} {mem_data[18]} {mem_data[19]} {mem_data[20]} {mem_data[21]} {mem_data[22]} {mem_data[23]} {mem_data[24]} {mem_data[25]} {mem_data[26]} {mem_data[27]} {mem_data[28]} {mem_data[29]} {mem_data[30]} {mem_data[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 32 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list {x3[0]} {x3[1]} {x3[2]} {x3[3]} {x3[4]} {x3[5]} {x3[6]} {x3[7]} {x3[8]} {x3[9]} {x3[10]} {x3[11]} {x3[12]} {x3[13]} {x3[14]} {x3[15]} {x3[16]} {x3[17]} {x3[18]} {x3[19]} {x3[20]} {x3[21]} {x3[22]} {x3[23]} {x3[24]} {x3[25]} {x3[26]} {x3[27]} {x3[28]} {x3[29]} {x3[30]} {x3[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 32 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list {pc[0]} {pc[1]} {pc[2]} {pc[3]} {pc[4]} {pc[5]} {pc[6]} {pc[7]} {pc[8]} {pc[9]} {pc[10]} {pc[11]} {pc[12]} {pc[13]} {pc[14]} {pc[15]} {pc[16]} {pc[17]} {pc[18]} {pc[19]} {pc[20]} {pc[21]} {pc[22]} {pc[23]} {pc[24]} {pc[25]} {pc[26]} {pc[27]} {pc[28]} {pc[29]} {pc[30]} {pc[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 32 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list {x2[0]} {x2[1]} {x2[2]} {x2[3]} {x2[4]} {x2[5]} {x2[6]} {x2[7]} {x2[8]} {x2[9]} {x2[10]} {x2[11]} {x2[12]} {x2[13]} {x2[14]} {x2[15]} {x2[16]} {x2[17]} {x2[18]} {x2[19]} {x2[20]} {x2[21]} {x2[22]} {x2[23]} {x2[24]} {x2[25]} {x2[26]} {x2[27]} {x2[28]} {x2[29]} {x2[30]} {x2[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 32 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list {x1[0]} {x1[1]} {x1[2]} {x1[3]} {x1[4]} {x1[5]} {x1[6]} {x1[7]} {x1[8]} {x1[9]} {x1[10]} {x1[11]} {x1[12]} {x1[13]} {x1[14]} {x1[15]} {x1[16]} {x1[17]} {x1[18]} {x1[19]} {x1[20]} {x1[21]} {x1[22]} {x1[23]} {x1[24]} {x1[25]} {x1[26]} {x1[27]} {x1[28]} {x1[29]} {x1[30]} {x1[31]}]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk_IBUF_BUFG]
