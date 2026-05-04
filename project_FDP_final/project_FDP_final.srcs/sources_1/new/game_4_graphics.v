`timescale 1ns / 1ps

module game_4_graphics (
    input clk,
    input [11:0] p_screen,              // [2:0]U, [5:3]R, [8:6]D, [11:9]L
    input [11:0] c1, c2, c3,            // Slices for the 12 assistant squares
    input [3:0] button_flag,
    input [15:0] pixel_index_A,
    input [15:0] pixel_index_B,
    input wrong_flag,
    output reg [15:0] oled_data_A,
    output reg [15:0] oled_data_B
);

    // --- 1. COORDINATE CALCULATION (180-Degree Rotation) ---
    wire [6:0] xA_raw = pixel_index_A % 96;
    wire [5:0] yA_raw = pixel_index_A / 96;
    
    // Flipped coordinates: (Max - Current)
    // 95 - xA_raw flips horizontally
    // 63 - yA_raw flips vertically
    wire [6:0] xA = 7'd95 - xA_raw;
    wire [5:0] yA = 6'd63 - yA_raw;

    // OLED B (Keeping original unless you want it flipped too)
    wire [6:0] xB = pixel_index_B % 96;
    wire [5:0] yB = pixel_index_B / 96;



    // --- 2. WIRE BOX DEFINITIONS ---
    // OLED A
    wire oledA_header     = (yA <= 10);
    wire oledA_player_ref = (xA >= 1 && xA <= 10) && (yA >= 11 && yA <= 63);
    
    // Assistant Columns A (Explicit Square Wires)
    wire [2:0] col_xA = (xA >= 22 && xA <= 34) ? 3'd1 :
                        (xA >= 47 && xA <= 59) ? 3'd2 :
                        (xA >= 72 && xA <= 84) ? 3'd3 : 3'd0;
                            
    wire [2:0] row_yA = (yA >= 11 && yA <= 23) ? 3'd1 :
                        (yA >= 24 && yA <= 36) ? 3'd2 :
                        (yA >= 37 && yA <= 49) ? 3'd3 :
                        (yA >= 50 && yA <= 62) ? 3'd4 : 3'd0;

    // OLED B
    wire oledB_h_line = (yB == 32);
    wire oledB_v_line = (xB == 48);
    wire oledB_cor_TL = (xB <= 15) && (yB <= 31);
    wire oledB_cor_TR = (xB >= 80) && (yB <= 31); // 96 - 16 = 80
    wire oledB_cor_BL = (xB <= 15) && (yB >= 32); // 64 - 32 = 32
    wire oledB_cor_BR = (xB >= 80) && (yB >= 32);
    
    wire oledB_sec_TL = (xB >= 22 && xB <= 47) && (yB >= 6  && yB <= 31);
    wire oledB_sec_TR = (xB >= 49 && xB <= 74) && (yB >= 6  && yB <= 31);
    wire oledB_sec_BL = (xB >= 22 && xB <= 47) && (yB >= 33 && yB <= 58);
    wire oledB_sec_BR = (xB >= 49 && xB <= 74) && (yB >= 33 && yB <= 58);

    // --- 3. TEXT ENGINES ---
    wire pix_v_text_B, pix_h_text_A;

    // OLED B: Vertical labels for corners
    text_engine_v b_text_unit (
        .x(xB), .y(yB), 
        .is_TL(oledB_cor_TL), .is_TR(oledB_cor_TR), 
        .is_BL(oledB_cor_BL), .is_BR(oledB_cor_BR),
        .pixel_out(pix_v_text_B)
    );

    // OLED A: Horizontal Header "PRESS CORRECT ORDER"
    text_engine_h a_header_unit (
        .x(xA), .y(yA), .active(oledA_header),
        .pixel_out(pix_h_text_A)
    );

    // --- 4. PROCEDURAL DRAWING (ARROW) ---
    wire is_arrow = oledA_player_ref && (
        (xA == 5 && yA >= 15 && yA <= 60) || // Stem
        (yA >= 56 && yA <= 61 && (xA == 5 + (61-yA) || xA == 5 - (61-yA))) // Head
    );

    // --- 5. SYMBOL MULTIPLEXING ---
    reg [2:0] active_symbol_A, active_symbol_B;
    
    // --- LOCAL COORDINATE CALCULATION FOR OLED A ---    
        wire [3:0] lx = (col_xA == 3'd1) ? (xA - 22) :
                        (col_xA == 3'd2) ? (xA - 47) :
                        (col_xA == 3'd3) ? (xA - 72) : 4'd0;
    
        wire [3:0] ly = (row_yA == 3'd1) ? (yA - 11) :
                        (row_yA == 3'd2) ? (yA - 24) :
                        (row_yA == 3'd3) ? (yA - 37) :
                        (row_yA == 3'd4) ? (yA - 50) : 4'd0;
    
        // Convert 2D local coordinates to the 1D pixel_index used in your symbol code
        wire [7:0] local_pixel_index = (ly * 13) + lx;
    
        // --- 2. SYMBOL DATA FETCH (The Case Switch) ---
        always @(*) begin
            case (col_xA)
                3'd1: active_symbol_A = c1 >> (3 * (row_yA - 1));
                3'd2: active_symbol_A = c2 >> (3 * (row_yA - 1));
                3'd3: active_symbol_A = c3 >> (3 * (row_yA - 1));
                default: active_symbol_A = 3'd0;
            endcase
        end
    
        // --- 3. SYMBOL RENDERING INSTANTIATION ---
        wire [15:0] symbol_pixel_color;
        symbol_renderer_A renderer_unit_A (
            .pixel_index(local_pixel_index),
            .symbol_id(active_symbol_A),
            .out_color(symbol_pixel_color)
        );

    // --- LOCAL COORDINATE CALCULATION FOR OLED B ---
        
        // Step 1: Find the 0-25 local position within the Sector
        // Recommended syntax to prevent underflow wrap-around
        wire [4:0] lxB_raw = (oledB_sec_TL || oledB_sec_BL) ? (xB >= 22 ? xB - 22 : 5'd0) :
                             (oledB_sec_TR || oledB_sec_BR) ? (xB >= 49 ? xB - 49 : 5'd0) : 5'd0;
        
        wire [4:0] lyB_raw = (oledB_sec_TL || oledB_sec_TR) ? (yB - 6)  :
                             (oledB_sec_BL || oledB_sec_BR) ? (yB - 33) : 5'd0;
        
        // Step 2: Boundary Check (Symbol is 25x25, Sector is 26x26)
        // This prevents the 26th pixel from bleeding into the next row of the symbol
        wire is_active_25B = (lxB_raw < 25) && (lyB_raw < 25);
        
        // Step 3: Calculate the 1D Index
        // CRITICAL: The multiplier must match the native width of the renderer (25)
        wire [9:0] index_25B = (lyB_raw * 25) + lxB_raw;
    
        // --- SYMBOL SELECTION B ---
        always @(*) begin
            if (oledB_sec_TL)      active_symbol_B = p_screen[2:0];
            else if (oledB_sec_TR) active_symbol_B = p_screen[5:3];
            else if (oledB_sec_BL) active_symbol_B = p_screen[8:6];
            else if (oledB_sec_BR) active_symbol_B = p_screen[11:9];
            else                   active_symbol_B = 3'd0;
        end
    
        // --- 3. RENDERER INSTANCE FOR OLED B ---
        wire [15:0] sym_pixel_B;
        
        // Instance of the native 25x25 renderer
        symbol_renderer_B renderer_unit_B (
            .pixel_index(index_25B),   // 10-bit index (0-624)
            .symbol_id(active_symbol_B),
            .out_color(sym_pixel_B)
        );

    // --- 6. FINAL DATA OUTPUTS ---
    always @(*) begin
        // OLED A Output Logic
        if (oledA_header) 
                oled_data_A = pix_h_text_A ? 16'hFFFF : 16'h0000;
            else if (is_arrow) 
                oled_data_A = 16'hFFFF;
            else if (col_xA != 0 && row_yA != 0) 
                oled_data_A = symbol_pixel_color; // Use the color from the renderer
            else 
                oled_data_A = 16'h0000;
        end

//        OLED B Output Logic
        always @(*) begin
            if (oledB_cor_TL) begin
                // If flag is 1, fill Green. If 0, show text (White on Black)
                oled_data_B = (button_flag[0]) ? 16'h07E0 : (pix_v_text_B ? 16'hFFFF : 16'h0000);
            end 
            else if (oledB_cor_TR) begin
                oled_data_B = (button_flag[1]) ? 16'h07E0 : (pix_v_text_B ? 16'hFFFF : 16'h0000);
            end 
            else if (oledB_cor_BL) begin
                oled_data_B = (button_flag[2]) ? 16'h07E0 : (pix_v_text_B ? 16'hFFFF : 16'h0000);
            end 
            else if (oledB_cor_BR) begin
                oled_data_B = (button_flag[3]) ? 16'h07E0 : (pix_v_text_B ? 16'hFFFF : 16'h0000);
            end
            
            // Use the Renderer output for the quadrants
            else if (oledB_sec_TL || oledB_sec_TR || oledB_sec_BL || oledB_sec_BR)
                        oled_data_B = sym_pixel_B;
                
            else if (oledB_h_line || oledB_v_line) 
                oled_data_B = 16'h7BEF;
            else 
                oled_data_B = 16'h0000;
                
            if (wrong_flag) begin
                oled_data_B = 16'hF800; // Bright Red Full Screen
            end
        end

endmodule