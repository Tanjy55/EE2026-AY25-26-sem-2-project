`timescale 1ns / 1ps

module game_2(
    input clk,
    input reset,
    input btnU_db, btnD_db, btnL_db, btnR_db,
    input [15:0] pixel_index_B,
    input [15:0] pixel_index_A,
    input [2:0] player_health,
    input enable_flag,

    output [15:0] oled_data_B,
    output [15:0] oled_data_A,
    output [3:0] JC,

    output [2:0] player_health_new,
    output reg win_flag = 0
);

//////////////////////////////////////////////////
// CLOCK DIVIDER
//////////////////////////////////////////////////
reg [27:0] clk_div = 0;
always @(posedge clk)
    clk_div <= clk_div + 1;

wire clk6p25m = clk_div[3];

//////////////////////////////////////////////////
// SIMON GAME
//////////////////////////////////////////////////
wire [2:0] display_colour;
wire simon_led;
wire sound;

wire simon_reset = ~enable_flag;

simon_game simon(
    .clk(clk6p25m),
    .reset(simon_reset),
    .btnU(btnU_db),
    .btnD(btnD_db),
    .btnL(btnL_db),
    .btnR(btnR_db),
    .variation_select(3'b000),
    .display_colour(display_colour),
    .led15(simon_led),
    .sound(sound)
);

//////////////////////////////////////////////////
// OLED OUTPUT
//////////////////////////////////////////////////
frame_data frame(
    .clk(clk6p25m),
    .pixel_index(pixel_index_B),
    .display_colour(display_colour),
    .oled_data(oled_data_B)
);

manual manual_inst(
    .clk(clk6p25m),
    .pixel_index(pixel_index_A),
    .oled_data(oled_data_A)
);

//////////////////////////////////////////////////
// AUDIO
//////////////////////////////////////////////////
assign JC[0] = (enable_flag) ? sound : 0;
assign JC[3:1] = 3'b000;

//////////////////////////////////////////////////
// GAME CONTROL
//////////////////////////////////////////////////
localparam OFF  = 3'b000;
localparam PINK = 3'b110;

reg [2:0] player_health_internal;
reg prev_enable = 0;
reg prev_led = 0;
reg error_active = 0;

// Output health (same style as other games)
assign player_health_new = (enable_flag) ?
                           player_health_internal :
                           player_health;

always @(posedge clk6p25m) begin
    prev_enable <= enable_flag;

    ////////////////////////////////
    // GLOBAL RESET
    ////////////////////////////////
    if (reset) begin
        player_health_internal <= player_health;
        win_flag <= 0;
        error_active <= 0;
        prev_led <= 0;
    end

    ////////////////////////////////
    // GAME DISABLED (IDLE)
    ////////////////////////////////
    else if (!enable_flag) begin
        // Keep synced with Top module
        player_health_internal <= player_health;
        error_active <= 0;
        prev_led <= 0;
        win_flag <= 0;
    end

    ////////////////////////////////
    // GAME ACTIVE (Game 1 STYLE)
    ////////////////////////////////
    else begin
        // FIRST CYCLE entering game
        if (prev_enable == 0) begin
            player_health_internal <= player_health;  // ? inherit or max HP
            win_flag <= 0;
            error_active <= 0;
            prev_led <= 0;
        end
        else begin
            // NORMAL RUNNING
            prev_led <= simon_led;

            // Error detection (only once per event)
            if (!error_active) begin
                if (display_colour == OFF && prev_led == 0 && simon_led == 1) begin
                    error_active <= 1;
                    if (player_health_internal > 0)
                        player_health_internal <= player_health_internal - 1;
                end
            end

            // Reset error latch
            if (display_colour != OFF)
                error_active <= 0;

            // Win condition
            if (display_colour == PINK)
                win_flag <= 1;
        end
    end
end

endmodule