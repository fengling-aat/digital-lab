module ALU(A,B,switch,result,out,over,C);
	input [3:0]A;
	input [3:0]B;
	input [2:0]switch;
	output reg [3:0]result;
	output reg out;
	output reg over;
	output reg C;
	
	always @(A or B or switch)begin
		out = 0;
		result = 0;
		over = 0;
		C = 0;
		case(switch)
			0:begin
			if(A <= 7 && B <= 7)begin
				if(A + B > 7)begin
					over = 1;
				end
				result = A + B;
			end
			else if(A >= 8 && B >= 8)begin
				over = 1;
				C = 1;
				result = A + B - 16;
			end
			else begin
				if(A + B > 15)begin
					result = A + B - 16;
					//over = 1;
					C = 1;
				end
				else result = A + B;
			end
		  end
			1:begin
			if(A < B) 
				C = 1;
			else C = 0;
			if(A >= 8 && B >= 8)begin
				if(A + (~B+1) > 15)begin
					result = A + (~B+1) - 16;
					
				end
				else
					result = A + (~B+1);
			end
			else if(A <= 7 && B <= 7)begin
				if(A >= B)
					result = A - B;
				else begin
					
					result = A + (~B+1);
					end
			end
			else if(A >= 8 && B <= 7)begin
				result = A - B;
				if(A < 8)
					over = 1;
				
			end
			else begin
				result = A + ~B + 1;
				if(result > 7)
						over = 1;
				//result = A + ~B + 1;
			end
		  end
			2:result = ~A;
			3:result = A & B;
			4:result = A | B;
			5:result = (~A&B) | (A&~B); 
			6:begin
				if(A > 7 && B <= 7)
					out = 0;
				else if(A > 7 && B > 7)begin
					if(A > B)
						out = 1;
					else out = 0;
				end
				else if(B > 7 && A <= 7)
					out = 1;
				else begin
					if(A >B)
						out = 1;
					else
						out = 0;
				end
			end
			7:begin if(A == B) out = 1; else out = 0; end
		endcase
	end
	
endmodule 