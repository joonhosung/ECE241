/*****************************************************************************
 *                                                                           *
 * Module:       datapathEffect                                              *
 *                                                                           *
 *****************************************************************************/
module datapathEffect(resetn, 
							 clk, 
							 c_start,
							 c_wait, 
							 c_effect1, 
							 c_effect2, 
							 c_effect3,
							 c_effect4,
							 c_effect5,
							 c_effect6,
							 c_effect7,
							 c_effect8,
							 c_record,
							 c_unrecord,
							 c_play,
							 c_unplay,
							 c_gain_up,
							 c_gain_down,
							 c_treble_up,
							 c_treble_down,
							 c_bass_up,
							 c_bass_down,
							 gain,
							 treble,
							 bass,
							 c_delete,
							 s_record,
							 s_play,
							 s_effect1,
							 s_effect2,
							 s_effect3,
							 s_effect4,
							 s_effect5,
							 s_effect6,
							 s_effect7,
							 s_effect8);
					 
					 
/*****************************************************************************
 *                           Port Declarations                               *
 *****************************************************************************/

	input resetn, clk;
	input c_start, c_wait, c_delete;
	
	input c_effect1, c_effect2, c_effect3, c_effect4,
			c_effect5, c_effect6, c_effect7, c_effect8;
			
	input c_record, c_unrecord, c_play, c_unplay;
			
	input c_gain_up, c_gain_down,
			c_treble_up, c_treble_down,
			c_bass_up, c_bass_down;
	
	output reg s_effect1, s_effect2, s_effect3, s_effect4,
				  s_effect5, s_effect6, s_effect7, s_effect8;
				  
	output reg s_record, s_play;
				  
	output reg [6:0] gain, treble, bass;
	
	
/*****************************************************************************
 *                           Sequential Logic                                *
 *****************************************************************************/
	
	always @ (posedge clk) begin
	
		// Reset 
		if (resetn == 0) begin
			s_effect1 <= 0;
			s_effect2 <= 0;
			s_effect3 <= 0;
			s_effect4 <= 0;
			s_effect5 <= 0;
			s_effect6 <= 0;
			s_effect7 <= 0;
			s_effect8 <= 0;
			
			s_record <= 0;
			s_play <= 0;
			
			gain <= 0;
			treble <= 0;
			bass <= 0;
		end
		
		// Load
		else begin
		
			if (c_start) begin
				gain <= 0;
				treble <= 0;
				bass <= 0;
			end
			
			else if (c_wait) begin
				
			end
			
			else if (c_effect1) begin
				s_effect1 <= 1;
			end
			
			else if (c_effect2) begin
				s_effect2 <= 1;
			end
			
			else if (c_effect3) begin
				s_effect3 <= 1;
			end
				
			else if (c_effect4) begin
				s_effect4 <= 1;
			end
			
			else if (c_effect5) begin
				s_effect5 <= 1;
			end
			
			else if (c_effect6) begin
				s_effect6 <= 1;
			end
			
			else if (c_effect7) begin
				s_effect7 <= 1;
			end
			
			else if (c_effect8) begin
				s_effect8 <= 1;
			end
			
			else if (c_delete) begin
				s_effect1 <= 0;
				s_effect2 <= 0;
				s_effect3 <= 0;
				s_effect4 <= 0;
				s_effect5 <= 0;
				s_effect6 <= 0;
				s_effect7 <= 0;
				s_effect8 <= 0;
				
				gain <= 0;
				treble <= 0;
				bass <= 0;
				
			end
			
			else if (c_gain_up) begin
				gain <= gain + 1'b1;
				
					if (gain >= 7'd126)
						gain <= 7'd126;	// Maximum 126
			end
			
			else if (c_gain_down) begin
				gain <= gain - 1'b1;
				
					if (gain <= 7'd0)
						gain <= 7'd0;		// Minimum 0
			end
			
			else if (c_treble_up) begin
				treble <= treble + 1'b1;
				
					if (treble >= 7'd127)
							treble <= 7'd127;		// Max 127
				
			end
			
			else if (c_treble_down) begin
				treble <= treble - 1'b1;
				
					if (treble <= 7'd0)
						treble <= 7'd0;		// Min 0
			end
			
			else if (c_bass_up) begin
				bass <= bass + 1'b1;
				
					if (bass >= 7'd127)
							bass <= 7'd127;	// Max 127
			end
			
			else if (c_bass_down) begin
				bass <= bass - 1'b1;
				
					if (bass <= 7'd0)
						bass <= 7'd0;			// Min 127
			end
			
			else if (c_record) begin
				s_record <= 1;
			end
			
			else if (c_unrecord) begin
				s_record <= 0;
			end
			
			else if (c_play) begin
				s_play <= 1;
			end
			
			else if (c_unplay) begin
				s_play <= 0;
			end
			
		end

end

endmodule





/*****************************************************************************
 *                                                                           *
 * Module:       datapathUpdate                                              *
 *                                                                           *
 *****************************************************************************/
 
 module datapathUpdate(clk,
							  c_start,
							  c_draw1,
							  c_draw2,
							  c_draw3,
							  c_draw4,
							  c_draw5,
							  c_draw6,
							  c_draw7,
							  c_draw8,
							  c_clear_gain,
							  c_draw_gain,
							  c_clear_treble,
							  c_draw_treble,
							  c_clear_bass,
							  c_draw_bass,
							  c_clear_graph,
							  c_draw_graph,
							  gain,
							  treble,
							  bass,
							  amplitude,
							  effect_1,
							  effect_2,
							  effect_3,
							  effect_4,
							  effect_5,
							  effect_6,
							  effect_7,
							  effect_8,
							  doneDraw1,
							  doneDraw2,
							  doneDraw3,
							  doneDraw4,
							  doneDraw5,
							  doneDraw6,
							  doneDraw7,
							  doneDraw8,
							  done_Clear_Gain,
							  done_Draw_Gain,
							  done_Clear_Treble,
							  done_Draw_Treble,
							  done_Clear_Bass,
							  done_Draw_Bass,
							  done_Clear_Graph,
							  done_Draw_Graph,
							  x_out,
							  y_out,
							  colour_out);
							  
							  
/*****************************************************************************
 *                           Port Declarations                               *
 *****************************************************************************/

	input clk, c_start;
	input c_draw1, c_draw2, c_draw3, c_draw4, c_draw5, c_draw6, c_draw7, c_draw8;
	input c_clear_graph, c_clear_gain, c_clear_treble, c_clear_bass;
	input c_draw_graph, c_draw_gain, c_draw_treble, c_draw_bass;
	input [6:0] gain, treble, bass, amplitude;
	input effect_1, effect_2, effect_3, effect_4, effect_5, effect_6, effect_7, effect_8;
	
	wire [8:0] clr_colour;
	colourTranslator u1(clk, count_clr_x, count_clr_y, clr_colour);
	
	output reg [8:0] x_out;
	output reg [7:0] y_out;
	output reg [8:0] colour_out;
	
	output reg doneDraw1, doneDraw2, doneDraw3, doneDraw4, 
				  doneDraw5, doneDraw6, doneDraw7, doneDraw8;
				  
	output reg done_Clear_Graph, done_Clear_Gain, done_Clear_Treble, done_Clear_Bass;
	output reg done_Draw_Graph, done_Draw_Gain, done_Draw_Treble, done_Draw_Bass;
	
	reg [8:0] count_x_1;
	reg [7:0] count_y_1;
	
	reg [8:0] count_x_2;
	reg [7:0] count_y_2;
	
	reg [8:0] count_x_3;
	reg [7:0] count_y_3;
	
	reg [8:0] count_x_4;
	reg [7:0] count_y_4;
	
	reg [8:0] count_x_5;
	reg [7:0] count_y_5;
	
	reg [8:0] count_x_6;
	reg [7:0] count_y_6;
	
	reg [8:0] count_x_7;
	reg [7:0] count_y_7;
	
	reg [8:0] count_x_8;
	reg [7:0] count_y_8;
	
	reg [8:0] count_x_gain;
	reg [7:0] count_y_gain;
	
	reg [8:0] count_x_treble;
	reg [7:0] count_y_treble;
	
	reg [8:0] count_x_bass;
	reg [7:0] count_y_bass;
	
	reg [8:0] count_x_graph;
	reg [7:0] count_y_graph;
	
	reg [8:0] count_clr_x;
	reg [7:0] count_clr_y;
	

/*****************************************************************************
 *                           Sequential Logic                                *
 *****************************************************************************/
	
	always @ (posedge clk) begin
	
		if (c_start) begin
		// Reset
			count_clr_x <= 1'b0;
			count_clr_y <= 1'b0;
			x_out <= 1'b0;
			y_out <= 1'b0;
			
			count_x_gain <= 1'b0;
			count_y_gain <= 1'b0;
			
			count_x_treble <= 1'b0;
			count_y_treble <= 1'b0;
			
			count_x_bass <= 1'b0;
			count_y_bass <= 1'b0;
			
			count_x_graph <= 1'b0;
			count_y_graph <= 1'b0;
			
			count_x_1 <= 1'b0;
			count_y_1 <= 1'b0;
			
			count_x_2 <= 1'b0;
			count_y_2 <= 1'b0;
			
			count_x_3 <= 1'b0;
			count_y_3 <= 1'b0;
			
			count_x_4 <= 1'b0;
			count_y_4 <= 1'b0;
			
			count_x_5 <= 1'b0;
			count_y_5 <= 1'b0;
			
			count_x_6 <= 1'b0;
			count_y_6 <= 1'b0;
			
			count_x_7 <= 1'b0;
			count_y_7 <= 1'b0;
			
			count_x_8 <= 1'b0;
			count_y_8 <= 1'b0;
			
			doneDraw1 <= 1'b0;
			doneDraw2 <= 1'b0;
			doneDraw3 <= 1'b0;
			doneDraw4 <= 1'b0;
			doneDraw5 <= 1'b0;
			doneDraw6 <= 1'b0;
			doneDraw7 <= 1'b0;
			doneDraw8 <= 1'b0;
			
			done_Clear_Graph <= 1'b0;
			done_Clear_Gain <= 1'b0;
			done_Clear_Treble <= 1'b0;
			done_Clear_Bass <= 1'b0;
			
			done_Draw_Graph <= 1'b0;
			done_Draw_Gain <= 1'b0;
			done_Draw_Treble <= 1'b0;
			done_Draw_Bass <= 1'b0;

		end
		
		else if (c_clear_graph) begin
		
			// (37, 203) - (66, 203)
				count_y_graph <= count_y_graph + 1'b1;
				
				if (count_x_graph >= 9'd29 && count_y_graph >= 8'd127) begin
					count_x_graph <= 1'b0;
					count_y_graph <= 1'b0;
					count_clr_x <= 1'b0;
					count_clr_y <= 1'b0;
					
					done_Clear_Graph <= 1'b1;
				end
				
				else if (count_y_graph >= 8'd127) begin
					count_y_graph <= 1'b0;
					count_x_graph <= count_x_graph + 1'b1;
				end
				
				else begin
					x_out <= count_x_graph + 9'd37;
					count_clr_x <= count_x_graph + 9'd37;
					
					y_out <= 8'd203 - count_y_graph;
					count_clr_y <= 8'd203 - count_y_graph; 
					
					colour_out <= clr_colour;
				end
		end
		
		else if (c_draw_graph) begin
		
				count_y_graph <= count_y_graph + 1'b1;
				
				if (count_x_graph >= 9'd29 && count_y_graph >= amplitude) begin
					count_x_graph <= 1'b0;
					count_y_graph <= 1'b0;
					done_Draw_Graph <= 1'b1;
				end
				
				else if (count_y_graph >= amplitude || count_y_graph >= 8'd127) begin
					count_y_graph <= 1'b0;
					count_x_graph <= count_x_graph + 1'b1;
				end
				else begin
					x_out <= count_x_graph + 9'd37;
					y_out <= 8'd203 - count_y_graph;
					
					colour_out <= 9'b111000000;
				end
		end
		
		else if (c_clear_gain) begin
			
			count_x_gain <= count_x_gain + 1'b1;
			
			if (count_y_gain >= 8'd16 && count_x_gain >= 9'd127) begin
				count_x_gain <= 1'b0;
				count_y_gain <= 1'b0;
				count_clr_x <= 1'b0;
				count_clr_y <= 1'b0;
				done_Clear_Gain <= 1'b1;
			end
			
			else if (count_x_gain >= 9'd127) begin
				count_x_gain <= 1'b0;
				count_y_gain <= count_y_gain + 1'b1;
			end
			
			else begin
				x_out <= count_x_gain + 9'd166;
				count_clr_x <= count_x_gain + 9'd166;
				
				y_out <= count_y_gain + 8'd153;
				count_clr_y <= count_y_gain + 8'd152;
				
				colour_out <= clr_colour;
			end

		end
		
		else if (c_draw_gain) begin
		
			count_x_gain <= count_x_gain + 1'b1;
			
			if (count_y_gain >= 8'd14 && count_x_gain >= {1'b0, gain}) begin
				count_x_gain <= 1'b0;
				count_y_gain <= 1'b0;
				done_Draw_Gain <= 1'b1;
			end
			
			else if (count_x_gain >= {1'b0, gain}) begin
				count_x_gain <= 1'b0;
				count_y_gain <= count_y_gain + 1'b1;
			end
			
			else begin
				x_out <= count_x_gain + 9'd166;
				y_out <= count_y_gain + 8'd154;
				colour_out <= 9'b000000111;
			end
			
		end
		
		else if (c_clear_treble) begin
		
			count_x_treble <= count_x_treble + 1'b1;
		
			if (count_y_treble >= 8'd16 && count_x_treble >= 9'd127) begin
				count_x_treble <= 1'b0;
				count_y_treble <= 1'b0;
				count_clr_x <= 1'b0;
				count_clr_y <= 1'b0;
				done_Clear_Treble <= 1'b1;
			end
			
			else if (count_x_treble >= 9'd127) begin
				count_x_treble <= 1'b0;
				count_y_treble <= count_y_treble + 1'b1;
			end
			
			else begin
				x_out <= count_x_treble + 9'd166;
				count_clr_x <= count_x_treble + 9'd166;
				
				y_out <= count_y_treble + 8'd180;
				count_clr_y <= count_y_treble + 8'd179;
				
				colour_out <= clr_colour;
			end
			
		end
		
		else if (c_draw_treble) begin
		
			count_x_treble <= count_x_treble + 1'b1;
			
			if (count_y_treble >= 8'd14 && count_x_treble >= {1'b0, treble}) begin
				count_x_treble <= 1'b0;
				count_y_treble <= 1'b0;
				done_Draw_Treble <= 1'b1;
			end
			
			else if (count_x_treble >= {1'b0, treble}) begin
				count_x_treble <= 1'b0;
				count_y_treble <= count_y_treble + 1'b1;
			end
			
			else begin
				x_out <= count_x_treble + 9'd166;
				y_out <= count_y_treble + 8'd180;
				colour_out <= 9'b000000111;
			end
			
		end
		
		else if (c_clear_bass) begin
		
			count_x_bass <= count_x_bass + 1'b1;
		
			if (count_y_bass >= 8'd16 && count_x_bass >= 9'd127) begin
				count_x_bass <= 1'b0;
				count_y_bass <= 1'b0;
				count_clr_x <= 1'b0;
				count_clr_y <= 1'b0;
				done_Clear_Bass <= 1'b1;
			end
			
			else if (count_x_bass >= 9'd127) begin
				count_x_bass <= 1'b0;
				count_y_bass <= count_y_bass + 1'b1;
			end
			
			else begin
				x_out <= count_x_bass + 9'd166;
				count_clr_x <= count_x_bass + 9'd166;
				
				y_out <= count_y_bass + 8'd205;
				count_clr_y <= count_y_bass + 8'd204;
				
				colour_out <= clr_colour;
			end
		end
		
		else if (c_draw_bass) begin
		
			count_x_bass <= count_x_bass + 1'b1;
			
			if (count_y_bass >= 8'd14 && count_x_bass >= {1'b0, bass}) begin
				count_x_bass <= 1'b0;
				count_y_bass <= 1'b0;
				done_Draw_Bass <= 1'b1;
			end
			
			else if (count_x_bass >= {1'b0, bass}) begin
				count_x_bass <= 1'b0;
				count_y_bass <= count_y_bass + 1'b1;
			end
			
			else begin
				x_out <= count_x_bass + 9'd166;
				y_out <= count_y_bass + 8'd205;
				colour_out <= 9'b000000111;
			end
			
		end
		
		else if (c_draw1) begin
		
				count_x_1 <= count_x_1 + 1'b1;

				if (count_y_1 >= 8'd9 && count_x_1 == 9'd9) begin
					count_x_1 <= 1'b0;
					count_y_1 <= 1'b0;
					doneDraw1 <= 1'b1;
				end
				
				else if (count_x_1 >= 9'd9) begin
					count_x_1 <= 1'b0;
					count_y_1 <= count_y_1 + 1'b1;
				end
				
				x_out <= 9'd118 + count_x_1;
				count_clr_x <= 9'd118 + count_x_1;
				
				y_out <= 8'd85 + count_y_1;
				count_clr_y <= 8'd85 + count_y_1;
				
				if (effect_1) begin
					colour_out <= 9'b000111000;
				end
				
				else begin
					colour_out <= clr_colour;
				end
		end
		
		else if (c_draw2) begin
		
				count_x_2 <= count_x_2 + 1'b1;

				if (count_y_2 >= 8'd9 && count_x_2 == 9'd9) begin
					count_x_2 <= 1'b0;
					count_y_2 <= 1'b0;
					doneDraw2 <= 1;
				end
				
				else if (count_x_2 >= 9'd9) begin
					count_x_2 <= 1'b0;
					count_y_2 <= count_y_2 + 1'b1;
				end
				
				x_out <= 9'd162 + count_x_2;
				count_clr_x <= 9'd162 + count_x_2;
				
				y_out <= 8'd85 + count_y_2;
				count_clr_y <= 8'd85 + count_y_2;
				
				if (effect_2) begin
					colour_out <= 9'b000111000;
				end
				
				else begin
					colour_out <= clr_colour;
				end
		end
		
		else if (c_draw3) begin
		
				count_x_3 <= count_x_3 + 1'b1;

				if (count_y_3 >= 8'd9 && count_x_3 == 9'd9) begin
					count_x_3 <= 1'b0;
					count_y_3 <= 1'b0;
					doneDraw3 <= 1'b1;
				end
				
				else if (count_x_3 >= 9'd9) begin
					count_x_3 <= 1'b0;
					count_y_3 <= count_y_3 + 1'b1;
				end
				
				x_out <= 9'd213 + count_x_3;
				count_clr_x <= 9'd213 + count_x_3;
				
				y_out <= 8'd85 + count_y_3;
				count_clr_y <= 8'd85 + count_y_3;
				
				if (effect_3) begin
					colour_out <= 9'b000111000;
				end
				
				else begin
					colour_out <= clr_colour;
				end
			
		end
		
		else if (c_draw4) begin
		
				count_x_4 <= count_x_4 + 1'b1;

				if (count_y_4 >= 8'd9 && count_x_4 == 9'd9) begin
					count_x_4 <= 1'b0;
					count_y_4 <= 1'b0;
					doneDraw4 <= 1'b1;
				end
				
				else if (count_x_4 >= 9'd9) begin
					count_x_4 <= 1'b0;
					count_y_4 <= count_y_4 + 1'b1;
				end
				
				x_out <= 9'd257 + count_x_4;
				count_clr_x <= 9'd257 + count_x_4;
				
				y_out <= 8'd85 + count_y_4;
				count_clr_y <= 8'd85 + count_y_4;
				
				if (effect_4) begin
					colour_out <= 9'b000111000;
				end
				
				else begin
					colour_out <= clr_colour;
				end
		end
		
		else if (c_draw5) begin
		
				count_x_5 <= count_x_5 + 1'b1;

				if (count_y_5 >= 8'd9 && count_x_5 == 9'd9) begin
					count_x_5 <= 1'b0;
					count_y_5 <= 1'b0;
					doneDraw5 <= 1'b1;
				end
				
				else if (count_x_5 >= 9'd9) begin
					count_x_5 <= 1'b0;
					count_y_5 <= count_y_5 + 1'b1;
				end
				
				x_out <= 9'd118 + count_x_5;
				count_clr_x <= 9'd118 + count_x_5;
				
				y_out <= 8'd116 + count_y_5;
				count_clr_y <= 8'd116 + count_y_5;
				
				if (effect_5) begin
					colour_out <= 9'b000111000;
				end
				
				else begin
					colour_out <= clr_colour;
				end
		end
		
		else if (c_draw6) begin
		
				count_x_6 <= count_x_6 + 1'b1;

				if (count_y_6 >= 8'd9 && count_x_6 == 9'd9) begin
					count_x_6 <= 1'b0;
					count_y_6 <= 1'b0;
					doneDraw6 <= 1'b1;
				end
				
				else if (count_x_6 >= 9'd9) begin
					count_x_6 <= 1'b0;
					count_y_6 <= count_y_6 + 1'b1;
				end
				
				x_out <= 9'd162 + count_x_6;
				count_clr_x <= 9'd162+ count_x_6;
				
				y_out <= 8'd116 + count_y_6;
				count_clr_y <= 8'd116 + count_y_6;
				
				if (effect_6) begin
					colour_out <= 9'b000111000;
				end
				
				else begin
					colour_out <= clr_colour;
				end
		end
		
		else if (c_draw7) begin
		
				count_x_7 <= count_x_7 + 1'b1;

				if (count_y_7 >= 8'd9 && count_x_7 == 9'd9) begin
					count_x_7 <= 1'b0;
					count_y_7 <= 1'b0;
					doneDraw7 <= 1'b1;
				end
				
				else if (count_x_7 >= 9'd9) begin
					count_x_7 <= 1'b0;
					count_y_7 <= count_y_7 + 1'b1;
				end
				
				x_out <= 9'd213 + count_x_7;
				count_clr_x <= 9'd213 + count_x_7;
				
				y_out <= 8'd116 + count_y_7;
				count_clr_y <= 8'd116 + count_y_7;
				
				if (effect_7) begin
					colour_out <= 9'b000111000;
				end
				
				else begin
					colour_out <= clr_colour;
				end
		end
		
		else if (c_draw8) begin
		
				count_x_8 <= count_x_8 + 1'b1;

				if (count_y_8 >= 8'd9 && count_x_8 == 9'd9) begin
					count_x_8 <= 1'b0;
					count_y_8 <= 1'b0;
					doneDraw8 <= 1'b1;
				end
				
				else if (count_x_8 >= 9'd9) begin
					count_x_8 <= 1'b0;
					count_y_8 <= count_y_8 + 1'b1;
				end
				
				x_out <= 9'd257 + count_x_8;
				count_clr_x <= 9'd257 + count_x_8;
				
				y_out <= 8'd116 + count_y_8;
				count_clr_y <= 8'd116 + count_y_8;
				
				if (effect_8) begin
					colour_out <= 9'b000111000;
				end
				
				else begin
					colour_out <= clr_colour;
				end
		end
		
end

 
 endmodule
 
 

/*****************************************************************************
 *                    Coordinate-to-Colour Translator                        *
 *****************************************************************************/
module colourTranslator(clock, x_in, y_in, colour);

	input [8:0] x_in;
	input [7:0] y_in;	
	input clock;
	wire [16:0] address;
	output [8:0] colour;
	
	assign address = y_in * 9'd320 + x_in;
	
	BackgroundMemory g1(address, clock, colour);	// Read colour in location

endmodule




