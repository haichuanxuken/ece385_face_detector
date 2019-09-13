module testbench2();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

// These signals are internal because the processor will be 
// instantiated as a submodule in testbench.\
/*
module ImageProcess(input logic [9:0] H_Cont,
                    input logic [9:0] V_Cont,
						  input logic pixclk,
						  input logic CLOCK_50,
						  input logic [9:0] pixval,
						  output logic [0:4] confidence);
*/
logic [9:0] H_Cont, V_Cont;
logic pixclk = 0, CLOCK_50 = 0;
logic [0:4] confidence;
logic [9:0] pixval=10'b1111111111;
ImageProcess test(.*);
// Toggle the clock
// #1 means wait for a delay of 1 timeunit


always begin : CLOCK_GENERATION
#2 pixclk = ~pixclk;
end
always begin : CLOCK2_GENERATION
#1 CLOCK_50 = ~CLOCK_50;
end
always begin : CLOCK3_GENERATION
#4 H_Cont = H_Cont+1;
end
always begin : CLOCK4_GENERATION
#4 if (H_Cont==799)
	 begin
		H_Cont<=0;
		V_Cont<=V_Cont+1;
	 end
	 if (V_Cont==524)
	  V_Cont<=0;
end

initial begin: CLOCK_INITIALIZATION
    pixclk = 0;
	 CLOCK_50 = 0;
	 H_Cont = 0;

end 

// Testing begins here
// The initial block is not synthesizable
// Everything happens sequentially inside an initial block
// as in a software program
initial begin: TEST_VECTORS
		 V_Cont = 0;

//LD_REG, LD_CC, DRMUX, SR1MUX, SR2MUX, LD_BEN



end


endmodule  
 