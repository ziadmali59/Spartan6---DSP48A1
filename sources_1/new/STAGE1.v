module STAGE1
#(parameter REG=0,RSTTYPE="SYNC",width=18)
(
input CLK,
CEA,CEB,CEC,CED,CEOPMODE,
RSTA,RSTB,RSTC,RSTD,
OPMODE6,OPMODE4,RSTOPMODE,
input [17:0] A,B,D,BCIN,
input [47:0] C,

output reg [47:0] concatenated,
output [47:0] outC,
output [35:0] out_Multiplier //????????/

);
wire [17:0] outA1,outA2,outB,outD,B_after_MUX1,after_pre_addsub,BCOUT,after_MUX_pre_addsub;
wire outOPMODE;


REG_MUX #(0 ,"SYNC",18) uutA0(clk,CEA,RSTA,A,outA1);
REG_MUX #(1,"SYNC",18)  uutA1(clk,CEA,RSTA,outA1,outA2);

MUX #(18) uutBMUX(B, BCIN,B_INPUT,B_after_MUX1);
REG_MUX #(0,"SYNC",18) uutB0(clk,CEB,RSTB,B_after_MUX1,outB);

REG_MUX #(1,"SYNC",48) uutC (clk,CEC,RSTC,C,outC);
REG_MUX #(1,"SYNC",18) uutD(clk,CED,RSTD,D,outD);

REG_MUX #(1,"SYNC",1) uutOpMode(clk,CEOPMODE,RSTOPMODE,OPMODE6,outOPMODE);
Pre_AddSub uutPre (outD,outB,OPMODE6,after_pre_addsub);

MUX #(18) uutOPMODE_MUX(outB,after_pre_addsub ,OPMODE4,after_MUX_pre_addsub);

REG_MUX #(1,"SYNC",18) uutB1(clk,CEB,RSTB,after_MUX_pre_addsub,BCOUT);

Multiplier uutMul(BCOUT,outA2,out_Multiplier);


assign concatenated = {outD[11:0], outA2[17:0],BCOUT[17:0]};

endmodule