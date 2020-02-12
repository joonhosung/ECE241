
module mux6to1(Input, Out, MuxSelect);
	input [5:0] Input;
	input [2:0] MuxSelect;
	output Out;
	
	reg Out;

	always@(*)
	begin
		case(MuxSelect[2:0])
			3'b000: Out = Input[0];
			3'b001: Out = Input[1];
			3'b010: Out = Input[2];
			3'b011: Out = Input[3];
			3'b100: Out = Input[4];
			3'b101: Out = Input[5];
			default: Out = 1'b0;
		endcase
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


module FA(a, b, c_in, s, c_out);
	input a, b, c_in;
	output s, c_out;
	
	assign s = c_in ^ b ^ a; // ^: XOR
	assign c_out = (b&a) | (c_in&b) | (c_in&a);

endmodule


module four_bit_ripple(a, b, c_in, s, c_out);
	input[3:0] a,b;
	input c_in;
	output [3:0] s;
	output c_out;
	wire c1, c2, c3;
	
	FA FA0(a[0], b[0], c_in, s[0], c1);
	FA FA1(a[1], b[1], c1, s[1], c2);
	FA FA2(a[2], b[2], c2, s[2], c3);
	FA FA3(a[3], b[3], c3, s[3], c_out);

endmodule


//mux6to1(Input, Out, MuxSelect)
//seg7(C, seg)
//four_bit_ripple(a, b, c_in, s, c_out)
module ALU(A, B, ALUout, func);
	input[3:0] A, B;
	input[2:0] func;
	reg[7:0] out;
	wire[4:0] AdderOut;
	output[7:0] ALUout;
	
	four_bit_ripple u1(.a(A[3:0]), .b(B[3:0]), .c_in(1'b0), .s(AdderOut[3:0]), .c_out(AdderOut[4]));
	
	always@(*)
	begin
		case(~func)
			3'b000: out = {3'b0, AdderOut};
			3'b001: out = A + B;
			3'b010: out = {A~^B, ~A|~B};
			3'b011: out = (A||B)?8'b00001111:8'b0;
			3'b100: out = ((A[0]+A[1]+A[2]+A[3] == 2'b01) && 
								(B[0]+B[1]+B[2]+B[3] == 3'b010))?8'b11110000:8'b0;
			3'b101: out = {A, ~B};
			default: out = 8'b0;
		endcase
	end
	assign ALUout = out;
endmodule


module Lab3_Part3(SW, KEY, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	input[7:0] SW;
	input[2:0] KEY;
	output[7:0] LEDR;
	output[6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	wire[7:0] ALUout;

	ALU U1(.A(SW[7:4]),
			 .B(SW[3:0]),
			 .ALUout(ALUout),
			 .func(KEY));
	
	assign LEDR = ALUout;
	
	seg7 H0(.C(SW[3:0]), .seg(HEX0));
	seg7 H1(.C(4'b0), .seg(HEX1));
	seg7 H2(.C(SW[7:4]), .seg(HEX2));
	seg7 H3(.C(4'b0), .seg(HEX3));
	seg7 H4(.C(ALUout[3:0]), .seg(HEX4));
	seg7 H5(.C(ALUout[7:4]), .seg(HEX5));
	
	
endmodule
	