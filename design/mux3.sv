`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/07/2018 10:21:50 PM
// Design Name: 
// Module Name: mux2
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


module mux3
    #(parameter WIDTH = 9)
    (input logic [WIDTH-1:0] d0, d1, d2,
     input logic s[1:0],
     output logic [WIDTH-1:0] y);

initial
begin
	if(s[1]&&!s[0])
		y = d1;
	else if(!s[1]&&s[0])
		y = d2;
	else
		y = d0;
end

endmodule
