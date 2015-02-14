module control(input Run, ClearA_LoadB, Reset, Clk, M, output Clr_Ld, Shift, Add, Sub);
	
	
	
	enum logic[6:0] {Wait, A0, A1, B0, B1, C0, C1, D0, D1, E0, E1, F0, F1, G0, G1, H0, H1, I} counter_cur, counter_next;
	always_ff @ (posedge Clk or posedge ~Reset) begin
		if(~Reset)
			counter_cur=Wait;
		else
			counter_cur=counter_next;
	end
	
	always_comb
	begin
		unique case(counter_cur)
			Wait: begin
				Shift=0;
				Add=0;
				Sub=0;
				if(~Run)
					counter_next=A0;
				else
					counter_next=Wait;
				end
			A0: begin 
				counter_next=A1; //add
				Shift=0;
				Add=M;
				Sub=0;
				end
			A1: begin
				counter_next=B0; //shift
				Shift=1;
				Add=0;
				Sub=0;
				end
			B0: begin
				counter_next=B1; //add
				Shift=0;
				Add=M;
				Sub=0;
				end
			B1: begin
				counter_next=C0; //shift
				Shift=1;
				Add=0;
				Sub=0;
				end
			C0: begin
				counter_next=C1; //add
				Shift=0;
				Add=M;
				Sub=0;
				end
			C1: begin
				counter_next=D0; //shift
				Shift=1;
				Add=0;
				Sub=0;
				end
			D0:begin 
				counter_next=D1; //add
				Shift=0;
				Add=M;
				Sub=0;
				end
			D1: begin
				counter_next=E0; //shift
				Shift=1;
				Add=0;
				Sub=0;
				end
			E0:begin 
				counter_next=E1; //add
				Shift=0;
				Add=M;
				Sub=0;
				end
			E1: begin
				counter_next=F0; //shift
				Shift=1;
				Add=0;
				Sub=0;
				end
			F0: begin
				counter_next=F1; //add
				Shift=0;
				Add=M;
				Sub=0;
				end
			F1: begin
				counter_next=G0; //shift
				Shift=1;
				Add=0;
				Sub=0;
				end
			G0:begin 
				counter_next=G1; //add
				Shift=0;
				Add=M;
				Sub=0;
				end
			G1: begin
				counter_next=H0; //shift
				Shift=1;
				Add=0;
				Sub=0;
				end
			H0:begin 
				counter_next=H1; //sub
				Shift=0;
				Add=0;
				Sub=M;
				end
			H1: begin
				counter_next=I;  //shift
				Shift=1;
				Sub=0;
				Add=0;
				end
			I: begin 
				Shift=0;
				Add=0;
				Sub=0;
				if(Run)	//8 and wait for button release
					counter_next=Wait;
				else
					counter_next=I;
				end
			endcase
	end
	assign Clr_Ld=~ClearA_LoadB;

endmodule	

