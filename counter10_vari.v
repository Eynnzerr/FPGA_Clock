`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: U202013828
// Engineer: Chen Peng
// 
// Create Date:    18:46:24 03/29/2022 
// Design Name: 
// Module Name:    counter10_vari 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: Special 10-mode counter intended for 24-hour counter.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module counter10_vari(
    input CP,
    input reset,
    input EN,
	 input incre,
    output reg[3:0] Q,
	 output ENL
    );
	
	reg ENL_t;
	reg[1:0] tenCounter;
	initial
		tenCounter = 2'b00;
		
	always @(posedge CP or negedge reset)
		begin
			if(~reset)
				Q <= 4'b0000;
			else if(incre)	
				begin
					if(Q == 4'b1001 || (tenCounter == 2'b10 && Q == 4'b0011))
						begin
							ENL_t <= 1'b1;
							Q <= 4'b0000;
							if(tenCounter == 2'b10) tenCounter <= 2'b00;
							else tenCounter <= tenCounter + 2'b01;
						end	
					else 
						begin
							ENL_t <= 1'b0;
							Q <= Q + 4'b0001;
						end	
				end	
			else if(~EN)	
				Q <= Q;
			else if(Q == 4'b1001 || (tenCounter == 2'b10 && Q == 4'b0011)) // reset to zero when meeting 10:00, 20:00, 24:00
				begin
					ENL_t <= 1'b1;
					Q <= 4'b0000;
					if(tenCounter == 2'b10) tenCounter <= 2'b00;
					else tenCounter <= tenCounter + 2'b01;
				end	
			else 
				begin
					ENL_t <= 1'b0;
					Q <= Q + 4'b0001;	
				end	
		end	
			
	assign ENL = ENL_t;		
endmodule
