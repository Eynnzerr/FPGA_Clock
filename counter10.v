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
	
	//һ��reg����ֻ����һ��always���б���ֵ��������������ð�գ������޷�ͨ���ۺ�
	//��ise�ۺϲ�����һ��always���е�һ��reg������ͨ����������ظ�ֵ������
	//ϣ��ʵ�ֵ�Ч��������ť���Ӽ�ʱ���Ҳ����ܵ�ʱ�Ӹ��� ����������
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
