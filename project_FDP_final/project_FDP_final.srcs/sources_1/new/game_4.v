`timescale 1ns / 1ps

module game_4(    
    input clk, 
    input btnU_pulse, btnD_pulse, btnL_pulse, btnR_pulse, 
    input [15:0] pixel_index_B,
    input [15:0] pixel_index_A,
    input [2:0] player_health,
    input enable_flag,
    input reset_flag,
    output [15:0] oled_data_B,
    output [15:0] oled_data_A,
    output [1:0] player_health_new,
    output win_flag
    );
    
    //WIRES
    wire [11:0] p_screen;
    wire [11:0] c1, c2, c3;
    wire [3:0] button_flag;
    wire [15:0] oled_data_1;
    wire [15:0] oled_data_2;
    wire [15:0] oled_data_3;
    wire wrong_flag;
    
    // RANDOM SEED GENERATOR
    reg [7:0] master_seed = 0;
    always @(posedge clk) begin
        if(!enable_flag) master_seed <= master_seed + 1;
    end
    
    // LOGIC MODULE
    game_4_logic logic(
        .clk(clk),
        .enable_flag(enable_flag),
        .master_seed(master_seed), //seed generator to be done
        .btn_u(btnU_pulse), .btn_d(btnD_pulse), .btn_l(btnL_pulse), .btn_r(btnR_pulse), 
        .player_health(player_health),
        .reset_flag(reset_flag),
        .player_health_new(player_health_new),
        .win_flag(win_flag),
        // Flattened outputs (4 symbols * 3 bits = 12 bits)
        .p_screen(p_screen),        
        .c1(c1), .c2(c2), .c3(c3),   
        .button_flag(button_flag),
        .wrong_flag(wrong_flag)
    );
    
    // GRAPHICS MODULE
    game_4_graphics graphics(
        .clk(clk),
        .p_screen(p_screen),             // [2:0]U, [5:3]R, [8:6]D, [11:9]L
        .c1(c1), .c2(c2), .c3(c3),            // Slices for the 12 assistant squares
        .button_flag(button_flag),
        .pixel_index_A(pixel_index_A),
        .pixel_index_B(pixel_index_B),
        .wrong_flag(wrong_flag),
        .oled_data_A(oled_data_A),
        .oled_data_B(oled_data_B)
    );
endmodule
