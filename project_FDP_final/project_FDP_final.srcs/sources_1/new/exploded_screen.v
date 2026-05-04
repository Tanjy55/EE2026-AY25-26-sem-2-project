`timescale 1ns / 1ps

module exploded_screen(
    input clk, [15:0] pixel_index,
    output reg [15:0] oled_data
    );
    
    wire [6:0] x = pixel_index % 96; // 0 to 95
    wire [5:0] y = pixel_index / 96; // 0 to 63
   
   // Colors
    parameter RED   = 16'hF800;
    parameter WHITE = 16'hFFFF;
    
        always @(*) begin
            // Default Background
            oled_data = RED;
    
            // --- Letter Rendering (Centered roughly at y=28 to y=36) ---
            
            // --- 'E' (Shifted Left by 8) ---
                // Width: 8 pixels (2 to 10)
                if (x >= 2 && x <= 10 && y >= 24 && y <= 40) begin
                    if (x == 2 || y == 24 || y == 32 || y == 40) 
                        oled_data = WHITE;
                end
                
                // --- 'X' (Expanded to 16 bits width) ---
                // Width: 16 pixels (13 to 29)
                // Center point for diagonals: x = 21
                else if (x >= 13 && x <= 29 && y >= 24 && y <= 40) begin
                    // Diagonal 1: top-left to bottom-right
                    // Diagonal 2: top-right to bottom-left
                    // Note: (y-32) centers the Y-axis crossing at the middle bar of the 'E'
                    if ((x-21) == (y-32) || (x-21) == (32-y)) 
                        oled_data = WHITE;
                end
            
            // 'P'
            else if (x >= 32 && x <= 40 && y >= 24 && y <= 40) begin
                if (x == 32 || y == 24 || y == 32 || (x == 40 && y >= 24 && y <= 32)) oled_data = WHITE;
            end
            
            // 'L'
            else if (x >= 43 && x <= 51 && y >= 24 && y <= 40) begin
                if (x == 43 || y == 40) oled_data = WHITE;
            end
            
            // 'O'
            else if (x >= 54 && x <= 62 && y >= 24 && y <= 40) begin
                if (x == 54 || x == 62 || y == 24 || y == 40) oled_data = WHITE;
            end
            
            // 'D'
            else if (x >= 65 && x <= 73 && y >= 24 && y <= 40) begin
                if (x == 65 || (x == 73 && y > 24 && y < 40) || y == 24 || y == 40) oled_data = WHITE;
            end
            
            // 'E'
            else if (x >= 76 && x <= 84 && y >= 24 && y <= 40) begin
                if (x == 76 || y == 24 || y == 32 || y == 40) oled_data = WHITE;
            end
            
            // 'D'
            else if (x >= 87 && x <= 95 && y >= 24 && y <= 40) begin
                if (x == 87 || (x == 95 && y > 24 && y < 40) || y == 24 || y == 40) oled_data = WHITE;
            end
        end
    endmodule

