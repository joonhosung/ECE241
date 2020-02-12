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


module ALU(A, register, ALUout, func);
	input[3:0] A;
	input[7:0] register;
	input[2:0] func;
	reg[7:0] out;
	wire [3:0] B;
	wire[4:0] AdderOut;
	output[7:0] ALUout;
	
	assign B = register[3:0];
	
	four_bit_ripple u1(.a(A[3:0]), .b(B[3:0]), .c_in(1'b0), .s(AdderOut[3:0]), .c_out(AdderOut[4]));
	
	always@(*)
	begin
		case(~func)
			3'b000: out = {3'b0, AdderOut};
			3'b001: out = A + B;
			3'b010: out = {A~^B, ~A|~B};
			3'b011: out = (|{A,B})?8'b00001111:8'b0;
			3'b100: out = ((A[0]+A[1]+A[2]+A[3] == 2'b01) && 
								(B[0]+B[1]+B[2]+B[3] == 3'b010))?8'b11110000:8'b0;
			3'b101: out = {A, ~B};
			3'b110: out = register;
			default: out = 8'b0;
		endcase
	end
	assign ALUout = out;
endmodule 
	