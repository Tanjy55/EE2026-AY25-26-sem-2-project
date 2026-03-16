`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//  STUDENT A NAME: DEXTER PEH JUN YEE (A0308274A)
//  STUDENT B NAME: KOH HEDLEY (A0308524H)
//  STUDENT C NAME: ER CHEN WEN (A0308559R)
//  STUDENT D NAME: TAN JUN YI (A0301980R)
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (
    input clk,
    input btnC, btnL, btnR, btnD, btnU,
    input [15:0] sw,
    output [7:0] JB,
    output reg [3:0] an,
    output reg [6:0] seg,
    output reg dp
);    

wire [15:0] oled_data_start;
wire [15:0] oled_data_test;

wire [3:0] game_state;
wire begin_flag;

// ------------ OLED DRIVER INIT ------------------
reg [3:0] clk_count = 0;    
reg clk6p25m = 0;
wire cs, sdin, sclk, d_cn, resn, vccen, pmoden;
wire frame_begin;                                       
wire sending_pixels;
wire sample_pixel;
wire [15:0] pixel_index;
reg [15:0] oled_data;

//6.25MHz clock gen
always @(posedge clk) begin
    if (clk_count == 7) begin                           
        clk_count <= 0;
        clk6p25m <= ~clk6p25m; 
    end else begin
        clk_count <= clk_count + 1;
    end      
end

 Oled_Display JB_OLED (
  .clk(clk6p25m),
  .reset(0), 
  .pixel_data(oled_data),
  .frame_begin(frame_begin),    
  .sending_pixels(sending_pixels),
  .sample_pixel(sample_pixel), 
  .pixel_index(pixel_index), 
  .cs(cs),                
  .sdin(sdin),            
  .sclk(sclk), 
  .d_cn(d_cn), 
  .resn(resn), 
  .vccen(vccen),
  .pmoden(pmoden)
);
    
assign JB[0] = cs;
assign JB[1] = sdin;
assign JB[2] = 1'b0;
assign JB[3] = sclk;
assign JB[4] = d_cn;
assign JB[5] = resn;
assign JB[6] = vccen;
assign JB[7] = pmoden;

// ------------ GRAPHICS INIT ------------------
start_screen screen1 (clk,
                           sw[15:0],
                           btnC, btnL, btnR, btnD, btnU,
                           pixel_index,
                           sample_pixel,
                           oled_data_start,
                           game_state,
                           begin_flag);

test_state_display screen2 (clk, 
                            pixel_index,
                            game_state,
                            oled_data_test);

always @(*) begin
        if (begin_flag == 0) oled_data <= oled_data_start;
        else if (begin_flag == 1) oled_data <= oled_data_test;
        else oled_data <= 16'h0000;
    end

endmodule