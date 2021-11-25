module picture(
	input clk,
	input reset,
	input clken,
	output HS,
	output VS,
	output blank,
	output vga_clk,
	output [7:0]red,
	output [7:0]green,
	output [7:0]blue
);

//reg [23:0]data;
wire [9:0]h_addr;
wire [9:0]v_addr;
wire signal;
wire [11:0]temp_color;
wire [18:0] addr;

assign vga_clk = signal;
assign addr = {h_addr,v_addr[8:0]};
clkgen #(25000000) my_vgaclk(clk,1'b0,1'b1,signal);
vga_ctrl v(signal,1'b0,temp_color,h_addr,v_addr,HS,VS,blank,red[7:4],green[7:4],blue[7:4]);
//rom r(addr,signal,temp_color);

my_rom cat(addr,signal,temp_color);

/*always @(posedge vga_clk) begin
	addr = {h_addr,v_addr[8:0]};
	data[23:20] = temp_color[11:8];
	data[19:19] = 4'b0;
	data[15:12] = temp_color[7:4];
	data[11:8] = 4'b0;
	data[7:4] = temp_color[3:0];
	data[3:0] = 4'b0;
end*/

endmodule  