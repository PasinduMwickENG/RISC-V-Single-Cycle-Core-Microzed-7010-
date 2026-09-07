`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2026 02:19:07 PM
// Design Name: 
// Module Name: RISC_V_tb
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

module RISC_V_tb;

    reg clk;
    reg reset;
    integer error_count;

    RISC_V_SingleCycle dut (
        .clk(clk),
        .reset(reset)
    );

    always #5 clk = ~clk;

    task check_reg;
        input [4:0]  reg_num;
        input [31:0] expected;
        input [40*8:1] name;
        begin
            #1;
            if (dut.RF.registers[reg_num] !== expected) begin
                $display("FAIL: %s ? x%0d = %h (Expected %h)", 
                         name, reg_num, dut.RF.registers[reg_num], expected);
                error_count = error_count + 1;
            end else begin
                $display("PASS: %s ? x%0d = %h", name, reg_num, expected);
            end
        end
    endtask

    initial begin
        clk = 0;
        reset = 1;
        error_count = 0;

        $display("==================================================");
        $display("     RISC-V Single Cycle - Full Instruction Test  ");
        $display("==================================================");

        #20;
        reset = 0;

        #250;   // enough time for the program

        $display("\n----------- Checking Register Values -----------");

        check_reg(5'd1, 32'd5,  "addi x1, x0, 5");
        check_reg(5'd2, 32'd10, "addi x2, x0, 10");
        check_reg(5'd3, 32'd15, "add  x3, x1, x2");
        check_reg(5'd4, 32'd15, "lw   x4, 0(x0)");
        check_reg(5'd5, 32'd5,  "lh   x5, 0(x0)");
        check_reg(5'd6, 32'd10, "lb   x6, 1(x0)");

        $display("--------------------------------------------------");
        if (error_count == 0)
            $display("**** ALL TESTS PASSED ****");
        else
            $display("**** %0d TEST(S) FAILED ****", error_count);
        $display("==================================================");

        $finish;
    end

    always @(posedge clk) begin
        if (!reset)
            $display("Time=%0t  PC=%h  Inst=%h", $time, dut.PC, dut.Instruction);
    end

endmodule