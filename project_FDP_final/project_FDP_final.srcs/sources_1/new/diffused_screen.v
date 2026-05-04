`timescale 1ns / 1ps

module diffused_screen(
    input clk, [15:0] pixel_index,
    output reg [15:0] oled_data
    );
    
    wire [6:0] x = pixel_index % 96; // 0 to 95
    wire [5:0] y = pixel_index / 96; // 0 to 63
    
    // --- Color Definitions (RGB565) ---
        parameter GREEN = 16'h07E0; // Vibrant Green background
        parameter WHITE = 16'hFFFF; // Pure White text
    
        // --- Text Positioning and Sizing ---
        // Total word width: ~86 pixels (leaving small margin)
        // Individual letter bounding box: Width ~9, Height ~16
        // Letter Spacing: ~2 pixels
        // Vertical Center: y=24 to y=40
    
        always @(*) begin
            // 1. Default Background Color
            oled_data = GREEN;
    
            // --- 2. Letter Rendering Logic ---
    
            // 'D' (starts at x=3)
            if (x >= 3 && x <= 12 && y >= 24 && y <= 40) begin
                // Top/Bottom bars + Left bar + hollow curve
                if (x == 3 || (x == 12 && y > 24 && y < 40) || y == 24 || y == 40) 
                    oled_data = WHITE;
            end
            
            // 'I' (starts at x=15)
            else if (x >= 15 && x <= 20 && y >= 24 && y <= 40) begin
                // Vertical bar + Top/Bottom serifs
                if (x == 17 || x == 18 || y == 24 || y == 40) 
                    oled_data = WHITE;
            end
            
            // 'F' (starts at x=23)
            else if (x >= 23 && x <= 32 && y >= 24 && y <= 40) begin
                // Left bar + Top bar + Middle bar
                if (x == 23 || y == 24 || y == 32) 
                    oled_data = WHITE;
            end
            
            // 'F' (starts at x=35)
            else if (x >= 35 && x <= 44 && y >= 24 && y <= 40) begin
                // Left bar + Top bar + Middle bar
                if (x == 35 || y == 24 || y == 32) 
                    oled_data = WHITE;
            end
            
            // 'U' (starts at x=47)
            else if (x >= 47 && x <= 56 && y >= 24 && y <= 40) begin
                // Left/Right bars + Bottom bar (hollow center)
                if (x == 47 || x == 56 || y == 40) 
                    oled_data = WHITE;
            end
            
            // 'S' (starts at x=59)
            else if (x >= 59 && x <= 68 && y >= 24 && y <= 40) begin
                // S-shape logic using vertical ranges for segments
                if (y == 24 || y == 32 || y == 40 || 
                   (x == 59 && y > 24 && y < 32) || // Upper left
                   (x == 68 && y > 32 && y < 40))   // Lower right
                    oled_data = WHITE;
            end
            
            // 'E' (starts at x=71)
            else if (x >= 71 && x <= 80 && y >= 24 && y <= 40) begin
                // Left bar + Top/Bottom/Middle bars
                if (x == 71 || y == 24 || y == 32 || y == 40) 
                    oled_data = WHITE;
            end
            
            // 'D' (starts at x=83)
            else if (x >= 83 && x <= 92 && y >= 24 && y <= 40) begin
                // Top/Bottom bars + Left bar + hollow curve
                if (x == 83 || (x == 92 && y > 24 && y < 40) || y == 24 || y == 40) 
                    oled_data = WHITE;
            end
        end
endmodule
