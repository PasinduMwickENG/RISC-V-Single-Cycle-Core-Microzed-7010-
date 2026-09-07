`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2026 09:48:18 AM
// Design Name: 
// Module Name: RegisterFile
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

module RegisterFile (
    input  wire        clk,
    input  wire        we,          // Write Enable
    input  wire [4:0]  ra1,         // Read Address 1 (rs1)
    input  wire [4:0]  ra2,         // Read Address 2 (rs2)
    input  wire [4:0]  wa,          // Write Address (rd)
    input  wire [31:0] wd,          // Write Data
    output wire [31:0] rd1,         // Read Data 1
    output wire [31:0] rd2          // Read Data 2
);

    // 32 registers, each 32-bit
    reg [31:0] registers [0:31];

    // Initialize all registers to 0 (important for simulation)
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1)
            registers[i] = 32'b0;
    end

    // Synchronous Write (only if we=1 and not writing to x0)
    always @(posedge clk) begin
        if (we && (wa != 5'd0)) begin
            registers[wa] <= wd;
        end
    end

    // Asynchronous Reads
    // x0 always returns 0
    assign rd1 = (ra1 == 5'd0) ? 32'b0 : registers[ra1];
    assign rd2 = (ra2 == 5'd0) ? 32'b0 : registers[ra2];

endmodule
