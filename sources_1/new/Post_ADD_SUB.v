`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/16/2023 09:26:39 PM
// Design Name: 
// Module Name: Post_ADD_SUB
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


module Post_ADD_SUB
    (
        output reg [47:0] Result,
        output reg cout,
        input [47:0] a,b,
        input cin,
        input add_subb
    );

    always @(*) 
    begin
        case (add_subb)
            0:
                begin
                    {cout,Result}=a+b+cin;
                end
            1: 
                begin
                    {cout,Result}=b-a-cin;
                end
            default: {cout,Result}=0;
        endcase    
    end
endmodule
