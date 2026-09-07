`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2026 10:40:12 AM
// Design Name: 
// Module Name: ImmGen_tb
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

module ImmGen_tb;

    reg  [31:0] Instruction;
    wire [31:0] ImmExt;

    // Instantiate
    ImmGen uut (
        .Instruction(Instruction),
        .ImmExt(ImmExt)
    );

    task test_imm;
        input [31:0] instr;
        input [31:0] expected;
        input [80*8:1] name;      // for printing
        begin
            Instruction = instr;
            #10;
            if (ImmExt === expected)
                $display("PASS | %-10s | Imm = %h", name, ImmExt);
            else
                $display("FAIL | %-10s | Got = %h  Expected = %h", name, ImmExt, expected);
        end
    endtask

    initial begin
        $display("======= Immediate Generator Test =======");

        // I-type example: addi x1, x0, -16     (imm = 0xFFFFFFF0)
        // Instruction: 0xFF000093
        test_imm(32'hFF000093, 32'hFFFFFFF0, "I-type");

        // S-type example: sw x1, 8(x2)         (imm = 8)
        // Instruction: 0x00112423
        test_imm(32'h00112423, 32'h00000008, "S-type");

        // B-type example: beq x1, x2, 16       (imm = 16)
        // Instruction: 0x00208863
        test_imm(32'h00208863, 32'h00000010, "B-type");

        // U-type example: lui x1, 0x12345      (imm = 0x12345000)
        // Instruction: 0x123450B7
        test_imm(32'h123450B7, 32'h12345000, "U-type");

        // J-type example: jal x1, 0x1000       (rough example)
        // Using a known pattern
        test_imm(32'h010000EF, 32'h00001000, "J-type");

        // Negative I-type
        test_imm(32'hFFF00093, 32'hFFFFFFFF, "I-neg");

        $display("======= Test Finished =======");
        $finish;
    end

endmodule
