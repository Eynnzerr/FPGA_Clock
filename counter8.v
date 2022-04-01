`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: U202013828
// Engineer: Chen Peng
// 
// Create Date:    17:39:50 03/26/2022 
// Design Name: 
// Module Name:    counter8 
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
module counter8(
    input CP,
    input reset,
    input EN,
    output reg[2:0] Q
    );

	always @(posedge CP or negedge reset)
		begin
			if(~reset)
				Q <= 3'b000;
			else if(~EN)	
				Q <= Q;
			else if(Q == 3'b111)
				Q <= 3'b000;
			else
				Q <= Q + 3'b001;
		end		
endmodule
