
module Guitar_Amp (
	// Inputs
	CLOCK_50,
	KEY,

	AUD_ADCDAT,

	// Bidirectionals
	AUD_BCLK,
	AUD_ADCLRCK,
	AUD_DACLRCK,

	FPGA_I2C_SDAT,

	// Outputs
	AUD_XCK,
	AUD_DACDAT,
	
	FPGA_I2C_SCLK,
	SW
);

/*****************************************************************************
 *                           Parameter Declarations                          *
 *****************************************************************************/


/*****************************************************************************
 *                             Port Declarations                             *
 *****************************************************************************/
	// Inputs
	input				CLOCK_50;
	input		[3:0]	KEY;
	input		[9:0]	SW;

	input				AUD_ADCDAT;

	// Bidirectionals
	inout				AUD_BCLK;
	inout				AUD_ADCLRCK;
	inout				AUD_DACLRCK;

	inout				FPGA_I2C_SDAT;

	// Outputs
	output				AUD_XCK;
	output				AUD_DACDAT;

	output				FPGA_I2C_SCLK;

	/*****************************************************************************
	 *                 Internal Wires and Registers Declarations                 *
	 *****************************************************************************/
	// Internal Wires
	wire				audio_in_available;
	wire		[31:0]	left_channel_audio_in;
	wire		[31:0]	right_channel_audio_in;
	wire				read_audio_in;

	wire				audio_out_allowed;
	wire		[31:0]	left_channel_audio_out;
	wire		[31:0]	right_channel_audio_out;
	wire				write_audio_out;

	// Internal Registers

	reg [18:0] delay_cnt;
	wire [18:0] delay;

	reg snd;

	// State Machine Registers

	/*****************************************************************************
	 *                         Finite State Machine(s)                           *
	 *****************************************************************************/

	datapath(
		.overdrive(SW[0]),
		.tremolo(SW[1]),
		.delay(SW[2]),
		.phase_shift(SW[3]),
		.clk(CLOCK_50),
		.resetn(SW[9]),
		.sound_in(left_channel_audio_in),
		.sound_out(left_channel_audio_out)
	);

	/*****************************************************************************
	 *                             Sequential Logic                              *
	 *****************************************************************************/

	always @(posedge CLOCK_50) begin
		if(delay_cnt == delay) begin
			delay_cnt <= 0;
			snd <= !snd;
		end else delay_cnt <= delay_cnt + 1;
	end

	reg clock_divider;
	reg [24:0] div_count;
	always @(posedge CLOCK_50) begin
		parameter load = 25'd24_999_999;
		if(load == div_count) begin
			div_count <= 0;
			clock_divider = 1;
		end 
		else begin
			div_count <= div_count + 1;
			clock_divider = 0;
		end
	end

	wire decrease, increase;
	assign increase = ~KEY[1];
	assign decrease = ~KEY[2];
	reg [9:0] gain; //1000 levels of gain. Divide by 100 -> 0 ~ 10.00 gain

	// increase/decrease gain
	always@(posedge clock_divider) begin
		if(increase && !decrease && (gain < 10'd1000)) begin
			gain <= gain + 10'd10;
		end
		
		if(decrease && !increase && (gain > 10'd0)) begin
			gain <= gain - 10'd10;
		end
	end


	// decrease gain
	/*always@(posedge decrease) begin
		if(gain > 10'd0) begin
			gain <= gain - 10'd10;
		end
	end
	*/
	// Get gain 
	always @(posedge CLOCK_50) begin
		sound_left <= gain * right_channel_audio_in[28:0] / 10'd100;//left_channel_audio_in[31:0];//gain * left_channel_audio_in[23:0] / 10'd100;
		sound_right <= gain * right_channel_audio_in[28:0] / 10'd100;//right_channel_audio_in[31:0];//
	end

	/*
	always @(posedge CLOCK_50) begin
		if(left_channel_audio_in[23:0] > {24{1'b1}} - gain) begin
			sound_left <= {left_channel_audio_in[31:24], {24{1'b1}} - gain};
			sound_right <= {right_channel_audio_in[31:24], {24{1'b1}} - gain};
		end
		else if (left_channel_audio_in[23:0] < -{24{1'b1}} + gain) begin
			sound_left <= {left_channel_audio_in[31:24], -{24{1'b1}} + gain};
			sound_right <= {right_channel_audio_in[31:24],-{24{1'b1}} + gain};
		end
		else begin
			sound_left <= left_channel_audio_in;
			sound_right <= right_channel_audio_in;
		end
	end
	*/



	/*****************************************************************************
	 *                            Combinational Logic                            *
	 *****************************************************************************/

	//assign delay = {SW[3:0], 15'd3000};
	assign delay = {4'b1000, 15'd3000};

	//wire [24:0] sound = (SW == 0) ? 0 : snd ? 24'd10000000 : -24'd10000000;
	//wire [23:0] gain = SW[5:0] * 24'd100_000;

	//reg [31:0] sound_left;
	//reg [31:0] sound_right;

	reg [31:0] sound_left;
	reg [31:0] sound_right;

	wire [7:0] volume;
	assign volume = SW[7:0];
	assign read_audio_in			= audio_in_available & audio_out_allowed;

	/*
	always@(posedge CLOCK_50) begin
		sound_left <= left_channel_audio_in;
		sound_right <= right_channel_audio_in;
	end */
	//assign left_channel_audio_out	= sound_left - (volume * sound_left) / 8'd255;
	//assign right_channel_audio_out	= sound_right - (volume * sound_right) / 8'd255;
	//assign left_channel_audio_out	= sound_left - (volume * sound_left) / 8'd255;
	//assign right_channel_audio_out	= sound_right - (volume * sound_right) / 8'd255;

	//assign left_channel_audio_out	= sound_left;//{left_channel_audio_in[31:24],sound_left[23:0]};
	//assign right_channel_audio_out	= sound_right;//{right_channel_audio_in[31:24],sound_left[23:0]};

	
	
	//assign left_channel_audio_out	= left_channel_audio_in;
	//assign right_channel_audio_out	= right_channel_audio_in;
	assign write_audio_out			= audio_in_available & audio_out_allowed;




	/*****************************************************************************
	 *                              Internal Modules                             *
	 *****************************************************************************/

	Audio_Controller Audio_Controller (
		// Inputs
		.CLOCK_50						(CLOCK_50),
		.reset						(~KEY[0]),

		.clear_audio_in_memory		(),
		.read_audio_in				(read_audio_in),
		
		.clear_audio_out_memory		(),
		.left_channel_audio_out		(left_channel_audio_out),
		.right_channel_audio_out	(right_channel_audio_out),
		.write_audio_out			(write_audio_out),

		.AUD_ADCDAT					(AUD_ADCDAT),

		// Bidirectionals
		.AUD_BCLK					(AUD_BCLK),
		.AUD_ADCLRCK				(AUD_ADCLRCK),
		.AUD_DACLRCK				(AUD_DACLRCK),


		// Outputs
		.audio_in_available			(audio_in_available),
		.left_channel_audio_in		(left_channel_audio_in),
		.right_channel_audio_in		(right_channel_audio_in),

		.audio_out_allowed			(audio_out_allowed),

		.AUD_XCK					(AUD_XCK),
		.AUD_DACDAT					(AUD_DACDAT)

	);

	avconf #(.USE_MIC_INPUT(1)) avc (
		.FPGA_I2C_SCLK					(FPGA_I2C_SCLK),
		.FPGA_I2C_SDAT					(FPGA_I2C_SDAT),
		.CLOCK_50					(CLOCK_50),
		.reset						(~KEY[0])
	);

	endmodule




module datapath(
	overdrive,
	tremolo,
	delay,
	phase_shift,
	clk,
	resetn,
	sound_in,
	sound_out
);
	
	input overdrive,
			tremolo,
			delay,
			phase_shift,
			resetn,
			clk;
		
	input signed[31:0] sound_in;
	output reg signed[31:0] sound_out;
	
	parameter signed drive = 32'd1_500_000_000;
	reg signed[15:0] molo;
	parameter signed[10:0] tremolo_adjuster = 10'd500;
	
	sync_rom(.clock(clk), .address(sine_count), .sine_out(sine));
	
	reg[7:0] sine_count;
	reg[7:0] clk_count;
	wire[15:0] sine;

	
	
	
	// 8-bit Counter for sine wave LUT
	always@(posedge clk) begin
		parameter load = 18'd196078; //255 Hz
		if(resetn) begin
			sine_count <= 0;
			clk_count <= 0;
		end
		else if(clk_count >= load) begin
			sine_count <= sine_count + 1;
			clk_count <= 0;
		end
		else if((clk_count >= load) && (sine_count == 8'd255)) begin
			sine_count <= 0;
			clk_count <= 0;
		end
		else 
			clk_count <= clk_count + 1;
			
	end
	
	
	// Active effects
	always@(posedge clk) begin
		
		
		// Clippy boi
		if(overdrive) begin
			if(sound_in > drive)
				sound_out <= drive;
			else if(sound_in < (-drive))
				sound_out <= -drive;
		end
		
		
		// Wobbly boi
		if(tremolo) begin
			molo <= $signed(sine) / $signed(tremolo_adjuster);
			sound_out <= sound_in / $signed(molo);
		end
		
		
		// Echo-y boi
		if(delay) begin
			// 
		end	
		
		
		// Pitchy boi
		if(phase_shift) begin
			
		end
	end
	
	
	// Passive effects (treble, bass)
	always@(posedge clk) begin
		//bass b();
		//treble t();
	end

endmodule


module bass(
	input[8:0] gain,
	input[31:0] audio_in_left, 
					audio_in_right,
	output reg [31:0] audio_out_left,
						  audio_out_right);
					 
	//Do fft for bass sections of signal
	//Then do inverse fft to return back to signal
endmodule



module treble(
	input[8:0] gain,
	input[31:0] audio_in_left, 
					audio_in_right,
	output reg [31:0] audio_out_left,
						  audio_out_right);
					 
	//Do fft for treble sections of signal
	//Then do inverse fft to return back to signal
endmodule




// Sine wave LUT. shift final values to that min. value = 0.
module sync_rom (clock, address, sine_out);
input clock;
input [7:0] address;
output [15:0] sine_out;
reg signed [15:0] sine;
reg signed [15:0] sine_out;
parameter signed[15:0] shift= 16'h4000;
always@(posedge clock)
begin
    case(address)
    		8'h00: sine = 16'h0000 ;
			8'h01: sine = 16'h0192 ;
			8'h02: sine = 16'h0323 ;
			8'h03: sine = 16'h04b5 ;
			8'h04: sine = 16'h0645 ;
			8'h05: sine = 16'h07d5 ;
			8'h06: sine = 16'h0963 ;
			8'h07: sine = 16'h0af0 ;
			8'h08: sine = 16'h0c7c ;
			8'h09: sine = 16'h0e05 ;
			8'h0a: sine = 16'h0f8c ;
			8'h0b: sine = 16'h1111 ;
			8'h0c: sine = 16'h1293 ;
			8'h0d: sine = 16'h1413 ;
			8'h0e: sine = 16'h158f ;
			8'h0f: sine = 16'h1708 ;
			8'h10: sine = 16'h187d ;
			8'h11: sine = 16'h19ef ;
			8'h12: sine = 16'h1b5c ;
			8'h13: sine = 16'h1cc5 ;
			8'h14: sine = 16'h1e2a ;
			8'h15: sine = 16'h1f8b ;
			8'h16: sine = 16'h20e6 ;
			8'h17: sine = 16'h223c ;
			8'h18: sine = 16'h238d ;
			8'h19: sine = 16'h24d9 ;
			8'h1a: sine = 16'h261f ;
			8'h1b: sine = 16'h275f ;
			8'h1c: sine = 16'h2899 ;
			8'h1d: sine = 16'h29cc ;
			8'h1e: sine = 16'h2afa ;
			8'h1f: sine = 16'h2c20 ;
			8'h20: sine = 16'h2d40 ;
			8'h21: sine = 16'h2e59 ;
			8'h22: sine = 16'h2f6b ;
			8'h23: sine = 16'h3075 ;
			8'h24: sine = 16'h3178 ;
			8'h25: sine = 16'h3273 ;
			8'h26: sine = 16'h3366 ;
			8'h27: sine = 16'h3452 ;
			8'h28: sine = 16'h3535 ;
			8'h29: sine = 16'h3611 ;
			8'h2a: sine = 16'h36e4 ;
			8'h2b: sine = 16'h37ae ;
			8'h2c: sine = 16'h3870 ;
			8'h2d: sine = 16'h3929 ;
			8'h2e: sine = 16'h39da ;
			8'h2f: sine = 16'h3a81 ;
			8'h30: sine = 16'h3b1f ;
			8'h31: sine = 16'h3bb5 ;
			8'h32: sine = 16'h3c41 ;
			8'h33: sine = 16'h3cc4 ;
			8'h34: sine = 16'h3d3d ;
			8'h35: sine = 16'h3dad ;
			8'h36: sine = 16'h3e14 ;
			8'h37: sine = 16'h3e70 ;
			8'h38: sine = 16'h3ec4 ;
			8'h39: sine = 16'h3f0d ;
			8'h3a: sine = 16'h3f4d ;
			8'h3b: sine = 16'h3f83 ;
			8'h3c: sine = 16'h3fb0 ;
			8'h3d: sine = 16'h3fd2 ;
			8'h3e: sine = 16'h3feb ;
			8'h3f: sine = 16'h3ffa ;
			8'h40: sine = 16'h3fff ;
			8'h41: sine = 16'h3ffa ;
			8'h42: sine = 16'h3feb ;
			8'h43: sine = 16'h3fd2 ;
			8'h44: sine = 16'h3fb0 ;
			8'h45: sine = 16'h3f83 ;
			8'h46: sine = 16'h3f4d ;
			8'h47: sine = 16'h3f0d ;
			8'h48: sine = 16'h3ec4 ;
			8'h49: sine = 16'h3e70 ;
			8'h4a: sine = 16'h3e14 ;
			8'h4b: sine = 16'h3dad ;
			8'h4c: sine = 16'h3d3d ;
			8'h4d: sine = 16'h3cc4 ;
			8'h4e: sine = 16'h3c41 ;
			8'h4f: sine = 16'h3bb5 ;
			8'h50: sine = 16'h3b1f ;
			8'h51: sine = 16'h3a81 ;
			8'h52: sine = 16'h39da ;
			8'h53: sine = 16'h3929 ;
			8'h54: sine = 16'h3870 ;
			8'h55: sine = 16'h37ae ;
			8'h56: sine = 16'h36e4 ;
			8'h57: sine = 16'h3611 ;
			8'h58: sine = 16'h3535 ;
			8'h59: sine = 16'h3452 ;
			8'h5a: sine = 16'h3366 ;
			8'h5b: sine = 16'h3273 ;
			8'h5c: sine = 16'h3178 ;
			8'h5d: sine = 16'h3075 ;
			8'h5e: sine = 16'h2f6b ;
			8'h5f: sine = 16'h2e59 ;
			8'h60: sine = 16'h2d40 ;
			8'h61: sine = 16'h2c20 ;
			8'h62: sine = 16'h2afa ;
			8'h63: sine = 16'h29cc ;
			8'h64: sine = 16'h2899 ;
			8'h65: sine = 16'h275f ;
			8'h66: sine = 16'h261f ;
			8'h67: sine = 16'h24d9 ;
			8'h68: sine = 16'h238d ;
			8'h69: sine = 16'h223c ;
			8'h6a: sine = 16'h20e6 ;
			8'h6b: sine = 16'h1f8b ;
			8'h6c: sine = 16'h1e2a ;
			8'h6d: sine = 16'h1cc5 ;
			8'h6e: sine = 16'h1b5c ;
			8'h6f: sine = 16'h19ef ;
			8'h70: sine = 16'h187d ;
			8'h71: sine = 16'h1708 ;
			8'h72: sine = 16'h158f ;
			8'h73: sine = 16'h1413 ;
			8'h74: sine = 16'h1293 ;
			8'h75: sine = 16'h1111 ;
			8'h76: sine = 16'h0f8c ;
			8'h77: sine = 16'h0e05 ;
			8'h78: sine = 16'h0c7c ;
			8'h79: sine = 16'h0af0 ;
			8'h7a: sine = 16'h0963 ;
			8'h7b: sine = 16'h07d5 ;
			8'h7c: sine = 16'h0645 ;
			8'h7d: sine = 16'h04b5 ;
			8'h7e: sine = 16'h0323 ;
			8'h7f: sine = 16'h0192 ;
			8'h80: sine = 16'h0000 ;
			8'h81: sine = 16'hfe6e ;
			8'h82: sine = 16'hfcdd ;
			8'h83: sine = 16'hfb4b ;
			8'h84: sine = 16'hf9bb ;
			8'h85: sine = 16'hf82b ;
			8'h86: sine = 16'hf69d ;
			8'h87: sine = 16'hf510 ;
			8'h88: sine = 16'hf384 ;
			8'h89: sine = 16'hf1fb ;
			8'h8a: sine = 16'hf074 ;
			8'h8b: sine = 16'heeef ;
			8'h8c: sine = 16'hed6d ;
			8'h8d: sine = 16'hebed ;
			8'h8e: sine = 16'hea71 ;
			8'h8f: sine = 16'he8f8 ;
			8'h90: sine = 16'he783 ;
			8'h91: sine = 16'he611 ;
			8'h92: sine = 16'he4a4 ;
			8'h93: sine = 16'he33b ;
			8'h94: sine = 16'he1d6 ;
			8'h95: sine = 16'he075 ;
			8'h96: sine = 16'hdf1a ;
			8'h97: sine = 16'hddc4 ;
			8'h98: sine = 16'hdc73 ;
			8'h99: sine = 16'hdb27 ;
			8'h9a: sine = 16'hd9e1 ;
			8'h9b: sine = 16'hd8a1 ;
			8'h9c: sine = 16'hd767 ;
			8'h9d: sine = 16'hd634 ;
			8'h9e: sine = 16'hd506 ;
			8'h9f: sine = 16'hd3e0 ;
			8'ha0: sine = 16'hd2c0 ;
			8'ha1: sine = 16'hd1a7 ;
			8'ha2: sine = 16'hd095 ;
			8'ha3: sine = 16'hcf8b ;
			8'ha4: sine = 16'hce88 ;
			8'ha5: sine = 16'hcd8d ;
			8'ha6: sine = 16'hcc9a ;
			8'ha7: sine = 16'hcbae ;
			8'ha8: sine = 16'hcacb ;
			8'ha9: sine = 16'hc9ef ;
			8'haa: sine = 16'hc91c ;
			8'hab: sine = 16'hc852 ;
			8'hac: sine = 16'hc790 ;
			8'had: sine = 16'hc6d7 ;
			8'hae: sine = 16'hc626 ;
			8'haf: sine = 16'hc57f ;
			8'hb0: sine = 16'hc4e1 ;
			8'hb1: sine = 16'hc44b ;
			8'hb2: sine = 16'hc3bf ;
			8'hb3: sine = 16'hc33c ;
			8'hb4: sine = 16'hc2c3 ;
			8'hb5: sine = 16'hc253 ;
			8'hb6: sine = 16'hc1ec ;
			8'hb7: sine = 16'hc190 ;
			8'hb8: sine = 16'hc13c ;
			8'hb9: sine = 16'hc0f3 ;
			8'hba: sine = 16'hc0b3 ;
			8'hbb: sine = 16'hc07d ;
			8'hbc: sine = 16'hc050 ;
			8'hbd: sine = 16'hc02e ;
			8'hbe: sine = 16'hc015 ;
			8'hbf: sine = 16'hc006 ;
			8'hc0: sine = 16'hc001 ;
			8'hc1: sine = 16'hc006 ;
			8'hc2: sine = 16'hc015 ;
			8'hc3: sine = 16'hc02e ;
			8'hc4: sine = 16'hc050 ;
			8'hc5: sine = 16'hc07d ;
			8'hc6: sine = 16'hc0b3 ;
			8'hc7: sine = 16'hc0f3 ;
			8'hc8: sine = 16'hc13c ;
			8'hc9: sine = 16'hc190 ;
			8'hca: sine = 16'hc1ec ;
			8'hcb: sine = 16'hc253 ;
			8'hcc: sine = 16'hc2c3 ;
			8'hcd: sine = 16'hc33c ;
			8'hce: sine = 16'hc3bf ;
			8'hcf: sine = 16'hc44b ;
			8'hd0: sine = 16'hc4e1 ;
			8'hd1: sine = 16'hc57f ;
			8'hd2: sine = 16'hc626 ;
			8'hd3: sine = 16'hc6d7 ;
			8'hd4: sine = 16'hc790 ;
			8'hd5: sine = 16'hc852 ;
			8'hd6: sine = 16'hc91c ;
			8'hd7: sine = 16'hc9ef ;
			8'hd8: sine = 16'hcacb ;
			8'hd9: sine = 16'hcbae ;
			8'hda: sine = 16'hcc9a ;
			8'hdb: sine = 16'hcd8d ;
			8'hdc: sine = 16'hce88 ;
			8'hdd: sine = 16'hcf8b ;
			8'hde: sine = 16'hd095 ;
			8'hdf: sine = 16'hd1a7 ;
			8'he0: sine = 16'hd2c0 ;
			8'he1: sine = 16'hd3e0 ;
			8'he2: sine = 16'hd506 ;
			8'he3: sine = 16'hd634 ;
			8'he4: sine = 16'hd767 ;
			8'he5: sine = 16'hd8a1 ;
			8'he6: sine = 16'hd9e1 ;
			8'he7: sine = 16'hdb27 ;
			8'he8: sine = 16'hdc73 ;
			8'he9: sine = 16'hddc4 ;
			8'hea: sine = 16'hdf1a ;
			8'heb: sine = 16'he075 ;
			8'hec: sine = 16'he1d6 ;
			8'hed: sine = 16'he33b ;
			8'hee: sine = 16'he4a4 ;
			8'hef: sine = 16'he611 ;
			8'hf0: sine = 16'he783 ;
			8'hf1: sine = 16'he8f8 ;
			8'hf2: sine = 16'hea71 ;
			8'hf3: sine = 16'hebed ;
			8'hf4: sine = 16'hed6d ;
			8'hf5: sine = 16'heeef ;
			8'hf6: sine = 16'hf074 ;
			8'hf7: sine = 16'hf1fb ;
			8'hf8: sine = 16'hf384 ;
			8'hf9: sine = 16'hf510 ;
			8'hfa: sine = 16'hf69d ;
			8'hfb: sine = 16'hf82b ;
			8'hfc: sine = 16'hf9bb ;
			8'hfd: sine = 16'hfb4b ;
			8'hfe: sine = 16'hfcdd ;
			8'hff: sine = 16'hfe6e ;
	endcase
	
	if((sine + shift) == 0) 
		sine_out <= 1;
	else 
		sine_out <= sine + shift;
end
endmodule
