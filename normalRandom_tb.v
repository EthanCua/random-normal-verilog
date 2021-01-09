`timescale 1ns / 100ps


module normalRandom_tb();
    integer file;
    

    wire signed [31:0] numOut;
    reg clk, rst, writeEn;
    reg [31:0] seedIn;
    
    normalRandom NR00(.clk(clk), .rst(rst), .writeEnable(writeEn), .seed(seedIn), .number(numOut));
    
    always begin
        clk = ~clk;
        #1;
        if(numOut != 0) begin
            $fwrite(file, numOut);
            $fwrite(file, ", ");
        end
    end
    
    initial begin
        file = $fopen ("C:\\Users\\ethan\\Documents\\SDSU\\Fall 2020\\CompE 470\\Semester Project\\testNumbers.txt", "w");//file extension here.
        rst = 1; clk = 0; seedIn = 32'hFEFEFEFE; writeEn = 1;
        #2;
        rst = 0;
        writeEn = 0;
    
    end

endmodule
