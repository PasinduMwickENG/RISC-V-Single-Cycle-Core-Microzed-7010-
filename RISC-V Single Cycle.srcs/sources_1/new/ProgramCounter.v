`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2026 02:11:58 PM
// Design Name: 
// Module Name: ProgramCounter
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

module ProgramCounter (
    input  wire        clk,
    input  wire        reset,
    input  wire [31:0] PC_Next,
    output reg  [31:0] PC
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            PC <= 32'h00000000;
        else
            PC <= PC_Next;
    end

endmodule
