module Sin_Generator(clk,
                     reset_n,
							freq,
							dataout
                     );
input clk;
input reset_n;
input [15:0] freq;
output reg [15:0] dataout;
(* ram_init_file = "sintable.mif" *) reg [15:0] sintable [1023:0];

reg [15:0] freq_counter; 

always @(posedge clk) 
begin
       dataout <= sintable[freq_counter[15:6]];
end


always @(posedge clk or negedge reset_n)
begin
    if(!reset_n)
	    freq_counter <= 16'b0;
	 else
	    freq_counter <= freq_counter + freq;
end
endmodule