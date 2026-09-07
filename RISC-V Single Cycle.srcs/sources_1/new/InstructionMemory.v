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
    input  wire [31:0] Address,       // Byte address from PC
    output reg  [31:0] Instruction
);

    // 256 instructions (1 KB) - enough for learning
    reg [31:0] memory [0:255];

    // Load program from hex file at start of simulation
    initial begin
        $readmemh("program.hex", memory);
        // If the file is missing, memory stays unknown (X)
    end

    // Combinational read (word-aligned)
    always @(*) begin
        // Use word address (Address[9:2] for 256 words)
        Instruction = memory[Address[9:2]];
    end

endmodule
