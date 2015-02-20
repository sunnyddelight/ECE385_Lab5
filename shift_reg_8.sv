//Register for memory in order to keep track of the values and display the LED numbers
module shift_reg_8(input[7:0] parallel_load,
				input serial_in, Clk, Reset_reg,
				input[1:0] mode, //mode 0: nothing, mode 1: shift right, mode 2: load parallel
				output[7:0] parallel_out,
				output serial_out);
	integer i;
	reg[7:0] R;
	assign parallel_out=R;
	assign serial_out=R[0];
	always @(posedge Clk) begin
			if(~Reset_reg)
				R=8'h0;
			else
			if(mode==1) begin
				for(i=0; i<7; i=i+1) begin
					R[i]=R[i+1];
				end
				R[7]=serial_in;
			end else if(mode==2) begin
				R=parallel_load;
			end
	end

endmodule
