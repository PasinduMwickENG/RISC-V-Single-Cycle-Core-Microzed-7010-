`timescale 1ns / 1ps

module top (
    input  wire       clk,        // 100 MHz
    output wire       clk_en,
    input  wire       reset_n,
    output wire [7:0] led
);

    assign clk_en = 1'b1;

    // --------------------------------------------------------
    // 100 MHz ? ~20 Hz
    // Toggle every 2_500_000 cycles
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

    // Short power-on reset
    reg [5:0] por_counter = 0;
    wire reset = (por_counter != 6'h3F);

    always @(posedge clk_slow) begin
        if (por_counter != 6'h3F)
            por_counter <= por_counter + 1;
    end

    wire [31:0] pc;

    RISC_V_SingleCycle cpu (
        .clk(clk_slow),
        .reset(reset),
        .PC_out(pc)
    );

    assign led = pc[9:2];

endmodule