`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2026 12:17:48 PM
// Design Name: 
// Module Name: InstructionMemory
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

module InstructionMemory (
    input  wire [31:0] Address,
    output reg  [31:0] Instruction
);

    reg [31:0] memory [0:255];

    initial begin
        $readmemh("program.hex", memory);
    end

    always @(*) begin
        Instruction = memory[Address[9:2]];
    end

endmodule
