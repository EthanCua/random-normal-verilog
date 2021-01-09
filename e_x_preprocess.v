`timescale 1ns / 100ps

//this module takes a number x from the LFSR in 32 bit signed format and returns -1/2 x^2 for use in calculating e^x
//Note that inputs are interpreted in a 4.28 fixed point format in 2's complement.
module e_x_preprocess(
    input clk,
    input [31:0] x,
    output reg [31:0] y,
    output reg [31:0] origNum
    );
    
    always @(posedge clk) begin
        //stores original number in output reg to be modified
        y = x;
        //Since I'm only concerned with the magnitude of the number (the sign gets carried over in origNum),
        //all arguments will be turned into positive numbers. (2's comp)
        if(y[31] == 1'b1) begin
            y = y - 1;
            y = ~y;
        end
        //square result
        y = {{32'd0, y} * y} >> 32;//A trick I got from https://stackoverflow.com/questions/16468114/verilog-access-specific-bits 
                                   //gets the 32 msb's of the result to be put into y, rather than the 32 lsb's
                                   
        //NOTE: while the original number is given in 4.28 fixed point, the number squared is now in 8.24 fixed point, because of the
        //process of squaring it. 
                                   
        //finally, divide result by 2
        y = y >> 1;
        origNum = x;
    end
    
endmodule
