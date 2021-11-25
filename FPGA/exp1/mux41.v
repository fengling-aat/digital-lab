module mux41(a,b,c,d,s,y);
	input a,b,c,d;
	input [1:0] s;
	output reg y;
	
	always @ (s or a or b or c or d)
		case (s)
			0: y = a;
			1: y = b;
			2: y = c;
			3: y = d;
			default: y = 1'b0;
		endcase
		
endmodule
