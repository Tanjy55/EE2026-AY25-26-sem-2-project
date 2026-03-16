`timescale 1ns / 1ps

module top_timer(
    input clk,           // 100MHz Basys 3 clock
    input begin_flag,
    output [3:0] an,     // 4-digit select
    output [6:0] seg,    // 7-segment segments
    output dp,           // Decimal point
    output [3:0] JC,      // Pmod Header JC (Pins 1-4)
    output death_flag
);

    // --- Registers ---
    reg [26:0] clk_div;       
    reg [3:0] m1, m0, s1, s0; 
    reg [15:0] audio_timer;   
    reg speaker_reg;          
    
    // Explosion Logic (0.4s)
    reg [15:0] noise_reg = 16'hB011; // LFSR Noise Seed
    reg [25:0] blast_duration;       // 40 million cycles = 0.4 seconds
    reg [17:0] rumble_div;           
    reg blast_done;                 
    
    wire time_up = (m1==0 && m0==0 && s1==0 && s0==0);
    wire ten_sec_left = (m1==0 && m0==0 && s1==0 && s0<=10 && s0>0);
    assign death_flag = time_up;
    
    initial begin
        m1 = 0; m0 = 3; s1 = 0; s0 = 0; // Starts at 03:00
        clk_div = 0;
        blast_done = 0;
        blast_duration = 0;
        speaker_reg = 0;
        audio_timer = 0;
    end

    // --- 1. Countdown Logic ---
    always @(posedge clk) begin
    if(begin_flag == 1) begin
        if (!time_up) begin
            if (clk_div >= 99_999_999) begin
                clk_div <= 0;
                if (s0 == 0) begin
                    s0 <= 9;
                    if (s1 == 0) begin
                        s1 <= 5;
                        if (m0 == 0) begin m0 <= 9; m1 <= m1 - 1; end
                        else m0 <= m0 - 1;
                    end else s1 <= s1 - 1;
                end else s0 <= s0 - 1;
            end else clk_div <= clk_div + 1;
        end
        end
    end

    // --- 2. 0.4s "Explosion" Audio Logic ---
    always @(posedge clk) begin
        // High-speed Noise Generation (LFSR)
        noise_reg <= {noise_reg[14:0], noise_reg[15] ^ noise_reg[13] ^ noise_reg[12] ^ noise_reg[10]};

        if (time_up && !blast_done) begin
            // Explosion Pitch Drop:
            // Threshold increases based on time to drop frequency.
            // threshold = blast_duration[25:11] for a 0.4s window.
            if (rumble_div >= (blast_duration[25:11] + 4)) begin 
                rumble_div <= 0;
                speaker_reg <= noise_reg[0];
            end else begin
                rumble_div <= rumble_div + 1;
            end

            // 0.4-second cutoff (40,000,000 cycles)
            if (blast_duration >= 39_999_999) begin
                blast_done <= 1;
                speaker_reg <= 0;
            end else begin
                blast_duration <= blast_duration + 1;
            end
        end else if (!time_up) begin
            blast_done <= 0;
            blast_duration <= 0;
            rumble_div <= 0;
            
            // Standard Tics
            if (ten_sec_left) begin
                if (clk_div == 0 || clk_div == 50_000_000) audio_timer <= 16'hFFFF;
                if (audio_timer > 0) begin
                    speaker_reg <= clk_div[14];
                    audio_timer <= audio_timer - 1;
                end else speaker_reg <= 0;
            end else begin
                if (clk_div == 0) audio_timer <= 16'h7FFF;
                if (audio_timer > 0) begin
                    speaker_reg <= clk_div[14];
                    audio_timer <= audio_timer - 1;
                end else speaker_reg <= 0;
            end
        end else begin
            speaker_reg <= 0; 
        end
    end

    // Drive all 4 JC pins for maximum volume (80 dB target)
    assign JC = {4{speaker_reg}};

    // --- 3. Display Multiplexing ---
    reg [17:0] refresh_counter; 
    reg [3:0] digit_val;

    always @(posedge clk) refresh_counter <= refresh_counter + 1;

    always @(*) begin
        case(refresh_counter[17:16])
            2'b00: digit_val = s0;
            2'b01: digit_val = s1;
            2'b10: digit_val = m0;
            2'b11: digit_val = m1;
        endcase
    end
    
    assign an = (refresh_counter[17:16] == 2'b00) ? 4'b1110 :
                (refresh_counter[17:16] == 2'b01) ? 4'b1101 :
                (refresh_counter[17:16] == 2'b10) ? 4'b1011 : 4'b0111;

    assign dp = (refresh_counter[17:16] == 2'b10) ? 1'b0 : 1'b1;

    assign seg = (digit_val == 4'h0) ? 7'b1000000 :
                 (digit_val == 4'h1) ? 7'b1111001 :
                 (digit_val == 4'h2) ? 7'b0100100 :
                 (digit_val == 4'h3) ? 7'b0110000 :
                 (digit_val == 4'h4) ? 7'b0011001 :
                 (digit_val == 4'h5) ? 7'b0010010 :
                 (digit_val == 4'h6) ? 7'b0000010 :
                 (digit_val == 4'h7) ? 7'b1111000 :
                 (digit_val == 4'h8) ? 7'b0000000 : 7'b0010000;

endmodule