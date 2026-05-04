`timescale 1ns / 1ps

module tone_generator(
    input clk,
    input reset,
    input [31:0] freq,
    output reg sound
);

parameter CLK_FREQ = 6_250_000;

reg [31:0] counter = 0;

always @(posedge clk) begin
    if(reset) begin
        counter <= 0;
        sound <= 0;
    end 
    else if(freq == 0) begin
        sound <= 0;
    end 
    else begin
        counter <= counter + freq;

        if(counter >= (CLK_FREQ >> 1)) begin
            sound <= ~sound;
            counter <= counter - (CLK_FREQ >> 1);
        end
    end
end

endmodule
