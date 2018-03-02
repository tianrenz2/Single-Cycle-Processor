`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/07/2018 10:23:43 PM
// Design Name: 
// Module Name: alu
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


module alu#(
        parameter DATA_WIDTH = 32,
        parameter OPCODE_LENGTH = 4
        )(
        input logic [DATA_WIDTH-1:0]    SrcA,
        input logic [DATA_WIDTH-1:0]    SrcB,

        input logic [OPCODE_LENGTH-1:0]    Operation,
        output logic[DATA_WIDTH-1:0] ALUResult,
        output logic Con_BLT, 
        output logic Con_BGT,
        output logic zero
        );

        integer      i;
        always_comb
        begin
            ALUResult = 'd0;
            Con_BLT = 'b0;
            Con_BGT = 'b0;
            zero = 'b0;
            case(Operation)
            4'b0000:        // AND
                    ALUResult = SrcA & SrcB;
            4'b0001:        //OR
                    ALUResult = SrcA | SrcB;
            4'b0011:        //XOR
                    ALUResult = SrcA ^ SrcB;
            4'b0010:        //ADD
                    ALUResult = SrcA + SrcB;
            4'b0110: begin       //Subtract
                    ALUResult = $signed(SrcA) - $signed(SrcB);
                    Con_BLT = ($signed(ALUResult) < $signed(1'd0));
                    Con_BGT = ($signed(ALUResult) > $signed(1'd0));
                    zero = ($signed(ALUResult) == $signed(1'd0));
                    end
            4'b0100:        //SLL
                    ALUResult = SrcA << SrcB;
            4'b0101:
                    ALUResult = SrcA < SrcB;
            4'b1010:
                    ALUResult = ($signed(SrcA)<$signed(SrcB));
            4'b0111:
                    begin       //unsigned branch
                    ALUResult = SrcA - SrcB;
                    Con_BLT = SrcA < SrcB;
                    Con_BGT = SrcA > SrcB;
                    zero = (ALUResult == 1'd0);
                    end
            4'b1000:        //SRL
                    ALUResult = SrcA >> SrcB;
            4'b1100:        //SRA
                    ALUResult = $signed(SrcA) >>> SrcB;
            default: 
                    ALUResult = 'b0;
            endcase
        end
endmodule

