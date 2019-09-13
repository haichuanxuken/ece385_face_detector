module ImageReg ( input logic WE, 
						input logic [9:0] X, Y,
						input logic eachConf,
						input CLK,
						output logic [0:149][0:299] image 
						);
		

		always_ff @ (posedge CLK)
		begin
				if(WE)
				begin
				image[Y][X]<=eachConf;
				end
		end
endmodule 
// ImageReg myImageArray(.WE(loadConf), .eachConf(blackorwhite), .CLK(pixclk), .RESET(RESET), .CLEAR(clear), .image(image));