module trsltr(number,s);
	input [3:0]number;
	output reg [6:0]s;
	
	always @(*)
		case(number)
			0:s = 7'b1000000;
			1:s = 7'b1111001;
			2:s = 7'b0100100;
			3:s = 7'b0110000;
			4:s = 7'b0011001;
			5:s = 7'b0010010;
			6:s = 7'b0000010;
			7:s = 7'b1111000;
			8:s = 7'b0000000;
			9:s = 7'b0010000;
			default:s = 7'b1111111;
		endcase
	
endmodule 