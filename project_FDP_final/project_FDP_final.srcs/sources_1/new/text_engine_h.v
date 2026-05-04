`timescale 1ns / 1ps

module text_engine_h (
    input [6:0] x,       // 0-95
    input [5:0] y,       // 0-63
    input active,
    output reg pixel_out
);
    reg [5:0] char_id;
    
    // REVERTED: Vertical range set to the very beginning of the coordinate space
    wire y_range = (y >= 0 && y <= 7);
    wire [2:0] local_y = y[2:0]; // Direct mapping, no offset subtraction

    // Horizontal placement (8-pixel pitch)
    wire [3:0] slot = x[6:3];    // x / 8
    wire [2:0] local_x = x[2:0]; // x % 8

    always @(*) begin
        if (!active || !y_range) begin 
            char_id = 6'd0; 
        end else begin
            case(slot)
                4'd0:  char_id = 6'd23; // W
                4'd1:  char_id = 6'd15; // H
                4'd2:  char_id = 6'd16; // I
                4'd3:  char_id = 6'd9;  // C
                4'd4:  char_id = 6'd15; // H
                4'd5:  char_id = 6'd0;  // Space
                4'd6:  char_id = 6'd10; // O
                4'd7:  char_id = 6'd6;  // R
                4'd8:  char_id = 6'd11; // D
                4'd9:  char_id = 6'd7;  // E
                4'd10: char_id = 6'd6;  // R
                4'd11: char_id = 6'd27; // ?
                default: char_id = 6'd0;
            endcase
        end
    end

    wire rom_pixel;
    char_rom ROM_INST (
        .char_id(char_id),
        .local_x(local_x),
        .local_y(local_y),
        .pixel_on(rom_pixel)
    );

    always @(*) begin
        pixel_out = (active && y_range) ? rom_pixel : 1'b0;
    end
endmodule