module testbench();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

// These signals are internal because the processor will be 
// instantiated as a submodule in testbench.\
/*
module ImageRead (	input logic pixclk, 
							input logic RESET, cansend, // active high
							input logic [9:0] hsync, vsync,
							input logic [9:0] pixvalue,
							output logic dataready,		 // active high
							output logic [0:149][0:299] image 
							);
*/
logic pixclk = 0;
logic RESET, cansend, dataready;
logic [9:0] hsync, vsync;
logic [0:149][0:299] image;
logic [9:0] pixvalue=10'b1111111111;
ImageRead test(.*);
// Toggle the clock
// #1 means wait for a delay of 1 timeunit
always begin : CLOCK_GENERATION
#1 pixclk = ~pixclk;
end

initial begin: CLOCK_INITIALIZATION
    pixclk = 0;
end 

// Testing begins here
// The initial block is not synthesizable
// Everything happens sequentially inside an initial block
// as in a software program
initial begin: TEST_VECTORS
RESET = 1;		// Toggle Rest
hsync = 0;
vsync = 0;
cansend=0;

//LD_REG, LD_CC, DRMUX, SR1MUX, SR2MUX, LD_BEN
#10 RESET = 0; 
#10 
#10 vsync = 200;
#10 cansend = 1;
#2  vsync = 0;
#2  vsync = 200;
#10 hsync = 311;
#10 hsync = 312;
#10 hsync = 313;
#10 hsync = 314;
#10 hsync = 315;
#10 hsync = 316;
#10 hsync = 317;
  pixvalue=10'b0;
#10 hsync = 318;
#10 hsync = 319;
#10 hsync = 610;
#10 hsync = 611;
#10 hsync = 612;
#10 hsync = 613;
#10 hsync = 614;
#10 hsync = 615;
#10 hsync = 616;
#10 hsync = 617;
end
endmodule
//