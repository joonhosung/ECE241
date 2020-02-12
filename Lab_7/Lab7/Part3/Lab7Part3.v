
module Lab7Part3
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
	wire [7:0] x, x_in;
	wire [6:0] y, y_in;
	wire [5:0] count;
	wire [7:0] count_clr_x;
	wire [6:0] count_clr_y;
	wire draw, writeEn, clear, enable, resetCounter;
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
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";
			
	// Put your code here. Your code should produce signals x,y,colour and writeEn
	// for the VGA controller, in addition to any other functionality your design may require.
	
	Xcounter U1(.clk(CLOCK_50), 
					.enable(enable), 
					.resetn(resetn),
					.x(x_in));

	Ycounter U2(.clk(CLOCK_50), 
					.enable(enable), 
					.resetn(resetn),
					.y(y_in));
					
	DelayCounter U3(.clk(CLOCK_50),
						 .resetn(resetCounter),
						 .enable(enable));
	
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
		.countEn(countEn),
		.resetCounter(resetCounter)
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
		.x_in(x_in),
		.y_in(y_in),
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
					input [5:0]	count,
					input [7:0] count_clr_x,
					input [6:0] count_clr_y,
					output reg writeEn,
							ld_x,
							ld_y,
							ld_c,
							clearEn,
							countEn,
							resetCounter);
	
	localparam S_LOAD = 2'd0,
			S_DRAW = 2'd1,
			S_COUNT_12 = 2'd2,
			S_CLEAR = 2'd3;
			
	reg[3:0] current_state, next_state;
	
	// State table
	always@(*)
	begin: state_table
        	case (current_state)
				S_LOAD: next_state = S_DRAW; //Update & Load Values                        	
				S_DRAW: next_state = (count >= 6'b010000) ? S_CLEAR : S_DRAW; //Draw box to current location 
				S_COUNT_12: next_state = enable ? S_CLEAR : S_COUNT_12;
				S_CLEAR: next_state = (count >= 6'b100000) ? S_LOAD : S_CLEAR; //Erase current box 
        	default: next_state = S_LOAD;
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
		resetCounter = 1'b1;
  
 
		case (current_state)
			S_LOAD: begin
				ld_x = 1'b1;
				ld_c = 1'b1;
				ld_y = 1'b1;
				writeEn = 1'b0;
				countEn = 1'b0;
				clearEn = 1'b0;
			end
			S_DRAW: begin
				ld_x = 1'b0;
				ld_c = 1'b0;
				ld_y = 1'b0;
				writeEn = 1'b1;
				countEn = 1'b1;
				clearEn = 1'b0;
			end
			S_COUNT_12: begin
				resetCounter = 1'b0;
			end
			S_CLEAR: begin
				ld_x = 1'b0;
				ld_c = 1'b0;
				ld_y = 1'b0;
				writeEn = 1'b1;
				countEn = 1'b1;
				clearEn = 1'b1;
			end
			
		endcase
	end
	
	
	// current_state registers
	always@(posedge clk)
	begin: state_FFs
		if(!resetn)
			current_state <= S_LOAD;
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
	input [7:0] x_in,
	input	[6:0]	y_in,
	output reg [7:0] x_out,
	output reg [6:0] y_out,
	output reg [2:0] c_out,
	output reg [7:0] count_clr_x,
	output reg [6:0] count_clr_y,
	output reg [5:0] count);
	
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
				x_origin <= x_in;
			if(ld_y)
				y_origin <= y_in;
			if(ld_c)
				colour <= c_in;
		end
	end
	
	
	// Draw a 4*4 pixel or erase 4*4 pixel
	always@(posedge clk)
	begin
		if(!resetn) begin
			count_clr_x <= 7'd0;
			count_clr_y <= 6'd0;
			count <= 6'd0;
			x_out <= 8'd0;
			y_out <= 7'd0;
			c_out <= 3'd0;
		end
		
		else if(clearEn && countEn && writeEn) begin
			count <= count + 6'd1;
			x_out <= x_origin + count[1:0];
			y_out <= y_origin + count[3:2];
			c_out <= 3'b000;
		end
		
		else if(writeEn && countEn && !clearEn) begin
			count <= count + 6'd1;
			x_out <= x_origin + count[1:0];
			y_out <= y_origin + count[3:2];
			c_out <= colour;

		end
		
		if (!countEn) begin
			count <= 6'd0;
			count_clr_x <= 7'd0;
			count_clr_y <= 6'd0;
		end
	end

endmodule



module Xcounter(input clk, enable, resetn, output reg[7:0] x);
	
	// 0 = right, 1 = left
	reg leftRight;
	
	always@(posedge clk)
	begin
		if(!resetn) begin
			leftRight <= 1'b0; //Initialize to right
			x <= 8'd0;
		end
		
		if(enable && !leftRight) begin //Right
			if(x >= 8'd155) begin //Flip direction
				x <= x - 8'd1;
				leftRight <= 1'b1;
			end
			else
				x <= x + 8'd1;
		end
		
		else if(enable && leftRight) begin //Left
			if(x <= 8'd0) begin //Flip direction
				x <= x + 8'd1;
				leftRight <= 1'b0;
			end
			else
				x <= x - 8'd1;
		end
	end
endmodule



module Ycounter(input clk, enable, resetn, output reg[6:0] y);
	// 0 = down, 1 = up
	reg upDown;
	
	always@(posedge clk)
	begin
		if(!resetn) begin
			upDown <= 1'b0; //Initialize to down
			y <= 7'd0;
		end
		
		if(enable && !upDown) begin //Down
			if(y >= 7'd115) begin //Flip direction
				y <= y - 7'd1;
				upDown <= 1'b1;
			end
			else
				y <= y + 7'd1;
		end
		
		else if(enable && upDown) begin //Up
			if(y <= 7'd0) begin //Flip direction
				y <= y + 7'd1;
				upDown <= 1'b0;
			end 
			else
				y <= y - 7'd1;
		end
	end

endmodule



module DelayCounter(input clk, resetn, output reg enable);
	parameter load = 24'd9_999_999; //60Hz * 12 frames = 5Hz
	reg[23:0] Q;
	
	always@(posedge clk)
	begin
		if(!resetn) begin
			Q <= 24'd0;
			enable <= 1'b0;
		end
		if(Q >= load)
		begin
			enable <= 1'b1;
			Q <= 24'd0;
		end
		else
		begin
			Q <= Q + 24'd1;
			enable <= 1'b0;
		end
	end

endmodule


