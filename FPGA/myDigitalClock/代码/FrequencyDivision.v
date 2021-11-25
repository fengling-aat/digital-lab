module FrequencyDivision(
	input en,
	input clk_input,
	output reg clk_output
);
	reg [31:0] count;
	initial
	begin
		clk_output = 1'b0;
	end
	always @ (posedge clk_input)
	begin
		if (count >= 25000000)
		begin
			count <= 0;
			clk_output <= ~clk_output;
		end
		else if (en)
		begin
			count <= count + 1;
			clk_output = clk_output;
		end
		else
		begin
			clk_output = clk_output;
		end
	end
endmodule
