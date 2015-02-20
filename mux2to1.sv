module mux2to1 (input [3:0]D_in0,
									D_in1,
					 input sel,
					 output logic[3:0]D_out);

	always @ (D_in0 or D_in1 or sel)
	begin
		case(sel)
			1'b0 : D_out[3:0] = D_in0[3:0];
			default: D_out[3:0] = D_in1[3:0];
		endcase
	end

endmodule
