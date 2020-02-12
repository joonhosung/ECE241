module datapath(left, right,  resetn, clk, colourSW, cnA, cnB, cnC, cnD, Enable, colour, coordinates, done, timer, update);
	input resetn;
	input clk;
	input [2:0] colourSW;
	input left, right;

	input cnA;
	input cnB;
	input cnC;
	input cnD;

	input Enable;					// indicating timer is finished

	output reg [2:0] colour;
	output reg [14:0] coordinates;
	output reg done;
	output reg timer;
	output reg update;

	reg [7:0] x;
	reg [6:0] y;
	reg upX, upY;

	reg [8:0] counter;
	reg [6:0] y1;
	reg [6:0] y2;
	reg [6:0] y3;
	reg [6:0] y4;
	reg [6:0] y5;
	reg [6:0] y6;
	reg [6:0] y7;
	reg [6:0] y8;
	reg [6:0] y9;
	reg [6:0] y10;
	reg [6:0] y11;
	reg [6:0] y12;
	reg [6:0] y13;
	reg [6:0] y14;

	reg resetStart = 1'b1;
	reg resetDone;

	
	random m1 (clk, resetn, x_rand);
	
	always@(posedge clk) begin
		if (!resetn) begin

			colour <= 0;
			done <= 0;
			counter <= 0;
			timer <= 0;

			x <= 8'b01000110;
			y <= 7'b1101001;

			if (resetStart) begin
				coordinates <= 0;
			end

			if (!resetDone) begin
				resetStart <= 0;
				coordinates <= coordinates + 1;
			end

			if (coordinates >= 15'b100111111111111) begin
				coordinates <= {x, y};
				resetDone <= 1'b1;
			end
		end
		
		else begin
			if (cnA) begin
				update <= 1'b0;

				colour <= colourSW;
				y1 = y + 1;
				y2 = y1 + 1;
				y3 = y2 + 1;
				y4 = y3 + 1;
				y5 = y4 + 1;
				y6 = y5 + 1;
				y7 = y6 + 1;
				y8 = y7 + 1;
				y9 = y8 + 1;
				y10 = y9 + 1;
				y11 = y10 + 1;
				y12 = y11 + 1;
				y13 = y12 + 1;
				y14 = y13 + 1;

				if (counter < 20)
					coordinates <= {x + counter, y};
				else if (counter < 40)
					coordinates <= {x + (counter - 20), y1};
				else if (counter < 60)
					coordinates <= {x + (counter - 40), y2};
				else if (counter < 80)
					coordinates <= {x + (counter - 60), y3};
				else if (counter < 100)
					coordinates <= {x + (counter - 80), y4};
				else if (counter < 120)
					coordinates <= {x + (counter - 100), y5};
				else if (counter < 140)
					coordinates <= {x + (counter - 120), y6};
				else if (counter < 160)
					coordinates <= {x + (counter - 140), y7};
				else if (counter < 180)
					coordinates <= {x + (counter - 160), y8};
				else if (counter < 200)
					coordinates <= {x + (counter - 180), y9};
				else if (counter < 220)
					coordinates <= {x + (counter - 200), y10};
				else if (counter < 240)
					coordinates <= {x + (counter - 220), y11};
				else if (counter < 260)
					coordinates <= {x + (counter - 240), y12};
				else if (counter < 280)
					coordinates <= {x + (counter - 260), y13};
				else if (counter < 300)
					coordinates <= {x + (counter - 280), y14};
				else
					done <= 1'b1;
				
				counter <= counter + 1;
			end

			if (cnB) begin
				counter <= 0;
				done <= 1'b0;

				timer <= 1'b1;
			end

			// state to erase
			if (cnC) begin
				timer <= 1'b0;

				colour <= 0;

				if (counter < 20)
					coordinates <= {x + counter, y};
				else if (counter < 40)
					coordinates <= {x + (counter - 20), y1};
				else if (counter < 60)
					coordinates <= {x + (counter - 40), y2};
				else if (counter < 80)
					coordinates <= {x + (counter - 60), y3};
				else if (counter < 100)
					coordinates <= {x + (counter - 80), y4};
				else if (counter < 120)
					coordinates <= {x + (counter - 100), y5};
				else if (counter < 140)
					coordinates <= {x + (counter - 120), y6};
				else if (counter < 160)
					coordinates <= {x + (counter - 140), y7};
				else if (counter < 180)
					coordinates <= {x + (counter - 160), y8};
				else if (counter < 200)
					coordinates <= {x + (counter - 180), y9};
				else if (counter < 220)
					coordinates <= {x + (counter - 200), y10};
				else if (counter < 240)
					coordinates <= {x + (counter - 220), y11};
				else if (counter < 260)
					coordinates <= {x + (counter - 240), y12};
				else if (counter < 280)
					coordinates <= {x + (counter - 260), y13};
				else if (counter < 300)
					coordinates <= {x + (counter - 280), y14};
				else
					done <= 1'b1;
				
				counter <= counter + 1;
			end

			if (cnD) begin
				counter <= 0;
				done <= 1'b0;

				if (!update) begin
					update <= 1'b1;

					if (left)
						x <= x - 1;

					if (right)
						x <= x + 1;
				end
			end
		end
	end
	
	

endmodule
