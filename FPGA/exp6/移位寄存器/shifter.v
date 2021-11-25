module shifter(
	input clk,
	input [2:0]chos,
	input [7:0]inp,
	input left,
	output reg [7:0]result
);

always @(posedge clk) begin
	case(chos)
	0:result <= 0;
	1:result <= inp;
	2:result <= (result>>1);
	3:result <= (result<<1);
	4:result <= {result[7],result[7:1]};
	5:result <= {left,result[7:1]};
	6:result <= {result[0],result[7:1]};
	7:result <= {result[6:0],result[7]};
	endcase
end

endmodule 