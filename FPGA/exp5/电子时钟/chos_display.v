module chos_display(
	input signal,
	input sw,
	input alarm,
	input [4:0]hour_true,
	input [5:0]minute_true,
	input [5:0]second_true,
	input [4:0]hour_sw,
	input [5:0]minute_sw,
	input [5:0]second_sw,
	input [4:0]hour_al,
	input [5:0]minute_al,
	input [5:0]second_al,
	output reg [4:0]hour_display = 5'b00000,
	output reg [5:0]minute_display = 6'b000000,
	output reg [5:0]second_display = 6'b000000
);

	always @(posedge signal) begin
		if(sw &&~alarm)begin
			hour_display <= hour_sw;
			minute_display <= minute_sw;
			second_display <= second_sw;
		end
		else if(~sw &&alarm)begin
			hour_display <= hour_al;
			minute_display <= minute_al;
			second_display <= second_al;
		end
		else begin
			hour_display <= hour_true;
			minute_display <= minute_true;
			second_display <= second_true;
		end
	end

endmodule 