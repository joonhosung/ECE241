/*****************************************************************************
 *                                                                           *
 * Module:       graphics                                                    *
 *                                                                           *
 *****************************************************************************/

module graphics(
		CLOCK_50,						//	On Board 50 MHz
		SW,								// Board Switches
		LEDR,								// Board LEDRs
		KEY,								// Board KEYs
		HEX0,         					// Baord HEX
		HEX1,
		HEX2,
		HEX3,
		HEX4,
		HEX5,
		
		audio_in,						// Audio from guitar
		
		PS2_CLK,
		PS2_DAT,
		
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,						//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B,   						//	VGA Blue[9:0]
		
		GAIN_OUT,
		TREBLE_OUT,
		BASS_OUT,
		
		EFFECT1_OUT,
		EFFECT2_OUT,
		EFFECT3_OUT,
		EFFECT4_OUT,
		EFFECT5_OUT,
		EFFECT6_OUT,
		EFFECT7_OUT,
		EFFECT8_OUT,
		
		RECORD_OUT,
		PLAY_OUT
		
	);
	
/*****************************************************************************
 *                           Port Declarations                               *
 *****************************************************************************/
	input	CLOCK_50;				//	50 MHz	
	input [9:0] SW;				
	input [3:0] KEY;
	input signed [31:0] audio_in;
	
	inout PS2_CLK, PS2_DAT;
	
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output [9:0] LEDR;			

	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;			//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[7:0]	VGA_R;   				//	VGA Red[7:0] Changed from 10 to 8-bit DAC
	output	[7:0]	VGA_G;	 				//	VGA Green[7:0]
	output	[7:0]	VGA_B;   				//	VGA Blue[7:0]
	
	output [7:0] GAIN_OUT, TREBLE_OUT, BASS_OUT;
	
	output EFFECT1_OUT,
			 EFFECT2_OUT,
		  	 EFFECT3_OUT,
			 EFFECT4_OUT,
			 EFFECT5_OUT,
			 EFFECT6_OUT,
			 EFFECT7_OUT,
			 EFFECT8_OUT;
			 
	output RECORD_OUT, PLAY_OUT;

	
	
/*****************************************************************************
 *                 Internal wires and registers Declarations                 *
 *****************************************************************************/
		
	
	// VGA
	wire resetn;
	assign resetn = (last_data_received == 8'h76) ? 0 : 1;


	wire [8:0] colour;
	wire [8:0] x;
	wire [7:0] y;
	wire writeEn;
	
	// Effects
	wire en_eff1 = (last_data_received == 8'h16) ? 1 : 0;
	wire en_eff2 = (last_data_received == 8'h1E) ? 1 : 0;
	wire en_eff3 = (last_data_received == 8'h26) ? 1 : 0;
	wire en_eff4 = (last_data_received == 8'h25) ? 1 : 0;
	wire en_eff5 = (last_data_received == 8'h2E) ? 1 : 0;
	wire en_eff6 = (last_data_received == 8'h36) ? 1 : 0;
	wire en_eff7 = (last_data_received == 8'h3D) ? 1 : 0;
	wire en_eff8 = (last_data_received == 8'h3E) ? 1 : 0;
	
	
	wire clear = (last_data_received == 8'h21) ? 1: 0;
	
	wire controlStart, controlD, control0, control1, control2, control3, control4,
														control5, control6, control7, control8;
														
	wire controlR, controlUR;
	wire controlP, controlUP;
														
	wire controlGain_up, controlGain_down,
		  controlTreble_up, controlTreble_down,
		  controlBass_up, controlBass_down;
		  
	wire effect1, effect2, effect3, effect4, effect5, effect6, effect7, effect8;
	wire en_record, en_play;
	
	wire [6:0] GAIN, TREBLE, BASS;
	
	wire gainUp = (last_data_received == 8'h1D) ? 1: 0,
		  gainDown = (last_data_received == 8'h15) ? 1 : 0;
	  
		  
	wire trebleUp = (last_data_received == 8'h1B) ? 1 : 0,
		  trebleDown = (last_data_received == 8'h1C) ? 1: 0;
		  
	wire bassUp = (last_data_received == 8'h22) ? 1'b1 : 1'b0,
		  bassDown = (last_data_received == 8'h1A) ? 1'b1 : 1'b0;
		  
	wire record_pressed = (last_data_received == 8'h4A) ? 1'b1 : 1'b0;
	wire record_unpressed = (last_data_received == 8'h49) ? 1'b1 : 1'b0;
	
	wire play_pressed = (last_data_received == 8'h52) ? 1'b1 : 1'b0;
	wire play_unpressed = (last_data_received == 8'h4C) ? 1'b1 : 1'b0;
	
	
	// Keyboard
	wire [7:0] ps2_key_data;
	wire ps2_key_pressed;
	reg [7:0] last_data_received;	
	
	
	// Update
	wire doneClearGraph, doneClearGain, doneClearTreble, doneClearBass,
		  doneDrawGraph, doneDrawGain, doneDrawTreble, doneDrawBass;
		  
	wire doneDraw1, doneDraw2, doneDraw3, doneDraw4, doneDraw5, doneDraw6, doneDraw7, doneDraw8;
	
	wire clearGraph, clearGain, clearTreble, clearBass,
		  drawGraph, drawGain, drawTreble, drawBass;
		  
	wire drawEffect1, drawEffect2, drawEffect3, drawEffect4,
		  drawEffect5, drawEffect6, drawEffect7, drawEffect8;
		  
	wire startUpdate;
	
	reg [6:0] AMPLITUDE;
	
	
	// Amplitude
	parameter signed [31:0] max_32b = 32'd16_909_320; //d2_147_483_647

	always@(posedge CLOCK_50) begin
		
		/*
		if(scounter >= 999_999) begin
			AMPLITUDE <= AMPLITUDE + 1;
			scounter <= 0;
			
			if(AMPLITUDE >= 8'd127);
				AMPLITUDE <= 0;
		end
		else
			scounter <= scounter + 1;
		*/
		
		if (audio_in > $signed(32'b0)) begin
			AMPLITUDE <= audio_in / max_32b;
		end
		
		else if(audio_in == 0) begin
			AMPLITUDE <= 7'd1;
		end
		
		/*
		if (AMPLITUDE >= 8'd127) begin
			AMPLITUDE <= 8'd127;
		end
		*/
		
	end
	//hex_decoder h0(AMPLITUDE[3:0], HEX0);
	//hex_decoder h1({1'b0, AMPLITUDE[6:4]}, HEX1);
	
	
	
/*****************************************************************************
 *                           VGA Adapter                                     *
 *****************************************************************************/

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
			
			// Signals for the DAC to drive the monitor.
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
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 3;
		defparam VGA.BACKGROUND_IMAGE = "guitar_amp_background_320_240_new.mif";
		
	
/*****************************************************************************
 *                           Internal Modules                                *
 *****************************************************************************/

					  
	controlEffect	u1(.resetn(resetn), 
							.clk(CLOCK_50), 
							.clear(clear), 
							.go_eff1(en_eff1), 
							.go_eff2(en_eff2), 
							.go_eff3(en_eff3),
							.go_eff4(en_eff4),
							.go_eff5(en_eff5),
							.go_eff6(en_eff6),
							.go_eff7(en_eff7),
							.go_eff8(en_eff8),
							.record_yes(record_pressed),
							.record_no(record_unpressed),
							.play_yes(play_pressed),
							.play_no(play_unpressed),
							.gain_up(gainUp),
							.gain_down(gainDown),
							.treble_up(trebleUp),
							.treble_down(trebleDown),
							.bass_up(bassUp),
							.bass_down(bassDown),
							.start_amp(controlStart),
							.effect_0(control0),
							.set_effect1(control1), 
							.set_effect2(control2), 
							.set_effect3(control3), 
							.set_effect4(control4),
							.set_effect5(control5),
							.set_effect6(control6),
							.set_effect7(control7),
							.set_effect8(control8),
							.set_record(controlR),
							.unset_record(controlUR),
							.set_play(controlP),
							.unset_play(controlUP),
							.unset_effect(controlD),
							.increment_gain(controlGain_up),
							.decrement_gain(controlGain_down),
							.increment_treble(controlTreble_up),
							.decrement_treble(controlTreble_down),
							.increment_bass(controlBass_up),
							.decrement_bass(controlBass_down));
						 
						  
	datapathEffect	 u2(.resetn(resetn), 
							 .clk(CLOCK_50), 
							 .c_start(controlStart),
							 .c_wait(control0), 
							 .c_effect1(control1), 
							 .c_effect2(control2), 
							 .c_effect3(control3),
							 .c_effect4(control4),
							 .c_effect5(control5),
							 .c_effect6(control6),
							 .c_effect7(control7),
							 .c_effect8(control8),
							 .c_record(controlR),
							 .c_unrecord(controlUR),
							 .c_play(controlP),
							 .c_unplay(controlUP),
							 .c_gain_up(controlGain_up),
							 .c_gain_down(controlGain_down),
							 .c_treble_up(controlTreble_up),
							 .c_treble_down(controlTreble_down),
							 .c_bass_up(controlBass_up),
							 .c_bass_down(controlBass_down),
							 .gain(GAIN),
							 .treble(TREBLE),
							 .bass(BASS),
							 .c_delete(controlD),
							 .s_record(en_record),
							 .s_play(en_play),
							 .s_effect1(effect1),
							 .s_effect2(effect2),
							 .s_effect3(effect3),
							 .s_effect4(effect4),
							 .s_effect5(effect5),
							 .s_effect6(effect6),
							 .s_effect7(effect7),
							 .s_effect8(effect8));
							 
							 
	controlUpdate	 u3(.resetn(resetn),
							 .clk(CLOCK_50),
							 .done_Clear_Gain(doneClearGain),
							 .done_Draw_Gain(doneDrawGain),
							 .done_Clear_Treble(doneClearTreble),
							 .done_Draw_Treble(doneDrawTreble),
							 .done_Clear_Bass(doneClearBass),
							 .done_Draw_Bass(doneDrawBass),
							 .done_Clear_Graph(doneClearGraph),
							 .done_Draw_Graph(doneDrawGraph),
							 .doneDraw1(doneDraw1),
							 .doneDraw2(doneDraw2),
							 .doneDraw3(doneDraw3),
							 .doneDraw4(doneDraw4),
							 .doneDraw5(doneDraw5),
							 .doneDraw6(doneDraw6),
							 .doneDraw7(doneDraw7),
							 .doneDraw8(doneDraw8),
							 .c_clear_gain(clearGain),
							 .c_draw_gain(drawGain),
							 .c_clear_treble(clearTreble),
							 .c_draw_treble(drawTreble),
							 .c_clear_bass(clearBass),
							 .c_draw_bass(drawBass),
							 .c_clear_graph(clearGraph),
							 .c_draw_graph(drawGraph),
							 .c_draw1(drawEffect1),
							 .c_draw2(drawEffect2),
							 .c_draw3(drawEffect3),
							 .c_draw4(drawEffect4),
							 .c_draw5(drawEffect5),
							 .c_draw6(drawEffect6),
							 .c_draw7(drawEffect7),
							 .c_draw8(drawEffect8),
							 .c_start(startUpdate),
							 .writeEn(writeEn));
												
	
	datapathUpdate	  u4(.clk(CLOCK_50),
							  .c_start(startUpdate),
							  .c_draw1(drawEffect1),
							  .c_draw2(drawEffect2),
							  .c_draw3(drawEffect3),
							  .c_draw4(drawEffect4),
							  .c_draw5(drawEffect5),
							  .c_draw6(drawEffect6),
							  .c_draw7(drawEffect7),
							  .c_draw8(drawEffect8),
							  .c_clear_gain(clearGain),
							  .c_draw_gain(drawGain),
							  .c_clear_treble(clearTreble),
							  .c_draw_treble(drawTreble),
							  .c_clear_bass(clearBass),
							  .c_draw_bass(drawBass),
							  .c_clear_graph(clearGraph),
							  .c_draw_graph(drawGraph),
							  .gain(GAIN),
							  .treble(TREBLE),
							  .bass(BASS),
							  .amplitude(AMPLITUDE),
							  .effect_1(effect1),
							  .effect_2(effect2),
							  .effect_3(effect3),
							  .effect_4(effect4),
							  .effect_5(effect5),
							  .effect_6(effect6),
							  .effect_7(effect7),
							  .effect_8(effect8),
							  .doneDraw1(doneDraw1),
							  .doneDraw2(doneDraw2),
							  .doneDraw3(doneDraw3),
							  .doneDraw4(doneDraw4),
							  .doneDraw5(doneDraw5),
							  .doneDraw6(doneDraw6),
							  .doneDraw7(doneDraw7),
							  .doneDraw8(doneDraw8),
							  .done_Clear_Gain(doneClearGain),
							  .done_Draw_Gain(doneDrawGain),
							  .done_Clear_Treble(doneClearTreble),
							  .done_Draw_Treble(doneDrawTreble),
							  .done_Clear_Bass(doneClearBass),
							  .done_Draw_Bass(doneDrawBass),
							  .done_Clear_Graph(doneClearGraph),
							  .done_Draw_Graph(doneDrawGraph),
							  .x_out(x),
							  .y_out(y),
							  .colour_out(colour));
	
	
/*****************************************************************************
 *                           KEYBOARD Controls                               *
 *****************************************************************************/
 
	PS2_Controller PS2 (	// Inputs
								.CLOCK_50			(CLOCK_50),
								.reset				(~KEY[0]),

								// Bidirectionals
								.PS2_CLK			(PS2_CLK),
								.PS2_DAT			(PS2_DAT),

								// Outputs
								.received_data		(ps2_key_data),
								.received_data_en	(ps2_key_pressed)
								);
							
	always @(posedge CLOCK_50)
	begin
		if (ps2_key_pressed == 1'b1)
			last_data_received <= ps2_key_data;
		else 
			last_data_received <= 8'b0;
	end
	
	
	
	// KEYBOARD CODE SOURCE: http://www.eecg.toronto.edu/~pc/courses/241/DE1_SoC_cores/ps2/ps2.html
	
	
/*****************************************************************************
 *                           Outputs                                         *
 *****************************************************************************/
	
	// Gain, Treble, Bass assignment
	assign GAIN_OUT = GAIN;
	assign TREBLE_OUT = TREBLE;
	assign BASS_OUT = BASS;
	
	// Effects register assignment
	assign EFFECT1_OUT = effect1;
	assign EFFECT2_OUT = effect2;
   assign EFFECT3_OUT = effect3;
	assign EFFECT4_OUT = effect4;
	assign EFFECT5_OUT = effect5;
	assign EFFECT6_OUT = effect6;
	assign EFFECT7_OUT = effect7;
	assign EFFECT8_OUT = effect8;
	
	// Record & Play
	assign RECORD_OUT = en_record;
	assign PLAY_OUT = en_play;
	
	// Display Record & Play
	assign LEDR[9] = en_record;
	assign LEDR[8] = en_record;
	assign LEDR[7] = en_record;
	
	assign LEDR[2] = en_play;
	assign LEDR[1] = en_play;
	assign LEDR[0] = en_play;

	
	hex_decoder h0(BASS_OUT[3:0], HEX0);
	hex_decoder h1({1'b0,BASS_OUT[6:4]}, HEX1);
	hex_decoder h2(TREBLE_OUT[3:0], HEX2);
	hex_decoder h3({1'b0,TREBLE_OUT[6:4]}, HEX3);
	hex_decoder h4(GAIN_OUT[3:0], HEX4);
	hex_decoder h5({1'b0,GAIN_OUT[6:4]}, HEX5);
		
endmodule


/*****************************************************************************
 *                           HEX Decoder                                     *
 *****************************************************************************/
 
module hex_decoder(hex_digit, segments);

    input [3:0] hex_digit;

    output reg [6:0] segments;

    always @(*)

        case (hex_digit)

            4'h0: segments = 7'b100_0000;

            4'h1: segments = 7'b111_1001;

            4'h2: segments = 7'b010_0100;

            4'h3: segments = 7'b011_0000;

            4'h4: segments = 7'b001_1001;

            4'h5: segments = 7'b001_0010;

            4'h6: segments = 7'b000_0010;

            4'h7: segments = 7'b111_1000;

            4'h8: segments = 7'b000_0000;

            4'h9: segments = 7'b001_1000;

            4'hA: segments = 7'b000_1000;

            4'hB: segments = 7'b000_0011;

            4'hC: segments = 7'b100_0110;

            4'hD: segments = 7'b010_0001;

            4'hE: segments = 7'b000_0110;

            4'hF: segments = 7'b000_1110;   

            default: segments = 7'h7f;

        endcase

endmodule



/*****************************************************************************
 *                           Keyboard FSM                                    *
 *****************************************************************************/
 /*
 module keyboardControl(clk, key_pressed, data_in, data_out);

	 // Inputs
	 input [7:0] data_in;
	 input clk;
	 input key_pressed;
	 output reg [7:0] data_out;
	 
	 reg [2:0] next_state, current_state;
	 
	 // States
	 localparam S_PRESSED = 3'd0,
					S_RELEASED = 3'd1;
					
					
	always @ (*)
	// State Table
	begin: state_table
		case(current_state)
		
			S_RELEASED: begin
				next_state = key_pressed ? S_PRESSED : S_RELEASED; 
			end
			
			S_PRESSED: begin
				next_state = (data_in == 8'hF0) ? S_RELEASED: S_PRESSED;
			end
		
			default: next_state = S_RELEASED;

		endcase
		
	end
	
	always @ (*) 
	begin: output_table
		case (current_state)
		
			S_PRESSED: begin
				data_out = data_in;
			end
			
			S_RELEASED: begin
				data_out = 8'b0;
			end
		
		endcase
	end
	
	always @ (posedge clk) 
	begin: state_transition
		current_state <= next_state;
	end
 
 endmodule 

*/

















