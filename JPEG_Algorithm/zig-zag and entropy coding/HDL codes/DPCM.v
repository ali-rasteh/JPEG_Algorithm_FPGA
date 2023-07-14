`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:25:50 06/02/2015 
// Design Name: 
// Module Name:    DPCM 
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
module DPCM(enable, Y_in , Cr_in , Cb_in , Y_out , Cr_out , Cb_out , data_valid , clk , reset);

	input [9:0] Y_in , Cr_in , Cb_in;
	input enable , clk , reset;
	
	output reg [9:0] Y_out , Cr_out , Cb_out;
	output reg data_valid;
	
	reg [9:0] pre_Y , pre_Cr , pre_Cb;
//**************************************************************************************************************
	
	always@(posedge clk)
	begin
		if(reset)
		begin
			pre_Y=0;
			pre_Cr=0;
			pre_Cb=0;
			Y_out=0;
			Cr_out=0;
			Cb_out=0;
			data_valid=0;
			
		end
		
		if(enable)
		begin
			Y_out=Y_in-pre_Y;		//performing the DC subtracting 
			Cr_out=Cr_in-pre_Cr;
			Cb_out=Cb_in-pre_Cb;
			
			pre_Y=Y_in;		//set the previous value of Y to the current value for the naxt calculation
			pre_Cr=Cr_in;
			pre_Cb=Cb_in;
			
		end
		
	end

//**************************************************************************************************************
endmodule
