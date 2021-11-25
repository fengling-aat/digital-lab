module second_watch(en,signal,starp,clr,hour,minute,second);
	input en;
	input signal;
	input starp;
	input clr;
	output reg [4:0]hour = 5'b00000;
	output reg [5:0]minute = 6'b000000;
	output reg [5:0]second = 6'b000000;
	
	always @(posedge signal) begin
		if(en) begin
			if(starp && ~clr) begin
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
			else if(clr) begin
				hour <= 0;
				minute <= 0;
				second <= 0;
			end
		end
	end
	
endmodule 