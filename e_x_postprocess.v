`timescale 1ns / 100ps

//This module takes the orignal number, its value after going through e^x module, and a random number from the LFSR
//If the argument from the e^x module is greater than the randomly generated value, then the original number is output.

module e_x_postprocess(
        input [31:0] arg,
        input [31:0] origNum,
        input [31:0] testNum,
        input clk,
        input rst,
        output [31:0] number
    );
    
    reg [31:0] number;
    reg [31:0] modifiedArg;
    reg [31:0] modifiedTestNum; //comes from LFSR, converted to a value between 0 and 1/sqrt(2pi), the max height of the function
    
    always @(posedge clk) begin
    
        //The rest of the formula normalizes the value of e^x so the area under the gaussian curve is 1. This is done by
        //dividing by sqrt(2pi), which is approximately the same as multiplying by 32'h06621101
    
        modifiedArg = {{32'd0, arg} * 32'h06621101} >> 28;
        modifiedTestNum = {{32'd0, testNum} * 32'h06621101} >> 28;
    
        if(rst == 1'b1) begin
           number = 32'h00000000;
        end
        else if(arg > testNum) begin
            number = origNum;
        end
        else begin
            number = 32'h00000000;
        end
    
    end
    
endmodule
