module read_cat(
	input clk,
	output reg [23:0]data
);

reg [18:0]count;

(* ram_init_file = "cat.mif" *) reg [23:0] datas[327679:0];

always @(posedge clk) begin
	if(count == 327679) begin
		data = datas[count];
		count = 0;
	end
	else begin
		data = datas[count];
		count = count + 1;
	end
end

endmodule 