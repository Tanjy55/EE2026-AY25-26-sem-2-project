`timescale 1ns / 1ps

module text_engine_v (
    input [6:0] x, input [5:0] y,
    input is_TL, is_TR, is_BL, is_BR,
    output pixel_out
);
    reg [4:0] char_id;
    wire rom_pixel;
    
   // 1. Normalize X and Y coordinates (Stay the same)
    wire [3:0] x_raw = (is_TR || is_BR) ? (x - 81) : x[3:0];
    wire [4:0] y_local = (is_BL || is_BR) ? (y - 33) : y[4:0];

    // 2. Centering Logic
    // Character is 8 pixels wide. Box is 15 pixels wide.
    // We start the "Window" at x=4 and end at x=11 (Total 8 pixels).
    wire x_window = (x_raw >= 4 && x_raw <= 11); 

    // 3. Normalized ROM X
    // We subtract the offset (4) so the ROM sees 0-7 when x_raw is 4-11.
    wire [2:0] x_for_rom = x_raw - 4;

    // 3. Determine Slot (Vertical position 0-31)
    reg [1:0] slot;
    always @(*) begin
        if (y_local < 8)       slot = 2'd0; // B
        else if (y_local < 16) slot = 2'd1; // T
        else if (y_local < 24) slot = 2'd2; // N
        else                   slot = 2'd3; // U/R/D/L
    end

    // 4. Character Selection
    always @(*) begin
        case(slot)
            2'd0: char_id = 5'd1;  // B
            2'd1: char_id = 5'd2;  // T
            2'd2: char_id = 5'd3;  // N
            2'd3: begin
                if (is_TL)      char_id = 5'd4;  // U
                else if (is_TR) char_id = 5'd6;  // R (Note: ID 6 is R)
                else if (is_BL) char_id = 5'd11; // D (Note: ID 11 is D)
                else if (is_BR) char_id = 5'd19; // L (Note: ID 19 is L)
                else            char_id = 5'd0;  // Space
            end
            default: char_id = 5'd0;
        endcase
    end

    // 5. ROM Instance
    char_rom ROM (
        .char_id(char_id), 
        .local_x(x_for_rom), // Use the centered offset
        .local_y(y_local[2:0]), 
        .pixel_on(rom_pixel)
    );

    // 6. Final Output Mask
    // Only output a pixel if the ROM says so AND we are within the first 8 pixels wide.
    assign pixel_out = rom_pixel && x_window;

endmodule