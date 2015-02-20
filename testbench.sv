module testbench();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

// These signals are internal because the processor will be 
// instantiated as a submodule in testbench.
logic [7:0] SW;
logic Run;
logic Reset;
logic ClearA_LoadB;
logic Clk = 0;
logic X_val;
logic [7:0] A_val,
		 B_val;
logic [6:0] AhexL,
		 AhexU,
		 BhexL,
		 BhexU; 
		
// Instantiating the DUT
// Make sure the module and signal names match with those in your design
processer processor0(.*);	

// Toggle the clock
// #1 means wait for a delay of 1 timeunit
always begin : CLOCK_GENERATION
#1 Clk = ~Clk;
end

initial begin: CLOCK_INITIALIZATION
    Clk = 0;
end 

// Testing begins here
// The initial block is not synthesizable
// Everything happens sequentially inside an initial block
// as in a software program
initial begin: TEST_VECTORS
Reset = 0;		// Toggle Rest
SW=8'h07;
Run=1;
Reset=0;
ClearA_LoadB=1;
#2 Reset = 1;

#2 ClearA_LoadB = 0;	// Toggle LoadA
#2 ClearA_LoadB=1;

#2 SW = 8'h3B;	// Toggle LoadB
	Run = 0;	// Toggle Run
#2 Run = 1;
#38 SW=8'h07;

#2 ClearA_LoadB = 0;	// Toggle LoadA
#2 ClearA_LoadB=1;	
	
#2 SW=8'hC5;
	Run = 0;	// Toggle Run
#2 Run = 1;

#38 Run = 1; //iter2
	SW=8'hF9;

#2 ClearA_LoadB = 0;	// Toggle LoadA
#2 ClearA_LoadB=1;	
	
#2 SW=8'h3B;
	Run = 0;	// Toggle Run
#2 Run = 1;

#38 Run = 1; //iter3
	SW=8'hF9;

#2 ClearA_LoadB = 0;	// Toggle LoadA
#2 ClearA_LoadB=1;	
	
#2 SW=8'hC5;
	Run = 0;	// Toggle Run
#2 Run = 1;

#38 Run = 1; //iter4
end
    


endmodule
