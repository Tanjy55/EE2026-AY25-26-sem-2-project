`timescale 1ns / 1ps

module reset_instructions_screen(
    input clk, 
    input [15:0] pixel_index,
    output reg [15:0] oled_data
    );

    // Coordinate extraction with 180 degree rotation
    wire [6:0] x_raw = pixel_index % 96;
    wire [5:0] y_raw = pixel_index / 96;
    
    wire [6:0] x = 95 - x_raw;
    wire [5:0] y = 63 - y_raw;

    localparam WHITE = 16'hFFFF;
    localparam BLACK = 16'h0000;

    always @(*) begin
        oled_data = BLACK; 

        // --- LINE 1: "PRESS ANY" ---
        if (x >= 10 && x <= 16 && y >= 8 && y <= 20) begin // P
            if (x == 10 || y == 8 || y == 14 || (x == 16 && y >= 8 && y <= 14)) oled_data = WHITE;
        end
        else if (x >= 18 && x <= 24 && y >= 8 && y <= 20) begin // R
            if (x == 18 || y == 8 || y == 14 || (x == 24 && y >= 8 && y <= 14) || (y > 14 && (x - 18 == y - 14))) oled_data = WHITE;
        end
        else if (x >= 26 && x <= 32 && y >= 8 && y <= 20) begin // E
            if (x == 26 || y == 8 || y == 14 || y == 20) oled_data = WHITE;
        end
        else if (x >= 34 && x <= 40 && y >= 8 && y <= 20) begin // S
            if (y == 8 || y == 14 || y == 20 || (x == 34 && y <= 14) || (x == 40 && y >= 14)) oled_data = WHITE;
        end
        else if (x >= 42 && x <= 48 && y >= 8 && y <= 20) begin // S
            if (y == 8 || y == 14 || y == 20 || (x == 42 && y <= 14) || (x == 48 && y >= 14)) oled_data = WHITE;
        end
        
        // "ANY"
        else if (x >= 55 && x <= 61 && y >= 8 && y <= 20) begin // A
            if (x == 55 || x == 61 || y == 8 || y == 14) oled_data = WHITE;
        end
        else if (x >= 63 && x <= 69 && y >= 8 && y <= 20) begin // N
            if (x == 63 || x == 69 || (x-63 == y-8)) oled_data = WHITE;
        end
        
        // --- FIXED Y LOGIC (Integer Only) ---
        else if (x >= 71 && x <= 77 && y >= 8 && y <= 20) begin 
            if (y < 14) begin
                // Top half: Draw V-arms only
                // Left arm: as y increases, x increases. Right arm: as y increases, x decreases.
                if (x == 71 + (y-8) || x == 77 - (y-8)) oled_data = WHITE;
            end else begin
                // Bottom half: Draw vertical stem only at the junction point
                if (x == 74) oled_data = WHITE;
            end
        end
                
        // --- LINE 2: "BUTTON" ---
        else if (x >= 28 && x <= 34 && y >= 26 && y <= 38) begin // B
            if (x == 28 || y == 26 || y == 32 || y == 38 || (x == 34 && (y != 32))) oled_data = WHITE;
        end
        else if (x >= 36 && x <= 42 && y >= 26 && y <= 38) begin // U
            if (x == 36 || x == 42 || y == 38) oled_data = WHITE;
        end
        else if (x >= 44 && x <= 50 && y >= 26 && y <= 38) begin // T
            if (y == 26 || x == 47) oled_data = WHITE;
        end
        else if (x >= 52 && x <= 58 && y >= 26 && y <= 38) begin // T
            if (y == 26 || x == 55) oled_data = WHITE;
        end
        else if (x >= 60 && x <= 66 && y >= 26 && y <= 38) begin // O
            if (x == 60 || x == 66 || y == 26 || y == 38) oled_data = WHITE;
        end
        else if (x >= 68 && x <= 74 && y >= 26 && y <= 38) begin // N
            if (x == 68 || x == 74 || (x-68 == y-26)) oled_data = WHITE;
        end

        // --- LINE 3: "TO RESET" ---
        else if (x >= 15 && x <= 21 && y >= 44 && y <= 56) begin // T
            if (y == 44 || x == 18) oled_data = WHITE;
        end
        else if (x >= 23 && x <= 29 && y >= 44 && y <= 56) begin // O
            if (x == 23 || x == 29 || y == 44 || y == 56) oled_data = WHITE;
        end
        else if (x >= 38 && x <= 44 && y >= 44 && y <= 56) begin // R
            if (x == 38 || y == 44 || y == 50 || (x == 44 && y >= 44 && y <= 50) || (y > 50 && (x - 38 == y - 50))) oled_data = WHITE;
        end
        else if (x >= 46 && x <= 52 && y >= 44 && y <= 56) begin // E
            if (x == 46 || y == 44 || y == 50 || y == 56) oled_data = WHITE;
        end
        else if (x >= 54 && x <= 60 && y >= 44 && y <= 56) begin // S
            if (y == 44 || y == 50 || y == 56 || (x == 54 && y <= 50) || (x == 60 && y >= 50)) oled_data = WHITE;
        end
        else if (x >= 62 && x <= 68 && y >= 44 && y <= 56) begin // E
            if (x == 62 || y == 44 || y == 50 || y == 56) oled_data = WHITE;
        end
        else if (x >= 70 && x <= 76 && y >= 44 && y <= 56) begin // T
            if (y == 44 || x == 73) oled_data = WHITE;
        end
    end
endmodule