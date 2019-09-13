module ConfidenceReg (input logic CLK, WE, RESET,
							 input logic [9:0] confidence_BLK,
							 input logic [9:0] confidence_WHT,
							 output logic [9:0] confidence_BLK_out,
							 output logic [9:0] confidence_WHT_out);
							 
		always_ff @ (posedge CLK)
		begin
			if(RESET)
				begin
				confidence_WHT_out<=10'b0;
				confidence_BLK_out<=10'b0;
				end
			else if(WE)
				begin
				confidence_BLK_out<=confidence_BLK;
				confidence_WHT_out<=confidence_WHT;
				end
		end

endmodule 