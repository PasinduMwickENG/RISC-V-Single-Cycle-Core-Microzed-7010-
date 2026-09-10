`timescale 1ns / 1ps

module top (
    input  wire       clk,
    output wire       clk_en,
    input  wire       reset_n,
    output wire [7:0] led
);

    // Enable carrier oscillator
    assign clk_en = 1'b1;

    // --------------------------------------------------------
    // Slow clock (~20 Hz)
    // --------------------------------------------------------
    reg [21:0] div_counter = 0;
    reg        clk_slow = 0;

    always @(posedge clk) begin
        if (div_counter == 22'd2_499_999) begin
            div_counter <= 0;
            clk_slow    <= ~clk_slow;
        end else begin
            div_counter <= div_counter + 1;
        end
    end

    // --------------------------------------------------------
    // Power-on reset
    // --------------------------------------------------------
    reg [5:0] por_counter = 0;
    wire reset = (por_counter != 6'h3F);

    always @(posedge clk_slow) begin
        if (por_counter != 6'h3F)
            por_counter <= por_counter + 1;
    end

    // --------------------------------------------------------
    // Debug signals
    // --------------------------------------------------------
    (* mark_debug = "true" *) wire [31:0] pc;
    (* mark_debug = "true" *) wire [31:0] instruction;
    (* mark_debug = "true" *) wire [31:0] alu_result;
    (* mark_debug = "true" *) wire [31:0] x1;
    (* mark_debug = "true" *) wire [31:0] x2;
    (* mark_debug = "true" *) wire [31:0] x3;
    (* mark_debug = "true" *) wire [31:0] mem_data;

    // --------------------------------------------------------
    // RISC-V Core
    // --------------------------------------------------------
    RISC_V_SingleCycle cpu (
        .clk             (clk_slow),
        .reset           (reset),
        .PC_out          (pc),
        .Instruction_out (instruction),
        .ALUResult_out   (alu_result),
        .x1_out          (x1),
        .x2_out          (x2),
        .x3_out          (x3),
        .MemData_out     (mem_data)
    );

    // Show PC on LEDs
    assign led = pc[9:2];

endmodule