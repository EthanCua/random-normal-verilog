`timescale 1ns / 100ps

module LFSR_tb();
    
    wire [31:0] test;
    reg clkSig;
    reg [31:0] seedIn = 32'h12_32_4a_6f;
    reg writeIn = 1'b0;
    
    initial
        begin
            clkSig = 1'b0;
            writeIn = 1'b1;
            #55 writeIn = 1'b0; seedIn = 32'h00000000;
        end
        
    always begin
        #50 clkSig = ~clkSig;
    end    
        
    LFSR_3 myReg(.numout(test), .seed(seedIn), .write(writeIn), .clk(clkSig));
endmodule
