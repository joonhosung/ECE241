
// 2-to-1 mux. 
module mux2to1(input select, x, y , output out);
    
	 assign out = select ? y : x; // 1=y, 0=x
	 
endmodule

module register (D, reset, clk, Q);
	input D;
	input reset , clk;
	output reg Q;
	
	always@(posedge clk)
	begin
		if(reset == 1'b1) // Synchronous active high reset
			Q <= 0;
		else
			Q <= D;	
	end
endmodule	


// Single bit of 8-bit register
module rot_reg(input LoadLeft, loadn, reset, clock, left, right, D, output Q);
	wire w1, D_in;
	
	// x = right (0), y = left (1) !!!!
	mux2to1 shifted_bit(.select(LoadLeft), .x(right), .y(left), .out(w1));
	mux2to1 load(.select(loadn), .x(D), .y(w1), .out(D_in));
	
	register flip_flop(.D(D_in), .reset(reset), .clk(clock), .Q(Q));
	
endmodule
	

module rot_reg_x8(IN, Q, RotateRight, ASRight, ParallelLoadn, reset, clock);
	input RotateRight, ASRight, ParallelLoadn, reset, clock;
	input[7:0] IN;
	output[7:0] Q;
	wire[7:0] w;
	wire asr;
	
	// Need 2-to-1 mux for ASRight right before R7 (Most significant digit)
	mux2to1 ASR(.select(ASRight), .x(w[0]), .y(w[7]), .out(asr));
	
	// All 8 rotating registers
	rot_reg R7(.LoadLeft(RotateRight), .loadn(ParallelLoadn), .reset(reset), 
				  .clock(clock), .left(asr), .right(w[6]), .D(IN[7]), .Q(w[7]));
	
	rot_reg R6(.LoadLeft(RotateRight), .loadn(ParallelLoadn), .reset(reset), 
				  .clock(clock), .left(w[7]), .right(w[5]), .D(IN[6]), .Q(w[6]));
	
	rot_reg R5(.LoadLeft(RotateRight), .loadn(ParallelLoadn), .reset(reset), 
				  .clock(clock), .left(w[6]), .right(w[4]), .D(IN[5]), .Q(w[5]));
	
	rot_reg R4(.LoadLeft(RotateRight), .loadn(ParallelLoadn), .reset(reset), 
				  .clock(clock), .left(w[5]), .right(w[3]), .D(IN[4]), .Q(w[4]));
	
	rot_reg R3(.LoadLeft(RotateRight), .loadn(ParallelLoadn), .reset(reset), 
				  .clock(clock), .left(w[4]), .right(w[2]), .D(IN[3]), .Q(w[3]));
	
	rot_reg R2(.LoadLeft(RotateRight), .loadn(ParallelLoadn), .reset(reset), 
				  .clock(clock), .left(w[3]), .right(w[1]), .D(IN[2]), .Q(w[2]));
	
	rot_reg R1(.LoadLeft(RotateRight), .loadn(ParallelLoadn), .reset(reset), 
				  .clock(clock), .left(w[2]), .right(w[0]), .D(IN[1]), .Q(w[1]));
	
	rot_reg R0(.LoadLeft(RotateRight), .loadn(ParallelLoadn), .reset(reset), 
				  .clock(clock), .left(w[1]), .right(w[7]), .D(IN[0]), .Q(w[0]));
	
	// Assign all values in w to output Q
	assign Q = w;
	
endmodule
	
	
// Main module! Need 8 instances of rot_reg
module Bit_Shifter(SW, KEY, LEDR);
	input[9:0] SW;
	input[3:0] KEY;
	output[7:0] LEDR;
	
	// Declare bit-shifting module!
	rot_reg_x8 bitshift(.IN(SW[7:0]), 
							  .Q(LEDR), 
							  .RotateRight(~KEY[2]), 
							  .ASRight(~KEY[3]), 
							  .ParallelLoadn(~KEY[1]), 
							  .reset(SW[9]), 
							  .clock(~KEY[0]));

endmodule
	
	