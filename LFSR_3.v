`timescale 1ns / 100ps


module LFSR_3(
    output [31:0] numout,
    input [31:0] seed,
    input write,
    input clk
    );
    
    reg [31:0] numout;
    reg [31:0] state;
    reg xoroutcome;   //legacy variable from previous iterations, I left it here because I'm lazy
    
    always @(posedge clk)
    begin
         numout[31:1] = state[30:0];  //essentially performs a left shift operation without actually using the <<
         xoroutcome = state[31] ^ state[29] ^ state[26] ^ state[25];  //new bit inserted using these bit 'taps'
         numout[0] = xoroutcome;
         if(write == 1'b1) state = seed;  //uf the write signal is high, a new seed is written in instead of using numout
         else state = numout;             //updates the shfit register if write is low
    end        
endmodule
