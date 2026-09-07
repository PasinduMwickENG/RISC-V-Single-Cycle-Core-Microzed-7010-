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
    input  wire [31:0] Instruction,
    output reg  [31:0] ImmExt
);

    wire [6:0] opcode = Instruction[6:0];

    always @(*) begin
        case (opcode)
            7'b0010011, 7'b0000011, 7'b1100111: // I-type
                ImmExt = {{20{Instruction[31]}}, Instruction[31:20]};

            7'b0100011: // S-type
                ImmExt = {{20{Instruction[31]}}, Instruction[31:25], Instruction[11:7]};

            7'b1100011: // B-type
                ImmExt = {{19{Instruction[31]}}, Instruction[31], Instruction[7],
                           Instruction[30:25], Instruction[11:8], 1'b0};

            7'b0110111, 7'b0010111: // U-type
                ImmExt = {Instruction[31:12], 12'b0};

            7'b1101111: // J-type
                ImmExt = {{11{Instruction[31]}}, Instruction[31], Instruction[19:12],
                           Instruction[20], Instruction[30:21], 1'b0};

            default: ImmExt = 32'b0;
        endcase
    end

endmodule
