`timescale 1ns/1ns

module register (D, reset_b, clk, Q);
	input[7:0] D;
	input reset_b, clk;
	output reg[7:0] Q;
	
	always@(posedge clk)
	begin
		if(reset_b == 1'b0)
			Q <= 0;
		else
			Q <= D;	
	end
endmodule			


module ALU_Register(KEY, LEDR, SW, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	input[3:0] KEY;
	input[9:0] SW;
	output[9:0] LEDR;
	output[6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	wire[7:0] ALUout, Rout;
	
	
	// Start off by setting HEX1~3 to 0 and HEX0 to input (D).
	seg7 H0(.C(SW[3:0]), .seg(HEX0));
	seg7 H1(.C(4'd0), .seg(HEX1));
	seg7 H2(.C(4'd0), .seg(HEX2));
	seg7 H3(.C(4'd0), .seg(HEX3));
	
	
	// Create ALU
	ALU ALU1(.A(SW[3:0]), .register(Rout), .ALUout(ALUout), .func(KEY[3:1]));
	
	assign LEDR = Rout;

	
	// Create Register
	register R1(.D(ALUout), .reset_b(SW[9]), .clk(KEY[0]), .Q(Rout));
	
	
	// Give outputs
	seg7 H4(.C(Rout[3:0]), .seg(HEX4));
	seg7 H5(.C(Rout[7:4]), .seg(HEX5));
endmodule
	
	