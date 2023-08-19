module REG_MUX
#(parameter REG=0,RSTTYPE="SYNC",width=18)

(
input CLK,CE,RST,
input [width-1:0] data,
output reg [width-1:0] Mux_out

);


reg [width-1:0] out_reg,out_reg_sync,out_reg_async;


//for async reset
always@(posedge CLK,posedge RST) begin
if (RST)
	begin
	 out_reg_async<= width-1'b0;
	end
else if (CE)
	     out_reg_async <= data;
else
         out_reg_async <=  width-1'b0;   //??????/
end



//for sync reset
always@(posedge CLK) begin
if (RST)
	begin
	 out_reg_sync<= 18'b0;
	end
else if (CE)
	     out_reg_sync <= data;
else
         out_reg_sync <=  width-1'b0;
end


always@(*) begin
case(REG)
	1'b0: Mux_out=data;
	1'b1: Mux_out=out_reg;
	default: Mux_out=data; //????????/?
endcase
end

always@(*) begin
case(RSTTYPE)
    "SYNC": out_reg=out_reg_sync;
    "ASYNC": out_reg=out_reg_async;
	default: out_reg=out_reg_sync;
endcase
end
endmodule