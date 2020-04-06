module MenuStateMachine(
input [7:0] key1_code,
input [17:0] SW, //For debugging purposes
input clk,
output reg [47:0]Xinitial_invert, //[47:36] is the first inverted zone(main buttons), [35:24] for 2nd(demo on/off), [23:12] for 3rd(bpm), [11:0] for 4th (instrument)
output reg [47:0]Xfinal_invert,
output reg [47:0]Yinitial_invert, //[47:36] is the first inverted zone(main buttons), [35:24] for 2nd(demo on/off), [23:12] for 3rd(bpm), [11:0] for 4th (instrument)
output reg [47:0]Yfinal_invert,
output reg selectimage, //0 for main menu, 1 for keys screen
output reg [2:0] metronomespeed,
//output ,//specific addresses to invert for needle
output reg demoenable, //0 for user inputs playing, 1 for demo track playing
output reg instr_select,
output [3:0] Statetracker
);

reg [3:0] S;
reg[3:0] NS;
assign Statetracker = S;
parameter
Start 					= 4'b0000, //***0th State to instantiate the demo/metro OFF button
View_Keys_Highl 		= 4'b1000, 
Display_Keys 			= 4'b0001,
Demo_Highl 				= 4'b0010,
Demo_ON 					= 4'b1010,
Demo_OFF					= 4'b1011,
Select_Instr_Highl 	= 4'b0011,
Instr1					= 4'b1111,
Instr2					= 4'b1001,
Metro_Highl 			= 4'b0100,
Metro_Off 				= 4'b0101,
Metro_80bpm 			= 4'b0110,
Metro_90bpm 			= 4'b0111,
Metro_100bpm 			= 4'b1100,
Metro_110bpm 			= 4'b1101;
//Maybe states for a new screen for instrument selection, maybe display everything in the main menu to save memory/ compile time?


always @(posedge clk) 
S <= NS;

always @(posedge clk) begin
if(SW[3]) NS <= SW[17:14]; //For debugging purposes
else
	case(S)
		Start:				//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			NS<= View_Keys_Highl;
			
		View_Keys_Highl: 	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		begin
			if(key1_code == 8'b01110010) //down arrow
				NS <= Demo_Highl;
			else if(key1_code == 8'h5a) //enter
				NS <= Display_Keys;
		end
		Display_Keys:		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		begin
			if(key1_code == 8'h76) //escape
				NS <= View_Keys_Highl;
		end
		Demo_Highl:			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		begin
			if(key1_code == 8'h72) //down arrow
				NS <= Metro_Highl;
			else if(key1_code == 8'h75) //up arrow
				NS <= View_Keys_Highl;
			else if(key1_code == 8'h5a)
				NS <= demoremember;
		
		end
		Demo_OFF:
		begin
			if(key1_code == 8'h74) //right arrow
				NS <= Demo_ON;
			else if(key1_code == 8'h76) //escape
				NS <= Demo_Highl;
		end
		Demo_ON:
		begin
			if(key1_code == 8'h76) //escape
				NS <= Demo_Highl;
			else if(key1_code == 8'h6b) // left arrow
				NS <= Demo_OFF;
		end
		Metro_Highl:		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		begin
			if(key1_code == 8'h72) //down arrow
				NS <= Select_Instr_Highl;
			else if(key1_code == 8'h75) //up arrow
				NS <= Demo_Highl;
			else if(key1_code == 8'h5a) //enter
				NS <= BPMremember; //Goes to the currently selected option
		end
		Select_Instr_Highl://////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			begin
				if(key1_code == 8'h75) //up arrow
					NS <= Metro_Highl;
				else if(key1_code == 8'h5a) //enter
					NS <= instr_remember;
			end
		Instr1:
		begin
			if(key1_code == 8'h74) //right arrow
				NS <= Instr2;
			else if(key1_code == 8'h76) //escape
				NS <= Select_Instr_Highl;
		end
		Instr2:
		begin
			if(key1_code == 8'h76) //escape
				NS <= Select_Instr_Highl;
			else if(key1_code == 8'h6b) // left arrow
				NS <= Instr1;
		end
		Metro_Off:			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			begin
				if(key1_code == 8'h76) //escape
					NS <= Metro_Highl;
				else if(key1_code == 8'h74) //right arrow
					NS <= Metro_80bpm;
			end
		Metro_80bpm:		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			begin
				if(key1_code == 8'h76) //escape
					NS <= Metro_Highl;
				else if(key1_code == 8'h74) //right arrow
					NS <= Metro_90bpm;
				else if(key1_code == 8'h6b) // left arrow
					NS <= Metro_Off;
			end
		Metro_90bpm:		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			begin
				if(key1_code == 8'h76) //escape
					NS = Metro_Highl;
				else if(key1_code == 8'h74) //right arrow
					NS = Metro_100bpm;
				else if(key1_code == 8'h6b) // left arrow
					NS = Metro_80bpm;
			end
		Metro_100bpm:		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			begin
				if(key1_code == 8'h76) //escape
					NS = Metro_Highl;
				else if(key1_code == 8'h74) //right arrow
					NS = Metro_110bpm;
				else if(key1_code == 8'h6b) // left arrow
					NS = Metro_90bpm;
			end
		Metro_110bpm:		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			begin
				if(key1_code == 8'h76) //escape
					NS = Metro_Highl;
				else if(key1_code == 8'h6b) // left arrow
					NS = Metro_100bpm;
			end
endcase
end


reg [3:0] BPMremember;
reg [3:0] demoremember;
reg [3:0] instr_remember;

always@(posedge clk) begin //behavior
case(S)
		Start:
			begin
				Xinitial_invert[35:24] <= 12'd183;//DemoOFF
				Xfinal_invert[35:24] <=	  12'd229;//DemoOFF
				Yinitial_invert[35:24] <= 12'd156;//DemoOFF
				Yfinal_invert[35:24] <=	  12'd183;//DemoOFF
				Xinitial_invert[23:12] <= 12'd175;//bpmOFF
				Xfinal_invert[23:12] <=	  12'd221;//bpmOFF
				Yinitial_invert[23:12] <= 12'd283;//bpmOFF
				Yfinal_invert[23:12] <=	  12'd310;//bpmOFF
				Xinitial_invert[11:0] <=	12'd285; //Default instrument
				Xfinal_invert[11:0] <= 		12'd322; //Default instrument
				Yinitial_invert[11:0] <= 	12'd409; //Default instrument
				Yfinal_invert[11:0] <=		12'd433; //Default instrument
				demoenable <= 1'b0;
				demoremember <= Demo_OFF;
				instr_remember <= Instr1;
				BPMremember <= Metro_Off;
				instr_select <= 1'b0;
				
			end
		View_Keys_Highl:
			begin
				selectimage <= 0;
				Xinitial_invert[47:36] <= 12'd30;
				Xfinal_invert[47:36] <=	  12'd152;
				Yinitial_invert[47:36] <= 12'd43;
				Yfinal_invert[47:36] <=	  12'd69;
			end
		Display_Keys:
			selectimage = 1;
		Demo_Highl:
			begin
				selectimage <= 0;
				Xinitial_invert[47:36] <= 12'd30;
				Xfinal_invert[47:36] <= 12'd164;
				Yinitial_invert[47:36] <= 12'd156;
				Yfinal_invert[47:36] <=12'd183;
	/*			
				if(key1_code == 8'h5a)
					demoflag <= ~demoflag;
				if(!demoflag)
					begin
					Xinitial_invert[35:24] <= 12'd183;//DemoOFF
					Xfinal_invert[35:24] <=	  12'd229;//DemoOFF
					Yinitial_invert[35:24] <= 12'd156;//DemoOFF
					Yfinal_invert[35:24] <=	  12'd183;//DemoOFF
					demoenable <= 1'b0; //turn off demo
					end
				else
					begin
					Xinitial_invert[35:24] <= 12'd235;
					Xfinal_invert[35:24] <=	  12'd267;
					Yinitial_invert[35:24] <= 12'd156;
					Yfinal_invert[35:24] <=	  12'd183;
					demoenable = 1'b1; //Turn on demo
					end */
			end
		Demo_OFF:
			begin
				selectimage <= 0;
				
				Xinitial_invert[47:36] <= 12'd0; //De-highlight Demo_Highl
				Xfinal_invert[47:36] <= 12'd0;
				Yinitial_invert[47:36] <= 12'd0;
				Yfinal_invert[47:36] <=12'd0;
				
				Xinitial_invert[35:24] <= 12'd183;//DemoOFF
				Xfinal_invert[35:24] <=	  12'd229;//DemoOFF
				Yinitial_invert[35:24] <= 12'd156;//DemoOFF
				Yfinal_invert[35:24] <=	  12'd183;//DemoOFF
				demoenable <= 1'b0; //turn off demo
				
				demoremember = Demo_OFF;
				
			end
		Demo_ON:
			begin
				selectimage <= 0;
				
				Xinitial_invert[47:36] <= 12'd0; //De-highlight Demo_Highl
				Xfinal_invert[47:36] <= 12'd0;
				Yinitial_invert[47:36] <= 12'd0;
				Yfinal_invert[47:36] <=12'd0;
				
				Xinitial_invert[35:24] <= 12'd235;
				Xfinal_invert[35:24] <=	  12'd267;
				Yinitial_invert[35:24] <= 12'd156;
				Yfinal_invert[35:24] <=	  12'd183;
				demoenable = 1'b1; //Turn on demo
				
				
				demoremember = Demo_ON;
			end
		Metro_Highl:
			begin
				selectimage <= 0;
				Xinitial_invert[47:36] <= 12'd30;
				Xfinal_invert[47:36] <=12'd153;
				Yinitial_invert[47:36] <=12'd283;
				Yfinal_invert[47:36] <=12'd310;
			end
		Select_Instr_Highl:
			begin
				selectimage <= 0;
				Xinitial_invert[47:36] <= 12'd30;
				Xfinal_invert[47:36] <=12'd258;
				Yinitial_invert[47:36] <=12'd407;
				Yfinal_invert[47:36] <=12'd434;
				
				
/*				if(key1_code == 8'h5a)
					instrflag = ~instrflag;
				if(!instrflag)
					begin
					Xinitial_invert[11:0] <= 12'd285;
					Xfinal_invert[11:0] <= 12'd322;
					Yinitial_invert[11:0] <= 12'd409;
					Yfinal_invert[11:0] <= 12'd433;
					
					instr_select <= 1'b0;
					end
				else
					begin
					Xinitial_invert[11:0] <= 12'd340;
					Xfinal_invert[11:0] <= 12'd369;
					Yinitial_invert[11:0] <= 12'd407;
					Yfinal_invert[11:0] <= 12'd433;
					
					instr_select <= 1'b1;
					end*/
			end
		Instr1:
		begin
			selectimage <= 0;
			
			instr_remember <= Instr1;
			
			instr_select <= 1'b0;
			
			Xinitial_invert[47:36] <= 12'd0;
			Xfinal_invert[47:36] <=12'd0;
			Yinitial_invert[47:36] <=12'd0;
			Yfinal_invert[47:36] <=12'd0;
			
			Xinitial_invert[11:0] <= 12'd285;
			Xfinal_invert[11:0] <= 12'd322;
			Yinitial_invert[11:0] <= 12'd409;
			Yfinal_invert[11:0] <= 12'd433;
			
			
		end
		Instr2:
		begin
			selectimage <= 0;
			
			instr_remember <= Instr2;
			
			instr_select <= 1'b1;
			
			Xinitial_invert[47:36] <= 12'd0;
			Xfinal_invert[47:36] <=12'd0;
			Yinitial_invert[47:36] <=12'd0;
			Yfinal_invert[47:36] <=12'd0;
			
			Xinitial_invert[11:0] <= 12'd340;
			Xfinal_invert[11:0] <= 12'd369;
			Yinitial_invert[11:0] <= 12'd407;
			Yfinal_invert[11:0] <= 12'd433;
			
			
		end
		Metro_Off:
			begin
				selectimage <= 0;
				
				BPMremember <= Metro_Off;
				
				Xinitial_invert[47:36] <= 12'd0;
				Xfinal_invert[47:36] <=12'd0;
				Yinitial_invert[47:36] <=12'd0;
				Yfinal_invert[47:36] <=12'd0;
				
				Xinitial_invert[23:12] <= 12'd175;//bpmOFF
				Xfinal_invert[23:12] <=	  12'd221;//bpmOFF
				Yinitial_invert[23:12] <= 12'd283;//bpmOFF
				Yfinal_invert[23:12] <=	  12'd310;//bpmOFF
				
				metronomespeed <= 3'd0;
			end
		Metro_80bpm:
			begin
				selectimage <= 0;
				
				BPMremember <= Metro_80bpm;
				
				Xinitial_invert[47:36] 	<=12'd0;
				Xfinal_invert[47:36] 	<=12'd0;
				Yinitial_invert[47:36] 	<=12'd0;
				Yfinal_invert[47:36] 	<=12'd0;
				
				Xinitial_invert[23:12] 	<= 12'd222;
				Xfinal_invert[23:12] 	<= 12'd274;
				Yinitial_invert[23:12] 	<= 12'd283;
				Yfinal_invert[23:12] 	<=	12'd310;
				
				metronomespeed <= 3'd1;
			end
		Metro_90bpm:
			begin
				selectimage <= 0;
				
				BPMremember <= Metro_90bpm;
				
				Xinitial_invert[47:36] 	<= 12'd0;
				Xfinal_invert[47:36] 	<= 12'd0;
				Yinitial_invert[47:36] 	<= 12'd0;
				Yfinal_invert[47:36] 	<= 12'd0;
				
				Xinitial_invert[23:12] 	<= 12'd275;
				Xfinal_invert[23:12] 	<= 12'd327;
				Yinitial_invert[23:12] 	<= 12'd283;
				Yfinal_invert[23:12] 	<= 12'd310;
				
				metronomespeed <= 3'd2;
			end
		Metro_100bpm:
			begin
				selectimage <= 0;
				
				BPMremember <= Metro_100bpm;
				
				Xinitial_invert[47:36] 	<= 12'd0;
				Xfinal_invert[47:36] 	<= 12'd0;
				Yinitial_invert[47:36] 	<= 12'd0;
				Yfinal_invert[47:36] 	<= 12'd0;
				
				Xinitial_invert[23:12] 	<= 12'd328;
				Xfinal_invert[23:12] 	<= 12'd390;
				Yinitial_invert[23:12] 	<= 12'd283;
				Yfinal_invert[23:12] 	<=	12'd310;
				
				metronomespeed <= 3'd3;
			end
		Metro_110bpm:
			begin
				selectimage <= 0;
				
				BPMremember <= Metro_110bpm;
				
				Xinitial_invert[47:36] 	<= 12'd0;
				Xfinal_invert[47:36] 	<= 12'd0;
				Yinitial_invert[47:36] 	<= 12'd0;
				Yfinal_invert[47:36] 	<= 12'd0;
				
				Xinitial_invert[23:12] 	<= 12'd391;
				Xfinal_invert[23:12] 	<= 12'd450;
				Yinitial_invert[23:12] 	<= 12'd283;
				Yfinal_invert[23:12] 	<=	12'd310;
				
				metronomespeed <= 3'd4;
			end								
	

endcase






end
		
endmodule
