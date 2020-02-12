// Module to separate Clock Pulses to every 0.25s
module RateDivider(Clock, resetn, timer, Enable);
	input Clock;
	input resetn;
	input timer;
	output reg Enable;

	reg [23:0] Q;

	always @(posedge Clock) begin
		if (!resetn) begin
			Q <= 0;
			Enable <= 0;
		end

		else if (Q == 21'b101111101011110000100) begin
			Enable <= 1;
			Q <= 0;
		end

		else if (timer) begin
			Q <= Q + 1;
			Enable <= 0;
		end
	end
endmodule
