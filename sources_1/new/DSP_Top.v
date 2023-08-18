`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/18/2023 09:35:18 AM
// Design Name: 
// Module Name: DSP_Top
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


module DSP_Top
    #(parameter RSTTYPE ="SYNC",MREG=1,CARRYINSEL="OPMODE5"
    ,CARRYINREG=1,PREG=1,CARRYOUTREG=1)
    (
        output [17:0] BCOUT,
        output [47:0] PCOUT,P,
        output [35:0] M,
        output CARRYOUT,CARRYOUTF,

        input [47:0] C,
        input [17:0] A,B,D,
        input clk,CARRYIN,
        input [7:0] opmode,
        input [17:0] BCIN,
        input RSTA,RSTB,RSTM,RSTP,RSTC,RSTD,RSTCARRYIN,RSTOPMODE,
        input CEA,CEB,CEM,CEP,CEC,CED,CECARRYIN,CEOPMODE,
        input [47:0] PCIN
    );
    //wire out of PCOUT to Output and stage A
    wire [47:0] PCOUT_sig;
    //wire out of x and z stageA->stageB
    wire [47:0] outOfX_sig,outOfZ_sig;
    //wire out of cyi stageB->stageB
    wire outOfCYI_sig;

    Stage_A #(RSTTYPE,MREG,CARRYINSEL,CARRYINREG) BA
    (.outOfX(outOfX_sig),.outOfZ(outOfZ_sig),.M(M),.outOfCYI(outOfCYI_sig)
    ,.outOfMul(/*martina signal*/),.PCIN(PCIN),.outOfCport(/*martina signal*/)
    ,.outOfDReg(/*martina signal*/),.PCOUT(PCOUT_sig),.opmode(opmode)
    ,.CARRYIN(CARRYIN),.clk(clk),.RSTM(RSTM),.CEM(CEM),.RSTCARRYIN(RSTCARRYIN),.CECARRYIN(CECARRYIN));

    Stage_B #(RSTTYPE,PREG,CARRYOUTREG) BB
    (.P(P),.PCOUT(PCOUT_sig),.CARRYOUT(CARRYOUT)
    ,.CARRYOUTF(CARRYOUTF),.outOfX(outOfX_sig)
    ,.outOfZ(outOfZ_sig),.outOfCYI(outOfCYI_sig),.opmode(opmode)
    ,.clk(clk),.CEP(CEP),.RSTP(RSTP),.CECARRYIN(CECARRYIN),.RSTCARRYIN(RSTCARRYIN));

    assign PCOUT=PCOUT_sig;
endmodule
