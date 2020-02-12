module Guitar_Amp(
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
	SW,
	LEDR,
	
	HEX0,
	HEX1,
	HEX2,
	HEX3,
	HEX4,
	HEX5,
	
	
	
	// For graphics
	
	PS2_CLK,
	PS2_DAT,
	VGA_CLK,
	VGA_HS,
	VGA_VS,
	VGA_BLANK_N,
	VGA_SYNC_N,
	VGA_R, // [7:0]
	VGA_G,
	VGA_B
);

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
	output[9:0]			LEDR;
	
	output[6:0]			HEX0,
							HEX1,
							HEX2,
							HEX3,
							HEX4,
							HEX5;
	
	
	// For graphics
	inout PS2_CLK,
			PS2_DAT;
	
	output VGA_CLK,
			 VGA_HS,
			 VGA_VS,
			 VGA_BLANK_N,
			 VGA_SYNC_N;
	
	output[7:0] VGA_R,
					VGA_G,
					VGA_B;


					
	// Internal Wires
	wire				audio_in_available;
	wire		[31:0]	left_channel_audio_in;
	wire		[31:0]	right_channel_audio_in;
	wire				read_audio_in;

	wire				audio_out_allowed;
	wire		[31:0]	left_channel_audio_out;
	wire		[31:0]	right_channel_audio_out;
	wire				write_audio_out;
	
	
	// Averaging Filter
	reg signed[31:0] filtered_sound,
						  div1, div2, div3, div4, 
						  div5, div6, div7, div8,
						  div9, div10;
	
	//reg [3:0] filter_count;
	/*
	always@(negedge read_audio_in) begin
		
		div1 <= $signed(left_channel_audio_in);
		div2 <= div1;
		div3 <= div2;
		div4 <= div3;
		div5 <= div4;
		div6 <= div5;
		div7 <= div6;
		div8 <= div7;
		div9 <= div8;
		div10 <= div9;
		
		filtered_sound <= $signed(left_channel_audio_in)/4'd11
								+ div1/4'd11
								+ div2/4'd11
								+ div3/4'd11
								+ div4/4'd11
								+ div5/4'd11
								+ div6/4'd11
								+ div7/4'd11
								+ div8/4'd11
								+ div9/4'd11
								+ div10/4'd11;
	end
	*/
		

	wire [6:0] gain_fsm; //126 levels of gain. Divide by 128 -> 0 ~ 1 gain
	
	wire [6:0] treble_fsm;
	wire [6:0] bass_fsm;
	
	reg [31:0] pregain;
	
	reg [6:0] gain;
	
	
	
	// get gain from control
	always@(*) begin
		gain <= 7'd127 - gain_fsm;			
		pregain <= $signed(left_channel_audio_in) / $signed(gain);  		
	end
	

	wire[31:0] sound_left;
	wire [31:0] sound_right;

	assign read_audio_in	= audio_in_available & audio_out_allowed;
	assign write_audio_out = audio_in_available & audio_out_allowed;

	
	wire signed [31:0] playback_in;
	
	
	// Module declarations
	effects_path e_p(
		.overdrive(overdrive),
		.tremolo(tremolo),
		.delay(delay),
		.phase_shift(phase_shift),
		.fuzz(fuzz),
		.bit_eff(bit_eff),
		.clk(CLOCK_50),
		.resetn(SW[9]),
		.read_clk(read_audio_in),
		.sound_in(pregain),
		.sound_out(playback_in),
		.sound_in_mem(sound_in_mem),
		.sound_out_mem(sound_out_mem),
	);
	
	playback playback(
		.clk(write_audio_out), 
		.record(record), 
		.play(play), 
		.sound_in(playback_in), 
		.sound_out(sound_left)
	);
	
	graphics graphics(
		.CLOCK_50(CLOCK_50),						//	On Board 50 MHz
		.SW(SW),								// Board Switches
		.LEDR(LEDR),								// Board LEDRs
		.KEY(KEY),								// Board KEYs
		.HEX0(HEX0),         					// Baord HEX
		.HEX1(HEX1),
		.HEX2(HEX2),
		.HEX3(HEX3),
		.HEX4(HEX4),
		.HEX5(HEX5),
		
		.audio_in(sound_left),						// Audio from guitar
		
		.PS2_CLK(PS2_CLK),
		.PS2_DAT(PS2_DAT),
		
		.VGA_CLK(VGA_CLK),   						//	VGA Clock
		.VGA_HS(VGA_HS),							//	VGA H_SYNC
		.VGA_VS(VGA_VS),							//	VGA V_SYNC
		.VGA_BLANK_N(VGA_BLANK_N),						//	VGA BLANK
		.VGA_SYNC_N(VGA_SYNC_N),						//	VGA SYNC
		.VGA_R(VGA_R),   						//	VGA Red[9:0]
		.VGA_G(VGA_G),	 						//	VGA Green[9:0]
		.VGA_B(VGA_B),   						//	VGA Blue[9:0]
		
		.GAIN_OUT(gain_fsm[6:0]),
		.TREBLE_OUT(treble_fsm),
		.BASS_OUT(bass_fsm),
		
		.EFFECT1_OUT(overdrive),
		.EFFECT2_OUT(tremolo),
		.EFFECT3_OUT(delay),
		.EFFECT4_OUT(phase_shift),
		.EFFECT5_OUT(fuzz),
		.EFFECT6_OUT(bit_eff),
		.EFFECT7_OUT(a),
		.EFFECT8_OUT(b),
		.RECORD_OUT(record),
		.PLAY_OUT(play)
	);
	
	
	wire a, b, overdrive, tremolo, delay, phase_shift, fuzz, 
		  bit_eff, record, play;
	
	Audio_Controller Audio_Controller (
		// Inputs
		.CLOCK_50						(CLOCK_50),
		.reset						(~KEY[0]),

		.clear_audio_in_memory		(),
		.read_audio_in				(read_audio_in),
		
		.clear_audio_out_memory		(),
		.left_channel_audio_out		(sound_left),
		.right_channel_audio_out	(sound_left),
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



module effects_path(
	overdrive,
	tremolo,
	delay,
	phase_shift,
	fuzz,
	bit_eff,
	resetn,
	clk,
	read_clk,
	sound_in,
	sound_out,
	sound_in_mem,
	sound_out_mem,
);
	
	input overdrive,
			tremolo,
			delay,
			phase_shift,
			fuzz,
			bit_eff,
			resetn,
			clk,
			read_clk;
		
	input signed[31:0] sound_in;
	output reg signed[31:0] sound_out;
	
	output signed[23:0] sound_in_mem;
	input signed[23:0] sound_out_mem;
	
	
	parameter signed amplitude = 32'd500_000_000;
	parameter signed drive = 32'd700_000_000;
	
	sync_rom sync_rom(.clock(read_clk), .address(sine_count), .sine(sine));
	
	wire[8:0] sine_count;
	reg[7:0] clk_count;
	wire[15:0] sine;
	


	// Active effects
	always@(negedge read_clk) begin
		
		if(~overdrive && ~tremolo && ~delay && ~phase_shift && ~fuzz && ~bit_eff)
			sound_out <= sound_in;
		
			
		if(overdrive) begin
			if(sound_in > drive)
				sound_out <= (drive);
			else if(sound_in < (-drive))
				sound_out <= -(drive);
			else 
				sound_out <= sound_in;
		end
		
		

		if(tremolo) begin
			sound_out <= sound_in / $signed(sine);
		end
		
		

		if(delay) begin
		end	
		
		
		if(phase_shift) begin
			// neet fft. couldn't manage to get to that
		end
		
		
		if(fuzz) begin
			if(sound_in > $signed(32'd10000))
				sound_out <= amplitude;
			else if(sound_in < -($signed(32'd10000)))
				sound_out <= -amplitude;
			else 
				sound_out <= 0;
		end
		
		
		// Square wave
		if(bit_eff) begin
			if(sound_in > $signed(32'd9_000_000))
				sound_out <= amplitude;
			else if(sound_in < -($signed(32'd9_000_000)))
				sound_out <= -amplitude;
			
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


// Playback audio!
module playback(clk, delay, record, play, sound_in, sound_out);
	input clk, delay, record, play;
	input signed[31:0] sound_in;
	output reg signed[31:0] sound_out;
	
	reg [23:0] reduced_sound;
	reg [19:0] sound_address, record_length;
	reg signed [23:0] sound_in_mem;
	wire signed[23:0] sound_out_mem;
	
	reg write_sound;
	
	Sound_Memory Sound_Memory(
		.address(sound_address),
		.clock(clk),
		.data(sound_in_mem),
		.wren(write_sound),
		.q(sound_out_mem)
	);
	
	always@(posedge clk) begin
		
		reduced_sound <= $unsigned(sound_in) / 8'b1000_0000;
		
		if(record) begin
			write_sound <= 1;
			
			
			if(sound_address >= 20'd524_288) begin
				sound_address <= 0;
			end
			else begin
				sound_address <= sound_address + 1;
				record_length <= sound_address;
				sound_in_mem <= reduced_sound;
				sound_out <= sound_in;
			end
		end
		
		
		else if(play) begin
			write_sound <= 0;
			
			if(sound_address >= record_length) begin
				sound_address <= 0;
			end
			else begin
				sound_address <= sound_address + 1;
				sound_out <= sound_in + (sound_out_mem * $signed(9'b0_1000_0000));
			end
		end
		
		else begin
			sound_address <= 0;
			sound_out <= sound_in;
		end
		
	end
	
endmodule


module delay(clk, delay, sound_in, sound_out);
	input clk, delay;
	input signed[31:0] sound_in;
	output reg signed[31:0] sound_out;
	
	reg [23:0] reduced_sound;
	reg [19:0] sound_address, record_length;
	reg signed [23:0] sound_in_mem;
	wire signed[23:0] sound_out_mem;
	
	reg write_sound;
	
	Sound_Memory Sound_Memory2(
		.address(sound_address),
		.clock(clk),
		.data(sound_in_mem),
		.wren(write_sound),
		.q(sound_out_mem)
	);
	
	
	always@(posedge clk) begin
		
		if(delay) begin			
		end
	end

endmodule


// Sine wave LUT. shift final values to that min. value = 0.
module sync_rom (clock, address, sine);
	input clock;
	output reg [8:0] address;
	output [15:0] sine;
	reg [15:0] sine;
	reg [15:0] sine_out;

	parameter frequency = 9'd15;
	reg[8:0] count;
	
	always@(posedge clock) begin
		if((count >= frequency) && (address < 9'd360)) begin
			count <= 9'd0;
			address <= address + 9'd1;
		end
		
		else if(address >= 9'd360) begin
			count <= 9'd0;
			address <= 9'd0;
		end
		
		else begin
			count <= count + 9'd1;
		end
	end
	
	always@(posedge clock)
	begin
		 case(address)
				9'd0: sine <= 16'd3;
				9'd1: sine <= 16'd3;
				9'd2: sine <= 16'd3;
				9'd3: sine <= 16'd3;
				9'd4: sine <= 16'd3;
				9'd5: sine <= 16'd3;
				9'd6: sine <= 16'd3;
				9'd7: sine <= 16'd3;
				9'd8: sine <= 16'd3;
				9'd9: sine <= 16'd3;
				9'd10: sine <= 16'd3;
				9'd11: sine <= 16'd3;
				9'd12: sine <= 16'd3;
				9'd13: sine <= 16'd3;
				9'd14: sine <= 16'd3;
				9'd15: sine <= 16'd4;
				9'd16: sine <= 16'd4;
				9'd17: sine <= 16'd4;
				9'd18: sine <= 16'd4;
				9'd19: sine <= 16'd4;
				9'd20: sine <= 16'd4;
				9'd21: sine <= 16'd4;
				9'd22: sine <= 16'd4;
				9'd23: sine <= 16'd4;
				9'd24: sine <= 16'd4;
				9'd25: sine <= 16'd4;
				9'd26: sine <= 16'd4;
				9'd27: sine <= 16'd4;
				9'd28: sine <= 16'd4;
				9'd29: sine <= 16'd4;
				9'd30: sine <= 16'd4;
				9'd31: sine <= 16'd4;
				9'd32: sine <= 16'd4;
				9'd33: sine <= 16'd4;
				9'd34: sine <= 16'd4;
				9'd35: sine <= 16'd4;
				9'd36: sine <= 16'd4;
				9'd37: sine <= 16'd4;
				9'd38: sine <= 16'd4;
				9'd39: sine <= 16'd4;
				9'd40: sine <= 16'd4;
				9'd41: sine <= 16'd4;
				9'd42: sine <= 16'd4;
				9'd43: sine <= 16'd4;
				9'd44: sine <= 16'd4;
				9'd45: sine <= 16'd4;
				9'd46: sine <= 16'd4;
				9'd47: sine <= 16'd4;
				9'd48: sine <= 16'd4;
				9'd49: sine <= 16'd5;
				9'd50: sine <= 16'd5;
				9'd51: sine <= 16'd5;
				9'd52: sine <= 16'd5;
				9'd53: sine <= 16'd5;
				9'd54: sine <= 16'd5;
				9'd55: sine <= 16'd5;
				9'd56: sine <= 16'd5;
				9'd57: sine <= 16'd5;
				9'd58: sine <= 16'd5;
				9'd59: sine <= 16'd5;
				9'd60: sine <= 16'd5;
				9'd61: sine <= 16'd5;
				9'd62: sine <= 16'd5;
				9'd63: sine <= 16'd5;
				9'd64: sine <= 16'd5;
				9'd65: sine <= 16'd5;
				9'd66: sine <= 16'd5;
				9'd67: sine <= 16'd5;
				9'd68: sine <= 16'd5;
				9'd69: sine <= 16'd5;
				9'd70: sine <= 16'd5;
				9'd71: sine <= 16'd5;
				9'd72: sine <= 16'd5;
				9'd73: sine <= 16'd5;
				9'd74: sine <= 16'd5;
				9'd75: sine <= 16'd5;
				9'd76: sine <= 16'd5;
				9'd77: sine <= 16'd5;
				9'd78: sine <= 16'd5;
				9'd79: sine <= 16'd5;
				9'd80: sine <= 16'd5;
				9'd81: sine <= 16'd5;
				9'd82: sine <= 16'd5;
				9'd83: sine <= 16'd5;
				9'd84: sine <= 16'd5;
				9'd85: sine <= 16'd5;
				9'd86: sine <= 16'd5;
				9'd87: sine <= 16'd5;
				9'd88: sine <= 16'd5;
				9'd89: sine <= 16'd5;
				9'd90: sine <= 16'd5;
				9'd91: sine <= 16'd5;
				9'd92: sine <= 16'd5;
				9'd93: sine <= 16'd5;
				9'd94: sine <= 16'd5;
				9'd95: sine <= 16'd5;
				9'd96: sine <= 16'd5;
				9'd97: sine <= 16'd5;
				9'd98: sine <= 16'd5;
				9'd99: sine <= 16'd5;
				9'd100: sine <= 16'd5;
				9'd101: sine <= 16'd5;
				9'd102: sine <= 16'd5;
				9'd103: sine <= 16'd5;
				9'd104: sine <= 16'd5;
				9'd105: sine <= 16'd5;
				9'd106: sine <= 16'd5;
				9'd107: sine <= 16'd5;
				9'd108: sine <= 16'd5;
				9'd109: sine <= 16'd5;
				9'd110: sine <= 16'd5;
				9'd111: sine <= 16'd5;
				9'd112: sine <= 16'd5;
				9'd113: sine <= 16'd5;
				9'd114: sine <= 16'd5;
				9'd115: sine <= 16'd5;
				9'd116: sine <= 16'd5;
				9'd117: sine <= 16'd5;
				9'd118: sine <= 16'd5;
				9'd119: sine <= 16'd5;
				9'd120: sine <= 16'd5;
				9'd121: sine <= 16'd5;
				9'd122: sine <= 16'd5;
				9'd123: sine <= 16'd5;
				9'd124: sine <= 16'd5;
				9'd125: sine <= 16'd5;
				9'd126: sine <= 16'd5;
				9'd127: sine <= 16'd5;
				9'd128: sine <= 16'd5;
				9'd129: sine <= 16'd5;
				9'd130: sine <= 16'd5;
				9'd131: sine <= 16'd5;
				9'd132: sine <= 16'd4;
				9'd133: sine <= 16'd4;
				9'd134: sine <= 16'd4;
				9'd135: sine <= 16'd4;
				9'd136: sine <= 16'd4;
				9'd137: sine <= 16'd4;
				9'd138: sine <= 16'd4;
				9'd139: sine <= 16'd4;
				9'd140: sine <= 16'd4;
				9'd141: sine <= 16'd4;
				9'd142: sine <= 16'd4;
				9'd143: sine <= 16'd4;
				9'd144: sine <= 16'd4;
				9'd145: sine <= 16'd4;
				9'd146: sine <= 16'd4;
				9'd147: sine <= 16'd4;
				9'd148: sine <= 16'd4;
				9'd149: sine <= 16'd4;
				9'd150: sine <= 16'd4;
				9'd151: sine <= 16'd4;
				9'd152: sine <= 16'd4;
				9'd153: sine <= 16'd4;
				9'd154: sine <= 16'd4;
				9'd155: sine <= 16'd4;
				9'd156: sine <= 16'd4;
				9'd157: sine <= 16'd4;
				9'd158: sine <= 16'd4;
				9'd159: sine <= 16'd4;
				9'd160: sine <= 16'd4;
				9'd161: sine <= 16'd4;
				9'd162: sine <= 16'd4;
				9'd163: sine <= 16'd4;
				9'd164: sine <= 16'd4;
				9'd165: sine <= 16'd4;
				9'd166: sine <= 16'd3;
				9'd167: sine <= 16'd3;
				9'd168: sine <= 16'd3;
				9'd169: sine <= 16'd3;
				9'd170: sine <= 16'd3;
				9'd171: sine <= 16'd3;
				9'd172: sine <= 16'd3;
				9'd173: sine <= 16'd3;
				9'd174: sine <= 16'd3;
				9'd175: sine <= 16'd3;
				9'd176: sine <= 16'd3;
				9'd177: sine <= 16'd3;
				9'd178: sine <= 16'd3;
				9'd179: sine <= 16'd3;
				9'd180: sine <= 16'd3;
				9'd181: sine <= 16'd3;
				9'd182: sine <= 16'd3;
				9'd183: sine <= 16'd3;
				9'd184: sine <= 16'd3;
				9'd185: sine <= 16'd3;
				9'd186: sine <= 16'd3;
				9'd187: sine <= 16'd3;
				9'd188: sine <= 16'd3;
				9'd189: sine <= 16'd3;
				9'd190: sine <= 16'd3;
				9'd191: sine <= 16'd3;
				9'd192: sine <= 16'd3;
				9'd193: sine <= 16'd3;
				9'd194: sine <= 16'd3;
				9'd195: sine <= 16'd2;
				9'd196: sine <= 16'd2;
				9'd197: sine <= 16'd2;
				9'd198: sine <= 16'd2;
				9'd199: sine <= 16'd2;
				9'd200: sine <= 16'd2;
				9'd201: sine <= 16'd2;
				9'd202: sine <= 16'd2;
				9'd203: sine <= 16'd2;
				9'd204: sine <= 16'd2;
				9'd205: sine <= 16'd2;
				9'd206: sine <= 16'd2;
				9'd207: sine <= 16'd2;
				9'd208: sine <= 16'd2;
				9'd209: sine <= 16'd2;
				9'd210: sine <= 16'd2;
				9'd211: sine <= 16'd2;
				9'd212: sine <= 16'd2;
				9'd213: sine <= 16'd2;
				9'd214: sine <= 16'd2;
				9'd215: sine <= 16'd2;
				9'd216: sine <= 16'd2;
				9'd217: sine <= 16'd2;
				9'd218: sine <= 16'd2;
				9'd219: sine <= 16'd2;
				9'd220: sine <= 16'd2;
				9'd221: sine <= 16'd2;
				9'd222: sine <= 16'd2;
				9'd223: sine <= 16'd2;
				9'd224: sine <= 16'd2;
				9'd225: sine <= 16'd2;
				9'd226: sine <= 16'd2;
				9'd227: sine <= 16'd2;
				9'd228: sine <= 16'd2;
				9'd229: sine <= 16'd1;
				9'd230: sine <= 16'd1;
				9'd231: sine <= 16'd1;
				9'd232: sine <= 16'd1;
				9'd233: sine <= 16'd1;
				9'd234: sine <= 16'd1;
				9'd235: sine <= 16'd1;
				9'd236: sine <= 16'd1;
				9'd237: sine <= 16'd1;
				9'd238: sine <= 16'd1;
				9'd239: sine <= 16'd1;
				9'd240: sine <= 16'd1;
				9'd241: sine <= 16'd1;
				9'd242: sine <= 16'd1;
				9'd243: sine <= 16'd1;
				9'd244: sine <= 16'd1;
				9'd245: sine <= 16'd1;
				9'd246: sine <= 16'd1;
				9'd247: sine <= 16'd1;
				9'd248: sine <= 16'd1;
				9'd249: sine <= 16'd1;
				9'd250: sine <= 16'd1;
				9'd251: sine <= 16'd1;
				9'd252: sine <= 16'd1;
				9'd253: sine <= 16'd1;
				9'd254: sine <= 16'd1;
				9'd255: sine <= 16'd1;
				9'd256: sine <= 16'd1;
				9'd257: sine <= 16'd1;
				9'd258: sine <= 16'd1;
				9'd259: sine <= 16'd1;
				9'd260: sine <= 16'd1;
				9'd261: sine <= 16'd1;
				9'd262: sine <= 16'd1;
				9'd263: sine <= 16'd1;
				9'd264: sine <= 16'd1;
				9'd265: sine <= 16'd1;
				9'd266: sine <= 16'd1;
				9'd267: sine <= 16'd1;
				9'd268: sine <= 16'd1;
				9'd269: sine <= 16'd1;
				9'd270: sine <= 16'd1;
				9'd271: sine <= 16'd1;
				9'd272: sine <= 16'd1;
				9'd273: sine <= 16'd1;
				9'd274: sine <= 16'd1;
				9'd275: sine <= 16'd1;
				9'd276: sine <= 16'd1;
				9'd277: sine <= 16'd1;
				9'd278: sine <= 16'd1;
				9'd279: sine <= 16'd1;
				9'd280: sine <= 16'd1;
				9'd281: sine <= 16'd1;
				9'd282: sine <= 16'd1;
				9'd283: sine <= 16'd1;
				9'd284: sine <= 16'd1;
				9'd285: sine <= 16'd1;
				9'd286: sine <= 16'd1;
				9'd287: sine <= 16'd1;
				9'd288: sine <= 16'd1;
				9'd289: sine <= 16'd1;
				9'd290: sine <= 16'd1;
				9'd291: sine <= 16'd1;
				9'd292: sine <= 16'd1;
				9'd293: sine <= 16'd1;
				9'd294: sine <= 16'd1;
				9'd295: sine <= 16'd1;
				9'd296: sine <= 16'd1;
				9'd297: sine <= 16'd1;
				9'd298: sine <= 16'd1;
				9'd299: sine <= 16'd1;
				9'd300: sine <= 16'd1;
				9'd301: sine <= 16'd1;
				9'd302: sine <= 16'd1;
				9'd303: sine <= 16'd1;
				9'd304: sine <= 16'd1;
				9'd305: sine <= 16'd1;
				9'd306: sine <= 16'd1;
				9'd307: sine <= 16'd1;
				9'd308: sine <= 16'd1;
				9'd309: sine <= 16'd1;
				9'd310: sine <= 16'd1;
				9'd311: sine <= 16'd1;
				9'd312: sine <= 16'd2;
				9'd313: sine <= 16'd2;
				9'd314: sine <= 16'd2;
				9'd315: sine <= 16'd2;
				9'd316: sine <= 16'd2;
				9'd317: sine <= 16'd2;
				9'd318: sine <= 16'd2;
				9'd319: sine <= 16'd2;
				9'd320: sine <= 16'd2;
				9'd321: sine <= 16'd2;
				9'd322: sine <= 16'd2;
				9'd323: sine <= 16'd2;
				9'd324: sine <= 16'd2;
				9'd325: sine <= 16'd2;
				9'd326: sine <= 16'd2;
				9'd327: sine <= 16'd2;
				9'd328: sine <= 16'd2;
				9'd329: sine <= 16'd2;
				9'd330: sine <= 16'd2;
				9'd331: sine <= 16'd2;
				9'd332: sine <= 16'd2;
				9'd333: sine <= 16'd2;
				9'd334: sine <= 16'd2;
				9'd335: sine <= 16'd2;
				9'd336: sine <= 16'd2;
				9'd337: sine <= 16'd2;
				9'd338: sine <= 16'd2;
				9'd339: sine <= 16'd2;
				9'd340: sine <= 16'd2;
				9'd341: sine <= 16'd2;
				9'd342: sine <= 16'd2;
				9'd343: sine <= 16'd2;
				9'd344: sine <= 16'd2;
				9'd345: sine <= 16'd2;
				9'd346: sine <= 16'd3;
				9'd347: sine <= 16'd3;
				9'd348: sine <= 16'd3;
				9'd349: sine <= 16'd3;
				9'd350: sine <= 16'd3;
				9'd351: sine <= 16'd3;
				9'd352: sine <= 16'd3;
				9'd353: sine <= 16'd3;
				9'd354: sine <= 16'd3;
				9'd355: sine <= 16'd3;
				9'd356: sine <= 16'd3;
				9'd357: sine <= 16'd3;
				9'd358: sine <= 16'd3;
				9'd359: sine <= 16'd3;
		endcase
		sine_out <= sine;
	end
endmodule
