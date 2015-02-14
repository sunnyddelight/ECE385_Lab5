module control(input Run, ClearA_LoadB, Reset, Clk, M, output Clr_Ld, Shift, Add, Sub);
	
	
	
	enum logic[3:0] {A, B, C, D, E, F, G, H, I,J} counter_cur, counter_next;
	always_ff @ (posedge Clk or posedge Reset) begin
		if(Reset)
			counter_cur=A;
		else
			counter_cur=counter_next;
	end
	
	always_comb
	begin
		unique case(counter_cur)
			A: if(Run)
				counter_next=B;
			B: counter_next=C; //Clear A Load B
			C: counter_next=D; //Shift 1
			D: counter_next=E;	//2
			E: counter_next=F;	//3
			F: counter_next=G;	//4
			G: counter_next=H;	//5
			H: counter_next=I;	//6
			I: counter_next=J;	//7
			J: if(~Run)	//8 and wait for button release
				counter_next=A;
			endcase
	end
	
	always_comb
	begin
		if( counter_cur== J|| counter_cur==A || counter_cur==B) 
			Shift=0;
		else
			Shift=1;
		if(M) begin
			if(counter_cur==I) begin
				Sub=1;
				Add=0;
			end else begin
				Sub=0;
				Add=1;
			end
		end
		if(counter_cur==B)
			Clr_Ld=1;
		else
			Clr_Ld=0;

	end
endmodule	

