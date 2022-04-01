`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: U202013828
// Engineer: Chen Peng
// 
// Create Date:    21:10:30 03/25/2022 
// Design Name: 
// Module Name:    dateClock 
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
module dateClock(
    input clk,
	 input reset,
	 input EN,
	 input mode,
	 input increMinUnit,
	 input increMinTen,
	 input increHourUnit,
	 input increHourTen,
	 output [7:0] segO,
    output [7:0] bitO,
	 output noon,
	 output hourReport
    );
	
	/*parameter DURATION = 50_000;
	wire key_enable;
	assign key_enable = increMinUnit | increMinTen | increHourUnit | increHourTen;
	reg[15:0] cnt;
	reg[3:0] key_en;*/
	
	/*always @(posedge clk or negedge reset)
	begin
		if(!reset)
			cnt <= 16'b0;
		else if(key_enable == 1) begin
			if(cnt == DURATION)
				cnt <= cnt;
			else 
				cnt <= cnt + 16'b1;
			end
		else
			cnt <= 16'b0;
	end
	
	always @(posedge clk or negedge reset) 
	begin
		if(!reset) key_en <= 4'd0;
		else if(increMinUnit) key_en[0] <= (cnt == DURATION-1'b1) ? 1'b1 : 1'b0;
		else if(increMinTen) key_en[1] <= (cnt == DURATION-1'b1) ? 1'b1 : 1'b0;
		else if(increHourUnit) key_en[2] <= (cnt == DURATION-1'b1) ? 1'b1 : 1'b0;
		else if(increHourTen) key_en[3] <= (cnt == DURATION-1'b1) ? 1'b1 : 1'b0;
		else key_en <= key_en;
	end*/
	
	wire clk_1hz, clk_1khz;
	freq_divider divider(clk, clk_1hz, clk_1khz);

	segSelector selector(
		.CP_1kHz(clk_1khz),
		.CP_1Hz(clk_1hz),
		.reset(~reset),
		.mode(mode),
		.increMinUnit(increMinUnit),
		.increMinTen(increMinTen),
		.increHourUnit(increHourUnit),
		.increHourTen(increHourTen),
		.hourReport(hourReport),
		.EN(EN),
		.segO(segO),
		.bitO(bitO),
		.noon(noon)
	);
endmodule
