`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/28/2026 08:24:28 PM
// Design Name: 
// Module Name: ALU
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


module ALU(

input wire [31:0] A,
input wire [31:0] B,
input wire [3:0] ALUControl,
output reg [31:0] ALUResult,
output reg Zero

    );
reg [31:0] Result;

always @(*) begin
    case (ALUControl)
            4'b0000: Result = A + B;                                                    // ADD
            4'b0001: Result = A - B;                                                    // SUB
            4'b0010: Result = A & B;                                                    // AND
            4'b0011: Result = A | B;                                                    // OR
            4'b0100: Result = A ^ B;                                                    // XOR
            4'b0101: Result = ($signed(A) < $signed(B)) ? 32'd1 : 32'd0;                // SLT
            4'b0110: Result = (A < B) ? 32'd1 : 32'd0;                                  // SLTU
            4'b0111: Result = A << B[4:0];                                              // SLL (only lower 5 bits)
            4'b1000: Result = A >> B[4:0];                                              // SRL
            4'b1001: Result = $signed(A) >>> B[4:0];                                    // SRA (arithmetic)
            default: Result = 32'hXXXXXXXX;                                             // Undefined → easy to spot
    endcase


assign Zero = (Result == 32'd0);
assign ALUResult = Result;

end
endmodule
