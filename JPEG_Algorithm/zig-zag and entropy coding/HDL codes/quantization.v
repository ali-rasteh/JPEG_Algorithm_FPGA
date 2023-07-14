`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:55:58 05/17/2015 
// Design Name: 
// Module Name:    quantization 
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
module quantization(Y_in,Cr_in,Cb_in,x,y,Y_out, Cb_out, Cr_out , reset);
input [13:0] Y_in,Cr_in,Cb_in;
input [2:0]x,y;
input reset;
output reg [9:0] Y_out, Cb_out, Cr_out;
reg [26:0] temp_Y,temp_Cb,temp_Cr;
reg [1:0]i=0;
reg [7:0]index;

reg [12:0]chrom[63:0];
reg [12:0]lumin[63:0];
reg	[12:0]lumin_tmp , chrom_tmp;

//**************************************************************************************************************
always @(*)
begin
			if(reset)
			begin
				chrom[0]  <= 13'd3855;	chrom[1]  <= 13'd3641; 	chrom[2]  <= 13'd2731;	chrom[3]  <= 13'd1394;	chrom[4]  <= 13'd662;	chrom[5]  <= 13'd662;	chrom[6]  <= 13'd662;	chrom[7]  <= 13'd662;
				chrom[8]  <= 13'd0;		chrom[9]  <= 13'd3121;	chrom[10] <= 13'd2521;	chrom[11] <= 13'd993; 	chrom[12] <= 13'd662;	chrom[13] <= 13'd662;	chrom[14] <= 13'd662;	chrom[15] <= 13'd662;
				chrom[16] <= 13'd0;		chrom[17] <= 13'd0; 		chrom[18] <= 13'd1456;	chrom[19] <= 13'd662;	chrom[20] <= 13'd662;	chrom[21] <= 13'd662;	chrom[22] <= 13'd662;	chrom[23] <= 13'd662;
				chrom[24] <= 13'd0;		chrom[25] <= 13'd0; 		chrom[26] <= 13'd0;		chrom[27] <= 13'd662;	chrom[28] <= 13'd662;	chrom[29] <= 13'd662;	chrom[30] <= 13'd662;	chrom[31] <= 13'd662;
				chrom[32] <= 13'd0;		chrom[33] <= 13'd0;		chrom[34] <= 13'd0;		chrom[35] <= 13'd0; 		chrom[36] <= 13'd662;	chrom[37] <= 13'd662;	chrom[38] <= 13'd662;	chrom[39] <= 13'd662; 
				chrom[40] <= 13'd0;		chrom[41] <= 13'd0;		chrom[42] <= 13'd0; 		chrom[43] <= 13'd0; 		chrom[44] <= 13'd0;		chrom[45] <= 13'd662;	chrom[46] <= 13'd662;	chrom[47] <= 13'd662;
				chrom[48] <= 13'd0;		chrom[49] <= 13'd0;		chrom[50] <= 13'd0; 		chrom[51] <= 13'd0; 		chrom[52] <= 13'd0; 		chrom[53] <= 13'd0; 		chrom[54] <= 13'd662;	chrom[55] <= 13'd662;
				chrom[56] <= 13'd0;		chrom[57] <= 13'd0;		chrom[58] <= 13'd0; 		chrom[59] <= 13'd0;		chrom[60] <= 13'd0; 		chrom[61] <= 13'd0; 		chrom[62] <= 13'd0;		chrom[63] <= 13'd662; 
				//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
				lumin[0]  <= 13'd4096;		lumin[1]  <= 13'd5958; 		lumin[2]  <= 13'd6554;		lumin[3]  <= 13'd4096;		lumin[4]  <= 13'd2731;		lumin[5]  <= 13'd1638;		lumin[6]  <= 13'd1285;	lumin[7]  <= 13'd1074;
				lumin[8]  <= 13'd5461;		lumin[9]  <= 13'd5461;		lumin[10] <= 13'd4681;		lumin[11] <= 13'd3449; 		lumin[12] <= 13'd2521;		lumin[13] <= 13'd1130;		lumin[14] <= 13'd1092;	lumin[15] <= 13'd1192;
				lumin[16] <= 13'd4681;		lumin[17] <= 13'd5041; 		lumin[18] <= 13'd4096;		lumin[19] <= 13'd2731;		lumin[20] <= 13'd1638;		lumin[21] <= 13'd1150;		lumin[22] <= 13'd950;	lumin[23] <= 13'd1170;
				lumin[24] <= 13'd4681;		lumin[25] <= 13'd3855; 		lumin[26] <= 13'd2979;		lumin[27] <= 13'd2260;		lumin[28] <= 13'd1285;		lumin[29] <= 13'd753;		lumin[30] <= 13'd819;	lumin[31] <= 13'd1057;
				lumin[32] <= 13'd3641;		lumin[33] <= 13'd2979;		lumin[34] <= 13'd1771;		lumin[35] <= 13'd1170; 		lumin[36] <= 13'd964;		lumin[37] <= 13'd601;		lumin[38] <= 13'd636;	lumin[39] <= 13'd851; 
				lumin[40] <= 13'd2730;		lumin[41] <= 13'd1872;		lumin[42] <= 13'd1191; 		lumin[43] <= 13'd1024; 		lumin[44] <= 13'd809;		lumin[45] <= 13'd630;		lumin[46] <= 13'd580;	lumin[47] <= 13'd712;
				lumin[48] <= 13'd1337;		lumin[49] <= 13'd1024;		lumin[50] <= 13'd840; 		lumin[51] <= 13'd753; 		lumin[52] <= 13'd636; 		lumin[53] <= 13'd542; 		lumin[54] <= 13'd546;	lumin[55] <= 13'd649;
				lumin[56] <= 13'd910;		lumin[57] <= 13'd712;		lumin[58] <= 13'd690; 		lumin[59] <= 13'd669;		lumin[60] <= 13'd585; 		lumin[61] <= 13'd655; 		lumin[62] <= 13'd636;	lumin[63] <= 13'd662; 
				index=0;
				lumin_tmp=0;
				chrom_tmp=0;
				temp_Y=0;
				temp_Cb=0;
				temp_Cr=0;
				Y_out=0;
				Cb_out=0;
				Cr_out=0;
				
			end
			index=8*x + y;
			lumin_tmp=lumin[index];
			chrom_tmp=chrom[index];
			temp_Y 	= {Y_in[13] ,Y_in} 	 * {lumin_tmp[12],lumin_tmp};
			temp_Cb	= {Cb_in[13] , Cb_in} * {chrom_tmp[12] ,chrom_tmp} ;
			temp_Cr	= {Cr_in[13] , Cr_in} * {chrom_tmp[12] ,chrom_tmp};
			
			Y_out  = temp_Y[16]  ? temp_Y [26:17]+1 : temp_Y [26:17];					//8 bit e balaE rond shode va zakhire mishavad
			Cb_out = temp_Cb[16] ? temp_Cb[26:17]+1 : temp_Cb[26:17];
			Cr_out = temp_Cr[16] ? temp_Cr[26:17]+1 : temp_Cr[26:17];
end
//**************************************************************************************************************

endmodule
