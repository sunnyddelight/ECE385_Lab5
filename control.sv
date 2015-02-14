module control(input Run, ClearA_LoadB, Reset, 
				output Clr_Ld, Shift, Add, Sub);

always_comb
begin
	case (state)
		A: // Reset state
			begin
				Clr_Ld <= Reset;
				Shift <= 1'b0;
				Add <= 1'b0;
				Sub <= 1'b0;
			end
		B: // ClearA_LoadB state
			begin
				Clr_Ld <= ClearA_LoadB;
				Shift <= 1'b0;
				Add <= 1'b0;
				Sub <= 1'b0;
		default:
			begin
				Clr_Ld <= 1'b0;
				Shift <= 1'b0;
				Add <= 1'b0;
				Sub <= 1'b0;
			end
	endcase