

//timescale 1ns / 1ns // `timescale time_unit/time_precision


module alwaysBlock(Input, Out, MuxSelect);
	input [5:0] Input;
	input [2:0] MuxSelect;
	output Out;
	
	reg Out;

always@(*)
begin
	case(MuxSelect[2:0])
		3'b000: Out = Input[0];
		3'b001: Out = Input[1];
		3'b010: Out = Input[2];
		3'b011: Out = Input[3];
		3'b100: Out = Input[4];
		3'b101: Out = Input[5];
		default: Out = 1'b0;
	endcase
end
endmodule


// Write like this or the way below? Question for TA.
/*module mux6to1(In, Sig, Out);
	input[5:0] In;
	input[2:0] Sig;
	output Out;
	
	alwaysBlock b1(.Input(In[5:0]), 
		       .MuxSelect(Sig[2:0]), 
		       .Out(Out)); 
endmodule
*/

module Lab_3(SW, LEDR);
	input[9:0] SW;
	output[9:0] LEDR;
	
	alwaysBlock b1(.Input(SW[5:0]), 
		       .MuxSelect(SW[9:7]), 
		       .Out(LEDR[0]));
endmodule 
