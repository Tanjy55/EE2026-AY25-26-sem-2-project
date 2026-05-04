`timescale 1ns / 1ps

module simon_game(
    input clk,
    input reset,
    input btnU,
    input btnD,
    input btnL,
    input btnR,
    input [2:0] variation_select,
    output reg [2:0] display_colour,
    output reg led15,
    output sound
);

// ==================================
localparam OFF    = 3'b000;
localparam R      = 3'b001;
localparam B      = 3'b010;
localparam Y      = 3'b011;
localparam G      = 3'b100;
localparam LIGHT_GREEN = 3'b101;
localparam PINK   = 3'b110;

// ==================================
// MANUAL MAPPING FUNCTION (NEW)
// ==================================
function [2:0] mapped_colour;
    input [2:0] simon_colour;
    begin
        case(simon_colour)
            R: mapped_colour = Y; // RED ? press YELLOW (btnD)
            B: mapped_colour = R; // BLUE ? press RED (btnU)
            Y: mapped_colour = G; // YELLOW ? press GREEN (btnR)
            G: mapped_colour = B; // GREEN ? press BLUE (btnL)
            default: mapped_colour = OFF;
        endcase
    end
endfunction

// ==================================
// SOUND FREQUENCIES
// ==================================
localparam FREQ_R = 262;
localparam FREQ_B = 330;
localparam FREQ_Y = 392;
localparam FREQ_G = 523;

reg [31:0] sound_freq;

// ==================================
// RANDOM VARIATION
// ==================================
reg [2:0] active_variation;
reg [15:0] rand_counter = 0;

always @(posedge clk) begin
    rand_counter <= rand_counter + 1;
    if(reset)
        active_variation <= rand_counter[2:0];
end

// ==================================
// SEQUENCES
// ==================================
reg [2:0] seq [0:4];

always @(*) begin
    case(active_variation)
        0: begin seq[0]=R; seq[1]=B; seq[2]=R; seq[3]=Y; seq[4]=G; end
        1: begin seq[0]=B; seq[1]=G; seq[2]=Y; seq[3]=R; seq[4]=B; end
        2: begin seq[0]=Y; seq[1]=R; seq[2]=G; seq[3]=B; seq[4]=Y; end
        3: begin seq[0]=G; seq[1]=Y; seq[2]=B; seq[3]=R; seq[4]=G; end
        4: begin seq[0]=R; seq[1]=R; seq[2]=B; seq[3]=Y; seq[4]=G; end
        5: begin seq[0]=B; seq[1]=Y; seq[2]=G; seq[3]=R; seq[4]=B; end
        6: begin seq[0]=Y; seq[1]=B; seq[2]=R; seq[3]=Y; seq[4]=G; end
        7: begin seq[0]=G; seq[1]=R; seq[2]=B; seq[3]=Y; seq[4]=R; end
        default: begin seq[0]=R; seq[1]=B; seq[2]=R; seq[3]=Y; seq[4]=G; end
    endcase
end

// ==================================
parameter T_FLASH = 3_000_000;
parameter T_GAP   = 1_000_000;
parameter T_WAIT  = 18_750_000;
parameter T_BLINK = 781_250;
parameter T_1S    = 6_250_000;

reg [24:0] counter;

// STATES
localparam S_SHOW=0,S_GAP=1,S_WAIT=2,S_INPUT=3,S_HOLD=4,S_WIN=5,S_ERROR=6,S_DELAY=7,S_FINAL=8;
reg [3:0] state;

reg [2:0] round;
reg [2:0] index;

// ==================================
// BUTTON EDGE
// ==================================
reg [3:0] btn_prev;
wire [3:0] btn_now = {btnR,btnD,btnL,btnU};
wire [3:0] btn_edge = btn_now & ~btn_prev;

always @(posedge clk)
    btn_prev <= btn_now;

wire any_btn = |btn_edge;

// ==================================
reg [2:0] input_colour;

always @(*) begin
    case(1'b1)
        btn_edge[0]: input_colour=R;
        btn_edge[1]: input_colour=B;
        btn_edge[2]: input_colour=Y;
        btn_edge[3]: input_colour=G;
        default: input_colour=OFF;
    endcase
end

reg [2:0] latched_colour;

always @(posedge clk)
    if(any_btn) latched_colour <= input_colour;

// ==================================
reg [2:0] button_colour;

always @(*) begin
    if(btnU) button_colour=R;
    else if(btnL) button_colour=B;
    else if(btnD) button_colour=Y;
    else if(btnR) button_colour=G;
    else button_colour=OFF;
end

wire any_btn_hold = btnU|btnD|btnL|btnR;

// ==================================
reg [2:0] game_colour;
reg [3:0] blink_count;

// ==================================
// FSM
// ==================================
always @(posedge clk) begin
    if(reset) begin
        state<=S_SHOW; counter<=0; index<=0; round<=1;
        game_colour<=OFF; led15<=0; blink_count<=0;
    end else begin

        counter <= counter + 1;

        case(state)

        S_SHOW: begin
            game_colour<=seq[index];
            if(counter>=T_FLASH) begin counter<=0; state<=S_GAP; end
        end

        S_GAP: begin
            game_colour<=OFF;
            if(counter>=T_GAP) begin
                counter<=0;
                if(index+1<round) begin index<=index+1; state<=S_SHOW; end
                else begin index<=0; state<=S_WAIT; end
            end
        end

        S_WAIT: begin
            game_colour<=OFF;
            if(any_btn) begin state<=S_INPUT; counter<=0; end
            else if(counter>=T_WAIT) begin counter<=0; index<=0; state<=S_SHOW; end
        end

        // ==================================
        // INPUT LOGIC 
        // ==================================
        S_INPUT: begin
            game_colour<=latched_colour;

            if(latched_colour == mapped_colour(seq[index])) begin
                if(index+1==round) begin state<=S_WIN; counter<=0; end
                else begin index<=index+1; state<=S_HOLD; end
            end else begin
                state<=S_ERROR; counter<=0; blink_count<=0;
            end
        end

        S_HOLD: begin
            game_colour<=OFF;
            if(btn_now==0) state<=S_WAIT;
        end

        S_WIN: begin
            game_colour<=LIGHT_GREEN;
            if(counter>=T_FLASH) begin
                counter<=0;
                if(round<5) begin round<=round+1; state<=S_DELAY; end
                else state<=S_FINAL;
                index<=0;
            end
        end

        S_DELAY: begin
            game_colour<=OFF;
            if(counter>=T_1S) begin counter<=0; state<=S_SHOW; end
        end

        S_FINAL: begin
            game_colour <= PINK;

            if(counter >= T_FLASH) begin
                counter <= 0;
                led15 <= ~led15;
            end
        end

        S_ERROR: begin
            game_colour<=OFF;
            if(counter>=T_BLINK) begin
                counter<=0;
                led15<=~led15;
                blink_count<=blink_count+1;
            end
            if(blink_count>=8) begin
                led15<=0; round<=1; index<=0;
                counter<=0; blink_count<=0;
                state<=S_SHOW;
            end
        end

        endcase
    end
end

// ==================================
// SOUND MAPPING
// ==================================
always @(*) begin
    case(button_colour)
        R: sound_freq = FREQ_R;
        B: sound_freq = FREQ_B;
        Y: sound_freq = FREQ_Y;
        G: sound_freq = FREQ_G;
        default: sound_freq = 0;
    endcase
end

tone_generator tone_gen(
    .clk(clk),
    .reset(reset),
    .freq(sound_freq),
    .sound(sound)
);

// ==================================
always @(*) begin
    if(any_btn_hold)
        display_colour = button_colour;
    else
        display_colour = game_colour;
end

endmodule