`timescale 1ns / 100ps

//This is an N bit counter from Homework 2, but instead of counting up, this number counts down.

module N_Bit_Counter
    #(
        parameter M = 4,
        parameter N = 2
    )
    
    (
        input clk,
        input rst,
        output reg [N - 1:0] number
    );
    
    always @(posedge clk) begin
    
        if(number == 0 || rst == 1'b1) begin
            number = M - 1;
        end
        else begin
            number = number - 1;
        end
    end
    
endmodule
