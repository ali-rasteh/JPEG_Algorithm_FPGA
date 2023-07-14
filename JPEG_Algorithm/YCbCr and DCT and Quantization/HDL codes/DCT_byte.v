`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:32:55 05/16/2015 
// Design Name: 
// Module Name:    DCT_byte 
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
module DCT_byte( Y_in , Cr_in , Cb_in , u , v , Y_out, Cr_out , Cb_out , clk , reset );
	
	input [511:0] Y_in;
	input [511:0] Cr_in;
	input [511:0] Cb_in;
	input [2:0] u,v;
	input clk , reset;
	output [13:0] Y_out;
	output [13:0] Cr_out;
	output [13:0] Cb_out;
	reg	[8:0] Y_in_tmp , Cr_in_tmp , Cb_in_tmp;
	reg	[24:0] Y_out_tmp1 , Cr_out_tmp1 , Cb_out_tmp1;		//sign bit,16 bits for integer part,8 bits for fractional part
	reg	[29:0] Y_out_tmp2 , Cr_out_tmp2 , Cb_out_tmp2;		////sign bit,17 bits for integer part,12 bits for fractional part

	reg [5:0]coefficient;		// sign bit,0.4 bits for fractional part
	integer first_cos_index;
	integer second_cos_index;
	reg [5:0]first_cos, second_cos;
	
	integer i,j;
	reg in_index;
	
//**************************************************************************************************************
	wire [5:0]cosine[31:0];		// sign bit,0.4 bits for fractional part		cosine is an array for cosinus amounts
	
	assign	cosine[0]=6'b010000;			assign	cosine[1]=6'b001111;			assign	cosine[2]=6'b001110;			assign	cosine[3]=6'b001101;			assign	cosine[4]=6'b001011;		
	assign	cosine[5]=6'b001000;			assign	cosine[6]=6'b000110;			assign	cosine[7]=6'b000011;			assign	cosine[8]=6'b000000;			assign	cosine[9]=6'b111101;		
	assign	cosine[10]=6'b111010;		assign	cosine[11]=6'b111000;		assign	cosine[12]=6'b110101;		assign	cosine[13]=6'b110011;		assign	cosine[14]=6'b110010;		
	assign	cosine[15]=6'b110001;		assign	cosine[16]=6'b110000;		assign	cosine[17]=6'b110001;		assign	cosine[18]=6'b110010;		assign	cosine[19]=6'b110011;		
	assign	cosine[20]=6'b110101;		assign	cosine[21]=6'b111000;		assign	cosine[22]=6'b111010;		assign	cosine[23]=6'b111101;		assign	cosine[24]=6'b000000;		
	assign	cosine[25]=6'b000011;		assign	cosine[26]=6'b000110;		assign	cosine[27]=6'b001000;		assign	cosine[28]=6'b001011;		assign	cosine[29]=6'b001101;		
	assign	cosine[30]=6'b001110;		assign	cosine[31]=6'b001111;		

//**************************************************************************************************************	
	assign Y_out = Y_out_tmp2[25:12];
	assign Cr_out = Cr_out_tmp2[25:12];
	assign Cb_out = Cb_out_tmp2[25:12];

//**************************************************************************************************************	
	
	always @ (*)
	begin
		if(reset)
		begin
			Y_out_tmp1=0;
			Cr_out_tmp1=0;
			Cb_out_tmp1=0;
			Y_out_tmp2=0;
			Cr_out_tmp2=0;
			Cb_out_tmp2=0;
			Y_in_tmp=0;
			Cr_in_tmp=0;
			Cb_in_tmp=0;
		end
	
		first_cos_index=u;
		first_cos=cosine[first_cos_index];
		second_cos_index=v;
		second_cos=cosine[second_cos_index];
		
		if(u==3'b000)
		begin
			if(v==3'b000)
				coefficient=000010; // 1/8
			else
				coefficient=000010; // 1/4sqrt(2)
		end
		else if(v==3'b000)
			coefficient=000010; // 1/4sqrt(2)
		else
			coefficient=000100; // 1/4
			
			
		for(i=0 ; i<8 ; i=i+1)
		begin
			for(j=0 ; j<8 ; j=j+1)
			begin
				in_index=8*j+i;
				Y_in_tmp = {0,Y_in[in_index + :7]};
				Cr_in_tmp = {0,Cr_in[in_index + :7]};
				Cb_in_tmp = {0,Cb_in[in_index + :7]};
				Y_out_tmp1 = Y_out_tmp1 + {Y_in_tmp[8] ,Y_in_tmp}  * {first_cos[5],first_cos} * {second_cos[5],second_cos};
				Cr_out_tmp1 = Cr_out_tmp1 + {Cr_in_tmp[8] ,Cr_in_tmp}  * {first_cos[5],first_cos} * {second_cos[5],second_cos};
				Cb_out_tmp1 = Cb_out_tmp1 + {Cb_in_tmp[8],Cb_in_tmp} * {first_cos[5],first_cos} * {second_cos[5],second_cos};
				
				first_cos_index= first_cos_index + 2*v;
				if(first_cos_index >31)
					first_cos_index=first_cos_index-32;
				first_cos=cosine[first_cos_index];
				
			end
			second_cos_index = second_cos_index + 2*u;
			if(second_cos_index >31)
					second_cos_index=second_cos_index-32;
			second_cos=cosine[second_cos_index];
		end
		
		Y_out_tmp2 = Y_out_tmp1 * coefficient;
		Cr_out_tmp2 = Cr_out_tmp1 * coefficient;
		Cb_out_tmp2 = Cb_out_tmp1 * coefficient;
	end
//**************************************************************************************************************
endmodule
