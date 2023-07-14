`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:05:00 05/13/2015 
// Design Name: 
// Module Name:    RGB2YCrCb_8in8 
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
module RGB2YCrCb_8in8( R_8in8 , G_8in8 , B_8in8 , Y_8in8 , Cr_8in8 , Cb_8in8, data_valid , clk , reset );

	input [511:0] R_8in8;
	input [511:0] G_8in8;
	input [511:0] B_8in8;
	input clk , reset;
	output reg [511:0] Y_8in8;
	output reg[511:0] Cr_8in8;
	output reg[511:0] Cb_8in8;
	output data_valid;
	integer counter;
	integer index;
	reg data_valid1;
	reg [7:0] R0,R1,R2,R3,R4,R5,R6,R7;
	reg [7:0] G0,G1,G2,G3,G4,G5,G6,G7;
	reg [7:0] B0,B1,B2,B3,B4,B5,B6,B7;
	wire [7:0]Y0,Y1,Y2,Y3,Y4,Y5,Y6,Y7;
	wire [7:0]Cr0,Cr1,Cr2,Cr3,Cr4,Cr5,Cr6,Cr7;
	wire [7:0]Cb0,Cb1,Cb2,Cb3,Cb4,Cb5,Cb6,Cb7;
//**************************************************************************************************************
	assign data_valid=data_valid1;
//**************************************************************************************************************	
	RGB2YCrCb_byte pixel0(R0 ,G0 ,B0 ,Y0 ,Cr0 ,Cb0, reset);
	RGB2YCrCb_byte pixel1(R1 ,G1 ,B1 ,Y1 ,Cr1 ,Cb1, reset);
	RGB2YCrCb_byte pixel2(R2 ,G2 ,B2 ,Y2 ,Cr2 ,Cb2, reset);
	RGB2YCrCb_byte pixel3(R3 ,G3 ,B3 ,Y3 ,Cr3 ,Cb3, reset);
	RGB2YCrCb_byte pixel4(R4 ,G4 ,B4 ,Y4 ,Cr4 ,Cb4, reset);
	RGB2YCrCb_byte pixel5(R5 ,G5 ,B5 ,Y5 ,Cr5 ,Cb5, reset);
	RGB2YCrCb_byte pixel6(R6 ,G6 ,B6 ,Y6 ,Cr6 ,Cb6, reset);
	RGB2YCrCb_byte pixel7(R7 ,G7 ,B7 ,Y7 ,Cr7 ,Cb7, reset);
	
//**************************************************************************************************************
	always @ (posedge clk)
	begin 
		if(reset)
		begin
			counter=500;
			index=0;
			data_valid1=0;
			Y_8in8=0;
			Cr_8in8=0;
			Cb_8in8=0;
		end
		if(counter==0)
		begin
			counter=500;
			if(data_valid1==0)
			begin
				if(index==448)
				begin
					data_valid1=1;
				end
				else
					Y_8in8[index +:8]=Y0;			Cr_8in8[index +:8]=Cr0;			Cb_8in8[index +:8]=Cb0;
					Y_8in8[index+8 +:8]=Y1;			Cr_8in8[index+8 +:8]=Cr1;		Cb_8in8[index+8 +:8]=Cb1;
					Y_8in8[index+16 +:8]=Y2;		Cr_8in8[index+16 +:8]=Cr2;		Cb_8in8[index+16 +:8]=Cb2;
					Y_8in8[index+24 +:8]=Y3;		Cr_8in8[index+24 +:8]=Cr3;		Cb_8in8[index+24 +:8]=Cb3;
					Y_8in8[index+32 +:8]=Y4;		Cr_8in8[index+32 +:8]=Cr4;		Cb_8in8[index+32 +:8]=Cb4;
					Y_8in8[index+40 +:8]=Y5;		Cr_8in8[index+40 +:8]=Cr5;		Cb_8in8[index+40 +:8]=Cb5;
					Y_8in8[index+48 +:8]=Y6;		Cr_8in8[index+48 +:8]=Cr6;		Cb_8in8[index+48 +:8]=Cb6;
					Y_8in8[index+56 +:8]=Y7;		Cr_8in8[index+56 +:8]=Cr7;		Cb_8in8[index+56 +:8]=Cb7;
					
					index=index+64;
					
					R0=R_8in8[index + :8];		G0=G_8in8[index +:8];		B0=B_8in8[index +:8];
					R1=R_8in8[index+8 + :8];	G1=G_8in8[index+8 +:8];		B1=B_8in8[index+8 +:8];
					R2=R_8in8[index+16 + :8];	G2=G_8in8[index+16 +:8];	B2=B_8in8[index+16 +:8];
					R3=R_8in8[index+24 + :8];	G3=G_8in8[index+24 +:8];	B3=B_8in8[index+24 +:8];
					R4=R_8in8[index+32 + :8];	G4=G_8in8[index+32 +:8];	B4=B_8in8[index+32 +:8];
					R5=R_8in8[index+40 + :8];	G5=G_8in8[index+40 +:8];	B5=B_8in8[index+40 +:8];
					R6=R_8in8[index+48 + :8];	G6=G_8in8[index+48 +:8];	B6=B_8in8[index+48 +:8];
					R7=R_8in8[index+56 + :8];	G7=G_8in8[index+56 +:8];	B7=B_8in8[index+56 +:8];
					
			end
		end
		else
			counter=counter-1;
	end
//**************************************************************************************************************
endmodule
