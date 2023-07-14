`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:12:05 05/17/2015 
// Design Name: 
// Module Name:    quantization_8in8 
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
module quantization_8in8(enable , Y_in , Cr_in , Cb_in , Y_out , Cr_out , Cb_out , data_valid ,clk , reset);

	input	[895:0]Y_in , Cr_in , Cb_in;
	input	enable;
	input clk , reset;
	output	reg [639:0]Y_out , Cr_out , Cb_out;
	output 	data_valid;
	reg data_valid1;
	integer counter;
	reg input_index , output_index;
	reg [2:0] x;
	
	reg [13:0]Y_in0,Y_in1,Y_in2,Y_in3,Y_in4,Y_in5,Y_in6,Y_in7;
	reg [13:0]Cr_in0,Cr_in1,Cr_in2,Cr_in3,Cr_in4,Cr_in5,Cr_in6,Cr_in7;
	reg [13:0]Cb_in0,Cb_in1,Cb_in2,Cb_in3,Cb_in4,Cb_in5,Cb_in6,Cb_in7;
	wire [9:0]Y_out0,Y_out1,Y_out2,Y_out3,Y_out4,Y_out5,Y_out6,Y_out7;
	wire [9:0]Cr_out0,Cr_out1,Cr_out2,Cr_out3,Cr_out4,Cr_out5,Cr_out6,Cr_out7;
	wire [9:0]Cb_out0,Cb_out1,Cb_out2,Cb_out3,Cb_out4,Cb_out5,Cb_out6,Cb_out7;
//**************************************************************************************************************
	assign data_valid=data_valid1;
//**************************************************************************************************************
	quantization pixel0(Y_in0 ,Cr_in0 ,Cb_in0 ,x , 3'b000,Y_out0 ,Cr_out0 ,Cb_out0, reset);
	quantization pixel1(Y_in1 ,Cr_in1 ,Cb_in1 ,x , 3'b001,Y_out1 ,Cr_out1 ,Cb_out1, reset);
	quantization pixel2(Y_in2 ,Cr_in2 ,Cb_in2 ,x , 3'b010,Y_out2 ,Cr_out2 ,Cb_out2, reset);
	quantization pixel3(Y_in3 ,Cr_in3 ,Cb_in3 ,x , 3'b011,Y_out3 ,Cr_out3 ,Cb_out3, reset);
	quantization pixel4(Y_in4 ,Cr_in4 ,Cb_in4 ,x , 3'b100,Y_out4 ,Cr_out4 ,Cb_out4, reset);
	quantization pixel5(Y_in5 ,Cr_in5 ,Cb_in5 ,x , 3'b101,Y_out5 ,Cr_out5 ,Cb_out5, reset);
	quantization pixel6(Y_in6 ,Cr_in6 ,Cb_in6 ,x , 3'b110,Y_out6 ,Cr_out6 ,Cb_out6, reset);
	quantization pixel7(Y_in7 ,Cr_in7 ,Cb_in7 ,x , 3'b111,Y_out7 ,Cr_out7 ,Cb_out7, reset);
	
//**************************************************************************************************************
	always @ (posedge clk)
	begin 
		if(reset)
		begin
			counter=500;
			input_index=0;
			output_index=0;
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
				if(output_index==560)
				begin
					data_valid1=1;
				end
				else
					Y_out[output_index + :10]=Y_out0;			Cr_out[output_index + :10]=Cr_out0;			Cb_out[output_index + :10]=Cb_out0;
					Y_out[output_index+10 + :10]=Y_out1;		Cr_out[output_index+10 + :10]=Cr_out1;		Cb_out[output_index+10 + :10]=Cb_out1;
					Y_out[output_index+20 + :10]=Y_out2;		Cr_out[output_index+20 + :10]=Cr_out2;		Cb_out[output_index+20 + :10]=Cb_out2;
					Y_out[output_index+30 + :10]=Y_out3;		Cr_out[output_index+30 + :10]=Cr_out3;		Cb_out[output_index+30 + :10]=Cb_out3;
					Y_out[output_index+40 + :10]=Y_out4;		Cr_out[output_index+40 + :10]=Cr_out4;		Cb_out[output_index+40 + :10]=Cb_out4;
					Y_out[output_index+50 + :10]=Y_out5;		Cr_out[output_index+50 + :10]=Cr_out5;		Cb_out[output_index+50 + :10]=Cb_out5;
					Y_out[output_index+60 + :10]=Y_out6;		Cr_out[output_index+60 + :10]=Cr_out6;		Cb_out[output_index+60 + :10]=Cb_out6;
					Y_out[output_index+70 + :10]=Y_out7;		Cr_out[output_index+70 + :10]=Cr_out7;		Cb_out[output_index+70 + :10]=Cb_out7;
					
					input_index=input_index+112;
					output_index=output_index + 80;
					x=x+1;
					
					Y_in0=Y_in[input_index + :14];  	Cr_in0=Cr_in[input_index + :14]; 		 Cb_in0=Cb_in[input_index + :14];
					Y_in1=Y_in[input_index+14 + :14];  Cr_in1=Cr_in[input_index+14 + :14];  Cb_in1=Cb_in[input_index+14 + :14];
					Y_in2=Y_in[input_index+28 + :14];  Cr_in2=Cr_in[input_index+28 + :14];  Cb_in2=Cb_in[input_index+28 + :14];
					Y_in3=Y_in[input_index+42 + :14];  Cr_in3=Cr_in[input_index+42 + :14];  Cb_in3=Cb_in[input_index+42 + :14];
					Y_in4=Y_in[input_index+56 + :14];  Cr_in4=Cr_in[input_index+56 + :14];  Cb_in4=Cb_in[input_index+56 + :14];
					Y_in5=Y_in[input_index+70 + :14];  Cr_in5=Cr_in[input_index+70 + :14];  Cb_in5=Cb_in[input_index+70 + :14];
					Y_in6=Y_in[input_index+84 + :14];  Cr_in6=Cr_in[input_index+84 + :14];  Cb_in6=Cb_in[input_index+84 + :14];
					Y_in7=Y_in[input_index+98 + :14];  Cr_in7=Cr_in[input_index+98 + :14];  Cb_in7=Cb_in[input_index+98 + :14];
								
			end
		end
		else
			counter=counter-1;
	
		end
	end
//**************************************************************************************************************
endmodule
