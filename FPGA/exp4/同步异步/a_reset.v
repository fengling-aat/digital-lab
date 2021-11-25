module a_reset(clk,clr,in_d,out_t);
	input clk;
	input clr;
	input in_d;
	output reg out_t;
	
	always @(posedge clk or posedge clr)
		if(clr)
			out_t <= 0;
		else
			out_t <= in_d;
	
endmodule 