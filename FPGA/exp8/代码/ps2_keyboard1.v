module ps2_keyboard1(
	input ps2_clk, 
	input ps2_data, 
	output reg pressed = 0,
	output reg [7:0] data = 0, 
	output reg [7:0] ascii = 0, 
	output reg [7:0] times = 0,
	output reg shift = 0, 
	output reg ctrl = 0, 
	output reg caps = 0
);
	reg [10:0] buffer;
	reg [3:0] pointer = 0;
	reg break = 0;
(* ram_init_file = "lower.mif" *) reg [7:0] lower[255:0];
(* ram_init_file = "upper.mif" *) reg [7:0] upper[255:0];
always @(negedge ps2_clk) begin
	buffer[pointer] = ps2_data;
	pointer = (pointer+1) % 11;
	if(pointer == 0) begin
		data = buffer[8:1];
		if(break) begin
			break = 0;
			if(data == 8'h12) shift = 0;
			if(data == 8'h14) ctrl = 0;
			if(shift == 0 && ctrl == 0)
				pressed = 0;
			data = 0;
			ascii = 0;
		end
		else if(!pressed || shift || ctrl) begin
			case(data)
				8'h12: begin shift = 1;pressed = 1; end
				8'h14: begin ctrl = 1;pressed = 1;end
				8'h58: begin caps = ~caps;pressed = 1;end
				8'hf0: ;
				default: begin
					times = times + 1;
					if(shift ^ caps) //upper
						ascii = upper[data];
					else
						ascii = lower[data];
					pressed = 1;
				end
			endcase
		end
		if(data == 8'hf0) break = 1;
	end
end
endmodule
