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
    ,CARRYINREG=1,PREG=1,CARRYOUTREG=1,A0REG=0
    ,A1REG=1,B0REG=0,B1REG=1,CREG=1,DREG=1,width=18,B_INPUT=0,OPMODEREG=1)
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
    //wire to concat
    wire [47:0] concatenated_sig;
    //wire out of c port
    wire [47:0] C_sig;
    //wire out of mul
    wire [35:0] Mul_sig;
    //wires of opmode
    wire [7:0] opmode_reg;
    wire [7:0] opmode_mux;

     Reg #(.WIDTH_IN(8),.RSTTYPE(RSTTYPE)) OPMODE_REG
    (.out(opmode_reg),.in(opmode),.clk(clk),.rst(RSTM),.ce(CEM));

    Mux #(.WIDTH_IN(8),.PIPELINE(MREG)) OPMODE_MUX
    (.out(opmode_mux),.in_REG(opmode_reg),.in_COMB(opmode));

    STAGE1 #(A0REG,A1REG,B0REG,B1REG,CREG,DREG,RSTTYPE,width,B_INPUT) B1
    (clk,CEA,CEB,CEC,CED,CEOPMODE,RSTA,RSTB,RSTC,RSTD,opmode_mux[6],opmode_mux[4],RSTOPMODE,A,B,D,BCIN,C,concatenated_sig,C_sig,Mul_sig,BCOUT);

    Stage_A #(RSTTYPE,MREG,CARRYINSEL,CARRYINREG) BA
    (.outOfX(outOfX_sig),.outOfZ(outOfZ_sig),.M(M),.outOfCYI(outOfCYI_sig)
    ,.outOfMul(Mul_sig),.PCIN(PCIN),.outOfCport(C_sig)
    ,.outOfDReg(concatenated_sig),.PCOUT(PCOUT_sig),.opmode(opmode_mux)
    ,.CARRYIN(CARRYIN),.clk(clk),.RSTM(RSTM),.CEM(CEM),.RSTCARRYIN(RSTCARRYIN),.CECARRYIN(CECARRYIN));

    Stage_B #(RSTTYPE,PREG,CARRYOUTREG) BB
    (.P(P),.PCOUT(PCOUT_sig),.CARRYOUT(CARRYOUT)
    ,.CARRYOUTF(CARRYOUTF),.outOfX(outOfX_sig)
    ,.outOfZ(outOfZ_sig),.outOfCYI(outOfCYI_sig),.opmode(opmode_mux)
    ,.clk(clk),.CEP(CEP),.RSTP(RSTP),.CECARRYIN(CECARRYIN),.RSTCARRYIN(RSTCARRYIN));

    assign PCOUT=PCOUT_sig;
endmodule
