`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/16/2023 07:45:38 PM
// Design Name: 
// Module Name: Reg
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


module Reg
    #(parameter  WIDTH_IN=4,RSTTYPE="SYNC" )
    (
        output reg [WIDTH_IN-1:0] out,
        input  [WIDTH_IN-1:0] in,
        input clk,rst,ce
    );
    generate
        case (RSTTYPE)
            "SYNC":
                begin
                    always @(posedge clk) 
                    begin
                        if (rst) 
                            begin
                                out<=0;    
                            end
                        else
                            begin
                                if (ce) 
                                begin
                                    out<=in;    
                                end
                            end
                    end
                end
            "ASYNC":
                begin
                    always @(posedge clk,posedge rst) 
                    begin
                        if (rst) 
                            begin
                                out<=0;    
                            end
                        else
                            begin
                                if (ce) 
                                begin
                                    out<=in;    
                                end
                            end
                    end
                    
                end 
            default: 
             begin
                    always @(posedge clk) 
                    begin
                        if (rst) 
                            begin
                                out<=0;    
                            end
                        else
                            begin
                                if (ce) 
                                begin
                                    out<=in;    
                                end
                            end
                    end
                end
        endcase
    endgenerate
endmodule
