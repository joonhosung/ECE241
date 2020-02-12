

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


module Lab3_Part2(SW, LEDR);
	input[9:0] SW;
	output[9:0] LEDR;
	
	four_bit_ripple U1(.a(SW[7:4]),
						 .b(SW[3:0]),
						 .c_in(SW[8]),
			    		 .s(LEDR[3:0]),
						 .c_out(LEDR[9]));
		  
endmodule
