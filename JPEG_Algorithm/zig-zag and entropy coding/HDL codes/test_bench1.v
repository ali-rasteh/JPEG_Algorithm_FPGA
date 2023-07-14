`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:52:12 05/18/2015
// Design Name:   total_project
// Module Name:   C:/Users/ALI/Desktop/FPGA project/project/test_bench1.v
// Project Name:  project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: total_project
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_bench1;

	// Inputs
	reg [511:0] R;
	reg [511:0] G;
	reg [511:0] B;
	reg clk;
	reg reset;

	// Outputs
	
	wire [9:0] Y_DPCM , Cr_DPCM , Cb_DPCM;
	wire [13:0] Y_RLE , Cr_RLE , Cb_RLE;
	
	integer R_file , G_file , B_file , Y_file , Cr_file , Cb_file , counter;
	// Instantiate the Unit Under Test (UUT)
	total_project uut (
		.R(R), 
		.G(G), 
		.B(B), 
		.Y_DPCM(Y_DPCM), 
		.Cr_DPCM(Cr_DPCM), 
		.Cb_DPCM(Cb_DPCM), 
		.Y_RLE(Y_RLE),
		.Cr_RLE(Cr_RLE),
		.Cb_RLE(Cb_RLE),
		.clk(clk), 
		.reset(reset)
	);

	initial begin
		// Initialize Inputs
		R = 0;
		G = 0;
		B = 0;
		clk = 0;
		reset = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		reset=0;

	end
   always #10 clk=~clk;
	initial
	begin
		//R=...
		//G=...
		//B=...
	R_file = $fopen("R.txt","r"); 
	G_file = $fopen("G.txt","r");
	B_file = $fopen("B.txt","r");
	Y_DPCM_file = $fopen("Y_DPCM.txt","w");
	Cb_DPCM_file = $fopen("Cb_DPCM.txt","w");
	Cr_DPCM_file = $fopen("Cr_DPCM.txt","w");
	Y_RLE_file = $fopen("Y_RLE.txt","w");
	Cb_RLE_file = $fopen("Cb_RLE.txt","w");
	Cr_RLE_file = $fopen("Cr_RLE.txt","w");
	end
	
	always @ (posedge clk)
	begin
		$fscanf (R_file, "%b \n", R);
		$fscanf (G_file, "%b \n",G);
		$fscanf (B_file, "%b \n",B);
		if(counter==0)
		begin
			counter=1000;
			$fwrite (Y_DPCM_file,"%b \n",Y_DPCM);
			$fwrite (Cr_DPCM_file,"%b \n",Cr_DPCM);
			$fwrite (Cb_DPCM_file,"%b \n",Cb_DPCM);
			$fwrite (Y_RLE_file,"%b \n",Y_RLE);
			$fwrite (Cr_RLE_file,"%b \n",Cr_RLE);
			$fwrite (Cb_RLE_file,"%b \n",Cb_RLE);
		end
		else
			counter=counter-1;
	end
endmodule

