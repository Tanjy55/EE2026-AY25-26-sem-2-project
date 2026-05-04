`timescale 1ns / 1ps

module game_4_logic (
    input clk,
    input enable_flag,
    input [7:0] master_seed,
    input btn_u, btn_d, btn_l, btn_r, 
    input [2:0] player_health,
    input reset_flag,
    output reg [2:0] player_health_new,
    output reg win_flag = 0,
    // Flattened outputs (4 symbols * 3 bits = 12 bits)
    output [11:0] p_screen,        
    output reg [11:0] c1, c2, c3,   
    output reg [3:0] button_flag,
    output reg wrong_flag
);
    /*
    Game_number permutation table:
    permutation 1: UP, RIGHT, DOWN, LEFT
    permutation 2: RIGHT, LEFT, UP, DOWN
    permutation 3: DOWN, RIGHT, LEFT, UP
    permutation 4: LEFT, DOWN, RIGHT, UP
    permutation 5: LEFT, DOWN, UP, RIGHT
    permutation 6: RIGHT, DOWN, UP, LEFT
    permutation 7: UP, LEFT, RIGHT, DOWN
    permutation 8: DOWN, UP, RIGHT, LEFT
    */
    
    // --- State Machine States ---
    localparam INIT = 0, WAIT_PRESS = 1, VALIDATE = 2, NEXT_STEP = 3, WIN = 4, ERR = 5;
    reg [2:0] state = INIT;
    reg [1:0] step_idx = 0;
    
    // --- Internal Randomized Registers ---
    reg [2:0] perm_id;       
    reg [1:0] correct_col;   
    reg [2:0] ps0, ps1, ps2, ps3; 
    reg [2:0] os0, os1, os2, os3; 
    
    
    
    // Determine the required button (0:U, 1:R, 2:D, 3:L)
    wire [1:0] target_btn = get_target_btn(perm_id, step_idx);
    
    // --- Helper Functions (Same as before) ---
        // Returns the Button ID (0:U, 1:R, 2:D, 3:L)
        function [1:0] get_target_btn(input [2:0] p_id, input [1:0] step);
            case (p_id)
                3'd0: case(step) 0:get_target_btn=0; 1:get_target_btn=1; 2:get_target_btn=2; 3:get_target_btn=3; endcase // U, R, D, L
                3'd1: case(step) 0:get_target_btn=1; 1:get_target_btn=3; 2:get_target_btn=0; 3:get_target_btn=2; endcase // R, L, U, D
                3'd2: case(step) 0:get_target_btn=2; 1:get_target_btn=1; 2:get_target_btn=3; 3:get_target_btn=0; endcase // D, R, L, U
                3'd3: case(step) 0:get_target_btn=3; 1:get_target_btn=2; 2:get_target_btn=1; 3:get_target_btn=0; endcase // L, D, R, U
                3'd4: case(step) 0:get_target_btn=3; 1:get_target_btn=2; 2:get_target_btn=0; 3:get_target_btn=1; endcase // L, D, U, R
                3'd5: case(step) 0:get_target_btn=1; 1:get_target_btn=2; 2:get_target_btn=0; 3:get_target_btn=3; endcase // R, D, U, L
                3'd6: case(step) 0:get_target_btn=0; 1:get_target_btn=3; 2:get_target_btn=1; 3:get_target_btn=2; endcase // U, L, R, D
                3'd7: case(step) 0:get_target_btn=2; 1:get_target_btn=0; 2:get_target_btn=1; 3:get_target_btn=3; endcase // D, U, R, L
                default: get_target_btn = 0;
            endcase
        endfunction
        
        // Returns 12-bit bus. 
        // Format: {Symbol4, Symbol3, Symbol2, Symbol1} 
        // Symbol 1 (bits 2:0) is the FIRST symbol the player must match.
        function [11:0] get_sym_seq(input [2:0] p_id, input [2:0] s0, s1, s2, s3);
            case (p_id)
                // Perm 1: U, R, D, L -> {s3, s2, s1, s0}
                3'd0: get_sym_seq = {s3, s2, s1, s0}; 
                // Perm 2: R, L, U, D -> {s2, s0, s3, s1}
                3'd1: get_sym_seq = {s2, s0, s3, s1}; 
                // Perm 3: D, R, L, U -> {s0, s3, s1, s2}
                3'd2: get_sym_seq = {s0, s3, s1, s2}; 
                // Perm 4: L, D, R, U -> {s0, s1, s2, s3}
                3'd3: get_sym_seq = {s0, s1, s2, s3}; 
                // Perm 5: L, D, U, R -> {s1, s0, s2, s3}
                3'd4: get_sym_seq = {s1, s0, s2, s3}; 
                // Perm 6: R, D, U, L -> {s3, s0, s2, s1}
                3'd5: get_sym_seq = {s3, s0, s2, s1}; 
                // Perm 7: U, L, R, D -> {s2, s1, s3, s0}
                3'd6: get_sym_seq = {s2, s1, s3, s0}; 
                // Perm 8: D, U, R, L -> {s3, s1, s0, s2}
                3'd7: get_sym_seq = {s3, s1, s0, s2}; 
                default: get_sym_seq = {s3, s2, s1, s0};
            endcase
        endfunction
    
    
        wire is_correct_press = (btn_u && target_btn == 2'd0) || 
                               (btn_r && target_btn == 2'd1) ||
                               (btn_d && target_btn == 2'd2) || 
                               (btn_l && target_btn == 2'd3);
        
        wire is_any_press     = (btn_u || btn_r || btn_d || btn_l);
        
        // Timer
        reg [26:0] wrong_timer = 0;
        
        always @(posedge clk) begin
            // If a button is pressed but it's NOT the correct one while in WAIT_PRESS
            if (is_any_press && !is_correct_press && state == WAIT_PRESS) begin
                wrong_timer <= 27'd100_000_000; // Trigger/Restart 1-second timer
            end 
            else if (wrong_timer > 0) begin
                wrong_timer <= wrong_timer - 1;
            end
            
            // Drive the flag output
            wrong_flag <= (wrong_timer > 0);
        end
    
    // FSM
    always @(posedge clk) begin
        if (!enable_flag || reset_flag) begin
            state <= INIT;
            win_flag <= 0;
            button_flag <= 4'b0000;
        end else begin
            case (state)
                INIT: begin
                    player_health_new <= player_health;
                    step_idx <= 0;
                    
                    // Seed Mapping (8 bits total used)
                    perm_id     <= master_seed[2:0]; // 0-7 Permutations
                    // Bits [5:3] used for Set Rotation below
                    correct_col <= master_seed[7:6]; // 0-3
                    
                    // 8-Set Symbol Rotation Logic
                    /*
                    ps0 UP
                    ps1 RIGHT
                    ps2 DOWN
                    ps3 LEFT
                    */
                    case (master_seed[5:3])
                        3'd0: begin {ps0,ps1,ps2,ps3} = {3'd0,3'd1,3'd2,3'd3}; {os0,os1,os2,os3} = {3'd4,3'd5,3'd6,3'd7}; end
                        3'd1: begin {ps0,ps1,ps2,ps3} = {3'd1,3'd2,3'd3,3'd4}; {os0,os1,os2,os3} = {3'd5,3'd6,3'd7,3'd0}; end
                        3'd2: begin {ps0,ps1,ps2,ps3} = {3'd2,3'd3,3'd4,3'd5}; {os0,os1,os2,os3} = {3'd6,3'd7,3'd0,3'd1}; end
                        3'd3: begin {ps0,ps1,ps2,ps3} = {3'd3,3'd4,3'd5,3'd6}; {os0,os1,os2,os3} = {3'd7,3'd0,3'd1,3'd2}; end
                        3'd4: begin {ps0,ps1,ps2,ps3} = {3'd4,3'd5,3'd6,3'd7}; {os0,os1,os2,os3} = {3'd0,3'd1,3'd2,3'd3}; end
                        3'd5: begin {ps0,ps1,ps2,ps3} = {3'd5,3'd6,3'd7,3'd0}; {os0,os1,os2,os3} = {3'd1,3'd2,3'd3,3'd4}; end
                        3'd6: begin {ps0,ps1,ps2,ps3} = {3'd6,3'd7,3'd0,3'd1}; {os0,os1,os2,os3} = {3'd2,3'd3,3'd4,3'd5}; end
                        3'd7: begin {ps0,ps1,ps2,ps3} = {3'd7,3'd0,3'd1,3'd2}; {os0,os1,os2,os3} = {3'd3,3'd4,3'd5,3'd6}; end
                    endcase
                    state <= WAIT_PRESS;
                end

                WAIT_PRESS: begin
                    if (is_any_press) begin
                        if (is_correct_press) begin
                            // Success Logic
                            case (target_btn)
                                2'd0: button_flag[0] <= 1'b1;
                                2'd1: button_flag[1] <= 1'b1;
                                2'd2: button_flag[2] <= 1'b1;
                                2'd3: button_flag[3] <= 1'b1;
                            endcase
                            state <= NEXT_STEP; 
                        end 
                        else begin
                            // Wrong Press Logic
                            player_health_new <= player_health_new - 1;
                            // The timer block above will catch this and handle wrong_flag
                            state <= WAIT_PRESS; 
                        end
                    end
                end
                
                NEXT_STEP: begin
                    if (step_idx == 2'd3) state <= WIN;
                    else begin
                        step_idx <= step_idx + 1;
                        state <= WAIT_PRESS;
                    end
                end

                WIN: win_flag <= 1;
            endcase
        end
    end

    // --- Output Logic ---
    assign p_screen = {ps3, ps2, ps1, ps0};

    always @(*) begin
        case (correct_col % 3) // Modulo ensures 2'd3 falls back to 2'd0
            2'd0: begin 
                c1 = get_sym_seq(perm_id, ps0, ps1, ps2, ps3);
                c2 = {ps2, ps1, ps0, os0}; 
                c3 = {os3, os2, ps1, ps0}; 
            end
            2'd1: begin 
                c1 = {ps0, ps2, os1, ps3}; 
                c2 = get_sym_seq(perm_id, ps0, ps1, ps2, ps3);
                c3 = {os0, os2, ps2, ps1};
            end
            default: begin 
                c1 = {os1, ps0, ps1, os2};
                c2 = {ps3, os3, ps1, ps0};
                c3 = get_sym_seq(perm_id, ps0, ps1, ps2, ps3);
            end
        endcase
    end
endmodule