`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: U202013828
// Engineer: Chen Peng
// 
// Create Date:    21:29:13 03/25/2022 
// Design Name: 
// Module Name:    counter10 
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
module counter10(
    input CP,
    input reset,
    input EN,
	 input incre,
    output reg[3:0] Q
    );			
	
	//一个reg变量只能在一个always块中被赋值，否则会产生竞争冒险，并且无法通过综合
	//且ise综合不允许一个always块中的一个reg变量被通过多个触发沿赋值？？？
	//希望实现的效果：按按钮来加减时间且不会受到时钟干扰 做不到阿？
	always @(posedge CP or negedge reset)
		begin
			if(~reset)
				Q <= 4'b0000;
			else if(incre)	
				begin
					if(Q == 4'b1001) Q <= 4'b0000;
					else Q <= Q + 4'b0001;
				end	
			else if(~EN)	
				Q <= Q;	
			else if(Q == 4'b1001)
				Q <= 4'b0000;
			else
				Q <= Q + 4'b0001;
		end
endmodule
