
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module random(

	//////////// CLOCK //////////
	input 		          		CLOCK2_50,
	input 		          		CLOCK3_50,
	input 		          		CLOCK4_50,
	input 		          		CLOCK_50,

	//////////// SW //////////
	input 		     [9:0]		SW,

	//////////// LED //////////
	output		     [9:0]		LEDR,

	//////////// Seg7 //////////
	output		     [6:0]		HEX0,
	output		     [6:0]		HEX1,
	output		     [6:0]		HEX2,
	output		     [6:0]		HEX3,
	output		     [6:0]		HEX4,
	output		     [6:0]		HEX5,

	//////////// PS2 //////////
	inout 		          		PS2_CLK,
	inout 		          		PS2_CLK2,
	inout 		          		PS2_DAT,
	inout 		          		PS2_DAT2
);



//=======================================================
//  REG/WIRE declarations
//=======================================================

wire signal;
divider#(1) d(CLOCK_50,signal);

randint#(8'b00011101) R(signal,SW[8],SW[7:0],LEDR[7:0],HEX1[6:0],HEX0[6:0]);


//=======================================================
//  Structural coding
//=======================================================



endmodule
