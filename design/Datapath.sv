`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/07/2018 10:10:33 PM
// Design Name: 
// Module Name: Datapath
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

module Datapath #(
    parameter PC_W = 9, // Program Counter
    parameter INS_W = 32, // Instruction Width
    parameter RF_ADDRESS = 5, // Register File Address
    parameter DATA_W = 32, // Data WriteData
    parameter DM_ADDRESS = 9, // Data Memory Address
    parameter ALU_CC_W = 4 // ALU Control Code Width
    )(
    input logic clk , reset , // global clock
    // reset , sets the PC to zero
    RegWrite , MemtoReg ,RegtoMem, //R- file writing enable // Memory or ALU MUX
    ALUsrc , MemWrite , //R- file or Immediate MUX // Memroy Writing Enable
    MemRead , // Memroy Reading Enable
    input logic Con_beq, 
    input logic Con_bnq, 
    input logic Con_bgt, 
    input logic Con_blt,
    input logic Con_Jalr,
    input logic Jal,
    input logic AUIPC, LUI, 
    input logic [ ALU_CC_W -1:0] ALU_CC, // ALU Control Code ( input of the ALU )
    output logic [6:0] opcode,
    output logic [6:0] Funct7,
    output logic [2:0] Funct3,
    output logic [31:0] ALU_Result
    );

logic [8:0] PC, PCPlus4, PCValue, BranchPC;
logic [31:0] Instr, PCPlusImm, PCJalr, LD,ST, Store_data;
logic [31:0] Result;
logic [31:0] Reg1, Reg2;
logic [31:0] ReadData;
logic [31:0] SrcB, ALUResult;
logic [31:0] ExtImm;
logic [31:0] PC_unsign_extend;
logic [31:0] Read_Alu_Result, Jal_test,aui_data, lui_data;
logic [1:0] PCSel;
logic zero, Con_BLT, Con_BGT, Jalr, Branch; 


// next PC
    assign PC_unsign_extend = {23'b0, PC};
    assign Branch = (Con_beq&&zero)||(Con_bnq&&!zero)||(Con_bgt&&Con_BGT)||(Con_blt&&Con_BLT)||Jal;
    assign Jalr = Con_Jalr;

    adder #(9) pcadd1 (PC, 9'b100, PCPlus4);
    adder_32 #(32) pcadd2 (PC_unsign_extend, ExtImm, PCPlusImm);
    adder_32 #(32) pcadd3 (ExtImm, Reg1, PCJalr);
    mux2 next_pc1(PCPlus4,PCPlusImm[8:0], Branch, BranchPC);
    mux2 next_pc2(BranchPC, PCJalr[8:0], Jalr, PCValue);

    flopr #(9) pcreg(clk, reset, PCValue, PC);

 //Instruction memory
    instructionmemory instr_mem (PC, Instr);
    
    assign opcode = Instr[6:0];
    assign Funct7 = Instr[31:25];
    assign Funct3 = Instr[14:12];

// //Register File
    data_extract store_data_ex(Instr, Reg2, ST);
    mux2 #(32) resmux_store(Reg2, ST, RegtoMem, Store_data);

    RegFile rf(clk, reset, RegWrite, Instr[11:7], Instr[19:15], Instr[24:20],
            Result, Reg1, Reg2);
    
    mux2 #(32) resmux(ALUResult, LD, MemtoReg, Read_Alu_Result);
    mux2 #(32) resmux_jal(Read_Alu_Result, {23'b0, PCPlus4}, (Jal||Jalr), Jal_test);
    mux2 #(32) resmux_auipc(Jal_test, PCPlusImm, AUIPC, aui_data);
    mux2 #(32) resmux_lui(aui_data, ExtImm, LUI, Result);


//// sign extend
    imm_Gen Ext_Imm (Instr,ExtImm);

//// ALU
    mux2 #(32) srcbmux(Reg2, ExtImm, (ALUsrc||Jal||Jalr), SrcB);
    alu alu_module(Reg1, SrcB, ALU_CC, ALUResult, Con_BLT, Con_BGT, zero);

    assign ALU_Result = Result;//[15:0];
    
////// Data memory
    data_extract load_data_ex(Instr, ReadData, LD);

    datamemory data_mem (clk, MemRead, MemWrite, ALUResult[8:0], Store_data, ReadData);   

endmodule