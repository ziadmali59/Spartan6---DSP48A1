`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/16/2023 07:52:14 PM
// Design Name: 
// Module Name: Mux_CYIN
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


module Mux_CYIN
#(parameter  CARRYINSEL="OPMODE5" )
    (
        output reg out,
        input OPMODE5,CARRYIN     
    );
    generate
        always @(*) 
        begin
            case (CARRYINSEL)
                "CARRYIN": out=CARRYIN;
                "OPMODE5": out=OPMODE5;
                default: out=0;
            endcase    
        end
    endgenerate

endmodule
