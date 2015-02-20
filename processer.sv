//Module for wiring all the modules together in order to make the circuit work
module processer(input [7:0] SW, input Run, Reset, ClearA_LoadB, Clk, output logic[7:0] A_val, B_val, output logic[6:0] AhexU, AhexL, BhexU, BhexL, output X_val );
	wire Add, Sub, Clr_Ld, A_out, M, Shift, Reset_reg;
	logic[1:0] A_mode, B_mode;
	wire[7:0] A_reg_val, B_reg_val, A_in;
	wire[8:0] S, comp_A, comp_SW;
	reg X;
	computation_module adder(.*,.A(comp_A), .SW(comp_SW));
	shift_reg_8 A_reg(.*, .mode(A_mode), .parallel_out(A_reg_val), .parallel_load(S[7:0]), .serial_in(X),.serial_out(A_out));
	shift_reg_8 B_reg(.*, .mode(B_mode), .parallel_out(B_reg_val), .parallel_load(SW), .serial_in(A_out), .serial_out(M));
	control control_module(.*);
	always_ff @(posedge Clk)
	begin
		X=S[8];
	end
	assign X_val=X;
	assign A_val=A_reg_val;
	assign B_val=B_reg_val;
	assign comp_A[7:0]=A_reg_val;
	assign comp_SW[7:0]=SW;
	assign comp_SW[8]=SW[7];
	assign comp_A[8]=A_reg_val[7];
	always_comb //Assign register mode 
	begin
		if(Clr_Ld) begin
			A_mode=2;
			B_mode=2;
		end
		else if(Shift) begin
			A_mode=1;
			B_mode=1;
		end
		else if(Add||Sub) begin 
			A_mode=2;
			B_mode=0;
		end
		else begin
			A_mode=0;
			B_mode=0;
		end
	end
	HexDriver A_HexUp(.In0(A_reg_val[7:4]), .Out0(AhexU));
	HexDriver A_HexDn(.In0(A_reg_val[3:0]), .Out0(AhexL));
	HexDriver B_HexUp(.In0(B_reg_val[7:4]), .Out0(BhexU));
	HexDriver B_HexDn(.In0(B_reg_val[3:0]), .Out0(BhexL));
endmodule
