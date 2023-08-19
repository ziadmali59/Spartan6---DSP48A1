`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/15/2023 09:03:38 PM
// Design Name: 
// Module Name: Mux
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


module MUX
    #(parameter WIDTH_IN =1,PIPELINE=1)
    (
        output reg [WIDTH_IN-1:0] out,
        input [WIDTH_IN-1:0] in_REG,in_COMB
    );
generate
    always @(*) 
    begin
        case (PIPELINE)
            1'b0:out=in_COMB;
            1'b1:out=in_REG; 
            default: out=0;
        endcase    
    end
endgenerate
endmodule
