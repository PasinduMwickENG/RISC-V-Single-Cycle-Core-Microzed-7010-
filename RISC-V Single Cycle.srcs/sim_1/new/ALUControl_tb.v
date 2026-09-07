`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2026 11:49:01 AM
// Design Name: 
// Module Name: ALUControl_tb
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

module ALUControl_tb;

    reg  [1:0] ALUOp;
    reg  [2:0] funct3;
    reg        funct7;
    wire [3:0] ALUControl;

    // Instantiate
    ALUControl uut (
        .ALUOp(ALUOp),
        .funct3(funct3),
        .funct7(funct7),
        .ALUControl(ALUControl)
    );

    task test;
        input [1:0] op;
        input [2:0] f3;
        input       f7;
        input [3:0] expected;
        input [20*8:1] name;
        begin
            ALUOp  = op;
            funct3 = f3;
            funct7 = f7;
            #5;
            if (ALUControl === expected)
                $display("PASS | %-8s ? ALUControl = %b", name, ALUControl);
            else
                $display("FAIL | %-8s ? Got %b  Expected %b", name, ALUControl, expected);
        end
    endtask

    initial begin
        $display("======= ALU Control Test =======");

        // Load / Store ? ADD
        test(2'b00, 3'b010, 1'b0, 4'b0000, "Load/Store");

        // Branch ? SUB
        test(2'b01, 3'b000, 1'b0, 4'b0001, "Branch");

        // R-type / I-type
        test(2'b10, 3'b000, 1'b0, 4'b0000, "ADD");
        test(2'b10, 3'b000, 1'b1, 4'b0001, "SUB");
        test(2'b10, 3'b111, 1'b0, 4'b0010, "AND");
        test(2'b10, 3'b110, 1'b0, 4'b0011, "OR");
        test(2'b10, 3'b100, 1'b0, 4'b0100, "XOR");
        test(2'b10, 3'b010, 1'b0, 4'b0101, "SLT");
        test(2'b10, 3'b011, 1'b0, 4'b0110, "SLTU");
        test(2'b10, 3'b001, 1'b0, 4'b0111, "SLL");
        test(2'b10, 3'b101, 1'b0, 4'b1000, "SRL");
        test(2'b10, 3'b101, 1'b1, 4'b1001, "SRA");

        $display("======= Test Finished =======");
        $finish;
    end

endmodule
