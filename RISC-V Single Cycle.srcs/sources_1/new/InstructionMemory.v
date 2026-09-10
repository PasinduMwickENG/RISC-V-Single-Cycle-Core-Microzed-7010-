`timescale 1ns / 1ps

module InstructionMemory (
    input  wire [31:0] Address,
    output reg  [31:0] Instruction
);

    always @(*) begin
        case (Address[9:2])

            // ========== Basic ALU Immediate ==========
            8'd0:  Instruction = 32'h00500093; // addi  x1, x0, 5        ? x1 = 5
            8'd1:  Instruction = 32'h00A00113; // addi  x2, x0, 10       ? x2 = 10
            8'd2:  Instruction = 32'h002081B3; // add   x3, x1, x2       ? x3 = 15
            8'd3:  Instruction = 32'h40208233; // sub   x4, x1, x2       ? x4 = -5
            8'd4:  Instruction = 32'h0020F2B3; // and   x5, x1, x2       ? x5 = 0
            8'd5:  Instruction = 32'h0020E333; // or    x6, x1, x2       ? x6 = 15
            8'd6:  Instruction = 32'h0020C3B3; // xor   x7, x1, x2       ? x7 = 15

            // ========== Shifts ==========
            8'd7:  Instruction = 32'h00111413; // slli  x8, x2, 1        ? x8 = 20
            8'd8:  Instruction = 32'h00115493; // srli  x9, x2, 1        ? x9 = 5
            8'd9:  Instruction = 32'h40115513; // srai  x10, x2, 1       ? x10 = 5

            // ========== Set Less Than ==========
            8'd10: Instruction = 32'h0020A593; // slti  x11, x1, 2       ? x11 = 0
            8'd11: Instruction = 32'h00A0B613; // sltiu x12, x1, 10      ? x12 = 1

            // ========== Store / Load ==========
            8'd12: Instruction = 32'h00302023; // sw    x3, 0(x0)        ? Mem[0] = 15
            8'd13: Instruction = 32'h00002703; // lw    x14, 0(x0)       ? x14 = 15
            8'd14: Instruction = 32'h00101223; // sh    x1, 4(x0)
            8'd15: Instruction = 32'h00401783; // lh    x15, 4(x0)       ? x15 = 5
            8'd16: Instruction = 32'h001000A3; // sb    x1, 1(x0)
            8'd17: Instruction = 32'h00104803; // lbu   x16, 1(x0)       ? x16 = 5

            // ========== LUI ==========
            8'd18: Instruction = 32'h123458B7; // lui   x17, 0x12345     ? x17 = 0x12345000

            // ========== LOOP back to address 0 ==========
            8'd19: Instruction = 32'hFE9FF06F; // jal   x0, -28         ? jump back to address 0

            default: Instruction = 32'h00000013; // nop
        endcase
    end

endmodule