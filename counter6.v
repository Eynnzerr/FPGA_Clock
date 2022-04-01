`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: U202013828
// Engineer: Eynnzerr
// 
// Create Date:    21:25:11 03/25/2022 
// Design Name: 
// Module Name:    counter6 
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
module counter6(
    input CP,
    input reset,
    input EN,
	 input incre,
    output reg [3:0] Q
    );

	always @(posedge CP or negedge reset)
		begin
			if(~reset)
				Q <= 4'b0000;
			else if(incre)
				begin
					if(Q == 4'b0101) Q <= 4'b0000;
					else Q <= Q + 4'b0001;
				end	
			else if(~EN)	
				Q <= Q;
			else if(Q == 4'b0101)
				Q <= 4'b0000;
			else
				Q <= Q + 4'b0001;
		end		
endmodule
