module d_trigger(clk,en,in_d,out_qt1,out_qt2);
	input clk;
	input en;
	input in_d;
	output reg out_qt1;
	output reg out_qt2;
	
	always @(posedge clk)
		if(en) begin
			out_qt1 <= in_d;
			out_qt2 <= out_qt1;
			end
		else begin
			out_qt1 <= out_qt1;
			out_qt2 <= out_qt2;
			end
			
endmodule 