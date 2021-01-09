`timescale 1ns / 100ps


module e_x_postprocess_tb( );
    reg [31:0] arg, origNum, randomNum;
    wire [31:0] out;
    reg rst, clk;
    
    e_x_postprocess EXPP00 (.arg(arg), .origNum(origNum), .testNum(randomNum), .number(out), .clk(clk), .rst(rst));
    
    initial begin
        clk = 0; rst = 1; arg = 32'h01234567; origNum = 32'h10000000; randomNum = 32'h02000000; 
        #15;
        rst = 0;
        #30;
        randomNum = 32'h00000000;
        #30;
        $finish;
    end

    always begin
        clk = ~clk;
        #5;
    end

endmodule
