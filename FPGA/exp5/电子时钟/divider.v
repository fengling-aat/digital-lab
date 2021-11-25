module divider
#(
	parameter n
)
(
	input clk,
	output reg my_signal = 0
);
	integer clk_count = 0;
	
	always @ (posedge clk) begin
		if(clk_count == 25000000*n) begin
			clk_count <= 0;
			my_signal <= ~my_signal;
		end
		else
			clk_count <= clk_count + 1;
	end

endmodule 