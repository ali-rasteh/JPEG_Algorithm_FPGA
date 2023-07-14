`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:23:21 05/31/2015 
// Design Name: 
// Module Name:    zigzag 
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
module zigzag(enable , Y_in , Cr_in , Cb_in , Y_out , Cr_out , Cb_out , DPCM_data_valid , RLE_data_valid , clk , reset);

input [639:0] Y_in , Cr_in , Cb_in;
input enable , clk , reset;
output reg [9:0] Y_out , Cr_out , Cb_out;
output reg DPCM_data_valid;
output reg RLE_data_valid;

integer direction;		//direction is 0 if we are moving up and is 1 if we are moving down
integer current_x;		//shows the current x value in the 8*8 matrix
integer current_y;		//shows the current y value in the 8*8 matrix

integer index;				//shows the index of register that we are puuting mstrix values in it on the specific order

//**************************************************************************************************************

always @ (posedge clk)
begin
	if(reset)
	begin
		direction=1;
		current_x=0;
		current_y=0;
		index=0;
		DPCM_data_valid=0;
		RLE_data_valid=0;
		Y_out=0;
		Cr_out=0;
		Cb_out=0;
	end
	if(enable)
	begin
		if (current_x==0)		//if we are in the left line
		begin
			if(current_y==0)		//if we are in the 00 place
			begin
				DPCM_data_valid=1;		//data is DC value so we activate the DPCM module
				RLE_data_valid=0;
				current_x=current_x+1;
			end
			else if(current_y<7)
			begin
				if(direction==1)		//moving in down direction
				begin
					current_y=current_y+1;
					direction=0;
				end
				else
				begin
					current_x=current_x+1;
					current_y=current_y-1;
				end
				DPCM_data_valid=0;		//data is AC so we activate the RLE module and deactivate DPCM module
				RLE_data_valid=1;
			end
			else
			begin
				current_x=current_x+1;
				DPCM_data_valid=0;
				RLE_data_valid=1;
			end
		end
		else if(current_x==7)		//if we are in the right line
		begin
			if(current_y<7)
			begin
				if(direction==0)
				begin
					current_y=current_y+1;
					direction=1;
				end
				else
				begin
					current_x=current_x-1;
					current_y=current_y+1;
				end
			end
			DPCM_data_valid=0;
			RLE_data_valid=1;
		end
		else if(current_y==0)		//if we are in the up line
		begin
			if(direction==0)
			begin
				current_x=current_x+1;
				direction=1;
			end
			else
			begin
				current_x=current_x-1;
				current_y=current_y+1;
			end
			DPCM_data_valid=0;
			RLE_data_valid=1;
		end
		else if(current_y==7)		//if we are in the down line
		begin
			if (current_x < 7)
			begin
				if(direction==1)
				begin
					current_x=current_x+1;
					direction=0;
				end
				else
				begin
					current_x=current_x+1;
					current_y=current_y-1;
				end
			end
			DPCM_data_valid=0;
			RLE_data_valid=1;
		end
		else if(direction ==0)		//if we are in the middle of matrix and we are moving up
		begin	
			current_x=current_x+1;
			current_y=current_y-1;
			DPCM_data_valid=0;
			RLE_data_valid=1;
		end
		else		//if we are in the middle of matrix and we are moving down
		begin
			current_x=current_x-1;
			current_y=current_y+1;
			DPCM_data_valid=0;
			RLE_data_valid=1;
		end
		index = 8*current_y + current_x;
		Y_out = Y_in[index + :10];		//send a specific data wird of main matrix to the output
		Cr_out = Cr_in[index + :10];
		Cb_out = Cb_in[index + :10];
	end
end

//**************************************************************************************************************
endmodule
