`timescale 1ns / 100ps

//This is the top-level module that implements this whole process as one module.

module normalRandom(
    input clk,
    input rst,
    input writeEnable,
    input [31:0] seed,
    output [31:0] number
    );
    
    wire [31:0] lfsrOut;
    wire [31:0] expreOut;
    wire [31:0] expreOrigOut;
    wire [4:0] counterNum;
    wire [31:0] origNumExpx;
    wire [31:0] expxOut;
    
    //These are instantiations of all the modules, operating in one data pipeline.
    //this collection is made to simplify testing of the entire project by supplying only a few signals
    
    LFSR_3 LFSR00 (.seed(seed), .write(writeEnable), .clk(clk), .numout(lfsrOut));
    e_x_preprocess EXPRE00 (.clk(clk), .x(lfsrOut), .y(expreOut), .origNum(expreOrigOut));
    exp_x EXPX00 (.clk(clk), .rst(rst), .origNum(expreOrigOut), .arg(expreOut), .num(counterNum), .origNumOut(origNumExpx), .numOut(expxOut));
    N_Bit_Counter #(.N(5), .M(32)) NBC00 (.clk(clk), .rst(rst), .number(counterNum));
    e_x_postprocess EXPOST00 (.clk(clk), .rst(rst), .number(number), .arg(expxOut), .origNum(origNumExpx), .testNum(lfsrOut));
    
endmodule
