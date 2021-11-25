module three_seg(a,s);
	input [2:0]a;
	output reg [6:0] s;
	
	always @ (*)
		case(a)
			0:s = 7'b1111111;
			1:s = 7'b1001111;
			2:s = 7'b0010010;
			3:s = 7'b0000110;
			4:s = 7'b1001100;
			5:s = 7'b0100100;
			6:s = 7'b0100000;
			7:s = 7'b0001111;
			default:s = 7'b1111111;
		endcase
		
endmodule 