module randint
#(
	parameter n
)
(
	input clk,
	input reset,
	input [7:0]start,
	output reg [7:0]r = 0,
	output [6:0]ten,
	output [6:0]one
);
	integer i;
	reg x;


always @(posedge clk)begin
	if(reset)
		r <= start;
	else if(r == 0)
		r <= 8'b01100110;
	else begin
		x = 0;
		for(i = 0;i<8;i = i+1)
			x = x^(n[i]&r[i]);
		r <= {x,r[7:1]};
	end
end


trsltr t2(r/16,ten);
trsltr t3(r%16,one);

endmodule 