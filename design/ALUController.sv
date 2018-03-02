`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/07/2018 10:10:33 PM
// Design Name: 
// Module Name: ALUController
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


module ALUController(
    
    //Inputs
    input logic [1:0] ALUOp,  //7-bit opcode field from the instruction
    input logic [6:0] Funct7, // bits 25 to 31 of the instruction
    input logic [2:0] Funct3, // bits 12 to 14 of the instruction
    input Branch,
    input Mem,OpI,AUIPC,
    //Output
    output logic [3:0] Operation, //operation selection for ALU
    output logic Con_beq, Con_bnq,  Con_blt, Con_bgt
);

 assign Con_beq = (Branch)&&(Funct3==3'b000);
 assign Con_bnq = (Branch)&&(Funct3==3'b001);
 assign Con_blt = (Branch)&&(Funct3==3'b100||Funct3==3'b110);
 assign Con_bgt = (Branch)&&(Funct3==3'b101||Funct3==3'b111);

 assign Operation[0]= ((ALUOp[1]==1'b1) && (Funct7==7'b0000000) && ((Funct3==3'b110)||(									Funct3==3'b100)||(Funct3==3'b011)))||(Branch&&(Funct3==3'b110||Funct3==3'b111))||(OpI&&(Funct3==3'b100))||(OpI&&(Funct3==3'b110))||(OpI&&Funct3==3'b011);


 assign Operation[1]= (ALUOp==2'b00&&(!OpI)) ||
                     ((ALUOp[1]==1'b1) && (Funct7==7'b0000000) && ((Funct3==3'b000)||(Funct3==3'b100)||(Funct3==3'b010)))||
                     ((ALUOp[1]==1'b1) && (Funct7==7'b0100000) && (Funct3==3'b000))||(ALUOp[0]==1'b1)||Mem||(OpI&&(Funct3==3'b100))||(OpI&&(Funct3==3'b000))||(OpI&&Funct3==3'b010); 



 assign Operation[2]= (ALUOp[0]==1'b1)||((ALUOp[1]==1'b1) && (Funct7==7'b0100000) && (									Funct3==3'b000))||((ALUOp[1]==1'b1) && (Funct7==7'b0000000) && ((Funct3==3'b001)||(Funct3==3'b011))) ||(OpI&&Funct7 == 7'b0100000&&Funct3 == 3'b101) || (ALUOp[1]&&Funct7 == 7'b0100000&&Funct3 == 3'b101)||(OpI&&Funct3 == 3'b001)||(OpI&&Funct3==3'b011);

 assign Operation[3]= (Funct3 == 3'b010&&(!Mem))||(OpI&&Funct3 == 3'b101&&Funct7 == 7'b0000000)||(ALUOp[1]&&(Funct3 == 3'b101))||(OpI&&Funct7 == 7'b0100000&&Funct3 == 3'b101)||(ALUOp[1]&&Funct7 == 7'b0100000&&Funct3 == 3'b101);

endmodule
