`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2026 09:55:18 AM
// Design Name: 
// Module Name: RegisterFile_tb
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

module RegisterFile_tb;

    // Inputs
    reg         clk;
    reg         we;
    reg  [4:0]  ra1, ra2, wa;
    reg  [31:0] wd;

    // Outputs
    wire [31:0] rd1, rd2;

    // Instantiate the Register File
    RegisterFile uut (
        .clk(clk),
        .we(we),
        .ra1(ra1),
        .ra2(ra2),
        .wa(wa),
        .wd(wd),
        .rd1(rd1),
        .rd2(rd2)
    );

    // Clock generation (10ns period)
    always #5 clk = ~clk;

    // Task for easier testing
    task write_reg;
        input [4:0]  addr;
        input [31:0] data;
        begin
            @(negedge clk);          // setup before rising edge
            we  = 1;
            wa  = addr;
            wd  = data;
            @(posedge clk);          // write happens here
            #1;                      // small delay
            we  = 0;
        end
    endtask

    initial begin
        // Initialize
        clk = 0;
        we  = 0;
        ra1 = 0;
        ra2 = 0;
        wa  = 0;
        wd  = 0;

        $display("======= Register File Test Started =======");

        //--------------------------------------------------
        // Test 1: Write to several registers and read back
        //--------------------------------------------------
        write_reg(5'd1, 32'hAAAA_1111);
        write_reg(5'd2, 32'hBBBB_2222);
        write_reg(5'd3, 32'hCCCC_3333);
        write_reg(5'd31,32'hDEAD_BEEF);

        // Read them
        ra1 = 5'd1; ra2 = 5'd2; #10;
        $display("Read x1=%h  x2=%h  (Expected AAAA1111 and BBBB2222)", rd1, rd2);

        ra1 = 5'd3; ra2 = 5'd31; #10;
        $display("Read x3=%h  x31=%h (Expected CCCC3333 and DEADBEEF)", rd1, rd2);

        //--------------------------------------------------
        // Test 2: x0 is hardwired to 0
        //--------------------------------------------------
        write_reg(5'd0, 32'hFFFFFFFF);   // try to write to x0

        ra1 = 5'd0; ra2 = 5'd1; #10;
        $display("Read x0=%h  (must be 00000000)   x1=%h", rd1, rd2);

        //--------------------------------------------------
        // Test 3: Simultaneous read of same register
        //--------------------------------------------------
        ra1 = 5'd2; ra2 = 5'd2; #10;
        $display("Both ports reading x2 ? rd1=%h  rd2=%h", rd1, rd2);

        //--------------------------------------------------
        // Test 4: Write enable = 0 (should not write)
        //--------------------------------------------------
        @(negedge clk);
        we = 0;
        wa = 5'd5;
        wd = 32'h1234_5678;
        @(posedge clk);
        #1;

        ra1 = 5'd5; #10;
        $display("Tried to write x5 with we=0 ? x5 = %h (should still be 0)", rd1);

        //--------------------------------------------------
        // Test 5: Read after write (same cycle behavior check)
        //--------------------------------------------------
        write_reg(5'd10, 32'hCAFE_BABE);
        ra1 = 5'd10; #1;
        $display("After writing CAFEBABE to x10 ? rd1 = %h", rd1);

        $display("======= Register File Test Finished =======");
        $finish;
    end

endmodule
