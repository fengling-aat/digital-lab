
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module exp3_2(

	//////////// KEY //////////
	input 		     [3:0]		KEY,

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
	output		     [6:0]		HEX5
);




ALU alu(SW[7:4],SW[3:0],KEY[2:0],LEDR[3:0],LEDR[9],LEDR[4],LEDR[5]);

//=======================================================
//  REG/WIRE declarations
//=======================================================




//=======================================================
//  Structural coding
//=======================================================



endmodule