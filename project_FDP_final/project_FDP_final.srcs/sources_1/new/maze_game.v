`timescale 1ns / 1ps

module maze_game(
    input clk,                    // 100MHz System Clock
    input btnU, btnD, btnL, btnR, // Movement buttons
    input reset,                  
    
    input [2:0] player_health,    // Starting health input
    input enable_flag,            // High when this game is active

    input [15:0] pixel_index_B,   // Screen B (Player layer)
    input [15:0] pixel_index_A,   // Screen A (Maze layer)
    output reg [15:0] oled_data_B,
    output reg [15:0] oled_data_A,
    output reg win_flag = 0,
    output reg [2:0] player_health_new
);

    // --- Internal Signals ---
    reg [3:0] p_x = 0; 
    reg [2:0] p_y = 0;
    reg [2:0] maze_sel_reg = 0;
    reg [21:0] lockout_timer = 0; 
    reg init_done = 0;
    parameter LOCKOUT_VAL = 10_000_000; 

    // --- 1. LFSR & Maze Selection ---
    reg [7:0] lfsr = 8'hA5; 
    reg lfsr_done = 0;

    
        always @(posedge clk) begin
            if (reset) begin
                lfsr <= 8'hA5; // Default seed
            end else begin
                // LFSR runs constantly at 100MHz
                lfsr <= {lfsr[6:0], (lfsr[7] ^ lfsr[5] ^ lfsr[4] ^ lfsr[3])};
            end
        end
    
        // Snap a value only when the game starts
        always @(posedge clk) begin
            if (reset || !enable_flag) begin
                lfsr_done <= 0;
            end else if (enable_flag && !lfsr_done) begin
                maze_sel_reg <= lfsr[2:0]; // Grabs a "random" index 0-7
                lfsr_done <= 1;           // Locks the maze for the session
            end
        end

    // --- 2. Maze ROM Definition (2D Array) ---
    reg [11:0] maze_rom [0:7][0:7]; 
    initial begin
        maze_rom[0][0]=12'h801; maze_rom[0][1]=12'h000; maze_rom[0][2]=12'hB6D; maze_rom[0][3]=12'h000;
        maze_rom[0][4]=12'hD6B; maze_rom[0][5]=12'h000; maze_rom[0][6]=12'h000; maze_rom[0][7]=12'h800; 
        maze_rom[1][0]=12'h811; maze_rom[1][1]=12'h010; maze_rom[1][2]=12'h811; maze_rom[1][3]=12'h010;
        maze_rom[1][4]=12'h811; maze_rom[1][5]=12'h010; maze_rom[1][6]=12'h801; maze_rom[1][7]=12'h000;
        maze_rom[2][0]=12'h001; maze_rom[2][1]=12'h000; maze_rom[2][2]=12'h0FE; maze_rom[2][3]=12'h081;
        maze_rom[2][4]=12'h0BD; maze_rom[2][5]=12'h000; maze_rom[2][6]=12'h001; maze_rom[2][7]=12'h000;
        maze_rom[3][0]=12'h801; maze_rom[3][1]=12'h000; maze_rom[3][2]=12'h7F1; maze_rom[3][3]=12'h000;
        maze_rom[3][4]=12'h8FE; maze_rom[3][5]=12'h000; maze_rom[3][6]=12'h7F1; maze_rom[3][7]=12'h800;
        maze_rom[4][0]=12'h001; maze_rom[4][1]=12'h000; maze_rom[4][2]=12'hAAA; maze_rom[4][3]=12'h000;
        maze_rom[4][4]=12'hAAA; maze_rom[4][5]=12'h000; maze_rom[4][6]=12'hAAA; maze_rom[4][7]=12'h000;
        maze_rom[5][0]=12'h801; maze_rom[5][1]=12'h000; maze_rom[5][2]=12'h000; maze_rom[5][3]=12'h707;
        maze_rom[5][4]=12'h000; maze_rom[5][5]=12'h000; maze_rom[5][6]=12'h000; maze_rom[5][7]=12'h800;
        maze_rom[6][0]=12'h801; maze_rom[6][1]=12'h000; maze_rom[6][2]=12'h7E1; maze_rom[6][3]=12'h000;
        maze_rom[6][4]=12'h07F; maze_rom[6][5]=12'h000; maze_rom[6][6]=12'h000; maze_rom[6][7]=12'h800;
        maze_rom[7][0]=12'h801; maze_rom[7][1]=12'h000; maze_rom[7][2]=12'h000; maze_rom[7][3]=12'h000;
        maze_rom[7][4]=12'h000; maze_rom[7][5]=12'h000; maze_rom[7][6]=12'h000; maze_rom[7][7]=12'h800;
    end

    // --- 3. Control & Movement Logic ---
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            p_x <= 0; p_y <= 0;
            win_flag <= 0; 
            lockout_timer <= 0; 
            init_done <= 0;
        end 
        else if (!enable_flag) begin
            p_x <= 0; p_y <= 0;
            win_flag <= 0; 
            lockout_timer <= 0; 
            init_done <= 0;
        end
        else begin
            if (!init_done) begin
                player_health_new <= player_health;
                init_done <= 1;
            end
    
            if (p_x == 11 && p_y == 7) win_flag <= 1;
    
            if (lockout_timer > 0) lockout_timer <= lockout_timer - 1;
    
            if (lockout_timer == 0 && (btnU || btnD || btnL || btnR)) begin
                lockout_timer <= LOCKOUT_VAL; 
    
                if (btnU && p_y > 0) begin
                    if (!((maze_rom[maze_sel_reg][p_y-1] >> (11 - p_x)) & 1)) p_y <= p_y - 1;
                    else player_health_new <= player_health_new - 1;
                end
                else if (btnD && p_y < 7) begin
                    if (!((maze_rom[maze_sel_reg][p_y+1] >> (11 - p_x)) & 1)) p_y <= p_y + 1;
                    else player_health_new <= player_health_new - 1;
                end
                else if (btnL && p_x > 0) begin
                    if (!((maze_rom[maze_sel_reg][p_y] >> (11 - (p_x-1))) & 1)) p_x <= p_x - 1;
                    else player_health_new <= player_health_new - 1;
                end
                else if (btnR && p_x < 11) begin
                    if (!((maze_rom[maze_sel_reg][p_y] >> (11 - (p_x+1))) & 1)) p_x <= p_x + 1;
                    else player_health_new <= player_health_new - 1;
                end
            end
        end
    end
        
    // --- 4. Rendering Logic ---
    wire [6:0] xa_pix = 95 - (pixel_index_A % 96); 
    wire [5:0] ya_pix = 63 - (pixel_index_A / 96);
    wire [3:0] ca_x = xa_pix[6:3]; 
    wire [2:0] ca_y = ya_pix[5:3];
    
    always @(*) begin
        if (ca_x == 11 && ca_y == 7) oled_data_A = 16'h07E0; 
        else if (ca_x == 0 && ca_y == 0) oled_data_A = 16'h001F; 
        else if (ca_y < 8 && ((maze_rom[maze_sel_reg][ca_y] >> (11 - ca_x)) & 1)) oled_data_A = 16'hFFFF; 
        else oled_data_A = 16'h0000;
    end

    wire [6:0] xb_pix = pixel_index_B % 96; 
    wire [5:0] yb_pix = pixel_index_B / 96;
    wire [3:0] cb_x = xb_pix[6:3]; 
    wire [2:0] cb_y = yb_pix[5:3];

    always @(*) begin
        oled_data_B = 16'h0000; 
        if (cb_x == p_x && cb_y == p_y) oled_data_B = 16'hF800; 
    end

endmodule