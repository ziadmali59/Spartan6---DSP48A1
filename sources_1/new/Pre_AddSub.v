module Pre_AddSub(
    input [17:0] B,D,
	input [0:0] OPMODE6,
    output reg [17:0] out

);

always @(*)
begin
case(OPMODE6)
	1'b0: out=D+B;
	1'b1: out=D-B;
	default: out=D+B; //????????/?
endcase
end


endmodule
