`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/16/2023 09:18:15 PM
// Design Name: 
// Module Name: Stage_B
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


module Stage_B
    #(parameter RSTTYPE="SYNC",PREG=1,CARRYOUTREG=1)
    (
        output [47:0] P,PCOUT,
        output CARRYOUT,CARRYOUTF,

        input [47:0] outOfX,outOfZ,
        input outOfCYI,
        input [7:0] opmode,
        input clk,CEP,RSTP,CECARRYIN,RSTCARRYIN
    );
    //wire out of addsub
    wire [47:0] Result_sig;
    //wire out of addsub carry
    wire carryout;
    //wire out of addsub Reg
    wire [47:0] addsub_Reg;
    //wire out of addsub Mux
    wire [47:0] addsub_Mux;
    //wire out of carrout Reg
    wire carryout_Reg;

    Post_ADD_SUB P1
    (.Result(Result_sig),.cout(carryout),.a(outOfX),.b(outOfZ),.cin(outOfCYI),.add_subb(opmode[7]));

    Reg #(.WIDTH_IN(48),.RSTTYPE(RSTTYPE)) P2
    (.out(addsub_Reg),.in(Result_sig),.clk(clk),.rst(RSTP),.ce(CEP));

    Mux #(.WIDTH_IN(48),.PIPELINE(PREG)) P3
    (.out(addsub_Mux),.in_REG(addsub_Reg),.in_COMB(Result_sig));

    Reg #(.WIDTH_IN(1),.RSTTYPE(RSTTYPE)) P4
    (.out(carryout_Reg),.in(carryout),.clk(clk),.rst(RSTCARRYIN),.ce(CECARRYIN));

    Mux #(.WIDTH_IN(1),.PIPELINE(CARRYOUTREG)) P5
    (.out(CARRYOUT),.in_REG(carryout_Reg),.in_COMB(carryout));

    assign CARRYOUTF=CARRYOUT;
    assign P=addsub_Mux;
    assign PCOUT=addsub_Mux;
endmodule
