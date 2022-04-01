`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: U202013828
// Engineer: Chen Peng
// 
// Create Date:    18:36:06 03/29/2022 
// Design Name: 
// Module Name:    counter24 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module counter24(
    input CP,
    input reset,
    input EN,
	 input mode,
	 input increUnit,
	 input increTen,
    output [5:0] mCnt,
	 output wire[5:0] x, // BCD of hour to be reported.
	 output noon // imply morning or afternoon
    );
	 
	//temporal variable 
	reg[5:0] mCnt_t;
   reg noon_t;	
	
	wire[5:0] cnt; 
	assign x = cnt[5:4] * 4'b1010 + {2'b00, cnt[3:0]};
	
	always @(*) begin
			if(mode == 1'b1) //24h
				begin
					mCnt_t = cnt;
					noon_t = 1'b0;
				end	
			else //12h
				begin
					//convert 24h to 12h
					if(x <= 6'b001100) mCnt_t = cnt; //0a.m. ~ 12a.m.
					else if(x <= 6'b010101) mCnt_t = x - 6'b001100; //1p.m. ~ 9p.m.
					else if(x == 6'b010110) mCnt_t = 6'b010000; //10p.m.
					else mCnt_t = 6'b010001; //11p.m.
					noon_t = (x > 6'b001100);
				end
	end
	assign mCnt = mCnt_t;
	assign noon = noon_t;
		
	wire ENP;
	wire ENL;
	counter10_vari UC0 (.Q(cnt[3:0]), .reset(reset), .EN(EN), .incre(increUnit), .CP(CP), .ENL(ENL));
	counter3 UC1 (.Q(cnt[5:4]), .reset(reset), .EN(ENP), .incre(increTen), .CP(CP));
	assign ENP = (ENL && EN);
endmodule
