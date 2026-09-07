# 100 MHz Clock from Carrier
set_property PACKAGE_PIN K17     [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name sys_clk [get_ports clk]

# Clock Enable (must be high)
set_property PACKAGE_PIN K18     [get_ports clk_en]
set_property IOSTANDARD LVCMOS33 [get_ports clk_en]

# Reset button
set_property PACKAGE_PIN G19     [get_ports reset_n]
set_property IOSTANDARD LVCMOS33 [get_ports reset_n]

# User LEDs
set_property PACKAGE_PIN U14 [get_ports {led[0]}]
set_property PACKAGE_PIN U15 [get_ports {led[1]}]
set_property PACKAGE_PIN U18 [get_ports {led[2]}]
set_property PACKAGE_PIN U19 [get_ports {led[3]}]
set_property PACKAGE_PIN R19 [get_ports {led[4]}]
set_property PACKAGE_PIN V13 [get_ports {led[5]}]
set_property PACKAGE_PIN P14 [get_ports {led[6]}]
set_property PACKAGE_PIN R14 [get_ports {led[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[*]}]