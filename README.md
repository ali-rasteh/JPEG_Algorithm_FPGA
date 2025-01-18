# JPEG_Algorithm_FPGA

JPEG Algorithm Implementation on FPGA

## Description

This project implements the JPEG algorithm on an FPGA. It includes modules written in Verilog for the FPGA implementation and MATLAB scripts for testing and verification. The goal is to provide a hardware-accelerated solution for JPEG compression, which is widely used in image processing and multimedia applications.

## Features

- **FPGA Implementation:** The core JPEG algorithm is implemented in Verilog. This includes modules for discrete cosine transform (DCT), quantization, Huffman encoding, and more.
- **MATLAB Verification:** MATLAB scripts are provided to verify and test the FPGA implementation. These scripts help ensure that the hardware implementation produces correct results compared to software simulations.
- **High Performance:** By leveraging FPGA hardware, the JPEG compression algorithm can achieve high performance and low latency, making it suitable for real-time applications.

## Repository Structure

- **Verilog:** Contains all Verilog modules for the JPEG algorithm implementation. This includes the main compression engine as well as testbenches for simulation.
- **MATLAB:** Contains MATLAB scripts for testing and verification. These scripts can be used to compare the output of the FPGA implementation with reference software implementations.

## Getting Started

### Prerequisites

- FPGA development environment (e.g., Xilinx Vivado)
- MATLAB

### Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/ali-rasteh/JPEG_Algorithm_FPGA.git
