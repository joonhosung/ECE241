/*****************************************************************************
 *                                                                           *
 * Module:       controlEffect                                               *
 *                                                                           *
 *****************************************************************************/
module controlEffect(resetn, 
							clk, 
							clear, 
							go_eff1, 
							go_eff2, 
							go_eff3,
							go_eff4,
							go_eff5,
							go_eff6,
							go_eff7,
							go_eff8,
							record_yes,
							record_no,
							play_yes,
							play_no,
							gain_up,
							gain_down,
							treble_up,
							treble_down,
							bass_up,
							bass_down,
							start_amp,
							effect_0,
							set_effect1, 
							set_effect2, 
							set_effect3, 
							set_effect4,
							set_effect5,
							set_effect6,
							set_effect7,
							set_effect8,
							set_record,
							unset_record,
							set_play,
							unset_play,
							unset_effect,
							increment_gain,
							decrement_gain,
							increment_treble,
							decrement_treble,
							increment_bass,
							decrement_bass);

							
/*****************************************************************************
 *                           Port & Register Declarations                    *
 *****************************************************************************/
	input resetn, clk, clear;
	input go_eff1, go_eff2, go_eff3, go_eff4, go_eff5, go_eff6, go_eff7, go_eff8;
	input gain_up, gain_down, treble_up, treble_down, bass_up, bass_down;
	input record_yes, record_no, play_yes, play_no;
	
	output reg start_amp, effect_0, unset_effect;
	
	output reg set_effect1, set_effect2, set_effect3, set_effect4,
			     set_effect5, set_effect6, set_effect7, set_effect8;
				  
	output reg set_record, unset_record, set_play, unset_play;
				  
	output reg increment_gain, decrement_gain,
				  increment_treble, decrement_treble,
				  increment_bass, decrement_bass;
	
	reg [4:0] current_state, next_state;
	
	localparam S_WAIT = 5'd0,
				  S_SET_EFFECT1 = 5'd1,
				  S_SET_EFFECT2= 5'd2,
				  S_SET_EFFECT3 = 5'd3,
				  S_UNSET_EFFECT = 5'd4,
				  S_START = 5'd5,
				  S_GAIN_UP = 5'd6,
				  S_SET_EFFECT4 = 5'd7,
				  S_SET_EFFECT5 = 5'd9,
				  S_SET_EFFECT6 = 5'd10,
				  S_SET_EFFECT7 = 5'd11,
				  S_SET_EFFECT8 = 5'd12,
				  S_GAIN_UP_WAIT = 5'd13,
				  S_GAIN_DOWN_WAIT = 5'd14,
				  S_GAIN_DOWN = 5'd15,
				  S_TREBLE_UP_WAIT = 5'd16,
				  S_TREBLE_UP = 5'd17,
				  S_TREBLE_DOWN_WAIT = 5'd18,
				  S_TREBLE_DOWN = 5'd19,
				  S_BASS_UP_WAIT = 5'd20,
				  S_BASS_UP = 5'd21,
				  S_BASS_DOWN_WAIT = 5'd22,
				  S_BASS_DOWN = 5'd23,
				  S_SET_RECORD = 5'd24,
				  S_UNSET_RECORD = 5'd25,
				  S_SET_PLAY = 5'd26,
				  S_UNSET_PLAY = 5'd27;
	

/*****************************************************************************
 *                         State Table                                       *
 *****************************************************************************/	
 
	always @ (*)
	// State Table
	begin: state_table
		case(current_state)
			S_START: begin
				next_state = S_WAIT;
			end
			
// WAIT
			S_WAIT: begin
				if (go_eff1)		
					next_state = S_SET_EFFECT1;
				else if (go_eff2) 			
					next_state = S_SET_EFFECT2;
				else if (go_eff3)		
					next_state = S_SET_EFFECT3;
				else if (go_eff4)		
					next_state = S_SET_EFFECT4;
				else if (go_eff5)		
					next_state = S_SET_EFFECT5;
				else if (go_eff6)	 	
					next_state = S_SET_EFFECT6;
				else if (go_eff7)	
					next_state = S_SET_EFFECT7;
				else if (go_eff8)
					next_state = S_SET_EFFECT8;
				else if (clear)
					next_state = S_UNSET_EFFECT;
				else if (gain_up) 
					next_state = S_GAIN_UP_WAIT;
				else if (gain_down) 
					next_state = S_GAIN_DOWN_WAIT;
				else if (treble_up)
					next_state = S_TREBLE_UP_WAIT;
				else if (treble_down)
					next_state = S_TREBLE_DOWN_WAIT;
				else if (bass_up)
					next_state = S_BASS_UP_WAIT;			
				else if (bass_down) 
					next_state = S_BASS_DOWN_WAIT;
				else if (record_yes)
					next_state = S_SET_RECORD;
				else if (play_yes)
					next_state = S_SET_PLAY;
				else 
					next_state = S_WAIT;
			end
			
// SET EFFECT
			S_SET_EFFECT1: begin
				if (go_eff1)
					next_state = S_SET_EFFECT1;
				else
					next_state = S_WAIT;
			end
			
			S_SET_EFFECT2: begin
				if (go_eff2)
					next_state = S_SET_EFFECT2;
				else
					next_state = S_WAIT;
			end
			
			S_SET_EFFECT3: begin
				if (go_eff3)
					next_state = S_SET_EFFECT3;
				else
					next_state = S_WAIT;
			end
			
			S_SET_EFFECT4: begin
				if (go_eff4)
					next_state = S_SET_EFFECT4;
				else
					next_state = S_WAIT;
			end
			
			S_SET_EFFECT5: begin
				if (go_eff5)
					next_state = S_SET_EFFECT5;
				else
					next_state = S_WAIT;
			end
			
			S_SET_EFFECT6: begin
				if (go_eff6)
					next_state = S_SET_EFFECT6;
				else
					next_state = S_WAIT;
			end
			
			S_SET_EFFECT7: begin
				if (go_eff7)
					next_state = S_SET_EFFECT7;
				else
					next_state = S_WAIT;
			end
			
			S_SET_EFFECT8: begin
				if (go_eff8)
					next_state = S_SET_EFFECT8;
				else
					next_state = S_WAIT;
			end
			
// CLEAR
			S_UNSET_EFFECT: begin
				if (clear)
					next_state = S_UNSET_EFFECT;
				else
					next_state = S_WAIT;
			end
			
// GAIN
			S_GAIN_UP_WAIT: begin
				if (gain_up)
					next_state = S_GAIN_UP_WAIT;
				else
					next_state = S_GAIN_UP;
			end
			
			S_GAIN_UP: begin
				next_state = S_WAIT;
			end
			
			S_GAIN_DOWN_WAIT: begin
				if (gain_down)
					next_state = S_GAIN_DOWN_WAIT;
				else
					next_state = S_GAIN_DOWN;
			end
		
			S_GAIN_DOWN: begin
				next_state = S_WAIT;
			end
			
// TREBLE
			S_TREBLE_UP_WAIT: begin
				if (treble_up)
					next_state = S_TREBLE_UP_WAIT;
				else
					next_state = S_TREBLE_UP;
			end
			
			S_TREBLE_UP: begin
				next_state = S_WAIT;
			end
			
			S_TREBLE_DOWN_WAIT: begin
				if (treble_down)
					next_state = S_TREBLE_DOWN_WAIT;
				else
					next_state = S_TREBLE_DOWN;
			end
		
			S_TREBLE_DOWN: begin
				next_state = S_WAIT;
			end
			
// BASS
			S_BASS_UP_WAIT: begin
				if (bass_up)
					next_state = S_BASS_UP_WAIT;
				else
					next_state = S_BASS_UP;
			end
			
			S_BASS_UP: begin
				next_state = S_WAIT;
			end
			
			S_BASS_DOWN_WAIT: begin
				if (bass_down)
					next_state = S_BASS_DOWN_WAIT;
				else
					next_state = S_BASS_DOWN;
			end
		
			S_BASS_DOWN: begin
				next_state = S_WAIT;
			end

// Record
			S_SET_RECORD: begin
				next_state = (record_no == 1) ? S_UNSET_RECORD : S_SET_RECORD;
			end
			
			S_UNSET_RECORD: begin
				next_state = S_WAIT;
			end
			
			S_SET_PLAY: begin
				next_state = (play_no == 1) ? S_UNSET_PLAY : S_SET_PLAY;
			end
			
			S_UNSET_PLAY: begin
				next_state = S_WAIT;
			end
			
			
			default: next_state = S_START;
			
		endcase 
	end
	
/*****************************************************************************
 *                         Output Table                                      *
 *****************************************************************************/
	always @ (*) 
	begin: communication
		start_amp = 0;
		effect_0 = 0;
		set_effect1 = 0;
		set_effect2 = 0;
		set_effect3 = 0;
		set_effect4 = 0;
		set_effect5 = 0;
		set_effect6 = 0;
		set_effect7 = 0;
		set_effect8 = 0;
		set_record = 0;
		unset_record = 0;
		set_play = 0;
		unset_play = 0;
		unset_effect = 0;
		increment_gain = 0;
		decrement_gain = 0;
		increment_treble = 0;
		decrement_treble = 0;
		increment_bass = 0;
		decrement_bass = 0;
		
		case (current_state)
		
			S_START: begin
				start_amp = 1;
			end
			
			S_WAIT: begin
				effect_0 = 1;
			end
		
			S_SET_EFFECT1: begin
				set_effect1 = 1;
			end
			
			S_SET_EFFECT2: begin
				set_effect2 = 1;
			end
			
			S_SET_EFFECT3: begin
				set_effect3 = 1;
			end
			
			S_SET_EFFECT4: begin
				set_effect4 = 1;
			end
			
			S_SET_EFFECT5: begin
				set_effect5 = 1;
			end
			
			S_SET_EFFECT6: begin
				set_effect6 = 1;
			end
			
			S_SET_EFFECT7: begin
				set_effect7 = 1;
			end
			
			S_SET_EFFECT8: begin
				set_effect8 = 1;
			end
			
			S_UNSET_EFFECT: begin
				unset_effect = 1;
			end
				
			S_GAIN_UP: begin
				increment_gain = 1;
			end
			
			S_GAIN_DOWN: begin
				decrement_gain = 1;
			end
			
			S_TREBLE_UP: begin
				increment_treble = 1;
			end
			
			S_TREBLE_DOWN: begin
				decrement_treble = 1;
			end
			
			S_BASS_UP: begin
				increment_bass = 1;
			end
			
			S_BASS_DOWN: begin
				decrement_bass = 1;
			end
			
			S_SET_RECORD: begin
				set_record = 1;
			end
			
			S_UNSET_RECORD: begin
				unset_record = 1;
			end
			
			S_SET_PLAY: begin
				set_play = 1;
			end
			
			S_UNSET_PLAY: begin
				unset_play = 1;
			end
			
		endcase
	end	
	
/*****************************************************************************
 *                         State Transition                                  *
 *****************************************************************************/
	// Move to next state or reset
	always @ (posedge clk) 
	begin: state_determination
		if (resetn == 0)
			current_state <= S_START;
		else begin
			current_state <= next_state;
		end
	end

endmodule 






/*****************************************************************************
 *                                                                           *
 * Module:       controlUpdate                                               *
 *                                                                           *
 *****************************************************************************/
 
 module controlUpdate(resetn,
							 clk,
							 done_Clear_Gain,
							 done_Draw_Gain,
							 done_Clear_Treble,
							 done_Draw_Treble,
							 done_Clear_Bass,
							 done_Draw_Bass,
							 done_Clear_Graph,
							 done_Draw_Graph,
							 doneDraw1,
							 doneDraw2,
							 doneDraw3,
							 doneDraw4,
							 doneDraw5,
							 doneDraw6,
							 doneDraw7,
							 doneDraw8,
							 c_clear_gain,
							 c_draw_gain,
							 c_clear_treble,
							 c_draw_treble,
							 c_clear_bass,
							 c_draw_bass,
							 c_clear_graph,
							 c_draw_graph,
							 c_draw1,
							 c_draw2,
							 c_draw3,
							 c_draw4,
							 c_draw5,
							 c_draw6,
							 c_draw7,
							 c_draw8,
							 c_start,
							 writeEn);
							 
							 
/*****************************************************************************
 *                           Port & Register Declarations                    *
 *****************************************************************************/
	input clk, resetn; 
	input done_Clear_Gain, done_Clear_Treble, done_Clear_Bass, done_Clear_Graph,
			done_Draw_Gain, done_Draw_Treble, done_Draw_Bass, done_Draw_Graph;
	input doneDraw1, doneDraw2, doneDraw3, doneDraw4, doneDraw5, doneDraw6, doneDraw7, doneDraw8;
	
	output reg writeEn;
	output reg c_clear_gain, c_draw_gain, c_clear_treble, c_draw_treble, c_clear_bass, c_draw_bass,
				  c_clear_graph, c_draw_graph;
	output reg c_draw1, c_draw2, c_draw3, c_draw4, c_draw5, c_draw6, c_draw7, c_draw8; 
	output reg c_start;
	
	wire enable;
	RateDivider u2(clk, enable);
	
	reg [4:0] current_state, next_state;
	
	localparam S_START = 5'd0,
				  S_CLEAR_GRAPH = 5'd1,
				  S_DRAW_GRAPH = 5'd2,
				  S_CLEAR_GAIN = 5'd3,
				  S_DRAW_GAIN = 5'd4,
				  S_CLEAR_TREBLE = 5'd5,
				  S_DRAW_TREBLE = 5'd6,
				  S_CLEAR_BASS = 5'd7,
				  S_DRAW_BASS = 5'd8,
				  S_DRAW_EFFECT1 = 5'd9,
				  S_DRAW_EFFECT2 = 5'd10,
				  S_DRAW_EFFECT3 = 5'd11,
				  S_DRAW_EFFECT4 = 5'd12,
				  S_DRAW_EFFECT5 = 5'd13,
				  S_DRAW_EFFECT6 = 5'd14,
				  S_DRAW_EFFECT7 = 5'd15,
				  S_DRAW_EFFECT8 = 5'd16;
	
	
				  
/*****************************************************************************
 *                         State Table                                       *
 *****************************************************************************/	
 
	always @ (*)
	// State Table
	begin: state_table
		case(current_state)
			S_START: begin
				next_state = enable ? S_CLEAR_GRAPH : S_START;
			end
			
			S_CLEAR_GRAPH: begin
				next_state = done_Clear_Graph ? S_DRAW_GRAPH : S_CLEAR_GRAPH;
			end
			
			S_DRAW_GRAPH: begin
				next_state = done_Draw_Graph ? S_CLEAR_GAIN : S_DRAW_GRAPH;
			end
			
			S_CLEAR_GAIN: begin
				next_state = done_Clear_Gain ? S_DRAW_GAIN : S_CLEAR_GAIN;
			end
			
			S_DRAW_GAIN: begin
				next_state = done_Draw_Gain ? S_CLEAR_TREBLE : S_DRAW_GAIN;
			end
			
			S_CLEAR_TREBLE: begin
				next_state = done_Clear_Treble ? S_DRAW_TREBLE : S_CLEAR_TREBLE;
			end
			
			S_DRAW_TREBLE: begin
				next_state = done_Draw_Treble ? S_CLEAR_BASS : S_DRAW_TREBLE;
			end
			
			S_CLEAR_BASS: begin
				next_state = done_Clear_Bass ? S_DRAW_BASS : S_CLEAR_BASS;
			end
			
			S_DRAW_BASS: begin
				next_state = done_Draw_Bass ? S_DRAW_EFFECT1 : S_DRAW_BASS;
			end
			
			S_DRAW_EFFECT1: begin
				next_state = doneDraw1 ? S_DRAW_EFFECT2 : S_DRAW_EFFECT1;
			end
			
			S_DRAW_EFFECT2: begin
				next_state = doneDraw2 ? S_DRAW_EFFECT3 : S_DRAW_EFFECT2;
			end
			
			S_DRAW_EFFECT3: begin
				next_state = doneDraw3 ? S_DRAW_EFFECT4 : S_DRAW_EFFECT3;
			end
			
			S_DRAW_EFFECT4: begin
				next_state = doneDraw4 ? S_DRAW_EFFECT5 : S_DRAW_EFFECT4;
			end
			
			S_DRAW_EFFECT5: begin
				next_state = doneDraw5 ? S_DRAW_EFFECT6 : S_DRAW_EFFECT5;
			end
			
			S_DRAW_EFFECT6: begin
				next_state = doneDraw6 ? S_DRAW_EFFECT7 : S_DRAW_EFFECT6;
			end
			
			S_DRAW_EFFECT7: begin
				next_state = doneDraw7 ? S_DRAW_EFFECT8 : S_DRAW_EFFECT7;
			end
			
			S_DRAW_EFFECT8: begin
				next_state = doneDraw8 ? S_START : S_DRAW_EFFECT8;
			end
			
			default: next_state = S_START;
			
		endcase 
	end


/*****************************************************************************
 *                         Output Table                                      *
 *****************************************************************************/
	always @ (*) 
	begin: communication
	// Default condition
	writeEn = 1;
	
	c_start = 0;
	c_draw1 = 0;
	c_draw2 = 0;
	c_draw3 = 0;
	c_draw4 = 0;
	c_draw5 = 0;
	c_draw6 = 0;
	c_draw7 = 0;
	c_draw8 = 0;
	
	c_clear_gain = 0;
	c_draw_gain = 0;
	c_clear_treble = 0;
	c_draw_treble = 0;
	c_clear_bass = 0;
	c_draw_bass = 0;
	c_clear_graph = 0;
	c_draw_graph = 0;
		
		case (current_state)
		
			S_START: begin
				c_start = 1;
				writeEn = 0;
			end
			
			S_CLEAR_GRAPH: begin
				c_clear_graph = 1;
			end
			
			S_DRAW_GRAPH: begin
				c_draw_graph = 1;
			end
			
			S_CLEAR_GAIN: begin
				c_clear_gain = 1;
			end
			
			S_DRAW_GAIN: begin
				c_draw_gain = 1;
			end	
			
			S_CLEAR_TREBLE: begin
				c_clear_treble = 1;
			end
			
			S_DRAW_TREBLE: begin
				c_draw_treble = 1;
			end
			
			S_CLEAR_BASS: begin
				c_clear_bass = 1;
			end
			
			S_DRAW_BASS: begin
				c_draw_bass = 1;
			end
			
			S_DRAW_EFFECT1: begin
				c_draw1 = 1;
			end
			
			S_DRAW_EFFECT2: begin
				c_draw2 = 1;
			end
			
			S_DRAW_EFFECT3: begin
				c_draw3 = 1;
			end
			
			S_DRAW_EFFECT4: begin
				c_draw4 = 1;
			end
			
			S_DRAW_EFFECT5: begin
				c_draw5 = 1;
			end
			
			S_DRAW_EFFECT6: begin
				c_draw6  = 1;
			end
			
			S_DRAW_EFFECT7: begin
				c_draw7 = 1;
			end	
			
			S_DRAW_EFFECT8: begin
				c_draw8 = 1;
			end

		endcase
	end		
	
	
/*****************************************************************************
 *                         State Transition                                  *
 *****************************************************************************/
	// Move to next state or reset
	always @ (posedge clk) 
	begin: state_determination
		if (resetn == 0)
			current_state <= S_START;
		else
			current_state <= next_state;
	end
				  
							 
							 
endmodule



/*****************************************************************************
 *                    			RateDivider                                    *
 *****************************************************************************/
module RateDivider(Clock, Enable);
	input Clock;
	output reg Enable;

	reg [23:0] Q;

	always @(posedge Clock) begin

		if (Q == 21'b11001011011100110101) begin
			Enable <= 1;
			Q <= 0;
		end

		else begin
			Q <= Q + 1'b1;
			Enable <= 0;
		end
	end
endmodule








