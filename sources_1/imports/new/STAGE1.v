module STAGE1
#(parameter A0REG=0,A1REG=1,B0REG=0,B1REG=1,CREG=1,DREG=1,RSTTYPE="SYNC",width=18,B_INPUT=0)
(
input clk,
CEA,CEB,CEC,CED,CEOPMODE,
RSTA,RSTB,RSTC,RSTD,
OPMODE6,OPMODE4,RSTOPMODE,
input [17:0] A,B,D,BCIN,
input [47:0] C,

output [47:0] concatenated,
output [47:0] outC,
output [35:0] out_Multiplier,
output [17:0] BCOUT

);
wire [17:0] outA1,outA2,outB,outD,B_after_MUX1,after_pre_addsub,after_MUX_pre_addsub;
wire outOPMODE;


REG_MUX #(A0REG ,"SYNC",18) uutA0(clk,CEA,RSTA,A,outA1);
REG_MUX #(A1REG,"SYNC",18)  uutA1(clk,CEA,RSTA,outA1,outA2);

MUX #(18,B_INPUT) uutBMUX(B_after_MUX1,BCIN,B);
REG_MUX #(B0REG,"SYNC",18) uutB0(clk,CEB,RSTB,B_after_MUX1,outB);

REG_MUX #(CREG,"SYNC",48) uutC (clk,CEC,RSTC,C,outC);
REG_MUX #(DREG,"SYNC",18) uutD(clk,CED,RSTD,D,outD);

REG_MUX #(1,"SYNC",1) uutOpMode(clk,CEOPMODE,RSTOPMODE,OPMODE6,outOPMODE);
Pre_AddSub uutPre (outD,outB,OPMODE6,after_pre_addsub);

Mux2x1 #(18) uutOPMODE_MUX(outB,after_pre_addsub ,OPMODE4,after_MUX_pre_addsub);
REG_MUX #(B1REG,"SYNC",18) uutB1(clk,CEB,RSTB,after_MUX_pre_addsub,BCOUT);

Multiplier uutMul(BCOUT,outA2,out_Multiplier);


assign concatenated = {outD[11:0], outA2[17:0],BCOUT[17:0]};

endmodule