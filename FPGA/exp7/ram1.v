module ram1(chos,clk,we,addr,din,dout);
	input chos;
	input clk;
	input we;
	input [3:0]addr;
	input [7:0]din;
	output reg [7:0]dout;
	
	reg [7:0] ram1 [15:0];
	
	(* ram_init_file = "test.mif" *) reg [7:0] ram2[15:0];
	
	initial begin
		$readmemh("mem1.txt",ram1,0,15);
	end
	
	always @(posedge clk)begin
		if(chos == 1)begin
			if(we)
				ram1[addr] <= din;
			else
				dout <= ram1[addr];
		end
		else begin
			if(we)
				ram2[addr] <= din;
			else
				dout <= ram2[addr];
		end
	end

endmodule 