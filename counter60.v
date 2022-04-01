`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: U202013828
// Engineer: Chen Peng
// 
// Create Date:    16:38:26 03/26/2022 
// Design Name: 
// Module Name:    counter60 
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
module counter60(
    input CP,
    input reset,
    input EN,
	 input increUnit, //高位有效
	 input increTen, //高位有效
    output [7:0] cnt,
	 output ENT
    );

	wire ENP;
	counter10 UC0 (.Q(cnt[3:0]), .reset(reset), .EN(EN), .incre(increUnit), .CP(CP));
	counter6 UC1 (.Q(cnt[7:4]), .reset(reset), .EN(ENP), .incre(increTen), .CP(CP));
	assign ENP = (cnt[3:0] == 4'h9 && EN); //这是自然计数产生的使能。还需要新增一个由手动增减产生的使能
	assign ENT = (cnt[7:4] == 4'b0101 && cnt[3:0] == 4'b1001); 
endmodule
