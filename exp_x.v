`timescale 1ns / 100ps


module exp_x(
    input rst,
    input clk,
    input [31:0] arg, 
    input [4:0] num, //number from counter to obtain values from the lookup table.
    input [31:0] origNum,
    output reg [31:0] origNumOut,
    output reg [31:0] numOut
);
    
    //Note: arg takes the form of a 8.24 fixed point number, as I only want to generate z-scores between 0 and 8 (signed 2's comp)
    
    //The following code creates a LUT filled with predefined values of e^x
    reg [31:0] lut [30:0]; //31 values of e^-x in 4.28 fixed point approximations
    reg [31:0] argState;
    reg [31:0] state;
    reg [31:0] origNumState;
    
    initial begin
        
        lut[0] = 32'h00000000;    //e^-64
        lut[1] = 32'h00000000;
        lut[2] = 32'h0000001E;
        lut[3] = 32'h00015FC2;
        lut[4] = 32'h004B0556; //e^-4
        lut[5] = 32'h022A5554;
        lut[6] = 32'h05E2D58D;
        lut[7] = 32'h09B4597E;
        lut[8] = 32'h0C75F7CF;
        lut[9] = 32'h0E1EB512;
        lut[10] = 32'h0F07D5FD;
        lut[11] = 32'h0F81FAB5;
        lut[12] = 32'h0FC07F55;
        lut[13] = 32'h0FE01FEA;
        lut[14] = 32'h0FF007FD;
        lut[15] = 32'h0FF801FF;
        lut[16] = 32'h0FFC007F;
        lut[17] = 32'h0FFE0020;
        lut[18] = 32'h0FFF8001;
        lut[19] = 32'h0FFF8001;
        lut[20] = 32'h0FFFC000;
        lut[21] = 32'h0FFFE000;
        lut[22] = 32'h0FFFEFFF;
        lut[23] = 32'h0FFFF800;
        lut[24] = 32'h0FFFFBFF;
        lut[25] = 32'h0FFFFE00;
        lut[26] = 32'h0FFFFEFF;
        lut[27] = 32'h0FFFFF7F;
        lut[28] = 32'h0FFFFFC0;
        lut[29] = 32'h0FFFFFE0;
        lut[30] = 32'h0FFFFFEF; //e^-2^24

    
    end
    
    always @(posedge clk) begin
        if(rst == 1'b1) begin
            state = 32'h00000000;
            numOut = 32'h00000000;
            argState = 32'h00000000;
            origNumState = 32'h00000000;
        end
        //before the counter resets, the finished number shows up on the output and then the new number gets shuffled in
        //this is done because 31 is the only number not used by the LUT
        if(num == 5'b11111) begin
            numOut <= state;
            state <= 32'h10000000; //this is 1 in 4.28 fixed point notation. Everything else gets multiplied to this
            argState = arg;
            origNumOut <= origNumState;
            origNumState <= origNum;
        end
        else begin
            if(argState[num - 1] == 1'b1) begin //the multiply only executes if there is a 
                state = {{32'd0, state} * lut[31 - num]} >> 28; //accumulated multiply, gets 32 msb's (see e_x_preprocess for why this line looks like this)
            end
        end
    end

endmodule
