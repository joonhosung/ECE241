`timescale 1ns/1ns


module Part2 (input[2:0] SW, input CLOCK_50 , output[6:0] HEX0);
	wire[26:0] W1;
	wire W2;
	wire[4:0] W3;
	wire clk;
	assign clk = CLOCK_50;
	
	mux_4to1 U1(.sel(SW[1:0]), .load(W1));
	RateDivider U2(.load(W1), .clock(clk), .reset_n(SW[2]), .enable(W2));
	DisplayCounter U3(.enable(W2), .clock(clk), .reset_n(SW[2]), .Q(W3));
	seg7 H0(.C(W3[3:0]), .seg(HEX0)); 
endmodule

module mux_4to1(sel, load);
	input[1:0] sel;
	output[26:0] load;
	reg[26:0] load;
	parameter Hz_full = 27'd0;
	parameter Hz_2 = 27'd24_999_999;
	parameter Hz_1 = 27'd49_999_999;
	parameter Hz_05 = 27'd99_999_999;
	
	
	always@(*)
	begin
		case(sel)
			2'b00: load = Hz_full;
			2'b01: load = Hz_2;
			2'b10: load = Hz_1;
			2'b11: load = Hz_05;
			default: load = 27'd0;
		endcase
	end
endmodule


module RateDivider(load, clock, reset_n, enable);
	input[26:0] load;
	input clock, reset_n;
	output enable;
	reg[26:0] Q;
	
	always@(posedge clock, negedge reset_n)
	begin
		if(reset_n == 1'b0)
			Q <= 27'd0;	
		else if(Q == load)
			Q <= 27'd0;
		else
			Q <= Q + 27'd1;
	end
	
	assign enable = (Q == 27'd0)?1'b1:1'b0;
endmodule


module DisplayCounter(enable, clock, reset_n, Q);	
	input enable, clock, reset_n;
	output[4:0] Q;
	reg[4:0] Q;
	
	always@(posedge clock, negedge reset_n)
	begin
		if(reset_n == 1'b0)
			Q <= 5'd0;	
		else if(Q == 5'b10000)
			Q <= 5'd0;
		else if(enable) 
			Q <= Q + 5'd1;	
	end
endmodule


module seg7(C, seg);
	input[3:0] C;
	output[6:0] seg;
	
	assign seg[0] = (~C[3]&~C[2]&~C[1]&C[0])|
						  (~C[3]&C[2]&~C[1]&~C[0])|
						  (C[3]&~C[2]&C[1]&C[0])|
						  (C[3]&C[2]&~C[1]&C[0]);
						  
	assign seg[1] = (~C[3]&C[2]&~C[1]&C[0])|
						  (~C[3]&C[2]&C[1]&~C[0])|
						  (C[3]&~C[2]&C[1]&C[0])|
						  (C[3]&C[2]&~C[1]&~C[0])|
						  (C[3]&C[2]&C[1]&~C[0])|
						  (C[3]&C[2]&C[1]&C[0]);
						  
	assign seg[2] = (~C[3]&~C[2]&C[1]&~C[0])|
						  (C[3]&C[2]&~C[1]&~C[0])|
						  (C[3]&C[2]&C[1]&~C[0])|
						  (C[3]&C[2]&C[1]&C[0]);
						  
	assign seg[3] = (~C[3]&~C[2]&~C[1]&C[0])|
						  (~C[3]&C[2]&~C[1]&~C[0])|
						  (~C[3]&C[2]&C[1]&C[0])|
						  (C[3]&~C[2]&C[1]&~C[0])|
						  (C[3]&C[2]&C[1]&C[0]);
						  
	assign seg[4] = (~C[3]&~C[2]&~C[1]&C[0])|
						  (~C[3]&~C[2]&C[1]&C[0])|
						  (~C[3]&C[2]&~C[1]&~C[0])|
						  (~C[3]&C[2]&~C[1]&C[0])|
						  (~C[3]&C[2]&C[1]&C[0])|
						  (C[3]&~C[2]&~C[1]&C[0]);
						  
	assign seg[5] = (~C[3]&~C[2]&~C[1]&C[0])|
						  (~C[3]&~C[2]&C[1]&~C[0])|
						  (~C[3]&~C[2]&C[1]&C[0])|
						  (~C[3]&C[2]&C[1]&C[0])|
						  (C[3]&C[2]&~C[1]&C[0]);
						  
	assign seg[6] = (~C[3]&~C[2]&~C[1]&~C[0])|
						  (~C[3]&~C[2]&~C[1]&C[0])|
						  (~C[3]&C[2]&C[1]&C[0])|
						  (C[3]&C[2]&~C[1]&~C[0]);
endmodule

