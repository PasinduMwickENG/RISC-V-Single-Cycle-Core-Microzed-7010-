`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/07/2026 05:10:12 PM
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module top (
    input  wire       clk,
    output wire       clk_en,
    input  wire       reset_n,      // we will ignore it for now
    output wire [7:0] led
);

    // Enable carrier oscillator
    assign clk_en = 1'b1;

    // Power-on reset: stay in reset for ~256 clock cycles after configuration
    reg [7:0] por_counter = 8'd0;
    wire reset = (por_counter != 8'hFF);

    always @(posedge clk) begin
        if (por_counter != 8'hFF)
            por_counter <= por_counter + 1'b1;
    end

    // RISC-V core
    RISC_V_SingleCycle cpu (
        .clk(clk),
        .reset(reset)
    );

    // Show PC on LEDs
    assign led = cpu.PC[9:2];

endmodule