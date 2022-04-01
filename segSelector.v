`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: U202013828
// Engineer: Chen Peng
// 
// Create Date:    16:57:58 03/26/2022 
// Design Name: 
// Module Name:    segSelector 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description:    Controller of the dynamic sweeping circuit. 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module segSelector(
	 input CP_1kHz, // clock from 60Hz to 1kHz
	 input CP_1Hz, // clock 1Hz
    input reset, // reset signal
	 input EN, // Enable clock
	 input mode, // 12 or 24 hour 0->12,1->24
	 input increMinUnit, // increse minute unit with 1 step
	 input increMinTen, // increse minute ten with 1 step
	 input increHourUnit, // increse hour unitwith 1 step
	 input increHourTen, // increse hour ten with 1 step
	 output reg hourReport, // LED for hour report
    output reg[7:0] segO, // return the needed pattern
    output reg[7:0] bitO, // decoded from select signal to decide which LED to be illuminated
	 output noon
    );
	 
	 wire [2:0] select; // select which LED to be illuminated, binary to be decoded into decimal
	 wire [7:0] secondCount; // counter number for 60s, [3:0] are units, i.e. BCD 0~9; [7:4] are tens, i.e. BCD 0~5
	 wire [7:0] minuteCount; // counter number for 60min, [3:0] are units, i.e. BCD 0~9; [7:4] are tens, i.e. BCD 0~5
	 wire [5:0] hourCount; // counter number for 24h, [3:0] are units, i.e. BCD 0~9; [5:4] are tens, i.e. BCD 0~2
	 wire [5:0] xBCD; // BCD of hour to be reported.
	 wire ENT; // Enable minuteCounter
	 wire ENH; // Enable hourCounter
	 counter8 refreshCounter(CP_1kHz, reset, 1'b1, select);
	 counter60 secondCounter(CP_1Hz, reset, EN, 1'b0, 1'b0, secondCount, ENT); // synchronized
	 counter60 minuteCounter(CP_1Hz, reset, ENT, increMinUnit, increMinTen, minuteCount, ENH); 
	 counter24 hourCounter(CP_1Hz, reset, ENH && ENT, mode, increHourUnit, increHourTen, hourCount, xBCD, noon);
	 reg[7:0] segSecondUnits;
	 reg[7:0] segSecondTens;
	 reg[7:0] segMinuteUnits;
	 reg[7:0] segMinuteTens; 
	 reg[7:0] segHourUnits; 
	 reg[7:0] segHourTens; // To meet the demand above, we only need to change hourCount's bits.
	 reg[5:0] xCounter; // inner counter for hour reporting.
	 reg xFlag; // flag for hour reporting
	 
	 parameter patternA = 8'b1000_0001; // 0
	 parameter patternB = 8'b1111_0011; // 1
	 parameter patternC = 8'b0100_1001; // 2
	 parameter patternD = 8'b0110_0001; // 3
	 parameter patternE = 8'b0011_0011; // 4
	 parameter patternF = 8'b0010_0101; // 5
	 parameter patternG = 8'b0000_0101; // 6
	 parameter patternH = 8'b1111_0001; // 7
	 parameter patternI = 8'b0000_0001; // 8
	 parameter patternJ = 8'b0010_0001; // 9
	 
	 //hour Report
	 always @(posedge CP_1Hz)
		begin
			if(ENH && ENT) xFlag <= 1'b1;
			if(xFlag) begin
				if(xCounter < xBCD * 2) begin
					xCounter <= xCounter + 6'b000001;
					hourReport <= ~hourReport;
				end
				else begin
					xCounter <= 6'b000000;
					hourReport <= 1'b0;
					xFlag <= 1'b0;
				end
			end
		end	
	 
	 // Refresh second display
	 always @(secondCount)
		begin
			// Refresh second units
			case(secondCount[3:0])
				4'b0000: segSecondUnits = patternA;
				4'b0001: segSecondUnits = patternB;
				4'b0010: segSecondUnits = patternC;
				4'b0011: segSecondUnits = patternD;
				4'b0100: segSecondUnits = patternE;
				4'b0101: segSecondUnits = patternF;
				4'b0110: segSecondUnits = patternG;
				4'b0111: segSecondUnits = patternH;
				4'b1000: segSecondUnits = patternI;
				4'b1001: segSecondUnits = patternJ;
				default: segSecondUnits = patternA;
			endcase
			// Refresh second tens
			case(secondCount[7:4])
				4'b0000: segSecondTens = patternA;
				4'b0001: segSecondTens = patternB;
				4'b0010: segSecondTens = patternC;
				4'b0011: segSecondTens = patternD;
				4'b0100: segSecondTens = patternE;
				4'b0101: segSecondTens = patternF;
				default: segSecondTens = patternA;
			endcase	
		end
	
	 // Refresh minute display	
	 always @(minuteCount)	
		begin
			// Refresh minute units
			case(minuteCount[3:0])
				4'b0000: segMinuteUnits = patternA;
				4'b0001: segMinuteUnits = patternB;
				4'b0010: segMinuteUnits = patternC;
				4'b0011: segMinuteUnits = patternD;
				4'b0100: segMinuteUnits = patternE;
				4'b0101: segMinuteUnits = patternF;
				4'b0110: segMinuteUnits = patternG;
				4'b0111: segMinuteUnits = patternH;
				4'b1000: segMinuteUnits = patternI;
				4'b1001: segMinuteUnits = patternJ;
				default: segMinuteUnits = patternA;
			endcase
			// Refresh minute tens
			case(minuteCount[7:4])
				4'b0000: segMinuteTens = patternA;
				4'b0001: segMinuteTens = patternB;
				4'b0010: segMinuteTens = patternC;
				4'b0011: segMinuteTens = patternD;
				4'b0100: segMinuteTens = patternE;
				4'b0101: segMinuteTens = patternF;
				default: segMinuteTens = patternA;
			endcase	
		end

	 // Refresh hour display, default 24-hour
	 always @(hourCount)
		begin
			// Refresh hour units
			case(hourCount[3:0])
				4'b0000: segHourUnits = patternA;
				4'b0001: segHourUnits = patternB;
				4'b0010: segHourUnits = patternC;
				4'b0011: segHourUnits = patternD;
				4'b0100: segHourUnits = patternE;
				4'b0101: segHourUnits = patternF;
				4'b0110: segHourUnits = patternG;
				4'b0111: segHourUnits = patternH;
				4'b1000: segHourUnits = patternI;
				4'b1001: segHourUnits = patternJ;
				default: segHourUnits = patternA;
			endcase
			// Refresh hour tens
			case(hourCount[5:4])
				2'b00: segHourTens = patternA;
				2'b01: segHourTens = patternB;
				2'b10: segHourTens = patternC;
				default: segHourTens = patternA;
			endcase
		end
		
	 always @(
		select 
		or reset 
		or segSecondUnits 
		or segSecondTens 
		or segMinuteUnits 
		or segMinuteTens
		or segHourUnits
		or segHourTens
		)
		 begin
			 if (~reset)
				 begin
					 bitO = 8'b1111_1111;
					 segO = 8'b1111_1111;
				 end
			 else
				 begin
					 case(select)
						 3'b000:
							 begin
								 bitO = 8'b1111_1110;
								 segO = segSecondUnits;
							 end
						 3'b001:
							 begin
								 bitO = 8'b1111_1101;
								 segO = segSecondTens;
							 end
						 3'b010:
							 begin
								 bitO = 8'b1111_1011;
								 segO = segMinuteUnits;
							 end
						 3'b011:
							 begin
								 bitO = 8'b1111_0111;
								 segO = segMinuteTens;
							 end
						 3'b100:
							 begin
								 bitO = 8'b1110_1111;
								 segO = segHourUnits;
							 end
						 3'b101:
							 begin
								 bitO = 8'b1101_1111;
								 segO = segHourTens;
							 end
						 3'b110:
							 begin
								 bitO = 8'b1011_1111;
								 segO = patternA;
							 end
						 3'b111:
							 begin
								 bitO = 8'b0111_1111;
								 segO = patternA;
							 end
					endcase
				end
		end	
endmodule
