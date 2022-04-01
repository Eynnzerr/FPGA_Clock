`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: U202013828
// Engineer: Chen Peng
// 
// Create Date:    19:05:29 03/29/2022 
// Design Name: 
// Module Name:    counter3 
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
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:34:22 03/29/2022 
// Design Name: 
// Module Name:    counter4 
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
module counter3(
    input CP,
    input reset,
    input EN,
	 input incre,
    output reg [1:0] Q
    );

	always @(posedge CP or negedge reset)
		begin
			if(~reset)
				Q <= 2'b00;
			else if(incre)	
				begin
					if(Q == 2'b10) Q <= 2'b00;
					else Q <= Q + 2'b01;
				end	
			else if(~EN)	
				Q <= Q;
			else if(Q == 2'b10)
				Q <= 2'b00;
			else
				Q <= Q + 2'b01;
		end		
endmodule
