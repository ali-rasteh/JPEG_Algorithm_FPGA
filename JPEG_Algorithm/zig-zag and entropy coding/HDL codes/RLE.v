`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:39:33 06/02/2015 
// Design Name: 
// Module Name:    RLE 
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
module RLE(enable , Y_in , Cr_in , Cb_in , Y_out , Cr_out , Cb_out , data_valid , clk , reset);

	input [9:0] Y_in , Cr_in , Cb_in;
	input enable , clk , reset;
	output reg [13:0] Y_out , Cr_out , Cb_out;
	output reg data_valid;
	
	reg [4:0]Y_zero_num ;		//indicates the zero numbers of Y matrix before the nonzero number
	reg [4:0]Cr_zero_num;		//indicates the zero numbers of Cr matrix before the nonzero number
	reg [4:0]Cb_zero_num;		//indicates the zero numbers of Cb matrix before the nonzero number
	reg Y_zero_flag;				//setting it when the Y_zero_num is greater than 15
	reg Cr_zero_flag;
	reg Cb_zero_flag;
	reg	[9:0] pre_Y_in;		//setting it when the Y_zero_num is greater than 15
	reg	[9:0] pre_Cr_in;
	reg	[9:0] pre_Cb_in;
	
	integer counter;
	
//**************************************************************************************************************	
	always@(posedge clk)
	begin
		if(reset)
		begin
			Y_out=0;
			Cr_out=0;
			Cb_out=0;
			data_valid=0;
			Y_zero_num=0;
			Cr_zero_num=0;
			Cb_zero_num=0;
			Y_zero_flag=0;
			Cr_zero_flag=0;
			Cb_zero_flag=0;
			counter=0;
		end
		if(enable)
		begin
			if(Y_zero_flag==1)		//if in the previous clk we had the Y_zero_num greater than 15
			begin
				Y_out = {Y_zero_num[3:0] , pre_Y_in};
				Y_zero_num = 0;
				Y_zero_flag=0;
				
				
				if(counter==63)		//if we are at the end of matrix so we should send 0 to the output
				begin
					Y_out=0;
				end
				else if( Y_in ==0)		//if we have 0 number in the input
				begin
					Y_zero_num = Y_zero_num+1;		//we increase Y zero numbers till now
				end
				else		////if number of zeros in Y matrix has not reached over 15
				begin
					pre_Y_in = Y_in;
					Y_zero_flag=1;
				end
			end

			
			if(counter==63)		//if we are at the end of matrix so we should send 0 to the output
			begin
				Y_out=0;
			end
			else if( Y_in ==0)		//if we have 0 number in the input
			begin
				Y_zero_num = Y_zero_num+1;		//we increase Y zero numbers till now
			end
			else if(Y_zero_num > 15)		//if number of zeros in Y matrix has reached over 15
			begin
				Y_zero_flag=1;
				Y_out = 14'b11110000000000 ;		//firstword that we send to the output
				Y_zero_num = Y_zero_num - 5'b01111;		//subtract 15 from Y zero numbers till now
				pre_Y_in=Y_in;
			end
			else		////if number of zeros in Y matrix has not reached over 15
			begin
				Y_out = {Y_zero_num[3:0] , Y_in};
				Y_zero_num = 0;
				Y_zero_flag=0;
			end
			
			
			if(Cr_zero_flag==1)
			begin
				Cr_out = {Cr_zero_num[3:0] , pre_Cr_in};
				Cr_zero_num = 0;
				Cr_zero_flag=0;
				
				
				if(counter==63)		//if we are at the end of matrix so we should send 0 to the output
				begin
					Cr_out=0;
				end
				else if( Cr_in ==0)		//if we have 0 number in the input
				begin
					Cr_zero_num = Cr_zero_num+1;		//we increase Y zero numbers till now
				end
				else		////if number of zeros in Y matrix has not reached over 15
				begin
					pre_Cr_in = Cr_in;
					Cr_zero_flag=1;
				end
				
				
			end
			if(counter==63)
			begin
				Cr_out=0;
			end
			else if( Cr_in ==0)
			begin
					Cr_zero_num = Cr_zero_num+1;
			end
			else if(Cr_zero_num > 15)
			begin
				Cr_zero_flag=1;
				Cr_out = 14'b11110000000000 ;
				Cr_zero_num = Cr_zero_num - 5'b01111;
				pre_Cr_in=Cr_in;
			end
			else
			begin
				Cr_out = {Cr_zero_num[3:0] , Cr_in};
				Cr_zero_num = 0;
				Cr_zero_flag=0;
			end
			
			
			
			if(Cb_zero_flag==1)
			begin
				Cb_out = {Cb_zero_num[3:0] , pre_Cb_in};
				Cb_zero_num = 0;
				Cb_zero_flag=0;
				
				if(counter==63)		//if we are at the end of matrix so we should send 0 to the output
				begin
					Cb_out=0;
				end
				else if( Cb_in ==0)		//if we have 0 number in the input
				begin
					Cb_zero_num = Cb_zero_num+1;		//we increase Y zero numbers till now
					counter=counter+1;
				end
				else		////if number of zeros in Y matrix has not reached over 15
				begin
					pre_Cb_in = Cb_in;
					counter=counter+1;
					Cb_zero_flag=1;
				end
				
				
				
			end
			if(counter==63)
			begin
				Cb_out=0;
				counter=0;
			end
			else if( Cb_in ==0)
			begin
					Cb_zero_num = Cb_zero_num+1;
					counter=counter+1;
			end
			else if(Cb_zero_num > 15)
			begin
				Cb_zero_flag=1;
				Cb_out = 14'b11110000000000 ;
				Cb_zero_num = Cb_zero_num - 5'b01111;
				pre_Cb_in=Cb_in;
				counter=counter+1;
			end
			else
			begin
				Cb_out = {Cb_zero_num[3:0] , Y_in};
				Cb_zero_num = 0;
				Cb_zero_flag=0;
				counter=counter+1;
			end
			
		end
	end
	
//**************************************************************************************************************
endmodule
