


module 4_ripple_carry(SW, LEDR);
	input[9:0] SW;
	output[9:0] LEDR;
	
	4_bit_ripple-carry U1(.a(sw[7:4]),
								 .b(sw[3:0]),
								 .c_in([sw[8]),
								 .s(LEDR[3:0]),
								 .c_out(LEDR[9]))
		  
endmodule


module 4_bit_ripple_carry(a, b, c_in, s, c_out);
	input[3:0] a,b;
	input c_in;
	output [3:0] s;
	output c_out;
	wire c1, c2, c3;
	
	FA FA0(a[0], b[0], c_in, s[0], c1);
	FA FA1(a[1], b[1], c1, s[1], c1);
	FA FA2(a[2], b[2], c2, s[2], c3);
	FA FA3(a[3], b[3], c3, s[3], c_out);

endmodule


module FA(c_in, c_out, a, b, s):
	input a, b, c_in;
	output s, c_out;
	
	assign s = c+in ^ b ^ a; // ^: XOR
	assign c_out = (b&a) | (c_in&b) | (c_in&a);

endmodule
