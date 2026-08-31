`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/28/2026 09:10:44 PM
// Design Name: 
// Module Name: ALU_tb
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



module ALU_tb;

    // Inputs
    reg  [31:0] A;
    reg  [31:0] B;
    reg  [3:0]  ALUControl;

    // Outputs
    wire [31:0] ALUResult;
    wire        Zero;

    // Instantiate the ALU
    ALU uut (
        .A(A),
        .B(B),
        .ALUControl(ALUControl),
        .ALUResult(ALUResult),
        .Zero(Zero)
    );

    // Task to make testing easy
    task do_test;
        input [31:0] a_val;
        input [31:0] b_val;
        input [3:0]  ctrl;
        input [31:0] expected;
        begin
            A = a_val;
            B = b_val;
            ALUControl = ctrl;
            #10;

            if (ALUResult === expected)
                $display("PASS | Ctrl=%b | A=%h B=%h ? Result=%h Zero=%b", 
                         ctrl, a_val, b_val, ALUResult, Zero);
            else
                $display("FAIL | Ctrl=%b | A=%h B=%h ? Got=%h Expected=%h", 
                         ctrl, a_val, b_val, ALUResult, expected);
        end
    endtask

    initial begin
        $display("======= Starting ALU Tests =======");

        // ADD
        do_test(32'h00000005, 32'h00000003, 4'b0000, 32'h00000008);
        do_test(32'hFFFFFFFE, 32'h00000003, 4'b0000, 32'h00000001); // -2 + 3

        // SUB
        do_test(32'h0000000A, 32'h00000003, 4'b0001, 32'h00000007);
        do_test(32'h00000005, 32'h00000008, 4'b0001, 32'hFFFFFFFD); // 5-8 = -3

        // AND / OR / XOR
        do_test(32'hF0F0F0F0, 32'h0F0F0F0F, 4'b0010, 32'h00000000); // AND
        do_test(32'hF0F0F0F0, 32'h0F0F0F0F, 4'b0011, 32'hFFFFFFFF); // OR
        do_test(32'hF0F0F0F0, 32'h0F0F0F0F, 4'b0100, 32'hFFFFFFFF); // XOR

        // SLT (signed)
        do_test(32'h00000005, 32'h0000000A, 4'b0101, 32'h00000001);
        do_test(32'hFFFFFFFE, 32'h00000001, 4'b0101, 32'h00000001); // -2 < 1
        do_test(32'h00000005, 32'h00000005, 4'b0101, 32'h00000000);

        // SLTU (unsigned)
        do_test(32'hFFFFFFFE, 32'h00000001, 4'b0110, 32'h00000000); // big number > 1
        do_test(32'h00000001, 32'hFFFFFFFE, 4'b0110, 32'h00000001);

        // Shifts
        do_test(32'h00000001, 32'h00000004, 4'b0111, 32'h00000010); // SLL
        do_test(32'h00000080, 32'h00000003, 4'b1000, 32'h00000010); // SRL
        do_test(32'h80000000, 32'h00000004, 4'b1001, 32'hF8000000); // SRA

        // Zero flag
        do_test(32'h00000005, 32'h00000005, 4'b0001, 32'h00000000); // 5-5 ? Zero=1

        $display("======= All tests finished =======");
        $finish;
    end

endmodule
