module stripe(
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

reg [23:0]data = 24'b0;
wire [9:0]h_addr;
wire [9:0]v_addr;
wire signal;

assign vga_clk = signal;

clkgen #(25000000) my_vgaclk(clk,1'b0,1'b1,signal);
vga_ctrl v(signal,1'b0,data,h_addr,v_addr,HS,VS,blank,red[7:0],green[7:0],blue[7:0]);

always @(posedge vga_clk) begin
	if(h_addr <= 200)
		data = 24'hFF0000;
	else if(h_addr <= 400)
		data = 24'h00FF00;
	else
		data = 24'h0000FF;
end

endmodule  