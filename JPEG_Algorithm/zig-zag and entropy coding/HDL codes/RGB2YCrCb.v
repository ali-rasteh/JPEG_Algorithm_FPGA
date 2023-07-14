`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20:23:56 05/10/2015 
// Design Name: 
// Module Name: Matrix 
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
module RGB2YCrCb_byte(R,G,B,Y,Cr,Cb , reset); //takes 3 arrays with size 1*8 as input
input [7:0] R,G,B;
input reset;
integer i,j;
output [7:0]Y, Cr, Cb;
reg [32:0]Y1, Cb1, Cr1;
//**************************************************************************************************************
assign Y=Y1[7:0];
assign Cb=Cb1[7:0];
assign Cr=Cr1[7:0];
//**************************************************************************************************************
always @(*)
begin
	Y1 = 77 *R +150*G + 29 *B ;
	Cr1 = (128*R -107*G - 21 *B);
	Cb1 = (-43*R -85 *G + 128*B);
	Y1=Y1>>8;
	Cr1=Cr1>>8;
	Cb1=Cb1>>8;
	Cr1=Cr1+128;
	Cb1=Cb1+128;
end
//**************************************************************************************************************
endmodule
