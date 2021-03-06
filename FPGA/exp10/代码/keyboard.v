module keyboard(clk, ps2_clk, ps2_data, freq);
	input clk, ps2_clk, ps2_data;
	output reg [15:0] freq;
	
	
	reg nextdata_n, pre;
	wire myClock, ready, overflow;
	wire [7:0] data;

	initial
	begin
		nextdata_n = 1;
		pre = 1;
	end

	my_clock mycl(clk, myClock);
	ps2_keyboard key(clk, 1, ps2_clk, ps2_data, data, ready, nextdata_n, overflow);
	
	always @(posedge myClock)
	begin
		if (ready == 1)
		begin
			if (pre == 1)
			begin
				case(data)
					8'h1c: freq = 523.25;
					8'h1b: freq = 587.33;
					8'h23: freq = 659.26;
					8'h2b: freq = 698.46;
					8'h34: freq = 783.99;
					8'h33: freq = 880;
					8'h3b: freq = 987.77;
					8'h42: freq = 1046.5;
					default: freq = 0;
				endcase
				freq = freq * 65536 / 48000;
				if(data[7:0] == 8'hf0)
				begin
					pre = 0;
					//freq = 0;
				end
				
			end
			
			else if(pre == 0)    
			begin
				pre = 1;
				freq = 0;
			end
			
			nextdata_n = 0;
		end
		
		else
			nextdata_n = 1;
	end

endmodule
