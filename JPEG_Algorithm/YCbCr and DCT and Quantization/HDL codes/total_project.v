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
module total_project( R , G , B , Y_out , Cr_out , Cb_out , clk , reset);

	input	[511:0] R,G,B;
	input clk,reset;
	output [639:0] Y_out , Cr_out , Cb_out;
	wire [511:0] Y,Cr,Cb;
	wire[895:0] Y_DCT , Cr_DCT , Cb_DCT;
	
	wire DCT_enable , quant_enable , zigzag_enable;
//**************************************************************************************************************
	RGB2YCrCb_8in8 module1( .R_8in8(R) , .G_8in8(G) , .B_8in8(B) , .Y_8in8(Y) , .Cr_8in8(Cr) , .Cb_8in8(Cb), .data_valid(DCT_enable) , .clk(clk) , .reset(reset) );
	DCT_8in8 module2(.enable(DCT_enable) , .Y_in(Y) , .Cr_in(Cr) , .Cb_in(Cb) , .Y_out(Y_DCT) , .Cr_out(Cr_DCT) , .Cb_out(Cb_DCT) , .data_valid(quant_enable) , .clk(clk) , .reset(reset) );
	quantization_8in8 module3(.enable(quant_enable) , .Y_in(Y_DCT) , .Cr_in(Cr_DCT) , .Cb_in(Cb_DCT) , .Y_out(Y_out) , .Cr_out(Cr_out) , .Cb_out(Cb_out) , .data_valid(zigzag_enable) ,.clk(clk) , .reset(reset));
//**************************************************************************************************************
//	always @ (posedge clk)
//	begin
//		if(reset)
//		begin

//		end
//	end	
//**************************************************************************************************************
endmodule
