`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2026 12:32:48 PM
// Design Name: 
// Module Name: Memory_tb
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

module Memory_tb;

    // ---------- Instruction Memory signals ----------
    reg  [31:0] im_addr;
    wire [31:0] instruction;

    // ---------- Data Memory signals ----------
    reg         clk;
    reg         MemWrite, MemRead;
    reg  [31:0] dm_addr, WriteData;
    wire [31:0] ReadData;

    // Instantiate Instruction Memory
    InstructionMemory imem (
        .Address(im_addr),
        .Instruction(instruction)
    );

    // Instantiate Data Memory
    DataMemory dmem (
        .clk(clk),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .Address(dm_addr),
        .WriteData(WriteData),
        .ReadData(ReadData)
    );

    // Clock
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        MemWrite = 0;
        MemRead  = 0;
        dm_addr  = 0;
        WriteData = 0;
        im_addr  = 0;

        $display("======= Memory Test Started =======");

        // Wait a little for $readmemh to finish
        #20;

        // ---- Test Instruction Memory ----
        $display("\n--- Instruction Memory ---");
        im_addr = 32'h00000000; #10;
        $display("Addr 0x00 ? Instruction = %h", instruction);

        im_addr = 32'h00000004; #10;
        $display("Addr 0x04 ? Instruction = %h", instruction);

        im_addr = 32'h00000008; #10;
        $display("Addr 0x08 ? Instruction = %h", instruction);

        // ---- Test Data Memory ----
        $display("\n--- Data Memory ---");

        // Write some values
        MemWrite = 1;
        MemRead  = 0;

        dm_addr   = 32'h00000000;
        WriteData = 32'hDEADBEEF;
        #10;   // wait posedge

        dm_addr   = 32'h00000004;
        WriteData = 32'hCAFEBABE;
        #10;

        dm_addr   = 32'h00000008;
        WriteData = 32'h12345678;
        #10;

        MemWrite = 0;

        // Read them back
        MemRead = 1;

        dm_addr = 32'h00000000; #10;
        $display("Read Addr 0x00 = %h (Expected DEADBEEF)", ReadData);

        dm_addr = 32'h00000004; #10;
        $display("Read Addr 0x04 = %h (Expected CAFEBABE)", ReadData);

        dm_addr = 32'h00000008; #10;
        $display("Read Addr 0x08 = %h (Expected 12345678)", ReadData);

        $display("\n======= Memory Test Finished =======");
        $finish;
    end

endmodule
