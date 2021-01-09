# random-normal-verilog
Non-synthesizable Verilog project that randomly generates normally distributed numbers.

This project was made for my COMPE 470 class at San Diego State University. The Verilog code was not intended to be synthesized on any FPGA boards; most timing specifications would not be met by the project. Other shortcomings of the project are discussed in the project report word doc included in this repository. Testbenches for each module are included to see individual performance. The matlab script included is to verify the output of the program, which is written by running the top level module's testbench (normalRandom_tb.v).
