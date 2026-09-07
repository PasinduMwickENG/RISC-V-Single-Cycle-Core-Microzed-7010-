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

module ALU (
    input  wire [31:0] A,
    input  wire [31:0] B,
    input  wire [3:0]  ALUControl,
    output reg  [31:0] ALUResult,
    output wire        Zero
);

    always @(*) begin
        case (ALUControl)
            4'b0000: ALUResult = A + B;                                    // ADD
            4'b0001: ALUResult = A - B;                                    // SUB
            4'b0010: ALUResult = A & B;                                    // AND
            4'b0011: ALUResult = A | B;                                    // OR
            4'b0100: ALUResult = A ^ B;                                    // XOR
            4'b0101: ALUResult = ($signed(A) < $signed(B)) ? 32'd1 : 32'd0; // SLT
            4'b0110: ALUResult = (A < B) ? 32'd1 : 32'd0;                  // SLTU
            4'b0111: ALUResult = A << B[4:0];                              // SLL
            4'b1000: ALUResult = A >> B[4:0];                              // SRL
            4'b1001: ALUResult = $signed(A) >>> B[4:0];                    // SRA
            default: ALUResult = 32'h00000000;
        endcase
    end

    // This must be OUTSIDE the always block
    assign Zero = (ALUResult == 32'b0);

endmodule
