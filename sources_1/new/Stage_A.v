`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/15/2023 08:53:24 PM
// Design Name: 
// Module Name: Stage_A
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


module Stage_A
    #(parameter RSTTYPE ="SYNC",MREG=1,CARRYINSEL="OPMODE5",CARRYINREG=1)
    (   
        output [47:0] outOfX,outOfZ,
        output [35:0] M,
        output outOfCYI,

        input [35:0] outOfMul,
        input [47:0] PCIN,outOfCport,outOfDReg,PCOUT,
        input [7:0] opmode,
        input CARRYIN,
        input clk,RSTM,CEM,RSTCARRYIN,CECARRYIN
    );
    //wire out of M_REG
    wire [35:0] MREG_sig;
    //wire out of MREG_MUX
    wire [35:0] MMUX_sig;
    //wire out of cyi carry cascade
    wire carry;
    //wire out of cyi reg
    wire CYI_sig;
    //wire out of cyi mux2
    wire ca;

    Reg #(.WIDTH_IN(36),.RSTTYPE(RSTTYPE)) M_REG
    (.out(MREG_sig),.in(outOfMul),.clk(clk),.rst(RSTM),.ce(CEM));

    Mux #(.WIDTH_IN(36),.PIPELINE(MREG)) MREG_MUX
    (.out(MMUX_sig),.in_REG(MREG_sig),.in_COMB(outOfMul));

    assign M=MMUX_sig;

    Mux_CYIN #(.CARRYINSEL(CARRYINSEL)) Mux_CYI
    (.out(carry),.OPMODE5(opmode[5]),.CARRYIN(CARRYIN));

    Reg #(.WIDTH_IN(1),.RSTTYPE(RSTTYPE)) CYI1
    (.out(CYI_sig),.in(carry),.clk(clk),.rst(RSTCARRYIN),.ce(CECARRYIN));

    Mux #(.WIDTH_IN(1),.PIPELINE(CARRYINREG)) CYIREG_MUX
    (.out(ca),.in_REG(CYI_sig),.in_COMB(carry));

    assign  outOfCYI=ca;
    //here outofDreg will be concatenation of D,A,B
    Mux4x1 #(.WIDTH_IN(48)) X
    (.out(outOfX),.a(outOfDReg),.b(PCOUT),.c(MMUX_sig),.d(0),.sel(opmode[1:0]));

    Mux4x1 #(.WIDTH_IN(48)) Z
    (.out(outOfZ),.a(outOfCport),.b(PCOUT),.c(PCIN),.d(0),.sel(opmode[3:2]));






endmodule
