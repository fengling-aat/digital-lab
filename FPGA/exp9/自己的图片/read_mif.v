module read_mif(
	input clk,
	input [9:0] h_addr, 
	input [9:0] v_addr,
	output reg [23:0]data
);

(* ram_init_file = "picture.mif" *) reg [23:0] datas[327679:0];

always @(posedge clk) begin
	data = datas[480*h_addr + v_addr];
end

endmodule 