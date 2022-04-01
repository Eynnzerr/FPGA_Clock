`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: U202013828
// Engineer: Chen Peng
// 
// Create Date:    17:21:14 03/26/2022 
// Design Name: 
// Module Name:    freq_divider 
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
module freq_divider(
	input clk_100M,
	output reg clk_1hz, 
	output reg clk_1khz
	);
	
	reg [16:0] count1;
	reg [9:0] count2;
	initial 
		begin
			count1 = 0;
			count2 = 0;
			clk_1khz = 0;
			clk_1hz = 0;
		end

	//100M分频得到1khz
	always@(posedge clk_100M)
		begin
			if(count1 == 17'd49999)
				begin
					clk_1khz <= ~clk_1khz;
					count1 <= 0;
				end
			else count1 <= count1 + 17'd1;
		end
	
	//1khz分频得到1hz
	always@(posedge clk_1khz)
		begin
			if(count2 == 10'd499)
				begin
					clk_1hz <= ~clk_1hz;
					count2 <= 0;
				end
			else count2 <= count2 + 10'd1;
		end
endmodule
