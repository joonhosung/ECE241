// State diagram - control module
module control(resetn, clk, done, Enable, update, ldA, ldB, ldC, ldD, plot);
	input resetn;
	input clk;
	input done;
	input Enable;
	input update;

	output reg ldA;
	output reg ldB;
	output reg ldC;
	output reg ldD;

	output reg plot;

	reg [2:0] current, next;

	localparam 	A = 2'b00,
				B = 2'b01,
				C = 2'b10,
				D = 2'b11;


	// State Table
	always@(*) begin
		case (current)
			A: next = (!done) ? A : B;			// Stay at A until counter is finished
			B: next = (!Enable) ? B : C;			// Stay at B until 0.25 seconds are over
			C: next = (!done) ? C : D;			// Stay at C until counter for erase is finished
			D: next = (!update) ? D : A;		// Stay at D until values for X and Y are changed
			default: next = A;
		endcase
	end

	// Datapath controls
	always@(*) begin
		// Setting all signals to 0 at first
		ldA = 1'b0;
		ldB = 1'b0;
		ldC = 1'b0;
		ldD = 1'b0;

		case (current)
			A: begin
				ldA = 1'b1;
				plot = 1'b1;
			end
			B: begin
				ldB = 1'b1;
				plot = 1'b0;
			end
			C: begin
				ldC = 1'b1;
				plot = 1'b1;
			end
			D: begin
				ldD = 1'b1;
				plot = 1'b0;
			end
		endcase
	end

	always@(posedge clk) begin
		if (!resetn)
			current <= A;
		else
			current <= next;
	end
endmodule
