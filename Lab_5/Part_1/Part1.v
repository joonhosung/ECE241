`timescale 1ns/1ns

module Part1(KEY, SW, HEX0, HEX1);
	input[0:0] KEY;
	input [1:0] SW;
	output [6:0] HEX0, HEX1;
	wire[7:0] Q;
	
	Counter_8bit B1(.enable(SW[1]), .clk(KEY[0]), .clr(SW[0]), .Q(Q));
	
	seg7 H0(.C(Q[3:0]), .seg(HEX0));
	seg7 H1(.C(Q[7:4]), .seg(HEX1));
endmodule




module Counter_8bit(input enable, clk, clr, output[7:0] Q);
	wire[6:0] w;
	
	T_ff u0(.clk(clk), .t(Q[0]), .enable(enable), .clr(clr), .Q(Q[0]));
	
	assign w[0] = enable && Q[0];
	T_ff u1(.clk(clk), .t(Q[1]), .enable(w[0]), .clr(clr), .Q(Q[1]));
	
	assign w[1] = w[0] && Q[1];
	T_ff u2(.clk(clk), .t(Q[2]), .enable(w[1]), .clr(clr), .Q(Q[2]));
	
	assign w[2] = w[1] && Q[2];
	T_ff u3(.clk(clk), .t(Q[3]), .enable(w[2]), .clr(clr), .Q(Q[3]));
	
	assign w[3] = w[2] && Q[3];
	T_ff u4(.clk(clk), .t(Q[4]), .enable(w[3]), .clr(clr), .Q(Q[4]));
	
	assign w[4] = w[3] && Q[4];
	T_ff u5(.clk(clk), .t(Q[5]), .enable(w[4]), .clr(clr), .Q(Q[5]));
	
	assign w[5] = w[4] && Q[5];
	T_ff u6(.clk(clk), .t(Q[6]), .enable(w[5]), .clr(clr), .Q(Q[6]));
	
	assign w[6] = w[5] && Q[6];
	T_ff u7(.clk(clk), .t(Q[7]), .enable(w[6]), .clr(clr), .Q(Q[7]));
	
endmodule
 

module T_ff(input clk, t, enable, clr, output reg Q);
	always@(posedge clk, negedge clr)
	begin
		if(clr == 1'b0)
			Q <= 0;
		else
			Q <= enable^t;	
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

