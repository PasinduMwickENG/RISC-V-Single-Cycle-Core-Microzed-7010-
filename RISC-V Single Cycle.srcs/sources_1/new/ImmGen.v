`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2026 10:06:59 AM
// Design Name: 
// Module Name: ImmGen
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


module ImmGen (
    input  wire [31:0] Instruction,   // Full 32-bit instruction
    output reg  [31:0] ImmExt         // Sign-extended immediate
);

    // Extract opcode to decide the type
    wire [6:0] opcode = Instruction[6:0];

    always @(*) begin
        case (opcode)
            // I-type: addi, andi, ori, xori, slli, srli, srai, lw, jalr, etc.
            7'b0010011,   // ALUi
            7'b0000011,   // Loads
            7'b1100111:   // jalr
                ImmExt = {{20{Instruction[31]}}, Instruction[31:20]};

            // S-type: sw, sh, sb
            7'b0100011:
                ImmExt = {{20{Instruction[31]}}, Instruction[31:25], Instruction[11:7]};

            // B-type: beq, bne, blt, bge, bltu, bgeu
            7'b1100011:
                ImmExt = {{19{Instruction[31]}}, Instruction[31], Instruction[7],
                           Instruction[30:25], Instruction[11:8], 1'b0};

            // U-type: lui, auipc
            7'b0110111,   // lui
            7'b0010111:   // auipc
                ImmExt = {Instruction[31:12], 12'b0};

            // J-type: jal
            7'b1101111:
                ImmExt = {{11{Instruction[31]}}, Instruction[31], Instruction[19:12],
                           Instruction[20], Instruction[30:21], 1'b0};

            // Default (R-type or unknown) → 0
            default:
                ImmExt = 32'b0;
        endcase
    end

endmodule
