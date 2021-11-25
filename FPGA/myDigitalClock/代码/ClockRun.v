module ClockRun(
	input one_second_clk,

	input [5:0] hour_set,
	input [5:0] minute_set,
	input [5:0] second_set, 

	input set_en, 

	output reg [5:0] hour,
	output reg [5:0] minute,
	output reg [5:0] second   
	);
	
	initial
	begin
		hour = 6'b000000;
		minute = 6'b000000;
		second = 6'b000000;  
	end

	always @ (posedge one_second_clk or posedge set_en)
	begin
		if (set_en == 1'b1)
		begin
			hour <= hour_set;
			minute <= minute_set;
			second <= second_set;
		end

		else if (one_second_clk == 1'b1)
		begin
			if (second >= 6'd59)
			begin
				second <= 6'b0;
				minute <= minute + 1'b1;
			end
			else
				second <= second + 1'b1;
			
			if (minute >= 6'd59 && second >= 6'd59)
			begin
				minute <= 6'b0;
				hour <= hour + 1'b1;
			end

			if (hour >= 6'd23 && minute >= 6'd59 && second >= 6'd59)
			begin
				hour <= 6'b0;
			end
		end
	end

endmodule
