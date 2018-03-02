`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/07/2018 10:22:44 PM
// Design Name: 
// Module Name: imm_Gen
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


module imm_Gen(
    input logic [31:0] inst_code,
    output logic [31:0] Imm_out);

    logic [4:0] srai;
    assign srai = inst_code[24:20];

always_comb
    case(inst_code[6:0])
        7'b0000011 /*I-type load*/     : 
            Imm_out = {inst_code[31]? {20{1'b1}}:20'b0 , inst_code[31:20]};
        7'b0010011 /*I-type addi*/     :
            begin 
            if((inst_code[31:25]==7'b0100000&&inst_code[14:12]==3'b101)||(inst_code[14:12]==3'b001)||inst_code[14:12]==3'b101)
                Imm_out = {srai[4]? {27{1'b1}}:27'b0,srai};
            else
                Imm_out = {inst_code[31]? 20'b1:20'b0 , inst_code[31:20]};
            end
        7'b0100011 /*S-type*/    : 
            Imm_out = {inst_code[31]? 20'b1:20'b0 , inst_code[31:25], inst_code[11:7]};
        7'b1100011 /*B-type*/    : 
            Imm_out = {inst_code[31]? 20'b1:20'b0 , inst_code[7], inst_code[30:25],inst_code[11:8],1'b0};
        7'b1100111 /*JALR*/    : 
            Imm_out = {inst_code[31]? 20'b1:20'b0 , inst_code[30:25], inst_code[24:21], inst_code[20]};
        7'b0010111 /*U-type*/    : 
            Imm_out = {inst_code[31]? 1'b1:1'b0 , inst_code[30:20], inst_code[19:12],12'b0};
        7'b0110111 /*LUI-type*/    : 
            Imm_out = {inst_code[31:12], 12'b0};
        7'b0110111 /*AUIPC-type*/    : 
            Imm_out = {inst_code[31:12], 12'b0};
        7'b1101111 /*JAL*/    : 
            Imm_out = {inst_code[31]? 20'b1:20'b0 , inst_code[19:12], inst_code[19:12],inst_code[20], inst_code[30:25],inst_code[24:21],1'b0};
        default                    : 
            Imm_out = {32'b0};
    endcase
    
endmodule
