# JPEG Algorithm Implementation on FPGA

This project implements the JPEG compression algorithm on an FPGA. It includes Verilog modules for hardware implementation and MATLAB scripts for testing and verification.

## Description

The project focuses on implementing the JPEG algorithm on an FPGA to achieve high performance and low latency suitable for real-time applications. The core components include modules for discrete cosine transform (DCT), quantization, and zigzag ordering.

## Features

- **FPGA Implementation:** Verilog modules for DCT, quantization, and zigzag ordering.
- **MATLAB Verification:** Scripts for verifying the FPGA implementation against software-based results.
- **High Performance:** Optimized for real-time JPEG compression on FPGA.

## Repository Structure

- **JPEG_Algorithm/YCbCr and DCT and Quantization/HDL codes:** Contains Verilog modules for DCT and quantization.
- **JPEG_Algorithm/zig-zag and entropy coding/HDL codes:** Contains Verilog modules for zigzag ordering and entropy coding.
- **JPEG_Algorithm/zig-zag and entropy coding/matlab codes:** MATLAB scripts for zigzag ordering and testing.
- **JPEG_Algorithm/YCbCr and DCT and Quantization/matlab codes:** MATLAB scripts for DCT and quantization testing.
- **README.md:** Project description and instructions.

## Getting Started

### Prerequisites

- FPGA development environment (e.g., Xilinx Vivado)
- MATLAB

### Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/ali-rasteh/JPEG_Algorithm_FPGA.git
   ```

### Usage

1. Open the Verilog files in your FPGA development environment. You can simulate codes with ModelSim or other simulation softwares.
2. Open the MATLAB scripts for testing and verification. You can run the MATLAB codes for verification of results.

## License

This project is licensed under the MIT License.

