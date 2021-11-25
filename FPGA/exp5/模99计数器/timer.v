module timer(clk,start,stop,clr,s1,s2,clk_1s);
	input clk;
	input start;
	input stop;
	input clr;
	output [6:0]s1;
	output [6:0]s2;
	output reg clk_1s = 0;
	integer clk_count = 0;
	reg [6:0]seconds = 7'b0000000;
	
	
	always @(posedge clk) begin
		if(clk_count == 50000000) begin
			clk_count <= 0;
			clk_1s <= ~clk_1s;
			if(start && ~stop) begin
				if(clr || seconds == 99) begin
					seconds <= 7'b0000000;
					clk_count <= 0;
				end
				
				else begin
					seconds <= seconds + 1;
				end
			end
		end
		else
			clk_count <= clk_count + 1;

	end
	
	trsltr t1(.number(seconds % 10),.s(s1));
	trsltr t2(.number(seconds / 10),.s(s2));
endmodule 