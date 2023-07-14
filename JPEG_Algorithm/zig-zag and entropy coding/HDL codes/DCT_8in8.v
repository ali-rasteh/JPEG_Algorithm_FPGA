`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:22:52 05/16/2015 
// Design Name: 
// Module Name:    DCT_8in8 
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
module DCT_8in8(enable , Y_in , Cr_in , Cb_in , Y_out , Cr_out , Cb_out , data_valid , clk , reset );
	
	input	enable;
	input	[511:0] Y_in,Cr_in,Cb_in;
	input clk,reset;
	
	output data_valid;
	reg	data_valid1;
	
	output	reg [895:0] Y_out , Cr_out , Cb_out; // dim : 14*8*8
	integer counter;
	integer index;
	wire [13:0]Y0,Y1,Y2,Y3,Y4,Y5,Y6,Y7;
	wire [13:0]Cr0,Cr1,Cr2,Cr3,Cr4,Cr5,Cr6,Cr7;
	wire [13:0]Cb0,Cb1,Cb2,Cb3,Cb4,Cb5,Cb6,Cb7;
	
	reg u;
//**************************************************************************************************************
	assign data_valid=data_valid1;
//**************************************************************************************************************
	
	DCT_byte pixel0( Y_in , Cr_in , Cb_in , u , 3'b000 , Y0 , Cr0 , Cb0 , clk ,reset);
	DCT_byte pixel1( Y_in , Cr_in , Cb_in , u , 3'b000 , Y1 , Cr1 , Cb1 , clk , reset);
	DCT_byte pixel2( Y_in , Cr_in , Cb_in , u , 3'b000 , Y2 , Cr2 , Cb2 , clk , reset);
	DCT_byte pixel3( Y_in , Cr_in , Cb_in , u , 3'b000 , Y3 , Cr3 , Cb3 , clk , reset);
	DCT_byte pixel4( Y_in , Cr_in , Cb_in , u , 3'b000 , Y4 , Cr4 , Cb4 , clk , reset);
	DCT_byte pixel5( Y_in , Cr_in , Cb_in , u , 3'b000 , Y5 , Cr5 , Cb5 , clk , reset);
	DCT_byte pixel6( Y_in , Cr_in , Cb_in , u , 3'b000 , Y6 , Cr6 , Cb6 , clk , reset);
	DCT_byte pixel7( Y_in , Cr_in , Cb_in , u , 3'b000 , Y7 , Cr7 , Cb7 , clk , reset);
//**************************************************************************************************************
	always @ (posedge clk)
	begin 
		if(reset)
		begin
			counter=500;
			index=0;
			data_valid1=0;
			Y_out=0;
			Cr_out=0;
			Cb_out=0;
			
		end
		if(enable)
		begin
		if(counter==0)
		begin
			counter=500;
			if(data_valid1==0)
			begin
				if(index==784)
				begin
					data_valid1=1;
				end
				else
					Y_out[index +:14]=Y0;			Cr_out[index +:14]=Cr0;			Cb_out[index +:14]=Cb0;
					Y_out[index+14 +:14]=Y1;		Cr_out[index+14 +:14]=Cr1;		Cb_out[index+14 +:14]=Cb1;
					Y_out[index+28 +:14]=Y2;		Cr_out[index+28 +:14]=Cr2;		Cb_out[index+28 +:14]=Cb2;
					Y_out[index+42 +:14]=Y3;		Cr_out[index+42 +:14]=Cr3;		Cb_out[index+42 +:14]=Cb3;
					Y_out[index+56 +:14]=Y4;		Cr_out[index+56 +:14]=Cr4;		Cb_out[index+56 +:14]=Cb4;
					Y_out[index+70 +:14]=Y5;		Cr_out[index+70 +:14]=Cr5;		Cb_out[index+70 +:14]=Cb5;
					Y_out[index+84 +:14]=Y6;		Cr_out[index+84 +:14]=Cr6;		Cb_out[index+84 +:14]=Cb6;
					Y_out[index+98 +:14]=Y7;		Cr_out[index+98 +:14]=Cr7;		Cb_out[index+98 +:14]=Cb7;
					index=index+112;
					u=u+1;
			end
		end
		else
			counter=counter-1;
	
		end
	end
//**************************************************************************************************************	
endmodule
