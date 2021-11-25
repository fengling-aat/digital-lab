module is_equal(
	input signal,
	input [4:0]hour_true,
	input [5:0]minute_true,
	input [4:0]hour_al,
	input [5:0]minute_al,
	output reg bell = 0
);

	always @(posedge signal) begin
		if(hour_true == hour_al && minute_true == minute_al)
			bell <= 1;
		else bell <= 0;
	end

endmodule 