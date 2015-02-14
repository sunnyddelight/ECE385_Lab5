module carry_select_adder_9(input [8:0] A,B,
						input c_in,
						output[8:0] S,
						output c_out);
	wire A0,A1,A2,B0,B1,B2;
	wire[3:0] A3, A4, B3, B4;
	adder_4_select adderB0(.A(A[8:5]), .B(B[8:5]), .c_in(0), .c_out(B0), .S(B3));
	adder_4_select adderB1(.A(A[8:5]), .B(B[8:5]), .c_in(1), .c_out(B1), .S(B4));
	mux2to1 muxB(.D_in0(B3),.D_in1(B4), .sel(B2), .D_out(S[8:5]));
	adder_4_select adderA0(.A(A[4:1]), .B(B[4:1]), .c_in(0), .c_out(A0), .S(A3));
	adder_4_select adderA1(.A(A[4:1]), .B(B[4:1]), .c_in(1), .c_out(A1), .S(A4));
	mux2to1 muxA(.D_in0(A3),.D_in1(A4), .sel(A2), .D_out(S[4:1]));
	full_adder bit0(.x(A[0]), .y(B[0]), .z(c_in), .c(A2), .s(S[0]));
	
	assign c_out= B0 | (B1 & B2);
	assign B2= A0| (A1 & A2);
endmodule	