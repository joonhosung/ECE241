// ECE241 Project - Control (FSM)
module control(resetn, clk, go_eff1, go_eff2, go_eff3, effect_0, effect_1, effect_2, effect_3, writeEn);

	input resetn, clk, go_eff1, go_eff2, go_eff3;
	
	output reg effect_0, effect_1, effect_2, effect_3, writeEn;
	
	reg [2:0] current_state, next_state;
	
	localparam S_EFFECT_0 = 3'b000,
				  S_EFFECT_1 = 3'b001,
				  S_EFFECT_2 = 3'b010,
				  S_EFFECT_3 = 3'b011,
				  S_EFFECT_12 = 3'b100,
				  S_EFFECT_23 = 3'b101,
				  S_EFFECT_13 = 3'b110,
				  S_EFFECT_123 = 3'b111;	// Audio effect states
				  
		
	always@(posedge SW[0]) begin
		next_state = S_EFFECT_1;
	end
	
	always @ (*)
	// State Table
	begin: state_table
		case(current_state)
			
			S_SET_EFFECT_1: begin
				next_state = done ? S_WAIT : S_EFFECT_1;
			end
			
			S_SET_EFFECT_2: begin
				next_state = done ? S_WAIT : S_EFFECT_2;
			end
			
			S_SET_EFFECT_3: begin
				next_state = done ? S_WAIT : S_EFFECT_3;
			end
			
			S_UNSET_EFFECT_1: begin
				next_state = done ? S_WAIT : S_UNSET_EFFECT_1;
			end
			
			S_UNSET_EFFECT_2: begin
				next_state = done ? S_WAIT : S_UNSET_EFFECT_2;
			end
			
			S_UNSET_EFFECT_3: begin
				next_state = done ? S_WAIT : S_UNSET_EFFECT_3;
			end
			
			S_WAIT: begin
				next_state
			end
		
	end
	
	// Communication with datapath
	always @ (*) 
	begin: communication
	
		//Default
		effect_0 = 0;
		effect_1 = 0;
		effect_2 = 0;
		effect_3 = 0;
		writeEn = 0;
		
		case (current_state)
		
			
			S_SET_EFFECT_1: begin
				effect_1 = 1;
				writeEn = 1;
			end
			
			S_SET_EFFECT_2: begin
				effect_2 = 1;
				writeEn = 1;
			end
			
			S_SET_EFFECT_3: begin
				effect_3 = 1;
				writeEn = 1;
			end
			
			S_UNSET_EFFECT_1: begin
				effect_1 = 0;
				writeEn = 1;
			end
			
			S_UNSET_EFFECT_2: begin
				effect_2 = 0;
				writeEn = 1;
			end
			
			S_UNSET_EFFECT_3: begin
				effect_3 = 0;
				writeEn = 1;
			end
			
		endcase
		
	end
	
	// Move to next state or reset
	always @ (posedge clk) 
	begin: state_determination
		if (resetn == 0)
			current_state <= S_EFFECT_0;
		else
			current_state <= next_state;
	end

endmodule 












