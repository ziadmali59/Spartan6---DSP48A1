`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/16/2023 08:18:26 PM
// Design Name: 
// Module Name: Mux4x1
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


module Mux4x1
    #(parameter WIDTH_IN =48)
    (
        output reg [WIDTH_IN-1:0] out,
        input [WIDTH_IN-1:0] a,b,c,d,
        input [1:0] sel
    );

    always @(*) 
    begin
        case (sel)
            0:out=a;
            1:out=b;
            2:out=c;
            3: out=d;
            default: out=0;
        endcase    
    end
endmodule
