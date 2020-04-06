module staff(
	input VGA_CLK,
	input CLK_50,
	input [7:0] key1_code,
	input [17:0] SW, //For debugging purposes
	input [7:0]scan_code1,
	input [7:0]scan_code2,
	input [7:0]scan_code3,
	output vga_sync,	
	output vga_h_sync,
	output vga_v_sync,
	output inDisplayArea,	
	output wire vga_R,
	output wire vga_G, 
	output wire vga_B,
	output [15:0]sound1,
	output [15:0]sound2,
	output [15:0]sound3,
	output sound_off1,
	output sound_off2,
	output sound_off3,
	output [3:0] Statetracker,
	output demoenable,
	output instr_select,
	output tick
);
	assign  vga_sync=1;	

//////SoundOff Key///////
	assign sound_off1=(scan_code1==8'hf0)?0:1;
	assign sound_off2=(scan_code2==8'hf0)?0:1;
	assign sound_off3=tick;

///////640X480 VGA-Timing-generater///////

	wire [11:0] CounterX;
	wire [11:0] CounterY;
	vga_time_generator vga0(
		.pixel_clk(VGA_CLK),
		.h_disp   (640),
		.h_fporch (16),
		.h_sync   (96), 
		.h_bporch (48),
		.v_disp   (480),
		.v_fporch (10),
		.v_sync   (2),
		.v_bporch (33),
		.vga_hs   (vga_h_sync),
		.vga_vs   (vga_v_sync),
		.vga_blank(inDisplayArea),
		.CounterY(CounterY),
		.CounterX(CounterX) 
	);

/////////Channel-1 Trigger////////
	wire L_5_tr=(scan_code1==8'h1c)?1:0;//-5
	wire L_6_tr=(scan_code1==8'h1b)?1:0;//-6		
	wire L_7_tr=(scan_code1==8'h23)?1:0;//-7		
	wire M_1_tr=(scan_code1==8'h2b)?1:0;//1		
	wire M_2_tr=(scan_code1==8'h34)?1:0;//2		
	wire M_3_tr=(scan_code1==8'h33)?1:0;//3		
	wire M_4_tr=(scan_code1==8'h3b)?1:0;//4		
	wire M_5_tr=(scan_code1==8'h42)?1:0;//5		
	wire M_6_tr=(scan_code1==8'h4b)?1:0;//6		
	wire M_7_tr=(scan_code1==8'h4c)?1:0;//7		
	wire H_1_tr=(scan_code1==8'h52)?1:0;//+1		
	wire H_2_tr=0;//+2
	wire H_3_tr=0;//+3
	wire H_4_tr=0;//+4
	wire H_5_tr=0;//+5
	wire Hu4_tr=0;//((!get_gate) && (scan_code==8'h15))?1:0;//+#4
	wire Hu2_tr=0;//((!get_gate) && (scan_code==8'h1d))?1:0;//+#2
	wire Hu1_tr=(scan_code1==8'h5b)?1:0;//+#1
	wire Mu6_tr=(scan_code1==8'h4d)?1:0;//#6
	wire Mu5_tr=(scan_code1==8'h44)?1:0;//#5
	wire Mu4_tr=(scan_code1==8'h43)?1:0;//#4
	wire Mu2_tr=(scan_code1==8'h35)?1:0;//#2
	wire Mu1_tr=(scan_code1==8'h2c)?1:0;//#1
	wire Lu6_tr=(scan_code1==8'h24)?1:0;//-#6
	wire Lu5_tr=(scan_code1==8'h1d)?1:0;//-#5
	wire Lu4_tr=(scan_code1==8'h15)?1:0;//-#4

	assign sound1=(    //channel-1 frequency
		(Lu4_tr)?400  :(
		(L_5_tr)?423  :(
		(Lu5_tr)?448  :(
		(L_6_tr)?475  :(
		(Lu6_tr)?503  :(
		(L_7_tr)?533  :(
		(M_1_tr)?565  :(
		(Mu1_tr)?599  :(
		(M_2_tr)?634  :(
		(Mu2_tr)?672  :(
		(M_3_tr)?712  :(
		(M_4_tr)?755  :(
		(Mu4_tr)?800  :(
		(M_5_tr)?847  :(
		(Mu5_tr)?897  :(
		(M_6_tr)?951  :(
		(Mu6_tr)?1007 :(
		(M_7_tr)?1067 :(
		(H_1_tr)?1131 :(
		(Hu1_tr)?1198 :1
		)))))))))))))))))))
	);

/////////Channel-2 Trigger////////
	wire L2_5_tr=(scan_code2==8'h1c)?1:0;//-5
	wire L2_6_tr=(scan_code2==8'h1b)?1:0;//-6		
	wire L2_7_tr=(scan_code2==8'h23)?1:0;//-7		
	wire M2_1_tr=(scan_code2==8'h2b)?1:0;//1		
	wire M2_2_tr=(scan_code2==8'h34)?1:0;//2		
	wire M2_3_tr=(scan_code2==8'h33)?1:0;//3		
	wire M2_4_tr=(scan_code2==8'h3b)?1:0;//4		
	wire M2_5_tr=(scan_code2==8'h42)?1:0;//5		
	wire M2_6_tr=(scan_code2==8'h4b)?1:0;//6		
	wire M2_7_tr=(scan_code2==8'h4c)?1:0;//7		
	wire H2_1_tr=(scan_code2==8'h52)?1:0;//+1		
	wire H2_2_tr=0;//+2
	wire H2_3_tr=0;//+3
	wire H2_4_tr=0;//+4
	wire H2_5_tr=0;//+5
	wire H2u4_tr=0;//((!get_gate) && (scan_code==8'h15))?1:0;//+#4
	wire H2u2_tr=0;//((!get_gate) && (scan_code==8'h1d))?1:0;//+#2
	wire H2u1_tr=(scan_code2==8'h5b)?1:0;//+#1
	wire M2u6_tr=(scan_code2==8'h4d)?1:0;//#6
	wire M2u5_tr=(scan_code2==8'h44)?1:0;//#5
	wire M2u4_tr=(scan_code2==8'h43)?1:0;//#4
	wire M2u2_tr=(scan_code2==8'h35)?1:0;//#2
	wire M2u1_tr=(scan_code2==8'h2c)?1:0;//#1
	wire L2u6_tr=(scan_code2==8'h24)?1:0;//-#6
	wire L2u5_tr=(scan_code2==8'h1d)?1:0;//-#5
	wire L2u4_tr=(scan_code2==8'h15)?1:0;//-#4

	assign sound2=(     //channel-2 frequency
		(L2u4_tr)?400  :(
		(L2_5_tr)?423  :(
		(L2u5_tr)?448  :(
		(L2_6_tr)?475  :(
		(L2u6_tr)?503  :(
		(L2_7_tr)?533  :(
		(M2_1_tr)?565  :(
		(M2u1_tr)?599  :(
		(M2_2_tr)?634  :(
		(M2u2_tr)?672  :(
		(M2_3_tr)?712  :(
		(M2_4_tr)?755  :(
		(M2u4_tr)?800  :(
		(M2_5_tr)?847  :(
		(M2u5_tr)?897  :(
		(M2_6_tr)?951  :(
		(M2u6_tr)?1007 :(
		(M2_7_tr)?1067 :(
		(H2_1_tr)?1131 :(
		(H2u1_tr)?1198 :1
		)))))))))))))))))))
	);

	assign sound3 = 599;

///////////White Key///////////
	wire L_5;
	wire L_6;
	wire L_7;
	wire M_1;
	wire M_2;
	wire M_3;
	wire M_4;
	wire M_5;
	wire M_6;
	wire M_7;
	wire H_1;
	wire H_2;
	wire H_3;
	wire H_4;
	wire H_5;
	bar_white bar1(
 		.CounterY(CounterY),
 		.L_5(L_5),
 		.L_6(L_6),
 		.L_7(L_7),
 		.M_1(M_1),
 		.M_2(M_2),
 		.M_3(M_3),
 		.M_4(M_4),
 		.M_5(M_5),
 		.M_6(M_6),
 		.M_7(M_7),
 		.H_1(H_1),
 		.H_2(H_2),
 		.H_3(H_3),
 		.H_4(H_4),
 		.H_5(H_5)
	);
	wire [11:0]ydeta=30;
	wire [11:0]yd_t =ydeta+2;
	wire [11:0]y_org=(
		(H_5)?yd_t*0:( //+5
		(H_4)?yd_t*1:( //+4
		(H_3)?yd_t*2:( //+3
		(H_2)?yd_t*3:( //+2
		(H_1)?yd_t*4:( //+1
		(M_7)?yd_t*5:( //7
		(M_6)?yd_t*6:( //6
		(M_5)?yd_t*7:( //5
		(M_4)?yd_t*8:( //4
		(M_3)?yd_t*9:( //3
		(M_2)?yd_t*10:(//2
		(M_1)?yd_t*11:(//1
		(L_7)?yd_t*12:(//-7
		(L_6)?yd_t*13:(//-6
		(L_5)?yd_t*14:yd_t*14//-5		
		))))))))))))))
	);

/////////White-key play////////
	wire [11:0]white_x=(
		((L2_5_tr|L_5_tr)&&(L_5))?110:(
		((L2_6_tr|L_6_tr)&&(L_6))?110:(
		((L2_7_tr|L_7_tr)&&(L_7))?110:(
		((M2_1_tr|M_1_tr)&&(M_1))?110:(
		((M2_2_tr|M_2_tr)&&(M_2))?110:(
		((M2_3_tr|M_3_tr)&&(M_3))?110:(
		((M2_4_tr|M_4_tr)&&(M_4))?110:(
		((M2_5_tr|M_5_tr)&&(M_5))?110:(
		((M2_6_tr|M_6_tr)&&(M_6))?110:(
		((M2_7_tr|M_7_tr)&&(M_7))?110:(
		((H2_1_tr|H_1_tr)&&(H_1))?110:(
		((H2_2_tr|H_2_tr)&&(H_2))?110:(
		((H2_3_tr|H_3_tr)&&(H_3))?110:(
		((H2_4_tr|H_4_tr)&&(H_4))?110:(	
		((H2_5_tr|H_5_tr)&&(H_5))?110:100
		))))))))))))))
	);	

////////White-key display//////				
	wire white_bar;
	bar_big b0(
		.org_y(y_org),
		.bar_space(white_bar),
		.org_x(0),
		.x(CounterX),
		.y(CounterY),
		.line_x(white_x),
		.line_y(ydeta)
	);


////////Blank key/////////
	wire Hu4;
	wire Hu2;
	wire Hu1;
	wire Mu6;
	wire Mu5;
	wire Mu4;
	wire Mu2;
	wire Mu1;
	wire Lu6;
	wire Lu5;
	wire Lu4;
	bar_blank bar_blank1(
		.CounterY(CounterY),
		.Hu4(Hu4),
		.Hu2(Hu2),
		.Hu1(Hu1),
		.Mu6(Mu6),
		.Mu5(Mu5),
		.Mu4(Mu4),
		.Mu2(Mu2),
		.Mu1(Mu1),
		.Lu6(Lu6),
		.Lu5(Lu5),
		.Lu4(Lu4)
	);
	wire [11:0]bydeta=30;
	wire [11:0]byd_t =bydeta+2;
	wire [11:0]by_org=(
		(Hu4)?15+byd_t*0:( //+5
		(Hu2)?15+byd_t*2:( //+3
		(Hu1)?15+byd_t*3:( //+2
		(Mu6)?15+byd_t*5:( //7
		(Mu5)?15+byd_t*6:( //6
		(Mu4)?15+byd_t*7:( //5
		(Mu2)?15+byd_t*9:( //3
		(Mu1)?15+byd_t*10:(//2
		(Lu6)?15+byd_t*12:(//-7
		(Lu5)?15+byd_t*13:(//-6
		(Lu4)?15+byd_t*14:15+byd_t*14//-5
		))))))))))
		);
		
/////////Blank-key play////////
	wire [11:0] blank_x	=(
		((H2u4_tr|Hu4_tr)&&(Hu4))?60:(
		((H2u2_tr|Hu2_tr)&&(Hu2))?60:(		
		((H2u1_tr|Hu1_tr)&&(Hu1))?60:(		
		((M2u6_tr|Mu6_tr)&&(Mu6))?60:(		
		((M2u5_tr|Mu5_tr)&&(Mu5))?60:(		
		((M2u4_tr|Mu4_tr)&&(Mu4))?60:(		
		((M2u2_tr|Mu2_tr)&&(Mu2))?60:(		
		((M2u1_tr|Mu1_tr)&&(Mu1))?60:(		
		((L2u6_tr|Lu6_tr)&&(Lu6))?60:(		
		((L2u5_tr|Lu5_tr)&&(Lu5))?60:(		
		((L2u4_tr|Lu4_tr)&&(Lu4))?60:50
		))))))))))
	);	
			
////////Blank-key display//////
	wire blank_bar;
	bar_big b2(
		.org_y(by_org),
		.bar_space(blank_bar),
		.org_x(0),
		.x(CounterX),
		.y(CounterY),
		.line_x(blank_x),
		.line_y(ydeta)
	);

/////////VGA data out///////
/*Piano Bars                            ///This is now implemented below
wire bar_key =~blank_bar &  white_bar;       
	assign	vga_R = bar_key & inDisplayArea;
	assign	vga_G = bar_key & inDisplayArea;
	assign	vga_B = bar_key & inDisplayArea;*/
	
	
	
	
	//Attempt 1 **FAILURE**

//assign addr = 16'd1;
/*
reg [4:0] miniaddr;
always @(posedge VGA_CLK)
 begin
	if(inDisplayArea)    miniaddr <= miniaddr + 1;
	if(miniaddr<=5'd4)
		begin
			miniaddr <= 5'd0;
			addr <= addr+1;
		end
	if(addr>=16'd61439) addr<= 16'd0;
	qo <= q[miniaddr];
end*/
		
		

		
//Attempt 2
MenuStateMachine Menu(
			.key1_code 			(key1_code),
			.clk					(Clockreg[20]),
			.SW					(SW),
			.Xinitial_invert  (Xinitial_invert),
			.Xfinal_invert		(Xfinal_invert),
			.Yinitial_invert	(Yinitial_invert),
			.Yfinal_invert		(Yfinal_invert),
			.selectimage		(selectimage),
			.metronomespeed 	(metronomespeed), //0 = off, 1 = 80, 2 = 90, etc
			.demoenable			(demoenable),
			.instr_select 		(instr_select),
			.Statetracker		(Statetracker),
			);
MetronomeFSM needle(
			.VGAaddr 				(addr),
			.clk					(CLK_50),
			.Tick					(tick),
			.speed 				(metronomespeed),
			.invert_specific 	(invert_flag),
			);
			
			

single_port_rom rom2(addr, VGA_CLK, qo);
	always @(posedge VGA_CLK)
 begin
	
	if(inDisplayArea)    addr <= addr + 1;
	if(addr>=19'd307199) addr<= 16'd0;
	//if((30 < CounterX) &&( 146 > CounterX)&&(44 < CounterY)&&(69 > CounterY))  final <= ~qo; //Dummy test
	if((Xinitial_invert[47:36] < CounterX) &&( Xfinal_invert[47:36] > CounterX)&&(Yinitial_invert[47:36] < CounterY)&&(Yfinal_invert[47:36] > CounterY))  final <= ~qo; //Check for 1st inversion zone, X/Y initial/final come from MenuStateMachine
	else if((Xinitial_invert[35:24] < CounterX) &&( Xfinal_invert[35:24]> CounterX)&&(Yinitial_invert[35:24] < CounterY)&&(Yfinal_invert[35:24] > CounterY))  final <= ~qo; //Check for 2nd inversion zone
	else if((Xinitial_invert[23:12] < CounterX) &&( Xfinal_invert[23:12]> CounterX)&&(Yinitial_invert[23:12] < CounterY)&&(Yfinal_invert[23:12] > CounterY))  final <= ~qo;   //Check for 3rd inversion zone
	else if((Xinitial_invert[11:0] < CounterX) &&( Xfinal_invert[11:0]> CounterX)&&(Yinitial_invert[11:0] < CounterY)&&(Yfinal_invert[11:0] > CounterY))  final <= ~qo;		   //Check for 4th inversion zone
		else final <= qo;
	
	
	if(invert_flag) //for metronome
		final <= ~final;
	
 end
reg [18:0] addr;
wire qo;
reg final;
wire invert_flag;
wire [47:0]Xinitial_invert;	//[47:36] is the first inverted zone(main buttons), [35:24] for 2nd(demo on/off), [23:12] for 3rd(bpm), [11:0] for 4th (instrument)
wire [47:0]Xfinal_invert;
wire [47:0]Yinitial_invert;
wire [47:0]Yfinal_invert;
wire [2:0] metronomespeed;
wire selectimage;
wire bar_key =~blank_bar &  white_bar;
reg  [31:0] Clockreg;
always @( posedge VGA_CLK )
		begin
			Clockreg <= Clockreg + 1;
		end

		
		
		
		
		assign vga_R = (selectimage) ? (bar_key & inDisplayArea) : final;
		assign vga_G = (selectimage) ? (bar_key & inDisplayArea) : final;
		assign vga_B = (selectimage) ? (bar_key & inDisplayArea) : final;
endmodule