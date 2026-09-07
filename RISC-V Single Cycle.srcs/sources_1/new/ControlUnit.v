`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2026 02:10:58 PM
// Design Name: 
// Module Name: ControlUnit
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

module ControlUnit (
    input  wire [6:0] opcode,
    input  wire [2:0] funct3,

    output reg        RegWrite,
    output reg        ALUSrc,
    output reg        MemWrite,
    output reg        MemRead,
    output reg        Branch,
    output reg        MemtoReg,
    output reg [1:0]  ALUOp,
    output reg        Jump
);

    always @(*) begin
        RegWrite = 0;
        ALUSrc   = 0;
        MemWrite = 0;
        MemRead  = 0;
        Branch   = 0;
        MemtoReg = 0;
        ALUOp    = 2'b00;
        Jump     = 0;

        case (opcode)
            7'b0110011: begin // R-type
                RegWrite = 1;
                ALUOp    = 2'b10;
            end
            7'b0010011: begin // I-type ALU
                RegWrite = 1;
                ALUSrc   = 1;
                ALUOp    = 2'b10;
            end
            7'b0000011: begin // Loads
                RegWrite = 1;
                ALUSrc   = 1;
                MemRead  = 1;
                MemtoReg = 1;
                ALUOp    = 2'b00;
            end
            7'b0100011: begin // Stores
                ALUSrc   = 1;
                MemWrite = 1;
                ALUOp    = 2'b00;
            end
            7'b1100011: begin // Branches
                Branch   = 1;
                ALUOp    = 2'b01;
            end
            7'b1101111: begin // JAL
                RegWrite = 1;
                Jump     = 1;
            end
            7'b1100111: begin // JALR
                RegWrite = 1;
                ALUSrc   = 1;
                Jump     = 1;
                ALUOp    = 2'b00;
            end
            7'b0110111: begin // LUI
                RegWrite = 1;
                ALUSrc   = 1;
            end
            7'b0010111: begin // AUIPC
                RegWrite = 1;
                ALUSrc   = 1;
            end
        endcase
    end

endmodule

