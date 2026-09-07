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

`timescale 1ns / 1ps

module InstructionMemory (
    input  wire [31:0] Address,
    output reg  [31:0] Instruction
);

    always @(*) begin
        case (Address[9:2])
            8'd0:  Instruction = 32'h00500093; // addi x1, x0, 5
            8'd1:  Instruction = 32'h00A00113; // addi x2, x0, 10
            8'd2:  Instruction = 32'h002081B3; // add  x3, x1, x2
            8'd3:  Instruction = 32'h00302023; // sw   x3, 0(x0)
            8'd4:  Instruction = 32'h00002203; // lw   x4, 0(x0)
            8'd5:  Instruction = 32'h00101023; // sh   x1, 0(x0)
            8'd6:  Instruction = 32'h00101283; // lh   x5, 0(x0)
            8'd7:  Instruction = 32'h002000A3; // sb   x2, 1(x0)
            8'd8:  Instruction = 32'h00100303; // lb   x6, 1(x0)
            default: Instruction = 32'h00000013; // nop
        endcase
    end

endmodule
