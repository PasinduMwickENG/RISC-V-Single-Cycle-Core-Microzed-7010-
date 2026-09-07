`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2026 10:51:27 AM
// Design Name: 
// Module Name: ALUControl
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

module ALUControl (
    input  wire [1:0]  ALUOp,       // From main control unit
    input  wire [2:0]  funct3,      // Instruction[14:12]
    input  wire        funct7,      // Instruction[30]  (only bit 30 matters for most)
    output reg  [3:0]  ALUControl
);

    always @(*) begin
        case (ALUOp)
            //--------------------------------------------------
            // ALUOp = 00 ? Load / Store / AUIPC / LUI ? always ADD
            //--------------------------------------------------
            2'b00: begin
                ALUControl = 4'b0000;           // ADD
            end

            //--------------------------------------------------
            // ALUOp = 01 ? Branch ? SUB (for comparison)
            //--------------------------------------------------
            2'b01: begin
                ALUControl = 4'b0001;           // SUB
            end

            //--------------------------------------------------
            // ALUOp = 10 ? R-type or I-type ALU operations
            //--------------------------------------------------
            2'b10: begin
                case (funct3)
                    3'b000: begin               // ADD or SUB
                        if (funct7 == 1'b1)
                            ALUControl = 4'b0001;   // SUB
                        else
                            ALUControl = 4'b0000;   // ADD
                    end
                    3'b001: ALUControl = 4'b0111;   // SLL
                    3'b010: ALUControl = 4'b0101;   // SLT
                    3'b011: ALUControl = 4'b0110;   // SLTU
                    3'b100: ALUControl = 4'b0100;   // XOR
                    3'b101: begin               // SRL or SRA
                        if (funct7 == 1'b1)
                            ALUControl = 4'b1001;   // SRA
                        else
                            ALUControl = 4'b1000;   // SRL
                    end
                    3'b110: ALUControl = 4'b0011;   // OR
                    3'b111: ALUControl = 4'b0010;   // AND
                    default: ALUControl = 4'b0000;
                endcase
            end

            // Default
            default: ALUControl = 4'b0000;
        endcase
    end

endmodule
