module ImageProcess(input logic [9:0] H_Cont,
                    input logic [9:0] V_Cont,
						  input logic pixclk,
						  input logic CLOCK_50,
						  input logic [9:0] pixval,
						  output logic [0:4] confidence);
						  
						  logic [0:44999] midrec;
						  logic cansend, dataready;
	ImageRead myImageRead(
								.pixclk(pixclk),
								.RESET(1'b0), 
								.cansend(cansend),
								.hsync(H_Cont),
								.vsync(V_Cont),
								.pixvalue(pixval), // read blue data
								.dataready(dataready),
								.image(midrec)
							);

	MaskLayer myMaskLayer(
								.CLK(CLOCK_50),
								.RESET(1'b0),
								.image(midrec),
								.start(dataready),
								.done(cansend),
								.confidence(confidence)
							);

			
endmodule 