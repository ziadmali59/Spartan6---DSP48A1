module Multiplier(
input [17:0]in1,in2,
output reg [35:0] out
);
always@(*)
begin
out= in1 * in2;
end

endmodule