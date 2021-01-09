`timescale 1ns / 100ps


module exp_x_tb();

    reg clk, rst;
    reg [31:0] arg;
    wire [4:0] num;
    wire [31:0] out;
    wire [31:0] state;

    exp_x EXP00 (.rst(rst), .clk(clk), .arg(arg), .num(num), .numOut(out), .state(state));
    N_Bit_Counter #(.M(32), .N(5)) NBC00 (.clk(clk), .rst(rst), .number(num));
    
    initial begin
        rst = 1; clk = 0; arg = 32'h01000000; //this should (hopefully) return e^-1/2 = 32'h022A5554; after enough cycles
        #6;
        rst = 0;
        #14;
        arg = 32'h0FF0B671; //just some random number, hoping to get a sensible result after the second cycle
        #750;
        $finish;
    end
    
    always begin
        #5;
        clk = ~clk;
    end
endmodule
