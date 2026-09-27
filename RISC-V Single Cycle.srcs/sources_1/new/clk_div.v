`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2026 11:26:03 AM
// Design Name: 
// Module Name: clk_div
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

//
// Divides the 100 MHz PS fabric clock down to ~20 Hz for the CPU core,
// so PC/Instruction/ALU/register values stay stable long enough for
// the ARM (PS) to read a consistent snapshot over AXI.
//
module clk_div (
    input  wire clk_in,    // 100 MHz from FCLK_CLK0
    output reg  clk_out = 0
);

    reg [21:0] counter = 0;

    always @(posedge clk_in) begin
        if (counter == 22'd2_499_999) begin
            counter <= 0;
            clk_out <= ~clk_out;
        end else begin
            counter <= counter + 1;
        end
    end

endmodule