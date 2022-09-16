/*
 Copyright (C) 2022  Intel Corporation. All rights reserved.
 Your use of Intel Corporation's design tools, logic functions 
 and other software and tools, and any partner logic 
 functions, and any output files from any of the foregoing 
 (including device programming or simulation files), and any 
 associated documentation or information are expressly subject 
 to the terms and conditions of the Intel Program License 
 Subscription Agreement, the Intel Quartus Prime License Agreement,
 the Intel FPGA IP License Agreement, or other applicable license
 agreement, including, without limitation, that your use is for
 the sole purpose of programming logic devices manufactured by
 Intel and sold by Intel or its authorized distributors.  Please
 refer to the applicable agreement for further details, at
 https://fpgasoftware.intel.com/eula.
*/
MODEL
/*MODEL HEADER*/
/*
 This file contains Slow Corner delays for the design using part 10M50DAF484C7G
 with speed grade 7, core voltage 1.2V, and temperature 0 Celsius

*/
MODEL_VERSION "1.0";
DESIGN "LED_ON";
DATE "09/15/2022 19:35:07";
PROGRAM "Quartus Prime";



INPUT clk;
INPUT boutton;
INPUT SW[2];
INPUT SW[3];
INPUT SW[6];
INPUT SW[9];
INPUT SW[8];
INPUT SW[7];
INPUT SW[1];
INPUT SW[0];
INOUT segment[0];
INOUT segment[1];
INOUT segment[2];
INOUT segment[3];
INOUT segment[4];
INOUT segment[5];
INOUT segment[6];
INOUT segment[7];
INOUT segment2[0];
INOUT segment2[1];
INOUT segment2[2];
INOUT segment2[3];
INOUT segment2[4];
INOUT segment2[5];
INOUT segment2[6];
INOUT segment2[7];
INOUT segment3[0];
INOUT segment3[1];
INOUT segment3[2];
INOUT segment3[3];
INOUT segment3[4];
INOUT segment3[5];
INOUT segment3[6];
INOUT segment3[7];
INOUT segment4[0];
INOUT segment4[1];
INOUT segment4[2];
INOUT segment4[3];
INOUT segment4[4];
INOUT segment4[5];
INOUT segment4[6];
INOUT segment4[7];
INOUT segment5[0];
INOUT segment5[1];
INOUT segment5[2];
INOUT segment5[3];
INOUT segment5[4];
INOUT segment5[5];
INOUT segment5[6];
INOUT segment5[7];
INOUT segment6[0];
INOUT segment6[1];
INOUT segment6[2];
INOUT segment6[3];
INOUT segment6[4];
INOUT segment6[5];
INOUT segment6[6];
INOUT segment6[7];
INOUT SRCLK1;
INOUT SRCLK2;
INPUT SW[4];
INPUT SW[5];
INPUT ~ALTERA_ADC1IN1~;
INPUT ~ALTERA_ADC2IN1~;
INPUT ~ALTERA_ADC1IN2~;
INPUT ~ALTERA_ADC2IN8~;
INPUT ~ALTERA_ADC1IN3~;
INPUT ~ALTERA_ADC2IN3~;
INPUT ~ALTERA_ADC1IN4~;
INPUT ~ALTERA_ADC2IN4~;
INPUT ~ALTERA_ADC1IN5~;
INPUT ~ALTERA_ADC2IN5~;
INPUT ~ALTERA_ADC1IN6~;
INPUT ~ALTERA_ADC2IN6~;
INPUT ~ALTERA_ADC1IN7~;
INPUT ~ALTERA_ADC2IN7~;
INPUT ~ALTERA_ADC1IN8~;
INPUT ~ALTERA_ADC2IN2~;
OUTPUT SER1;
OUTPUT SCLK1;
OUTPUT SER2;
OUTPUT SCLK2;
OUTPUT RESET1;
OUTPUT RESET2;
OUTPUT buzzer;
OUTPUT VGA_HS;
OUTPUT VGA_VS;
OUTPUT VGA_R[0];
OUTPUT VGA_R[1];
OUTPUT VGA_R[2];
OUTPUT VGA_R[3];
OUTPUT VGA_G[0];
OUTPUT VGA_G[1];
OUTPUT VGA_G[2];
OUTPUT VGA_G[3];
OUTPUT VGA_B[0];
OUTPUT VGA_B[1];
OUTPUT VGA_B[2];
OUTPUT VGA_B[3];
OUTPUT LED[0];
OUTPUT LED[1];
OUTPUT LED[2];
OUTPUT LED[3];
OUTPUT LED[4];
OUTPUT LED[5];
OUTPUT LED[6];
OUTPUT LED[7];
OUTPUT LED[8];
OUTPUT LED[9];

/*Arc definitions start here*/
pos_SW[0]__blocka__setup:		SETUP (POSEDGE) SW[0] blocka ;
pos_SW[1]__blocka__setup:		SETUP (POSEDGE) SW[1] blocka ;
pos_SW[2]__blocka__setup:		SETUP (POSEDGE) SW[2] blocka ;
pos_SW[3]__blocka__setup:		SETUP (POSEDGE) SW[3] blocka ;
pos_SW[0]__blocka__hold:		HOLD (POSEDGE) SW[0] blocka ;
pos_SW[1]__blocka__hold:		HOLD (POSEDGE) SW[1] blocka ;
pos_SW[2]__blocka__hold:		HOLD (POSEDGE) SW[2] blocka ;
pos_SW[3]__blocka__hold:		HOLD (POSEDGE) SW[3] blocka ;
pos_VGA_display:FS4|VGA:VGA_Sub|HS__VGA_HS__delay:		DELAY (POSEDGE) VGA_display:FS4|VGA:VGA_Sub|HS VGA_HS ;
pos_VGA_display:FS4|VGA:VGA_Sub|HS__VGA_HS__delay:		DELAY (POSEDGE) VGA_display:FS4|VGA:VGA_Sub|HS VGA_HS ;
pos_VGA_display:FS4|VGA:VGA_Sub|HS__VGA_VS__delay:		DELAY (POSEDGE) VGA_display:FS4|VGA:VGA_Sub|HS VGA_VS ;
pos_VGA_display:FS4|VGA_clk__VGA_B[0]__delay:		DELAY (POSEDGE) VGA_display:FS4|VGA_clk VGA_B[0] ;
pos_VGA_display:FS4|VGA_clk__VGA_B[1]__delay:		DELAY (POSEDGE) VGA_display:FS4|VGA_clk VGA_B[1] ;
pos_VGA_display:FS4|VGA_clk__VGA_B[2]__delay:		DELAY (POSEDGE) VGA_display:FS4|VGA_clk VGA_B[2] ;
pos_VGA_display:FS4|VGA_clk__VGA_B[3]__delay:		DELAY (POSEDGE) VGA_display:FS4|VGA_clk VGA_B[3] ;
pos_VGA_display:FS4|VGA_clk__VGA_G[0]__delay:		DELAY (POSEDGE) VGA_display:FS4|VGA_clk VGA_G[0] ;
pos_VGA_display:FS4|VGA_clk__VGA_G[1]__delay:		DELAY (POSEDGE) VGA_display:FS4|VGA_clk VGA_G[1] ;
pos_VGA_display:FS4|VGA_clk__VGA_G[2]__delay:		DELAY (POSEDGE) VGA_display:FS4|VGA_clk VGA_G[2] ;
pos_VGA_display:FS4|VGA_clk__VGA_G[3]__delay:		DELAY (POSEDGE) VGA_display:FS4|VGA_clk VGA_G[3] ;
pos_VGA_display:FS4|VGA_clk__VGA_R[0]__delay:		DELAY (POSEDGE) VGA_display:FS4|VGA_clk VGA_R[0] ;
pos_VGA_display:FS4|VGA_clk__VGA_R[1]__delay:		DELAY (POSEDGE) VGA_display:FS4|VGA_clk VGA_R[1] ;
pos_VGA_display:FS4|VGA_clk__VGA_R[2]__delay:		DELAY (POSEDGE) VGA_display:FS4|VGA_clk VGA_R[2] ;
pos_VGA_display:FS4|VGA_clk__VGA_R[3]__delay:		DELAY (POSEDGE) VGA_display:FS4|VGA_clk VGA_R[3] ;
pos_blocka__segment[0]__delay:		DELAY (POSEDGE) blocka segment[0] ;
pos_blocka__segment[1]__delay:		DELAY (POSEDGE) blocka segment[1] ;
pos_blocka__segment[2]__delay:		DELAY (POSEDGE) blocka segment[2] ;
pos_blocka__segment[3]__delay:		DELAY (POSEDGE) blocka segment[3] ;
pos_blocka__segment[4]__delay:		DELAY (POSEDGE) blocka segment[4] ;
pos_blocka__segment[5]__delay:		DELAY (POSEDGE) blocka segment[5] ;
pos_blocka__segment[6]__delay:		DELAY (POSEDGE) blocka segment[6] ;
pos_blocka__segment2[0]__delay:		DELAY (POSEDGE) blocka segment2[0] ;
pos_blocka__segment2[1]__delay:		DELAY (POSEDGE) blocka segment2[1] ;
pos_blocka__segment2[2]__delay:		DELAY (POSEDGE) blocka segment2[2] ;
pos_blocka__segment2[3]__delay:		DELAY (POSEDGE) blocka segment2[3] ;
pos_blocka__segment2[4]__delay:		DELAY (POSEDGE) blocka segment2[4] ;
pos_blocka__segment2[5]__delay:		DELAY (POSEDGE) blocka segment2[5] ;
pos_blocka__segment2[6]__delay:		DELAY (POSEDGE) blocka segment2[6] ;
pos_blocka__segment3[0]__delay:		DELAY (POSEDGE) blocka segment3[0] ;
pos_blocka__segment3[1]__delay:		DELAY (POSEDGE) blocka segment3[1] ;
pos_blocka__segment3[2]__delay:		DELAY (POSEDGE) blocka segment3[2] ;
pos_blocka__segment3[3]__delay:		DELAY (POSEDGE) blocka segment3[3] ;
pos_blocka__segment3[4]__delay:		DELAY (POSEDGE) blocka segment3[4] ;
pos_blocka__segment3[5]__delay:		DELAY (POSEDGE) blocka segment3[5] ;
pos_blocka__segment3[6]__delay:		DELAY (POSEDGE) blocka segment3[6] ;
pos_blocka__segment4[0]__delay:		DELAY (POSEDGE) blocka segment4[0] ;
pos_blocka__segment4[1]__delay:		DELAY (POSEDGE) blocka segment4[1] ;
pos_blocka__segment4[2]__delay:		DELAY (POSEDGE) blocka segment4[2] ;
pos_blocka__segment4[3]__delay:		DELAY (POSEDGE) blocka segment4[3] ;
pos_blocka__segment4[4]__delay:		DELAY (POSEDGE) blocka segment4[4] ;
pos_blocka__segment4[5]__delay:		DELAY (POSEDGE) blocka segment4[5] ;
pos_blocka__segment4[6]__delay:		DELAY (POSEDGE) blocka segment4[6] ;
pos_blocka__segment5[0]__delay:		DELAY (POSEDGE) blocka segment5[0] ;
pos_blocka__segment5[1]__delay:		DELAY (POSEDGE) blocka segment5[1] ;
pos_blocka__segment5[2]__delay:		DELAY (POSEDGE) blocka segment5[2] ;
pos_blocka__segment5[3]__delay:		DELAY (POSEDGE) blocka segment5[3] ;
pos_blocka__segment5[4]__delay:		DELAY (POSEDGE) blocka segment5[4] ;
pos_blocka__segment5[5]__delay:		DELAY (POSEDGE) blocka segment5[5] ;
pos_blocka__segment5[6]__delay:		DELAY (POSEDGE) blocka segment5[6] ;
pos_clk__buzzer__delay:		DELAY (POSEDGE) clk buzzer ;
pos_clockM:fS1_25MHZ|clockout__RESET1__delay:		DELAY (POSEDGE) clockM:fS1_25MHZ|clockout RESET1 ;
pos_clockM:fS1_25MHZ|clockout__RESET2__delay:		DELAY (POSEDGE) clockM:fS1_25MHZ|clockout RESET2 ;
pos_clockM:fS1_25MHZ|clockout__SCLK1__delay:		DELAY (POSEDGE) clockM:fS1_25MHZ|clockout SCLK1 ;
pos_clockM:fS1_25MHZ|clockout__SCLK2__delay:		DELAY (POSEDGE) clockM:fS1_25MHZ|clockout SCLK2 ;
pos_clockM:fS1_25MHZ|clockout__SER1__delay:		DELAY (POSEDGE) clockM:fS1_25MHZ|clockout SER1 ;
pos_clockM:fS1_25MHZ|clockout__SER2__delay:		DELAY (POSEDGE) clockM:fS1_25MHZ|clockout SER2 ;
pos_clockM:fS1_25MHZ|clockout__SRCLK1__delay:		DELAY (POSEDGE) clockM:fS1_25MHZ|clockout SRCLK1 ;
pos_clockM:fS1_25MHZ|clockout__SRCLK2__delay:		DELAY (POSEDGE) clockM:fS1_25MHZ|clockout SRCLK2 ;
___6.591__delay:		DELAY  6.591 ;
___6.791__delay:		DELAY  6.791 ;
___6.408__delay:		DELAY  6.408 ;
___6.913__delay:		DELAY  6.913 ;
___6.450__delay:		DELAY  6.450 ;
___6.757__delay:		DELAY  6.757 ;
___6.767__delay:		DELAY  6.767 ;
___6.356__delay:		DELAY  6.356 ;
___6.984__delay:		DELAY  6.984 ;
___6.730__delay:		DELAY  6.730 ;

ENDMODEL
