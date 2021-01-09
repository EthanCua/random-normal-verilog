`timescale 1ns / 100ps

module e_x_preprocess_tb();
    
    reg clk;
    reg [31:0] in;
    wire [31:0] out;
    
    e_x_preprocess EXP_00(.x(in), .clk(clk), .y(out));
    
    always begin
        #10 clk = ~clk;
    end
    
    initial begin
    
        clk = 1'b0;
        in = 32'hffffffff;
        #40;
        in = 32'h10000000;
        #40;
        in = 32'h00000000;
        #40;
        in = 32'h08000000;
        #40;
        in = 32'h00000001;
        #40;
        $finish;
    
    end

endmodule
