`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2026 02:36:26 PM
// Design Name: 
// Module Name: LoadExtender
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

module LoadExtender (
    input  wire [31:0] MemData,
    input  wire [1:0]  Addr,
    input  wire [2:0]  funct3,
    output reg  [31:0] ExtData
);

    always @(*) begin
        case (funct3)
            3'b000: begin // LB
                case (Addr)
                    2'b00: ExtData = {{24{MemData[7]}},  MemData[7:0]};
                    2'b01: ExtData = {{24{MemData[15]}}, MemData[15:8]};
                    2'b10: ExtData = {{24{MemData[23]}}, MemData[23:16]};
                    2'b11: ExtData = {{24{MemData[31]}}, MemData[31:24]};
                endcase
            end
            3'b001: begin // LH
                case (Addr[1])
                    1'b0: ExtData = {{16{MemData[15]}}, MemData[15:0]};
                    1'b1: ExtData = {{16{MemData[31]}}, MemData[31:16]};
                endcase
            end
            3'b010: ExtData = MemData; // LW
            3'b100: begin // LBU
                case (Addr)
                    2'b00: ExtData = {24'b0, MemData[7:0]};
                    2'b01: ExtData = {24'b0, MemData[15:8]};
                    2'b10: ExtData = {24'b0, MemData[23:16]};
                    2'b11: ExtData = {24'b0, MemData[31:24]};
                endcase
            end
            3'b101: begin // LHU
                case (Addr[1])
                    1'b0: ExtData = {16'b0, MemData[15:0]};
                    1'b1: ExtData = {16'b0, MemData[31:16]};
                endcase
            end
            default: ExtData = MemData;
        endcase
    end

endmodule
