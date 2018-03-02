`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/07/2018 10:10:33 PM
// Design Name: 
// Module Name: Controller
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

module Controller(
    
    //Input
    input logic [6:0] Opcode, //7-bit opcode field from the instruction
    
    //Outputs
    output logic ALUSrc,//0: The second ALU operand comes from the second register file output (Read data 2); 
                  //1: The second ALU operand is the sign-extended, lower 16 bits of the instruction.
    output logic MemtoReg,RegtoMem, //0: The value fed to the register Write data input comes from the ALU.
                     //1: The value fed to the register Write data input comes from the data memory.
    output logic RegWrite, //The register on the Write register input is written with the value on the Write data input 
    output logic MemRead,  //Data memory contents designated by the address input are put on the Read data output
    output logic MemWrite, //Data memory contents designated by the address input are replaced by the value on the Write data input.
    output logic Branch,
    output logic [1:0] ALUOp,
    output logic Con_Jalr,Con_Jal,Mem,OpI,Con_AUIPC,Con_LUI

);

//    localparam R_TYPE = 7'b0110011;
//    localparam LW     = 7'b0000011;
//    localparam SW     = 7'b0100011;
//    localparam BR     = 7'b1100011;
//    localparam RTypeI = 7'b0010011; //addi,ori,andi
    
    logic [6:0] R_TYPE, LW, SW, RTypeI, BR, JALR, JAL,AUIPC,LUI;
    assign  BR     = 7'b1100011;
    assign  R_TYPE = 7'b0110011;
    assign  LW     = 7'b0000011;
    assign  SW     = 7'b0100011;
    assign  RTypeI = 7'b0010011; //addi,ori,andi
    assign  JAL = 7'b1101111;
    assign  JALR = 7'b1100111;
    assign  AUIPC = 7'b0010111;
    assign  LUI = 7'b0110111;

  assign Con_Jal = (Opcode == JAL);  
  assign Con_Jalr = (Opcode == JALR);  
  assign Branch = (Opcode == BR);  
  assign ALUSrc   = (Opcode==LW || Opcode==SW || Opcode == RTypeI);
  assign MemtoReg = (Opcode==LW);
  assign RegtoMem = (Opcode==SW);
  assign RegWrite = (Opcode==R_TYPE || Opcode==LW || Opcode == RTypeI || Opcode == JALR || Opcode == JAL);
  assign Mem = (Opcode==LW||Opcode==SW);
  assign MemRead  = (Opcode==LW);
  assign MemWrite = (Opcode==SW||Opcode == JALR);
  assign ALUOp[0] = (Opcode==BR);
  assign OpI = (Opcode==RTypeI);
  assign ALUOp[1] = (Opcode==R_TYPE);
  assign Con_AUIPC = (Opcode==AUIPC);
  assign Con_LUI = (Opcode==LUI);
  

endmodule
