`timescale 1ns / 1ps

module symbol_renderer_A (
    input [7:0] pixel_index,
    input [2:0] symbol_id,
    output reg [15:0] out_color
);
    //STORE 13x13 SYMBOL AND RETURN PIXEL COLOUR 
    // Intermediate wires for each symbol's logic
    reg [15:0] color_s0, color_s1, color_s2, color_s3, 
               color_s4, color_s5, color_s6, color_s7;

    // --- Symbol 1 Logic ---
    always @(*) begin
        if (pixel_index == 3 || (pixel_index >= 109) && (pixel_index <= 111)) color_s0 = 16'b0100001000001000;
        else if (pixel_index == 4 || pixel_index == 16 || pixel_index == 41) color_s0 = 16'b1001010010110010;
        else if (pixel_index == 5 || pixel_index == 103 || pixel_index == 119) color_s0 = 16'b0010100101000101;
        else if (pixel_index == 7 || pixel_index == 22 || pixel_index == 158) color_s0 = 16'b0100101001001001;
        else if (pixel_index == 8 || pixel_index == 53 || pixel_index == 126 || pixel_index == 152) color_s0 = 16'b1000110001010001;
        else if (pixel_index == 9 || ((pixel_index >= 56) && (pixel_index <= 57)) || pixel_index == 108 || pixel_index == 116 || pixel_index == 118 || pixel_index == 141) color_s0 = 16'b0010000100000100;
        else if (pixel_index == 17 || pixel_index == 21 || pixel_index == 102) color_s0 = 16'b1111011110111110;
        else if (pixel_index == 18 || pixel_index == 59 || pixel_index == 113 || ((pixel_index >= 147) && (pixel_index <= 148)) || pixel_index == 159) color_s0 = 16'b0110101101001101;
        else if (pixel_index == 20 || pixel_index == 46 || pixel_index == 128) color_s0 = 16'b1010010100110100;
        else if (pixel_index == 30 || pixel_index == 58) color_s0 = 16'b0011000110000110;
        else if (pixel_index == 31 || pixel_index == 48 || pixel_index == 90 || pixel_index == 133 || pixel_index == 157) color_s0 = 16'b0001000010000010;
        else if (pixel_index == 34 || pixel_index == 73 || pixel_index == 153 || pixel_index == 164) color_s0 = 16'b0001100011000011;
        else if (pixel_index == 40 || pixel_index == 112) color_s0 = 16'b0011100111000111;
        else if (pixel_index == 42 || pixel_index == 97) color_s0 = 16'b1010110101110101;
        else if (pixel_index == 43 || pixel_index == 100) color_s0 = 16'b1011110111110111;
        else if (pixel_index == 44 || pixel_index == 150) color_s0 = 16'b1100011000111000;
        else if (pixel_index == 45 || pixel_index == 96 || ((pixel_index >= 98) && (pixel_index <= 99)) || pixel_index == 146) color_s0 = 16'b1011010110110110;
        else if (pixel_index == 47 || pixel_index == 55 || pixel_index == 62 || pixel_index == 76 || pixel_index == 138) color_s0 = 16'b0110001100001100;
        else if (pixel_index == 54 || pixel_index == 75 || pixel_index == 88 || pixel_index == 101 || pixel_index == 114 || pixel_index == 127 || pixel_index == 139 || pixel_index == 145) color_s0 = 16'b1111111111111111;
        else if (pixel_index == 60 || pixel_index == 89) color_s0 = 16'b1101111011111011;
        else if (pixel_index == 61 || pixel_index == 151) color_s0 = 16'b1110011100111100;
        else if (pixel_index == 66 || pixel_index == 95) color_s0 = 16'b0101101011001011;
        else if (pixel_index == 67 || pixel_index == 149) color_s0 = 16'b1001110011110011;
        else if (pixel_index == 74) color_s0 = 16'b1100111001111001;
        else if (pixel_index == 87 || pixel_index == 163) color_s0 = 16'b0101001010001010;
        else if (pixel_index == 115 || pixel_index == 132) color_s0 = 16'b1110111101111101;
        else if (pixel_index == 131) color_s0 = 16'b1000010000010000;
        else if (pixel_index == 140) color_s0 = 16'b1101011010111010;
        else if (pixel_index == 144) color_s0 = 16'b0111001110001110;
        else if ((pixel_index >= 160) && (pixel_index <= 162)) color_s0 = 16'b0111101111001111;
        else color_s0 = 0;
    end

    // --- Symbol 2 Logic ---
    always @(*) begin
       if (pixel_index == 6 || pixel_index == 56 || pixel_index == 60 || pixel_index == 151 || pixel_index == 166) color_s1 = 16'b0010000100000100;
        else if (pixel_index == 18 || ((pixel_index >= 52) && (pixel_index <= 53)) || pixel_index == 55 || ((pixel_index >= 62) && (pixel_index <= 64)) || pixel_index == 132) color_s1 = 16'b0001100011000011;
        else if (pixel_index == 19 || pixel_index == 88) color_s1 = 16'b1100011000111000;
        else if (pixel_index == 20 || pixel_index == 101 || pixel_index == 136 || pixel_index == 159 || pixel_index == 165) color_s1 = 16'b0000100001000001;
        else if (pixel_index == 31 || pixel_index == 153) color_s1 = 16'b0101001010001010;
        else if (pixel_index == 32 || pixel_index == 45 || pixel_index == 58 || ((pixel_index >= 70) && (pixel_index <= 72)) || ((pixel_index >= 81) && (pixel_index <= 87)) || ((pixel_index >= 95) && (pixel_index <= 99)) || ((pixel_index >= 109) && (pixel_index <= 111)) || ((pixel_index >= 121) && (pixel_index <= 122)) || (pixel_index >= 124) && (pixel_index <= 125)) color_s1 = 16'b1111111111111111;
        else if (pixel_index == 33 || pixel_index == 79) color_s1 = 16'b0100001000001000;
        else if (pixel_index == 44) color_s1 = 16'b1001110011110011;
        else if (pixel_index == 46 || pixel_index == 126) color_s1 = 16'b1001010010110010;
        else if (pixel_index == 54 || pixel_index == 61 || pixel_index == 93 || pixel_index == 140) color_s1 = 16'b0001000010000010;
        else if (pixel_index == 57 || pixel_index == 59 || pixel_index == 76) color_s1 = 16'b1101111011111011;
        else if (pixel_index == 65 || pixel_index == 145) color_s1 = 16'b0111001110001110;
        else if (pixel_index == 66 || pixel_index == 68 || pixel_index == 138) color_s1 = 16'b1110011100111100;
        else if (pixel_index == 67 || pixel_index == 69 || ((pixel_index >= 73) && (pixel_index <= 75)) || pixel_index == 134 || pixel_index == 139) color_s1 = 16'b1110111101111101;
        else if (pixel_index == 77 || pixel_index == 135) color_s1 = 16'b0110101101001101;
        else if (pixel_index == 80 || pixel_index == 123) color_s1 = 16'b1100111001111001;
        else if (pixel_index == 89) color_s1 = 16'b0011000110000110;
        else if (pixel_index == 94 || pixel_index == 100) color_s1 = 16'b1000110001010001;
        else if (pixel_index == 107) color_s1 = 16'b0100101001001001;
        else if (pixel_index == 108 || pixel_index == 112 || pixel_index == 133) color_s1 = 16'b1111011110111110;
        else if (pixel_index == 113) color_s1 = 16'b0011100111000111;
        else if (pixel_index == 120) color_s1 = 16'b1010110101110101;
        else if (pixel_index == 137) color_s1 = 16'b0101101011001011;
        else if (pixel_index == 146) color_s1 = 16'b1011010110110110;
        else if (pixel_index == 147 || pixel_index == 158) color_s1 = 16'b0010100101000101;
        else if (pixel_index == 152) color_s1 = 16'b1011110111110111;
        else color_s1 = 0;
    end
    
    // --- Symbol 3 Logic ---
    always @(*) begin
       if (pixel_index == 4 || ((pixel_index >= 161) && (pixel_index <= 162)) || (pixel_index >= 165) && (pixel_index <= 166)) color_s2 = 16'b0010100101000101;
        else if (pixel_index == 5) color_s2 = 16'b0101101011001011;
        else if (pixel_index == 6 || pixel_index == 27 || pixel_index == 50 || pixel_index == 52 || pixel_index == 55 || pixel_index == 72 || pixel_index == 82 || pixel_index == 163) color_s2 = 16'b0001100011000011;
        else if (pixel_index == 15 || pixel_index == 107) color_s2 = 16'b0010000100000100;
        else if (pixel_index == 16 || pixel_index == 32) color_s2 = 16'b1010010100110100;
        else if (pixel_index == 17 || pixel_index == 70 || pixel_index == 96 || pixel_index == 124 || (pixel_index >= 150) && (pixel_index <= 152)) color_s2 = 16'b1110011100111100;
        else if (pixel_index == 18 || pixel_index == 34 || pixel_index == 109 || pixel_index == 127) color_s2 = 16'b1011010110110110;
        else if (pixel_index == 19 || pixel_index == 59 || pixel_index == 98 || pixel_index == 135) color_s2 = 16'b0011000110000110;
        else if (pixel_index == 20 || pixel_index == 122 || pixel_index == 140) color_s2 = 16'b0101001010001010;
        else if (pixel_index == 21 || pixel_index == 40 || pixel_index == 76 || pixel_index == 87 || pixel_index == 125) color_s2 = 16'b1000010000010000;
        else if (pixel_index == 22 || pixel_index == 65) color_s2 = 16'b0100001000001000;
        else if (pixel_index == 28 || pixel_index == 48 || pixel_index == 67 || pixel_index == 147) color_s2 = 16'b1101011010111010;
        else if (pixel_index == 29 || pixel_index == 33 || pixel_index == 54 || pixel_index == 97) color_s2 = 16'b1111011110111110;
        else if (pixel_index == 30) color_s2 = 16'b0100101001001001;
        else if (pixel_index == 35 || pixel_index == 41 || pixel_index == 45 || pixel_index == 58 || pixel_index == 62 || pixel_index == 66 || pixel_index == 75 || pixel_index == 79 || pixel_index == 88 || pixel_index == 92 || pixel_index == 101 || pixel_index == 110 || pixel_index == 114 || pixel_index == 119 || pixel_index == 123 || pixel_index == 126 || pixel_index == 133 || (pixel_index >= 137) && (pixel_index <= 138)) color_s2 = 16'b1111111111111111;
        else if (pixel_index == 36 || pixel_index == 63 || pixel_index == 146) color_s2 = 16'b0110001100001100;
        else if (pixel_index == 42) color_s2 = 16'b0111001110001110;
        else if (pixel_index == 44 || pixel_index == 111 || pixel_index == 118) color_s2 = 16'b0110101101001101;
        else if (pixel_index == 46 || pixel_index == 74 || pixel_index == 89 || pixel_index == 102 || pixel_index == 141) color_s2 = 16'b0111101111001111;
        else if (pixel_index == 49 || pixel_index == 71 || ((pixel_index >= 83) && (pixel_index <= 84)) || pixel_index == 106 || pixel_index == 139 || pixel_index == 148) color_s2 = 16'b1110111101111101;
        else if (pixel_index == 53 || pixel_index == 105 || pixel_index == 149 || pixel_index == 153) color_s2 = 16'b1101111011111011;
        else if (pixel_index == 57 || pixel_index == 80) color_s2 = 16'b1100011000111000;
        else if (pixel_index == 61 || pixel_index == 100 || pixel_index == 120 || pixel_index == 154) color_s2 = 16'b1000110001010001;
        else if (pixel_index == 69 || pixel_index == 85 || pixel_index == 95 || pixel_index == 142 || pixel_index == 164) color_s2 = 16'b0001000010000010;
        else if (pixel_index == 78 || pixel_index == 91 || pixel_index == 115) color_s2 = 16'b0011100111000111;
        else if (pixel_index == 93 || pixel_index == 113) color_s2 = 16'b1100111001111001;
        else if (pixel_index == 104 || pixel_index == 155 || pixel_index == 160) color_s2 = 16'b0000100001000001;
        else if (pixel_index == 132 || pixel_index == 134) color_s2 = 16'b1001110011110011;
        else if (pixel_index == 136) color_s2 = 16'b1011110111110111;
        else color_s2 = 0; 
    end
    
    // --- Symbol 4 Logic ---
    always @(*) begin
       if (pixel_index == 8 || pixel_index == 18 || pixel_index == 23 || pixel_index == 66) color_s3 = 16'b0110101101001101;
        else if (pixel_index == 9) color_s3 = 16'b0010100101000101;
        else if (pixel_index == 16 || pixel_index == 131 || pixel_index == 139 || pixel_index == 158) color_s3 = 16'b0001100011000011;
        else if (pixel_index == 17 || pixel_index == 48 || pixel_index == 111 || pixel_index == 147) color_s3 = 16'b1011010110110110;
        else if (pixel_index == 19 || pixel_index == 41 || pixel_index == 64 || pixel_index == 100 || pixel_index == 102) color_s3 = 16'b0000100001000001;
        else if (pixel_index == 20 || pixel_index == 101 || pixel_index == 119) color_s3 = 16'b0101001010001010;
        else if (pixel_index == 21 || ((pixel_index >= 30) && (pixel_index <= 31)) || ((pixel_index >= 34) && (pixel_index <= 35)) || ((pixel_index >= 44) && (pixel_index <= 47)) || ((pixel_index >= 58) && (pixel_index <= 60)) || ((pixel_index >= 71) && (pixel_index <= 75)) || pixel_index == 80 || ((pixel_index >= 83) && (pixel_index <= 84)) || pixel_index == 88 || ((pixel_index >= 93) && (pixel_index <= 96)) || ((pixel_index >= 107) && (pixel_index <= 110)) || ((pixel_index >= 120) && (pixel_index <= 125)) || ((pixel_index >= 133) && (pixel_index <= 134)) || pixel_index == 137 || pixel_index == 146) color_s3 = 16'b1111111111111111;
        else if (pixel_index == 22 || pixel_index == 61 || pixel_index == 76) color_s3 = 16'b1110111101111101;
        else if (pixel_index == 29 || pixel_index == 42) color_s3 = 16'b1001110011110011;
        else if (pixel_index == 32 || pixel_index == 81 || pixel_index == 87) color_s3 = 16'b1101011010111010;
        else if (pixel_index == 33) color_s3 = 16'b1110011100111100;
        else if (pixel_index == 36 || pixel_index == 91 || pixel_index == 126) color_s3 = 16'b0110001100001100;
        else if (pixel_index == 43 || pixel_index == 79 || pixel_index == 92 || pixel_index == 97) color_s3 = 16'b1111011110111110;
        else if (pixel_index == 56 || pixel_index == 78 || pixel_index == 105) color_s3 = 16'b0011000110000110;
        else if (pixel_index == 57 || pixel_index == 70) color_s3 = 16'b1100011000111000;
        else if (pixel_index == 62 || pixel_index == 82) color_s3 = 16'b1010010100110100;
        else if (pixel_index == 63 || pixel_index == 98 || pixel_index == 144) color_s3 = 16'b0011100111000111;
        else if (pixel_index == 67) color_s3 = 16'b1000010000010000;
        else if (pixel_index == 68) color_s3 = 16'b0001000010000010;
        else if (pixel_index == 77 || pixel_index == 160) color_s3 = 16'b0010000100000100;
        else if (pixel_index == 85) color_s3 = 16'b1011110111110111;
        else if (pixel_index == 86) color_s3 = 16'b0101101011001011;
        else if (pixel_index == 89) color_s3 = 16'b0111001110001110;
        else if (pixel_index == 106 || pixel_index == 136) color_s3 = 16'b1010110101110101;
        else if (pixel_index == 112 || pixel_index == 151) color_s3 = 16'b0100001000001000;
        else if (pixel_index == 132 || pixel_index == 138 || pixel_index == 145) color_s3 = 16'b1101111011111011;
        else if (pixel_index == 135) color_s3 = 16'b1000110001010001;
        else if (pixel_index == 150) color_s3 = 16'b0100101001001001;
        else if (pixel_index == 159) color_s3 = 16'b0111101111001111;
        else color_s3 = 0; 
    end
    
    // --- Symbol 5 Logic ---
    always @(*) begin
       if (pixel_index == 1 || pixel_index == 128) color_s4 = 16'b0010100101000101;
        else if (pixel_index == 2 || pixel_index == 100) color_s4 = 16'b0100001000001000;
        else if (pixel_index == 3 || pixel_index == 10 || pixel_index == 13 || pixel_index == 83 || pixel_index == 125) color_s4 = 16'b0011000110000110;
        else if (pixel_index == 4 || pixel_index == 33 || pixel_index == 67 || pixel_index == 165) color_s4 = 16'b0001000010000010;
        else if (pixel_index == 11 || pixel_index == 55 || pixel_index == 117 || pixel_index == 153) color_s4 = 16'b0010000100000100;
        else if (pixel_index == 14 || pixel_index == 23 || pixel_index == 48 || pixel_index == 56 || pixel_index == 70 || pixel_index == 94 || pixel_index == 139) color_s4 = 16'b1111011110111110;
        else if (((pixel_index >= 15) && (pixel_index <= 16)) || pixel_index == 30 || ((pixel_index >= 35) && (pixel_index <= 36)) || pixel_index == 47 || pixel_index == 59 || pixel_index == 69 || pixel_index == 72 || pixel_index == 81 || pixel_index == 85 || pixel_index == 93 || pixel_index == 98 || pixel_index == 105 || ((pixel_index >= 112) && (pixel_index <= 114)) || pixel_index == 127) color_s4 = 16'b1111111111111111;
        else if (pixel_index == 17 || pixel_index == 152) color_s4 = 16'b1100111001111001;
        else if (pixel_index == 18 || pixel_index == 26 || pixel_index == 61 || pixel_index == 97 || pixel_index == 138) color_s4 = 16'b0011100111000111;
        else if (pixel_index == 21 || pixel_index == 79 || pixel_index == 119 || (pixel_index >= 135) && (pixel_index <= 136)) color_s4 = 16'b0001100011000011;
        else if (pixel_index == 22 || pixel_index == 140) color_s4 = 16'b1010010100110100;
        else if (pixel_index == 24 || pixel_index == 46) color_s4 = 16'b1010110101110101;
        else if (pixel_index == 27 || pixel_index == 68 || pixel_index == 111) color_s4 = 16'b1001110011110011;
        else if (pixel_index == 28 || pixel_index == 95 || pixel_index == 162 || pixel_index == 164) color_s4 = 16'b0100101001001001;
        else if (pixel_index == 29 || pixel_index == 163) color_s4 = 16'b0111101111001111;
        else if (pixel_index == 31 || pixel_index == 92) color_s4 = 16'b1011110111110111;
        else if (pixel_index == 34 || pixel_index == 44 || pixel_index == 58 || pixel_index == 80) color_s4 = 16'b1100011000111000;
        else if (pixel_index == 37 || pixel_index == 101 || pixel_index == 118 || pixel_index == 148) color_s4 = 16'b0101101011001011;
        else if (pixel_index == 42 || pixel_index == 45 || pixel_index == 91 || pixel_index == 110 || pixel_index == 161) color_s4 = 16'b0000100001000001;
        else if (pixel_index == 43 || pixel_index == 82 || pixel_index == 151) color_s4 = 16'b1110111101111101;
        else if (pixel_index == 49 || pixel_index == 84 || pixel_index == 86 || pixel_index == 104) color_s4 = 16'b0110001100001100;
        else if (pixel_index == 57 || pixel_index == 60 || pixel_index == 106) color_s4 = 16'b1110011100111100;
        else if (pixel_index == 71 || pixel_index == 126 || pixel_index == 149) color_s4 = 16'b1101111011111011;
        else if (pixel_index == 73) color_s4 = 16'b1000010000010000;
        else if (pixel_index == 99 || pixel_index == 150) color_s4 = 16'b1011010110110110;
        else if (pixel_index == 102) color_s4 = 16'b0111001110001110;
        else if (pixel_index == 107) color_s4 = 16'b0101001010001010;
        else if (pixel_index == 115) color_s4 = 16'b0110101101001101;
        else color_s4 = 0; 
    end
    
    // --- Symbol 6 Logic ---
    always @(*) begin
        if (pixel_index == 10 || pixel_index == 16 || pixel_index == 24 || pixel_index == 47 || pixel_index == 53 || pixel_index == 82 || pixel_index == 89 || pixel_index == 112 || pixel_index == 160 || pixel_index == 164) color_s5 = 16'b0000100001000001;
        else if (pixel_index == 17 || pixel_index == 86 || pixel_index == 92 || pixel_index == 125) color_s5 = 16'b0100001000001000;
        else if (pixel_index == 18 || pixel_index == 41 || pixel_index == 107) color_s5 = 16'b1000010000010000;
        else if ((pixel_index >= 19) && (pixel_index <= 20)) color_s5 = 16'b1001110011110011;
        else if (pixel_index == 21) color_s5 = 16'b1010010100110100;
        else if (pixel_index == 22 || (pixel_index >= 33) && (pixel_index <= 35)) color_s5 = 16'b1011010110110110;
        else if (pixel_index == 23 || pixel_index == 127) color_s5 = 16'b1100011000111000;
        else if (pixel_index == 28 || pixel_index == 99 || pixel_index == 102 || pixel_index == 115 || pixel_index == 118 || pixel_index == 121) color_s5 = 16'b0001000010000010;
        else if (pixel_index == 29 || pixel_index == 32 || pixel_index == 56 || pixel_index == 88 || pixel_index == 134) color_s5 = 16'b1011110111110111;
        else if (pixel_index == 30 || pixel_index == 42 || pixel_index == 59 || pixel_index == 68 || pixel_index == 80 || pixel_index == 87 || pixel_index == 93 || pixel_index == 106 || pixel_index == 126 || pixel_index == 133) color_s5 = 16'b1111111111111111;
        else if (pixel_index == 31 || pixel_index == 57 || pixel_index == 73 || pixel_index == 100 || ((pixel_index >= 113) && (pixel_index <= 114)) || pixel_index == 119) color_s5 = 16'b1110011100111100;
        else if (pixel_index == 36) color_s5 = 16'b0111101111001111;
        else if (pixel_index == 43) color_s5 = 16'b0110101101001101;
        else if (pixel_index == 44 || pixel_index == 46 || pixel_index == 162) color_s5 = 16'b0010100101000101;
        else if (pixel_index == 45 || pixel_index == 79 || pixel_index == 105) color_s5 = 16'b0011000110000110;
        else if (pixel_index == 54 || pixel_index == 60 || pixel_index == 81 || pixel_index == 120) color_s5 = 16'b1101111011111011;
        else if (pixel_index == 55 || pixel_index == 58 || pixel_index == 67 || pixel_index == 74 || pixel_index == 139 || (pixel_index >= 149) && (pixel_index <= 150)) color_s5 = 16'b1111011110111110;
        else if (pixel_index == 61) color_s5 = 16'b0101101011001011;
        else if (pixel_index == 66 || pixel_index == 71 || pixel_index == 161 || pixel_index == 163) color_s5 = 16'b0010000100000100;
        else if (pixel_index == 69) color_s5 = 16'b1010110101110101;
        else if (pixel_index == 70 || pixel_index == 136) color_s5 = 16'b0011100111000111;
        else if (pixel_index == 72 || pixel_index == 75 || pixel_index == 135) color_s5 = 16'b0101001010001010;
        else if (pixel_index == 94) color_s5 = 16'b1000110001010001;
        else if (pixel_index == 101 || pixel_index == 138 || pixel_index == 148) color_s5 = 16'b1110111101111101;
        else if (pixel_index == 132 || pixel_index == 137 || pixel_index == 146) color_s5 = 16'b0110001100001100;
        else if (pixel_index == 140 || pixel_index == 152) color_s5 = 16'b0100101001001001;
        else if (pixel_index == 147) color_s5 = 16'b1101011010111010;
        else if (pixel_index == 151) color_s5 = 16'b1100111001111001;
        else color_s5 = 0;
    end

    // --- Symbol 7 Logic ---
    always @(*) begin
        if (pixel_index == 5 || pixel_index == 20 || pixel_index == 67 || pixel_index == 70 || pixel_index == 72 || pixel_index == 75 || pixel_index == 81 || pixel_index == 101 || pixel_index == 119 || pixel_index == 122 || pixel_index == 136 || pixel_index == 159) color_s6 = 16'b0000100001000001;
        else if (pixel_index == 6 || pixel_index == 44 || pixel_index == 107 || pixel_index == 126) color_s6 = 16'b0100001000001000;
        else if (pixel_index == 18 || pixel_index == 32 || pixel_index == 52 || pixel_index == 55 || pixel_index == 61 || pixel_index == 64 || pixel_index == 79 || pixel_index == 99 || pixel_index == 112 || pixel_index == 146 || pixel_index == 158 || pixel_index == 166) color_s6 = 16'b0010000100000100;
        else if (pixel_index == 19) color_s6 = 16'b0101001010001010;
        else if (pixel_index == 31 || pixel_index == 46 || pixel_index == 76 || pixel_index == 80 || pixel_index == 88 || pixel_index == 113 || pixel_index == 139) color_s6 = 16'b0011000110000110;
        else if (pixel_index == 33 || ((pixel_index >= 59) && (pixel_index <= 60)) || pixel_index == 66 || ((pixel_index >= 132) && (pixel_index <= 133)) || pixel_index == 137) color_s6 = 16'b0010100101000101;
        else if (((pixel_index >= 53) && (pixel_index <= 54)) || ((pixel_index >= 62) && (pixel_index <= 63)) || pixel_index == 87 || pixel_index == 93 || pixel_index == 124 || pixel_index == 134 || pixel_index == 140 || pixel_index == 147 || pixel_index == 151 || pixel_index == 165) color_s6 = 16'b0001000010000010;
        else if (((pixel_index >= 56) && (pixel_index <= 57)) || (pixel_index >= 152) && (pixel_index <= 153)) color_s6 = 16'b0011100111000111;
        else if (pixel_index == 65 || pixel_index == 77 || pixel_index == 94 || pixel_index == 100 || pixel_index == 120 || pixel_index == 145) color_s6 = 16'b0100101001001001;
        else if (((pixel_index >= 68) && (pixel_index <= 69)) || ((pixel_index >= 73) && (pixel_index <= 74)) || pixel_index == 89 || pixel_index == 95 || pixel_index == 108 || pixel_index == 123 || pixel_index == 135 || pixel_index == 138) color_s6 = 16'b0001100011000011;
        else color_s6 = 0;
    end
    
    // --- Symbol 8 Logic ---
    always @(*) begin
        if (pixel_index == 17 || ((pixel_index >= 43) && (pixel_index <= 44)) || pixel_index == 60 || pixel_index == 82) color_s7 = 16'b0001000010000010;
        else if (pixel_index == 18 || pixel_index == 77 || pixel_index == 97) color_s7 = 16'b0001100011000011;
        else if (pixel_index == 19 || pixel_index == 50 || pixel_index == 95) color_s7 = 16'b0000100001000001;
        else if (pixel_index == 27 || pixel_index == 96 || pixel_index == 134 || pixel_index == 145) color_s7 = 16'b0101101011001011;
        else if (pixel_index == 28 || pixel_index == 139) color_s7 = 16'b1010110101110101;
        else if (((pixel_index >= 29) && (pixel_index <= 30)) || pixel_index == 83 || pixel_index == 115) color_s7 = 16'b1100011000111000;
        else if (pixel_index == 31 || pixel_index == 61) color_s7 = 16'b1100111001111001;
        else if ((pixel_index >= 32) && (pixel_index <= 33)) color_s7 = 16'b1011110111110111;
        else if (pixel_index == 34 || pixel_index == 63 || pixel_index == 146) color_s7 = 16'b0111101111001111;
        else if (pixel_index == 35 || pixel_index == 100 || pixel_index == 106) color_s7 = 16'b0010100101000101;
        else if (pixel_index == 40) color_s7 = 16'b1010010100110100;
        else if (pixel_index == 41 || pixel_index == 48 || pixel_index == 75 || (pixel_index >= 101) && (pixel_index <= 102)) color_s7 = 16'b1111011110111110;
        else if (pixel_index == 42 || pixel_index == 74 || pixel_index == 84) color_s7 = 16'b0100001000001000;
        else if (pixel_index == 45 || pixel_index == 105 || pixel_index == 144 || pixel_index == 151) color_s7 = 16'b0010000100000100;
        else if (pixel_index == 46 || pixel_index == 135) color_s7 = 16'b0101001010001010;
        else if (pixel_index == 47) color_s7 = 16'b1101011010111010;
        else if (pixel_index == 49 || pixel_index == 113 || pixel_index == 136 || (pixel_index >= 147) && (pixel_index <= 148)) color_s7 = 16'b1000010000010000;
        else if (pixel_index == 53) color_s7 = 16'b0110101101001101;
        else if (pixel_index == 54 || pixel_index == 149) color_s7 = 16'b1000110001010001;
        else if (pixel_index == 62 || ((pixel_index >= 88) && (pixel_index <= 89)) || pixel_index == 114 || pixel_index == 126 || pixel_index == 132) color_s7 = 16'b1111111111111111;
        else if (pixel_index == 76 || pixel_index == 127 || pixel_index == 138) color_s7 = 16'b1110111101111101;
        else if (pixel_index == 87 || pixel_index == 103 || pixel_index == 128 || pixel_index == 140) color_s7 = 16'b0011000110000110;
        else if (pixel_index == 90) color_s7 = 16'b0011100111000111;
        else if (pixel_index == 118 || pixel_index == 131) color_s7 = 16'b1001110011110011;
        else if (pixel_index == 119) color_s7 = 16'b1101111011111011;
        else if (pixel_index == 125) color_s7 = 16'b0100101001001001;
        else if (pixel_index == 133) color_s7 = 16'b1001010010110010;
        else if (pixel_index == 137) color_s7 = 16'b1011010110110110;
        else if (pixel_index == 150) color_s7 = 16'b0110001100001100;
        else color_s7 = 0;
    end

    // --- Final Multiplexer (The Efficient Switch) ---
    always @(*) begin
        case (symbol_id)
            3'd0:    out_color = color_s0;
            3'd1:    out_color = color_s1; // Your Symbol 1 logic
            3'd2:    out_color = color_s2;
            3'd3:    out_color = color_s3;
            3'd4:    out_color = color_s4;
            3'd5:    out_color = color_s5;
            3'd6:    out_color = color_s6;
            3'd7:    out_color = color_s7;
            default: out_color = 16'h0000; // Safety catch-all
        endcase
    end
endmodule