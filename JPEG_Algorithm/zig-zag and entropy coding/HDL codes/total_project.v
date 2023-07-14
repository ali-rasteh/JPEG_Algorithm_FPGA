`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:53:27 05/17/2015 
// Design Name: 
// Module Name:    total_project 
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
module total_project( R , G , B , Y_DPCM , Cr_DPCM , Cb_DPCM , Y_RLE , Cr_RLE , Cb_RLE , clk , reset);

	input	[511:0] R,G,B;
	input clk,reset;
	wire [511:0] Y,Cr,Cb;
	wire[895:0] Y_DCT , Cr_DCT , Cb_DCT;
	wire [639:0] Y_quant , Cr_quant , Cb_quant;
	wire [9:0]Y_zigzag, Cr_zigzag , Cb_zigzag;
	output [9:0] Y_DPCM , Cr_DPCM , Cb_DPCM;
	output [13:0] Y_RLE , Cr_RLE , Cb_RLE;
	
	
	wire DCT_enable , quant_enable , zigzag_enable , DPCM_enable , RLE_enable;
//**************************************************************************************************************
	RGB2YCrCb_8in8 module1( .R_8in8(R) , .G_8in8(G) , .B_8in8(B) , .Y_8in8(Y) , .Cr_8in8(Cr) , .Cb_8in8(Cb), .data_valid(DCT_enable) , .clk(clk) , .reset(reset) );
	DCT_8in8 module2(.enable(DCT_enable) , .Y_in(Y) , .Cr_in(Cr) , .Cb_in(Cb) , .Y_out(Y_DCT) , .Cr_out(Cr_DCT) , .Cb_out(Cb_DCT) , .data_valid(quant_enable) , .clk(clk) , .reset(reset) );
	quantization_8in8 module3(.enable(quant_enable) , .Y_in(Y_DCT) , .Cr_in(Cr_DCT) , .Cb_in(Cb_DCT) , .Y_out(Y_out) , .Cr_out(Cr_out) , .Cb_out(Cb_out) , .data_valid(zigzag_enable) ,.clk(clk) , .reset(reset));
	zigzag module4(.enable(zigzag_enable) , .Y_in(Y_quant) , .Cr_in(Cr_quant) , .Cb_in(Cb_quant) , .Y_out(Y_zigzag) , .Cr_out(Cr_zigzag) , .Cb_out(Cb_zigzag) , .DPCM_data_valid(DPCM_enable) , .RLE_data_valid(RLE_enable) ,.clk(clk) , .reset(reset));
	DPCM	module5( .enable(DPCM_enable) , .Y_in(Y_zigzag) , .Cr_in(Cr_zigzag) , .Cb_in(Cb_zigzag) , .Y_out(Y_DPCM) , .Cr_out(Cr_DPCM) , .Cb_out(Cb_DPCM) , .data_valid(DPCM_data_valid) , .clk(clk) , .reset(reset));
	RLE module6( .enable(RLE_enable) ,.Y_in(Y_zigzag) , .Cr_in(Cr_zigzag) , .Cb_in(Cb_zigzag) , .Y_out(Y_RLE) , .Cr_out(Cr_RLE) , .Cb_out(Cb_RLE) , .data_valid(RLE_data_valid) , .clk(clk) , .reset(reset));
//**************************************************************************************************************
//	always @ (posedge clk)
//	begin
//		if(reset)
//		begin

//		end
//	end	
//**************************************************************************************************************
endmodule
