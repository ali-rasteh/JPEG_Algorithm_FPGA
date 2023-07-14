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
	wire [639:0] Y_out;
	wire [639:0] Cr_out;
	wire [639:0] Cb_out;
	integer R_file , G_file , B_file , Y_file , Cr_file , Cb_file , counter;
	// Instantiate the Unit Under Test (UUT)
	total_project uut (
		.R(R), 
		.G(G), 
		.B(B), 
		.Y_out(Y_out), 
		.Cr_out(Cr_out), 
		.Cb_out(Cb_out), 
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
	Y_file = $fopen("Y.txt","w");
	Cb_file = $fopen("Cb.txt","w");
	Cr_file = $fopen("Cr.txt","w");
	end
	
	always @ (posedge clk)
	begin
		$fscanf (R_file, "%b \n", R);
		$fscanf (G_file, "%b \n",G);
		$fscanf (B_file, "%b \n",B);
		if(counter==0)
		begin
			counter=1000;
			$fwrite (Y_file,"%b \n",Y_out);
			$fwrite (Cr_file,"%b \n",Cr_out);
			$fwrite (Cb_file,"%b \n",Cb_out);
		end
		else
			counter=counter-1;
	end
endmodule

