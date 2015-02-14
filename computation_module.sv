module computation_module(input [8:0] A, SW,
							input Add, Sub, Clr_Ld,
							output[8:0] S);

	wire[8:0] invert, operand, result;
	assign invert=~SW;
	carry_select_adder_9(.A(operand),.B(B),.c_in(Sub),.S(result), .c_out(z));
	
	always_comb
	begin
		if(Add)
			operand=SW;
		else if(Sub)
			operand=invert;
		if(Clr_Ld)
			S=8'h0;
		else
			S=result;
	end
							
endmodule
