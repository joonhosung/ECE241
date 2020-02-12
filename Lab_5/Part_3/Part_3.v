`timescale 1ns/1ns

module Part_3(input[1:0] KEY, input[2:0] SW, input CLOCK_50, output[0:0] LEDR);
	wire[12:0] W1;
	wire W2;
	wire clk;
	assign clk = CLOCK_50;
	
	mux8to1 U1(.sel(SW), .out(W1));
	RateDiv U2(.clock(clk), .enable(W2));
	ShiftReg_13bit U3(.clock(clk), .enable(W2), .reset_n(KEY[0]), .ParallelLoadn(KEY[1]), .D(W1), .out(LEDR[0]));

endmodule


module mux8to1(sel, out);
	input[2:0] sel;
	output[12:0] out;
	reg[12:0] out;
	
	parameter I = {4'b0101, 9'd0};
	parameter J = 13'b1011101110111;
	parameter K = {9'b111010111, 4'd0};
	parameter L = {9'b101110101, 4'd0};
	parameter M = {7'b1110111, 6'd0};
	parameter N = {5'b11101, 8'd0};
	parameter O = {11'b11101110111, 2'd0};
	parameter P = {11'b10111011101, 2'd0};
	
	always@(*)
	begin
		case(sel)
			3'b000: out = I;
			3'b001: out = J;
			3'b010: out = K;
			3'b011: out = L;
			3'b100: out = M;
			3'b101: out = N;
			3'b110: out = O;
			3'b111: out = P;
			default: out = 13'd0;
		endcase
	end
endmodule


module RateDiv(input clock, output reg enable);
	parameter load = 25'd24_999_999;
	reg[24:0] Q;
	
	always@(posedge clock)
	begin
		if(Q >= load)
		begin
			enable <= 1'b1;
			Q <= 25'd0;
		end
		else
		begin
			Q <= Q + 25'd1;
			enable <= 1'b0;
		end
	end
	
endmodule


module ShiftReg_13bit(input clock, enable, reset_n, ParallelLoadn, input[12:0] D, output reg out);
	reg[12:0] Q;
	
	always@(posedge clock, negedge reset_n)
	begin
		if(reset_n == 1'b0)
		begin
			Q <= 13'd0;
			out <= 1'b0;
		end
		else if((ParallelLoadn == 1'b1) && (enable == 1'b1))
			begin
				Q[0] <= 1'b0;
				Q[1] <= Q[0];
				Q[2] <= Q[1];
				Q[3] <= Q[2];
				Q[4] <= Q[3];
				Q[5] <= Q[4];
				Q[6] <= Q[5];
				Q[7] <= Q[6];
				Q[8] <= Q[7];
				Q[9] <= Q[8];
				Q[10] <= Q[9];
				Q[11] <= Q[10];
				Q[12] <= Q[11];
				out <= Q[12];
			end
		else if(ParallelLoadn == 1'b0)
			Q <= D;
	end
	
endmodule


	
	