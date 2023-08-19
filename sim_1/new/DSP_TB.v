`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/18/2023 10:34:32 AM
// Design Name: 
// Module Name: DSP_TB
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


module DSP_TB();
//define parameters
parameter RSTTYPE="ASYNC";
parameter AOREG=1;
parameter A1REG=1;
parameter B1REG=1;
parameter B0REG=1;
parameter DREG=1;
//define inputs
reg [47:0] C;
reg [17:0] A,B,D;
reg clk,CARRYIN;
reg [7:0] opmode;
reg [17:0] BCIN;
reg RSTA,RSTB,RSTM,RSTP,RSTC,RSTD,RSTCARRYIN,RSTOPMODE;
reg CEA,CEB,CEM,CEP,CEC,CED,CECARRYIN,CEOPMODE;
reg [47:0] PCIN;
//define outputs
wire [17:0] BCOUT;
wire [47:0] PCOUT,P;
wire [35:0] M;
wire CARRYOUT,CARRYOUTF;
//instant of module
DSP_Top #(.RSTTYPE(RSTTYPE),.A0REG(AOREG),.A1REG(A1REG),.B0REG(B0REG),.B1REG(B1REG),.DREG(DREG))DUT
(BCOUT,PCOUT,P,M,CARRYOUT,CARRYOUTF,C,A,B,D,clk,CARRYIN,opmode,
BCIN,RSTA,RSTB,RSTM,RSTP,RSTC,RSTD,RSTCARRYIN,RSTOPMODE,
CEA,CEB,CEM,CEP,CEC,CED,CECARRYIN,CEOPMODE,
PCIN);

//generate clock
initial 
begin
    clk=1;
    forever begin
        #2 clk=~clk;
    end
end

initial 
begin
    //rst outputs for 1 cycle and set clock enables
    CEA=1;
    CEB=1;
    CEM=1;
    CEP=1;
    CEC=1;
    CED=1;
    CECARRYIN=1;
    CEOPMODE=1;
    RSTA=1;
    RSTB=1;
    RSTM=1;
    RSTP=1;
    RSTC=1;
    RSTD=1;
    RSTCARRYIN=1;
    RSTOPMODE=1;
    #2
    RSTA=0;
    RSTB=0;
    RSTM=0;
    RSTP=0;
    RSTC=0;
    RSTD=0;
    RSTCARRYIN=0;
    RSTOPMODE=0;
    C=1;
    A=2;
    B=4;
    D=5;
    opmode=0;
    CARRYIN=1;
    BCIN=3;
    PCIN=10;
    //cases
    #2
    @(negedge clk)
    opmode=8'b0000_0101 ; //pre:+ / pos:+ / carryin / B_direct / use PCIN and out of mul values  8+10=18 output valid after 2 cycles
    #12
    opmode=8'b0010_1101 ; //pre:+ / pos:+ / OPMODE5 / B_direct / use C_port and out of mul values  (4*2)+1+1=10 output valid after 2 cycles
    #12
    opmode=8'b0011_1101 ; //pre:+ / pos:+ / OPMODE5 / addresult / use C_port and out of mul values  (9*2)+1+1=20 output valid after 2 cycles
    #12
    opmode=8'b0011_0001 ; //pre:+ / pos:+ / OPMODE5 / addresult / use Zero and out of mul values  (9*2)+1=19 output valid after 2 cycles
    CARRYIN=0;
    #12
    opmode=8'b0101_0101 ; //pre:- / pos:+ / carryin / subresult / use PCIN and out of mul values  (5-4)*2+10=12 output valid after 2 cycles
    #12
    opmode=0;
    #12
    opmode=8'b1101_0101 ; //pre:- / pos:- / carryin / subresult / use PCIN and out of mul values  10-(5-4)*2=8 output valid after 2 cycles
    #12
    opmode=8'b1111_0101 ; //pre:- / pos:- / OPMODE5 / subresult / use PCIN and out of mul values  10-(5-4)*2-1=7 output valid after 2 cycles
    #12
    opmode=8'b0111_0101 ; //pre:+ / pos:- / OPMODE5 / subresult / use PCIN and out of mul values  10+(5-4)*2+1=13 output valid after 2 cycles
    #12
    opmode=8'b0010_0010 ; //pre:+ / pos:+ / OPMODE5 / B_direct / use Zero and Feedback Value  lastout =13 then 13+1=14 then 14+1=15  output valid after 2 cycles
    #12
    opmode=8'b0010_0011 ; //pre:+ / pos:+ / OPMODE5 / B_direct / use Zero and Concatenated   output valid after 2 cycles
    #12
    opmode=8'b0010_0100 ; //pre:+ / pos:+ / OPMODE5 / B_direct / use PCIN and Zero  10+0+1=11 output valid after 2 cycles
    #12
    opmode=8'b0010_1001 ; //pre:+ / pos:+ / OPMODE5 / B_direct / use Feedback and out of mul values  11+8+1=20->29->38 output valid after 2 cycles
    #12
    opmode=8'b0010_1010 ; //pre:+ / pos:+ / OPMODE5 / B_direct / use feedback and feedback 38+38+1=77 -> 77+77+1=  output valid after 2 cycles
    #12
    opmode=8'b0010_1111 ; //pre:+ / pos:+ / OPMODE5 / B_direct / use PCIN and Concatenated value output valid after 2 cycles
    #12
    $stop;
    
    

    
    


   end
endmodule
