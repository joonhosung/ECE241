// Part 2 skeleton

module Lab7Part2
	(
		CLOCK_50,					//	On Board 50 MHz
		// Your inputs and outputs here
		KEY,							// On Board Keys
		SW,
		// The ports below are for the VGA output.  Do not change.
		VGA_CLK,   					//	VGA Clock
		VGA_HS,						//	VGA H_SYNC
		VGA_VS,						//	VGA V_SYNC
		VGA_BLANK_N,				//	VGA BLANK
		VGA_SYNC_N,					//	VGA SYNC
		VGA_R,   					//	VGA Red[9:0]
		VGA_G,	 					//	VGA Green[9:0]
		VGA_B   						//	VGA Blue[9:0]
	);

	input	CLOCK_50;				//	50 MHz
	input [9:0] SW;
	input	[3:0]	KEY;
	// Declare your inputs and outputs here
	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[7:0]	VGA_R;   				//	VGA Red[7:0] Changed from 10 to 8-bit DAC
	output	[7:0]	VGA_G;	 				//	VGA Green[7:0]
	output	[7:0]	VGA_B;   				//	VGA Blue[7:0]
	
	wire resetn;
	assign resetn = KEY[0];
	
	// Create the colour, x, y and writeEn wires that are inputs to the controller.

	wire [2:0] colour;
	wire [7:0] x;
	wire [6:0] y;
	wire [4:0] count;
	wire [7:0] count_clr_x;
	wire [6:0] count_clr_y;
	wire draw, writeEn, clear, enable;
	assign draw = ~KEY[1];
	assign clear = ~KEY[2];
	assign enable = ~KEY[3];
	wire ld_x, ld_y, ld_c, countEn, clearEn;
	
	

	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(writeEn),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "320x240";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";
			
	// Put your code here. Your code should produce signals x,y,colour and writeEn
	// for the VGA controller, in addition to any other functionality your design may require.
	
	
	control ctrl(
		.enable(enable), 
		.plot(draw),
		.resetn(resetn),
		.clk(CLOCK_50),
		.clear(clear),
		.count(count),
		.count_clr_x(count_clr_x),
		.count_clr_y(count_clr_y),
		.writeEn(writeEn),
		.ld_x(ld_x),
		.ld_y(ld_y),
		.ld_c(ld_c),
		.clearEn(clearEn),
		.countEn(countEn)
	);
	
	datapath dp(
		.ld_x(ld_x),
		.ld_y(ld_y),
		.ld_c(ld_c),
		.clearEn(clearEn),
		.writeEn(writeEn),
		.countEn(countEn),
		.resetn(resetn),
		.clk(CLOCK_50),
		.c_in(SW[9:7]),
		.x_in(SW[6:0]),
		.y_in(SW[6:0]),
		.x_out(x),
		.y_out(y),
		.c_out(colour),
		.count_clr_x(count_clr_x),
		.count_clr_y(count_clr_y),
		.count(count)
	);
endmodule



module control(input enable, 
							plot,
							resetn,
							clk,
							clear,
					input [4:0]	count,
					input [7:0] count_clr_x,
					input [6:0] count_clr_y,
					output reg writeEn,
							ld_x,
							ld_y,
							ld_c,
							clearEn,
							countEn);
	
	localparam S_LOAD_X = 3'd0,
			S_LOAD_X_WAIT = 3'd1,
			S_LOAD_Y = 3'd2,
			DRAW = 3'd3,
			CLEAR = 3'd4;
			
	reg[3:0] current_state, next_state;
	
	// State table
	always@(*)
	begin: state_table
        	case (current_state)
             	S_LOAD_X: next_state = enable ? S_LOAD_X_WAIT : S_LOAD_X;                            	
               S_LOAD_X_WAIT: next_state = enable ? S_LOAD_X_WAIT : S_LOAD_Y; 
					S_LOAD_Y: next_state = plot ? DRAW : S_LOAD_Y;     
					DRAW: next_state = (count >= 5'b10000) ? S_LOAD_X : DRAW; 
					CLEAR: next_state = ((count_clr_x >= 8'd160) && (count_clr_y >= 7'd120)) ? S_LOAD_X : CLEAR; // 159,119 (last pixel)
        	default: next_state = S_LOAD_X;
			endcase
	end
	
	
	always @(*)
	begin: writeEn_signals
    	ld_x = 1'b0;
      writeEn = 1'b0;
      ld_c = 1'b0;
		ld_y = 1'b0;
		countEn = 1'b0;
		clearEn = 1'b0;
  
 
		case (current_state)
			S_LOAD_X: begin
				ld_x = 1'b1;
				ld_c = 1'b1;
				writeEn = 1'b0;
				countEn = 1'b0;
				clearEn = 1'b0;
				ld_y = 1'b0;
			end

			S_LOAD_Y: begin
				ld_x = 1'b0;
				ld_c = 1'b0;
				writeEn = 1'b0;	
				countEn = 1'b0;
				clearEn = 1'b0;
				ld_y = 1'b1;
			end

			DRAW: begin
				ld_x = 1'b0;
				ld_c = 1'b0;
				writeEn = 1'b1;
				countEn = 1'b1;
				clearEn = 1'b0;	
				ld_y = 1'b0;
			end
		
			CLEAR: begin
				ld_x = 1'b0;
				ld_c = 1'b0;
				writeEn = 1'b1;
				countEn = 1'b1;
				clearEn = 1'b1;
				ld_y = 1'b0;
			end
			
		endcase
	end
	
	
	// current_state registers
	always@(posedge clk)
	begin: state_FFs
		if(!resetn)
			current_state <= S_LOAD_X;
		else if(clear)
			current_state <= CLEAR;
		else
			current_state <= next_state;
	end // state_FFS

endmodule



module datapath(
	input ld_x,
			ld_y,
			ld_c,
			clearEn,
			writeEn,
			countEn,
			resetn,
			clk,
	input [2:0] c_in,
	input [6:0] x_in,
					y_in,
	output reg [7:0] x_out,
	output reg [6:0] y_out,
	output reg [2:0] c_out,
	output reg [7:0] count_clr_x,
	output reg [6:0] count_clr_y,
	output reg [4:0] count);
	
	reg [7:0] x_origin;
	reg [6:0] y_origin;
	reg [2:0] colour;
	// Load x, y, and colour
	always@(posedge clk)
	begin
		if(!resetn) begin
			x_origin <= 8'd0;
			y_origin <= 7'd0;
			colour <= 2'd0;
		end
		else begin
			if(ld_x)
				x_origin <= {1'b0,x_in};
			if(ld_y)
				y_origin <= y_in;
			if(ld_c)
				colour <= c_in;
		end
	end
	
	
	// Draw a 4*4 pixel or clear whole thing
	always@(posedge clk)
	begin
		if(!resetn) begin
			count_clr_x <= 7'd0;
			count_clr_y <= 6'd0;
			count <= 5'd0;
			x_out <= 8'd0;
			y_out <= 7'd0;
			c_out <= 3'd0;
		end
		
		else if(clearEn && countEn && writeEn) begin
			count_clr_x <= count_clr_x + 8'd1;
			if(count_clr_x >= 8'd160) begin
				count_clr_x <= 8'd0;
				count_clr_y <= count_clr_y + 7'd1;
			end			
			x_out <= count_clr_x;
			y_out <= count_clr_y;
			c_out <= 3'b000;
		end
		
		else if(writeEn && countEn && !clearEn) begin
			count <= count + 5'd1;
			x_out <= x_origin + count[1:0];
			y_out <= y_origin + count[3:2];
			c_out <= colour;

		end
		
		if (!countEn) begin
			count <= 5'd0;
			count_clr_x <= 7'd0;
			count_clr_y <= 6'd0;
		end
	end

endmodule



