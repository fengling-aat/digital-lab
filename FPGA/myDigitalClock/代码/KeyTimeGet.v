module KeyTimeGet(

	input ps2_clk,
	input ps2_data,

	input CLK_50,

	output reg set_en,
	output reg alarm_en, 

	output reg all_ready, 
	output reg [5:0] hour,
	output reg [5:0] minute,
	output reg [5:0] second,

	output wire trans_en
);

	wire [7:0] data;
	wire ready;
	wire [7:0] ASCII;
	
	reg [2:0] location;

	initial
	begin
		set_en = 1'b0;
		alarm_en = 1'b0;
		hour = 6'b0;
		minute = 6'b0;
		second = 6'b0;
		location = 3'b0;
	end

	ps2_keyboard keyboard(
		.clk(CLK_50),
		.clrn(1'b1),
		.ps2_clk(ps2_clk),
		.ps2_data(ps2_data),
		.data(data),
		.ready(ready),
		.nextdata_n(1'b0)
		//.overflow(overflow)
		);
	
	KeyTranslate GetASCII(
		.ready(ready),
		.now_data(data),
		.ASCII(ASCII),
		.CLK_50(CLK_50),
		.out_en(trans_en)
	);


	always @ (negedge trans_en) 
	begin
		if (alarm_en == 1'b0 && set_en == 1'b0) 
		begin
			if (ASCII == 8'h61) // 此时是A
				alarm_en = 1'b1;
			else if (ASCII == 8'h73) // 此时是S
				set_en = 1'b1;
			
			hour = 8'b0;
			minute = 8'b0;
			second = 8'b0;
			location = 3'b0;
		end

		else if (ASCII == 8'h64) // 此时是D
		begin
			alarm_en = 1'b0;
			set_en = 1'b0;
		end

		else if (ASCII >= 8'h30 && ASCII <= 8'h39)
		begin
			
		
			case (location)
			0:begin hour = hour + (ASCII - 8'h30) * 8'd10;location = location + 3'b1;end
			1:begin hour = hour + (ASCII - 8'h30);location = location + 3'b1;end
			2:begin minute = minute + (ASCII - 8'h30) * 8'd10;location = location + 3'b1;end
			3:begin minute = minute + (ASCII - 8'h30);location = location + 3'b1;end
			4:begin second = second + (ASCII - 8'h30) * 8'd10;location = location + 3'b1;end
			5:begin second = second + (ASCII - 8'h30);location = location + 3'b1;end
			default:;
			endcase
			//location = location + 3'b1;
		

		end
	end

endmodule
