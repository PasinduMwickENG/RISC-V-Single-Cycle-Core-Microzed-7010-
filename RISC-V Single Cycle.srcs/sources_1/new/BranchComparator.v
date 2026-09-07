`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2026 02:35:47 PM
// Design Name: 
// Module Name: BranchComparator
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

module BranchComparator (
    input  wire [31:0] A,
    input  wire [31:0] B,
    input  wire [2:0]  funct3,
    output reg         TakeBranch
);

    wire signed [31:0] As = A;
    wire signed [31:0] Bs = B;

    always @(*) begin
        case (funct3)
            3'b000: TakeBranch = (A == B);      // BEQ
            3'b001: TakeBranch = (A != B);      // BNE
            3'b100: TakeBranch = (As < Bs);     // BLT
            3'b101: TakeBranch = (As >= Bs);    // BGE
            3'b110: TakeBranch = (A < B);       // BLTU
            3'b111: TakeBranch = (A >= B);      // BGEU
            default: TakeBranch = 1'b0;
        endcase
    end

endmodule
