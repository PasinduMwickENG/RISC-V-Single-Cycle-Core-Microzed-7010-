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
    input  wire [1:0]  ALUOp,
    input  wire [2:0]  funct3,
    input  wire        funct7,
    output reg  [3:0]  ALUControl
);

    always @(*) begin
        case (ALUOp)
            2'b00: ALUControl = 4'b0000;           // ADD (loads/stores)
            2'b01: ALUControl = 4'b0001;           // SUB (branches)
            2'b10: begin                           // R-type / I-type ALU
                case (funct3)
                    3'b000: ALUControl = (funct7) ? 4'b0001 : 4'b0000; // ADD/SUB
                    3'b001: ALUControl = 4'b0111;  // SLL
                    3'b010: ALUControl = 4'b0101;  // SLT
                    3'b011: ALUControl = 4'b0110;  // SLTU
                    3'b100: ALUControl = 4'b0100;  // XOR
                    3'b101: ALUControl = (funct7) ? 4'b1001 : 4'b1000; // SRL/SRA
                    3'b110: ALUControl = 4'b0011;  // OR
                    3'b111: ALUControl = 4'b0010;  // AND
                    default: ALUControl = 4'b0000;
                endcase
            end
            default: ALUControl = 4'b0000;
        endcase
    end

endmodule
