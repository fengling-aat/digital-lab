module ROM_char
#(parameter DATA_WIDTH=12, parameter ADDR_WIDTH=12)
(
	input [ADDR_WIDTH-1:0] outaddr, 
	input clk,
	output reg [DATA_WIDTH-1:0] q
);
	
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];
	
	wire clk_1s;
	
	initial
	begin
		$readmemh("char_table.txt", ram, 0, 4095);
	end
	
	my_clock clock(clk, clk_1s);
	
	always @ (posedge clk_1s)
	begin
		q <= ram[outaddr];
	end

endmodule
