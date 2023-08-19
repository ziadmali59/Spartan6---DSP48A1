`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/18/2023 05:30:10 PM
// Design Name: 
// Module Name: Mux2x1
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


module Mux2x1#(parameter width=18)
(
    input [width-1 :0] in1,in2,
    input sel,
    output reg [width-1 :0] out
);

always@(*) begin
case(sel)
	1'b0: out=in1;
	1'b1: out=in2;
	default: out=width-1 'b0; 
endcase
end
endmodule
