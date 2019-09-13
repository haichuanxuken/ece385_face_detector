module ImageRead (	input logic pixclk, 
							input logic RESET, cansend, // active high
							input logic [9:0] hsync, vsync,
							input logic [9:0] pixvalue,
							output logic dataready,		 // active high
							output logic [0:149][0:299] image 
							);
											
				logic	blackorwhite;
				logic [9:0] x, y;
				logic loadConf;
				assign y=vsync-(34+165);
				assign x=hsync-(144+170);
				assign blackorwhite = (pixvalue >= 10'b0110000000) ? 1'b1 : 1'b0; // each confidence bit
				// state declaration
				enum logic [2:0] {waitState ,readNothing, readData, doneState }state, nextState;
				// module declaration
				ImageReg myImageArray(.WE(loadConf), .X(x), .Y(y), .eachConf(blackorwhite), .CLK(pixclk), .image(image));
				
				always_ff @ (posedge pixclk)
				begin
					if (RESET) 
						state <= waitState;
					else 
						state <= nextState;
				end
				
				// state transition
				always_comb
				begin
					nextState = state;
					unique case(state)
					waitState: 
						if(cansend && vsync==10'b0)
							nextState = readNothing;
					readNothing:
						begin
							if(vsync== 34+315 && hsync==144+470)
								nextState = doneState;
							else if (hsync == 144+170-2 && vsync >= 34+165 && vsync < 34+315)
								nextState = readData;
						end
					readData:
						begin 
							if (hsync == 144+470-1 && vsync >= 34+165 && vsync < 34+315)
								nextState = readNothing;
						end
					doneState:
						begin
							nextState = waitState;
						end
					default:
						nextState = waitState;
					endcase
				
				// state implementation
					// control signal implementation
					loadConf=1'b0;
					dataready=1'b0;
					unique case(state)
						waitState:	
							; // do nothing
						readNothing:
							; // do nothing
						readData:
							loadConf=1'b1; 
						doneState:
							dataready=1'b1;
					endcase		
				end
endmodule 