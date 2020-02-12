/*
wire Connection;

block1 B1 (
	.in1(SW[0]),		 //SW[0] to in1
	.out1(Connection) //Connection to out1
);


block2 B2 (
	.in2(Connection), //Connection to in2
	.out2(LEDR[5]) //LEDR[2] to out2
);

//assign LEDR[0] = Connection; //Join wire Connection to LEDR[0]
*/

`timescale 1ns / 1ns // `timescale time_unit/time_precision
module muxGates(SW, LEDR);
	input [9:0] SW;
	output [9:0] LEDR;
	wire w1, w2, w3;

	v7404 u1(.pin1(SW[9]), .pin2(w1));
	v7408 u2(.pin1(SW[0]), .pin2(w1), .pin4(SW[9]), .pin5(SW[1]), .pin3(w2), .pin6(w3));
	v7432 u3(.pin1(w2), .pin2(w3), .pin3(LEDR[0]));
endmodule
//6 inverters
module v7404 (input pin1, pin3, pin5, pin9, pin11, pin13, 
				  output pin2, pin4, pin6, pin8, pin10, pin12);
	
	assign pin2 = ~pin1;
	assign pin4 = ~pin3;
	assign pin6 = ~pin5;
	assign pin9 = ~pin8;
	assign pin11 = ~pin10;
	assign pin13 = ~pin12;
	
endmodule

//4 2-AND gates				  
module v7408 (input pin1, pin2, pin4, pin5, pin9, pin10, pin12, pin13,
				  output pin3, pin6, pin8, pin11);
	
	assign pin3 = pin1&pin2;
	assign pin6 = pin4&pin5;
	assign pin8 = pin9&pin10;
	assign pin11 = pin12&pin13;
	
endmodule

//4 2-OR gates				  
module v7432 (input pin1, pin2, pin4, pin5, pin9, pin10, pin12, pin13,
				  output pin3, pin6, pin8, pin11);
	
	assign pin3 = pin1|pin2;
	assign pin6 = pin4|pin5;
	assign pin8 = pin9|pin10;
	assign pin11 = pin12|pin13;
	
endmodule



	