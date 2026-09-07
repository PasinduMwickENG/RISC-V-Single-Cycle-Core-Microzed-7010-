`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2026 12:24:21 PM
// Design Name: 
// Module Name: DataMemory
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

module DataMemory (
    input  wire        clk,
    input  wire        MemWrite,
    input  wire        MemRead,
    input  wire [2:0]  funct3,       // to know sb/sh/sw
    input  wire [31:0] Address,
    input  wire [31:0] WriteData,
    output reg  [31:0] ReadData
);

    reg [31:0] memory [0:255];

    integer i;
    initial begin
        for (i = 0; i < 256; i = i + 1)
            memory[i] = 32'b0;
    end

    // Write with byte enables
    always @(posedge clk) begin
        if (MemWrite) begin
            case (funct3)
                3'b000: begin // SB
                    case (Address[1:0])
                        2'b00: memory[Address[9:2]][7:0]   <= WriteData[7:0];
                        2'b01: memory[Address[9:2]][15:8]  <= WriteData[7:0];
                        2'b10: memory[Address[9:2]][23:16] <= WriteData[7:0];
                        2'b11: memory[Address[9:2]][31:24] <= WriteData[7:0];
                    endcase
                end
                3'b001: begin // SH
                    case (Address[1])
                        1'b0: memory[Address[9:2]][15:0]  <= WriteData[15:0];
                        1'b1: memory[Address[9:2]][31:16] <= WriteData[15:0];
                    endcase
                end
                3'b010: memory[Address[9:2]] <= WriteData; // SW
            endcase
        end
    end

    // Read full word (extension done later)
    always @(*) begin
        if (MemRead)
            ReadData = memory[Address[9:2]];
        else
            ReadData = 32'b0;
    end

endmodule
