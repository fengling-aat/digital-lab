module move(signal,stop,adjust_h,adjust_m,adjust_s,hour,minute,second);
	input signal;
	input stop;
	input adjust_h;
	input adjust_m;
	input adjust_s;
	output reg [4:0]hour = 5'b00000;
	output reg [5:0]minute = 6'b000000;
	output reg [5:0]second = 6'b000000;
	
	always @(posedge signal) begin
		if(~stop) begin
			if(second == 59) begin
				second <= 0;
					if(minute == 59) begin
						minute <= 0;
						if(hour == 23)
							hour <= 0;
						else hour <= hour + 1;
					end
				else minute <= minute + 1;
			end
			else
				second <= second + 1;
		end
		else begin
			if(adjust_h) begin
				if(hour == 23)
					hour <= 0;
				else hour <= hour + 1;
			end
				
			if(adjust_m) begin
				if(minute == 59)
					minute <= 0;
				else minute <= minute + 1;
			end
				
			if(adjust_s) begin
				if(second == 59)
					second <= 0;
				else second <= second + 1;
			end
		end
	end
	
endmodule 