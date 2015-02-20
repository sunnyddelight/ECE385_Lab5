module computation_module(input [8:0] A, SW,
							input Add, Sub, Clr_Ld,
							output logic[8:0] S);

	logic[8:0] invert, operand, result;
	assign invert=~SW;
	carry_select_adder_9 adder(.A(operand),.B(A),.c_in(Sub),.S(result));
	
	always_comb
	begin
		if(Add)
			operand=SW;
		else if(Sub)
			operand=invert;
		else
			operand=0;
		if(Clr_Ld)
			S=8'h0;
		else
			S=result;
	end
							
endmodule
