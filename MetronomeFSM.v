module MetronomeFSM(
	input [18:0] VGAaddr,
	input wire clk,
	input [2:0] speed, //For determining how fast to switch states
	output reg Tick,
	output reg invert_specific/*,
	output [4:0] State*/
	);
	assign State = S;
	reg [4:0] S;
	reg [4:0] NS;
	
	parameter 
		One 	= 5'b00001,
		Two 	= 5'b00010,
		Three	= 5'b00000,  //Zeros b/c the start position should be the middle
		Four 	= 5'b00100,
		Five 	= 5'b00101,
		Twob	= 5'b10010,
		Threeb= 5'b10011,
		Fourb = 5'b10100,
		Tick1 = 5'b10101,
		Tick2 = 5'b11100;

	reg [26:0] counter;
	wire [4:0] q;
	reg [26:0] threshold;
	wire [26:0] endpause;
	
	assign endpause = threshold/4;
	
	always @ (posedge clk)
		S<=NS;
		
	always @ (posedge clk)
	begin
		case(speed)
			0: threshold <= 26'd 9999999*2;
			1: threshold <= 26'd 4687500*2;
			2: threshold <= 26'd 4166667*2;
			3: threshold <= 26'd 3750000*2;
			4: threshold <= 26'd 3409091*2;
		endcase
	
		counter <= counter +1;
		if(counter == threshold)
			counter <= 0;
		
		case(S)
			One:
			   if (counter==endpause*3 && speed != 3'd0)
				begin
					NS<=Tick1;
					
				
					
				end
			Tick1:
				if(counter == threshold)
					NS<=Two;
			
			Two:
			if (counter==threshold && speed != 3'd0)
				begin
					NS<=Three;
					
					
					
				end
			Three:
			if (counter==threshold && speed != 3'd0)
				begin
					NS<=Four;
					
					
					
				end
			Four:
			if (counter==threshold && speed != 3'd0)
				begin
					NS<=Five;
					
					
					
				end
			Five:
			if (counter==endpause*3 && speed != 3'd0)
				begin
					NS<=Tick2;
					
					
					
				end
			Tick2:
			if	(counter==threshold)
				NS <= Fourb;
				
				
			Twob:
			if (counter==threshold && speed != 3'd0)
				begin
					NS<=One;
					
				end
			Threeb:
			if (counter==threshold && speed != 3'd0)
				begin
					NS<=Twob;
					
				
				
				end
			Fourb:
			if (counter==threshold && speed != 3'd0)
				begin
					NS<=Threeb;
					
					
					
				end
		endcase
	end
		
		reg [6:0] List1addr;
		reg [6:0] List2addr;
		reg [6:0] List3addr;
		reg [6:0] List4addr;
		reg [6:0] List5addr;
		wire [18:0] Arm1out;
		wire [18:0] Arm2out;
		wire [18:0] Arm3out;
		wire [18:0] Arm4out;
		wire [18:0] Arm5out;
		metronomeArm1_ROM List1(List1addr, clk, Arm1out);
		metronomeArm2_ROM List2(List2addr, clk, Arm2out);
		metronomeArm3_ROM List3(List3addr, clk, Arm3out);
		metronomeArm4_ROM List4(List4addr, clk, Arm4out);
		metronomeArm5_ROM List5(List5addr, clk, Arm5out);
		
		
		
	always @ (posedge clk) begin
		case(S)
			One: 
			begin
				if(VGAaddr == Arm1out)
					begin
						invert_specific <= 1'b1;
						List1addr <= List1addr + 1;
					end
				else
					invert_specific <= 0;
				
				if(List1addr >= 102)
					List1addr <= 0;
					
					Tick <= 1'b0;	
				
			end
			
			Tick1:
				Tick <= 1'b1;
				
			Two:
			begin
				if(VGAaddr == Arm2out)
					begin
						invert_specific <= 1;
						List2addr <= List2addr + 1;
					end
				else
				invert_specific <= 0; 
					
				if(List2addr >= 116)
					List2addr <= 0;
					
				Tick <= 1'b0;	
					
			end
			Three:
			begin
				if(VGAaddr == Arm3out)
					begin
						invert_specific <= 1;
						List3addr <= List3addr + 1;
					end
				else
					 invert_specific <= 0; 
					
				if(List3addr >= 122)
					List3addr <= 0;
				
			
				Tick <= 1'b0;	
	
			end
			Four:
			begin
				if(VGAaddr == Arm4out)
					begin
						invert_specific <= 1;
						List4addr <= List4addr + 1;
					end
				else
					 invert_specific <= 0; 
				
				if(List4addr >= 116)
					List4addr <= 0;
					
				Tick <= 1'b0;	

			end
			Five:
			begin
				if(VGAaddr == Arm5out)
					begin
						invert_specific <= 1;
						List5addr <= List5addr + 1;
					end
				else
					 invert_specific <= 0; 
					
				if(List5addr >= 102)
					List5addr <= 0;
					
				Tick <= 1'b0;
					
			end
			
			Tick2:
				Tick <= 1'b1;
			
			Fourb:
			begin
				if(VGAaddr == Arm4out)
					begin
						invert_specific <= 1;
						List4addr <= List4addr + 1;
					end
				else
					 invert_specific <= 0; 
					
				if(List4addr >= 116)
					List4addr <= 0;
					
				Tick <= 1'b0;	

					
			end
			Threeb:
			begin
				if(VGAaddr == Arm3out)
					begin
						invert_specific <= 1;
						List3addr <= List3addr + 1;
					end
				else
					 invert_specific <= 0; 
					
				if(List3addr >= 122)
					List3addr <= 0;
					
				Tick <= 1'b0;
			end
			Twob:
			begin
				if(VGAaddr == Arm2out)
					begin
						invert_specific <= 1;
						List2addr <= List2addr + 1;
					end
				else
					 invert_specific <= 0; 
					
				if(List4addr >= 116)
					List4addr <= 0;
					
				Tick <= 1'b0;
			end
		endcase
	end
endmodule
			
			
			
			
		