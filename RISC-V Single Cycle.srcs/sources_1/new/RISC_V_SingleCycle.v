`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2026 02:17:40 PM
// Design Name: 
// Module Name: RISC_V_SingleCycle
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

module RISC_V_SingleCycle (
    input  wire        clk,
    input  wire        reset,
    output wire [31:0] PC_out
);

    wire [31:0] PC, PC_Next, PC_Plus4;
    wire [31:0] Instruction;
    wire [31:0] ImmExt;
    wire [31:0] RD1, RD2;
    wire [31:0] ALUResult;
    wire [31:0] MemReadData;
    wire [31:0] LoadData;
    wire [31:0] WriteBackData;
    wire [31:0] ALU_B;

    wire        RegWrite, ALUSrc, MemWrite, MemRead;
    wire        Branch, MemtoReg, Jump;
    wire [1:0]  ALUOp;
    wire [3:0]  ALUControl;
    wire        Zero;
    wire        TakeBranch;
    wire        PCSrc;
    wire [31:0] BranchTarget, JumpTarget;

    // Program Counter
    ProgramCounter PC_reg (
        .clk(clk),
        .reset(reset),
        .PC_Next(PC_Next),
        .PC(PC)
    );

    assign PC_out   = PC;
    assign PC_Plus4 = PC + 32'd4;

    // Instruction Memory
    InstructionMemory IMEM (
        .Address(PC),
        .Instruction(Instruction)
    );

    // Control Unit
    ControlUnit CU (
        .opcode(Instruction[6:0]),
        .funct3(Instruction[14:12]),
        .RegWrite(RegWrite),
        .ALUSrc(ALUSrc),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .Branch(Branch),
        .MemtoReg(MemtoReg),
        .ALUOp(ALUOp),
        .Jump(Jump)
    );

    // Immediate Generator
    ImmGen IMM (
        .Instruction(Instruction),
        .ImmExt(ImmExt)
    );

    // Register File
    RegisterFile RF (
        .clk(clk),
        .we(RegWrite),
        .ra1(Instruction[19:15]),
        .ra2(Instruction[24:20]),
        .wa(Instruction[11:7]),
        .wd(WriteBackData),
        .rd1(RD1),
        .rd2(RD2)
    );

    // ALU Control
    ALUControl ALU_CTRL (
        .ALUOp(ALUOp),
        .funct3(Instruction[14:12]),
        .funct7(Instruction[30]),
        .ALUControl(ALUControl)
    );

    assign ALU_B = ALUSrc ? ImmExt : RD2;

    // ALU
    ALU ALU_inst (
        .A(RD1),
        .B(ALU_B),
        .ALUControl(ALUControl),
        .ALUResult(ALUResult),
        .Zero(Zero)
    );

    // Branch Comparator
    BranchComparator BR_COMP (
        .A(RD1),
        .B(RD2),
        .funct3(Instruction[14:12]),
        .TakeBranch(TakeBranch)
    );

    // Data Memory
    DataMemory DMEM (
        .clk(clk),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .funct3(Instruction[14:12]),
        .Address(ALUResult),
        .WriteData(RD2),
        .ReadData(MemReadData)
    );

    // Load Extender
    LoadExtender LOAD_EXT (
        .MemData(MemReadData),
        .Addr(ALUResult[1:0]),
        .funct3(Instruction[14:12]),
        .ExtData(LoadData)
    );

    // Write-back
    assign WriteBackData = Jump ? PC_Plus4 :
                           (MemtoReg ? LoadData : ALUResult);

    // Next PC logic
    assign BranchTarget = PC + ImmExt;
    assign JumpTarget   = (Instruction[6:0] == 7'b1100111) ?
                          ((RD1 + ImmExt) & ~32'd1) : (PC + ImmExt);

    assign PCSrc  = (Branch & TakeBranch) | Jump;
    assign PC_Next = PCSrc ? (Jump ? JumpTarget : BranchTarget) : PC_Plus4;

endmodule