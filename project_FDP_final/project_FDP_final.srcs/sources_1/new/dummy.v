`timescale 1ns / 1ps

module dummy_game (
    input clk,                      // 100MHz Clock
    input [2:0] player_health,      
    input [15:0] pixel_index_B,
    input [15:0] pixel_index_A,
    input enable_flag,
    output [15:0] oled_data_B,
    output [15:0] oled_data_A,
    output reg [2:0] player_health_new, // Changed to 3-bit to match input
    output reg win_flag
);

    // --- Color Definitions (RGB565) ---
    assign oled_data_B = 16'h001F; // Pure Blue
    assign oled_data_A = 16'hFD20; // Orange

    // --- Health Pass-Through ---
    always @(*) begin
        player_health_new = player_health;
    end

    // --- Timer Logic (5 Seconds @ 100MHz) ---
    // 5 * 100,000,000 = 500,000,000 cycles
    reg [28:0] count = 0;

    always @(posedge clk) begin
        if (!enable_flag) begin
            count <= 0;
            win_flag <= 0;
        end else begin
            if (count < 29'd100_000_000) begin
                count <= count + 1;
                win_flag <= 0;
            end else begin
                win_flag <= 1; // Set win_flag high after 5 seconds
            end
        end
    end

endmodule
