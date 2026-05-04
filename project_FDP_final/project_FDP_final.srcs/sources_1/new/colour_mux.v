`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2026 21:35:14
// Design Name: 
// Module Name: colour_mux
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module colour_mux(
        
        input clk,
        input [2:0] wire_n_colour,
        output reg [15:0] oled_data,
        output reg [3:0] colour_in_number

    );
    
    // ------------ GAME 1 colors ------------------
        
    localparam RED    = 16'hF800;
    localparam BLUE   = 16'h001F;
    localparam GREEN  = 16'h07E0;
    localparam PURPLE = 16'h8010;
    localparam GREY   = 16'h8410;
    localparam PINK   = 16'hF81F;
    localparam YELLOW = 16'hFFE0;
    localparam ORANGE = 16'hFD20;
    
    always @(posedge clk) begin
        case (wire_n_colour)
            3'd0: begin
            oled_data <= BLUE;
            colour_in_number <= 3'b111;
            end
            3'd1: begin 
            oled_data <= YELLOW;
            colour_in_number <= 3'b000;
            end
            3'd2: begin
            oled_data <= ORANGE;
            colour_in_number <= 3'b001;
            end
            3'd3: begin
            oled_data <= GREY;
            colour_in_number <= 3'b010;
            end
            3'd4: begin
            oled_data <= PURPLE;
            colour_in_number <= 3'b011;
            end
            3'd5: begin
            oled_data <= GREEN;
            colour_in_number <= 3'b100;
            end
            3'd6: begin
            oled_data <= RED;
            colour_in_number <= 3'b101;
            end
            3'd7: begin
            oled_data <= RED;
            colour_in_number <= 3'b110;
            end
            default: begin 
            oled_data <= 16'h0000;
            end
        endcase
    end
endmodule
