`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  GROUP: S6.04
//  GAME: BOMB SQUAD
//  STUDENT A NAME: DEXTER PEH 
//  STUDENT B NAME: KOH HEDLEY 
//  STUDENT C NAME: ER CHEN WEN 
//  STUDENT D NAME: TAN JUN YI 
//
//////////////////////////////////////////////////////////////////////////////////
module Top_Student (
    input clk,
    input btnC, btnL, btnR, btnD, btnU,
    input [15:0] sw,
    inout PS2Clk,             
    inout PS2Data,            
    output [7:0] JB,
    output reg [3:0] JC,
    output [7:0] JA,
    output [3:0] an,
    output [6:0] seg,
    output dp,
    output reg [15:0] led
);    

    //------------ BUTTON AND PULSE VARIABLES  ------------------
    // Debouncing         
    wire btnU_debounced;  
    wire btnL_debounced;  
    wire btnR_debounced;  
    wire btnD_debounced;  
    wire btnC_debounced;  
    
    // Pulses      
    reg u_prev = 0;
    reg r_prev = 0;
    reg d_prev = 0;
    reg l_prev = 0;
    reg c_prev = 0;
    wire u_pulse;
    wire r_pulse;
    wire d_pulse;
    wire l_pulse;
    wire c_pulse;
    
    
    
    //------------ WIRE AND REG FOR MULTIPLEXING  ------------------
    reg [15:0] final_oled_A;
    reg [15:0] final_oled_B;
    wire [15:0] oled_data_start;
    wire [15:0] oled_data_start_instructions;
    wire [15:0] oled_data_reset_instructions;
    wire [15:0] oled_data_exploded;
    wire [15:0] oled_data_diffused;
    wire [15:0] oled_data_g1_A;
    wire [15:0] oled_data_g1_B;
    wire [15:0] oled_data_g2_A;
    wire [15:0] oled_data_g2_B;     
    wire [15:0] oled_data_g3_A;
    wire [15:0] oled_data_g3_B;
    wire [15:0] oled_data_g4_A;
    wire [15:0] oled_data_g4_B;
    wire [3:0] audio_timer;
    wire [3:0] audio_game_2;
    
    
    
    // ------------ GAME STATE VARIABLES ------------------
    reg begin_flag = 1'b0;
    reg death_flag = 1'b0;
    reg success_flag = 1'b0;
    reg reset_flag = 1'b0;
    reg enable_g1 = 1'b0;
    reg enable_g2 = 1'b0;
    reg enable_g3 = 1'b0;
    reg enable_g4 = 1'b0;
    wire win_flag_g1;            
    wire win_flag_g2;
    wire win_flag_g3;
    wire win_flag_g4;
    reg [4:0] shuffle_count = 0;
    reg [1:0] lvl1_id;
    reg [1:0] lvl2_id;
    reg [1:0] lvl3_id;
    reg [1:0] lvl4_id;
    reg [2:0] current_stage = 0;
    reg g1_flag_prev = 0;                   
    reg g2_flag_prev = 0;                   
    reg g3_flag_prev = 0;                   
    reg g4_flag_prev = 0;                   
    
   
   
    //-------------- GLOBAL HEALTH VARIABLES------------------
    reg [2:0] active_game_health = 3'd7;
    wire [2:0] health_new_g1;
    wire [2:0] health_new_g2;
    wire [2:0] health_new_g3;
    wire [2:0] health_new_g4;
    reg [25:0] counter;    
    reg [25:0] counter_2;    
    reg led_flickering = 1'b0; 
    wire time_up_flag;         
    
    
    // ------------ OLED DRIVER INIT ------------------
    reg [3:0] clk_count = 0;    
    reg clk6p25m = 0;
    wire cs_B, sdin_B, sclk_B, d_cn_B, resn_B, vccen_B, pmoden_B;
    wire frame_begin_B;                                       
    wire sending_pixels_B;
    wire sample_pixel_B;
    wire [15:0] pixel_index_B;
    reg [15:0] oled_data_B;
    
    wire cs_A, sdin_A, sclk_A, d_cn_A, resn_A, vccen_A, pmoden_A;
    wire frame_begin_A;                                       
    wire sending_pixels_A;
    wire sample_pixel_A;
    wire [15:0] pixel_index_A;
    reg [15:0] oled_data_A;
    
    // 6.25MHz clock gen for oled
    always @ (posedge clk) begin
        if (clk_count == 7) begin                           
            clk_count <= 0;
            clk6p25m <= ~clk6p25m; 
        end else begin
            clk_count <= clk_count + 1;
        end      
    end
    
     Oled_Display JB_OLED (
      .clk(clk6p25m),
      .reset(0), 
      .pixel_data(final_oled_B),
      .frame_begin(frame_begin_B),    
      .sending_pixels(sending_pixels_B),
      .sample_pixel(sample_pixel_B), 
      .pixel_index(pixel_index_B), 
      .cs(cs_B),                
      .sdin(sdin_B),            
      .sclk(sclk_B), 
      .d_cn(d_cn_B), 
      .resn(resn_B), 
      .vccen(vccen_B),
      .pmoden(pmoden_B)
    );
        
    assign JB[0] = cs_B;
    assign JB[1] = sdin_B;
    assign JB[2] = 1'b0;
    assign JB[3] = sclk_B;
    assign JB[4] = d_cn_B;
    assign JB[5] = resn_B;
    assign JB[6] = vccen_B;
    assign JB[7] = pmoden_B;
    
     Oled_Display JXADC_OLED (
      .clk(clk6p25m),
      .reset(0), 
      .pixel_data(final_oled_A),
      .frame_begin(frame_begin_A),    
      .sending_pixels(sending_pixels_A),
      .sample_pixel(sample_pixel_A), 
      .pixel_index(pixel_index_A), 
      .cs(cs_A),                
      .sdin(sdin_A),            
      .sclk(sclk_A), 
      .d_cn(d_cn_A), 
      .resn(resn_A), 
      .vccen(vccen_A),
      .pmoden(pmoden_A)
    );
        
    assign JA[0] = cs_A;
    assign JA[1] = sdin_A;
    assign JA[2] = 1'b0;
    assign JA[3] = sclk_A;
    assign JA[4] = d_cn_A;
    assign JA[5] = resn_A;
    assign JA[6] = vccen_A;
    assign JA[7] = pmoden_A;
                  
                  
                    
    //------------ BUTTONS AND PULSE INITIALISATION ------------------
    debouncer db1(clk, btnU, btnU_debounced);
    debouncer db2(clk, btnL, btnL_debounced);
    debouncer db3(clk, btnR, btnR_debounced);
    debouncer db4(clk, btnD, btnD_debounced);  
    debouncer db5(clk, btnC, btnC_debounced);  
    
    always @(posedge clk) begin
        u_prev <= btnU_debounced;
        r_prev <= btnR_debounced;
        d_prev <= btnD_debounced;
        l_prev <= btnL_debounced;
        c_prev <= btnC_debounced;
    end

    assign u_pulse = (btnU_debounced && !u_prev);
    assign r_pulse = (btnR_debounced && !r_prev);
    assign d_pulse = (btnD_debounced && !d_prev);
    assign l_pulse = (btnL_debounced && !l_prev);
    assign c_pulse = (btnC_debounced && !c_prev);



    //--------------------- OLED_DATA MULTIPLEXING ---------------------------
    always @(*) begin

        case (1'b1) 
            death_flag: begin
                // Death condition, show exploded on right and reset on left
                final_oled_A = oled_data_reset_instructions;
                final_oled_B = oled_data_exploded;
                JC[3:0] = audio_timer[3:0];
            end
            enable_g1: begin
                // Show game 1
                final_oled_A = oled_data_g1_A;
                final_oled_B = oled_data_g1_B;
                JC[3:0] = audio_timer[3:0];
            end
            enable_g2: begin
                // Show game 2
                final_oled_A = oled_data_g2_A;
                final_oled_B = oled_data_g2_B;
                JC[3:0] = audio_game_2[3:0];
            end
            enable_g3: begin
                // Show game 3
                final_oled_A = oled_data_g3_A;
                final_oled_B = oled_data_g3_B;
                JC[3:0] = audio_timer[3:0];
            end
            enable_g4: begin
                // Show game 4
                final_oled_A = oled_data_g4_A;
                final_oled_B = oled_data_g4_B;
                JC[3:0] = audio_timer[3:0];
            end
            success_flag: begin
                // Win condition, show diffused on right and rest on left
                final_oled_A = oled_data_reset_instructions;
                final_oled_B = oled_data_diffused;
                JC[3:0] = audio_timer[3:0];
            end
            default: begin
                // Wait for start, show start on right and instruction on left
                final_oled_A <= oled_data_start_instructions; 
                final_oled_B <= oled_data_start;
            end
        endcase
    end
        
        
        
    //-------------------------- GLOBAL HEALTH LOGIC ---------------------------
    always @(posedge clk) begin
        counter_2 <= counter_2 + 1'b1;
    
        // RESET STATE
        if ((death_flag || success_flag) && (u_pulse || d_pulse || l_pulse || r_pulse || c_pulse)) begin
            reset_flag   <= 1;
            begin_flag   <= 0;
            death_flag   <= 0;
            success_flag <= 0;
        end 
        
        // START STATE
        else if (!begin_flag && (u_pulse || d_pulse || l_pulse || r_pulse || c_pulse)) begin
            begin_flag <= 1;            
        end 
    
        // 3. TRAPS (Stay on End Screens)
        else if (success_flag || death_flag) begin
            // Trap here until a pulse hits Priority cases
        end
    
        // 4. WAIT STATE (Idle)
        else if (!begin_flag) begin
            active_game_health <= 3'd3;
            reset_flag <= 0;
            counter_2  <= 26'd0;
        end 
    
        // 5. PLAYING STATE
        else if (begin_flag) begin
            // Periodic Health Check
            if (counter_2 >= 26'd999_999) begin
                counter_2 <= 26'd0;
                if (time_up_flag || (active_game_health == 3'd0)) begin  
                   death_flag <= 1;
                   begin_flag <= 0; 
                end
            end
            
            // WIN DETECTION 
            // We moved this out of the "current_stage < 4" gate so it can actually fire
            if (current_stage >= 3'd4 && !reset_flag) begin
                success_flag <= 1;
                begin_flag   <= 0; 
            end
            
            // Health Update from Games
            if (!death_flag && !success_flag) begin
                case (1'b1)
                    enable_g1: active_game_health <= health_new_g1;
                    enable_g2: active_game_health <= health_new_g2;
                    enable_g3: active_game_health <= health_new_g3;
                    enable_g4: active_game_health <= health_new_g4;
                endcase
            end
        end 
    end
    
    // LED Flickering Logic
    always @(posedge clk) begin   
        if (counter == 26'd49_999_999) begin //every 0.5second or 0.5Hz
                counter <= 26'd0;
                led_flickering <= ~led_flickering;
                
            end else counter <= counter + 1'b1;
        
        // LED Assignment
        led[0] <= ((active_game_health < 3) || !begin_flag) ? 1'b0 : led_flickering;
        led[1] <= ((active_game_health < 2) || !begin_flag) ? 1'b0 : led_flickering;
        led[2] <= ((active_game_health < 1) || !begin_flag) ? 1'b0 : led_flickering;
    end
    
    
    
    // ----------------------------------- GAME ORDER RANDOMISATION AND SELECTION ------------------------------------------------
    always @(posedge clk) begin
        if (shuffle_count == 23) shuffle_count <= 0;
        else shuffle_count <= shuffle_count + 1;
    end
    
    always @(posedge clk) begin
        if (!begin_flag) begin //sample the order when begin flag
            case (shuffle_count)
                // Starts with Game 1 (2'd0)
                5'd0:  {lvl1_id, lvl2_id, lvl3_id, lvl4_id} <= {2'd0, 2'd1, 2'd2, 2'd3};
                5'd1:  {lvl1_id, lvl2_id, lvl3_id, lvl4_id} <= {2'd0, 2'd1, 2'd3, 2'd2};
                5'd2:  {lvl1_id, lvl2_id, lvl3_id, lvl4_id} <= {2'd0, 2'd2, 2'd1, 2'd3};
                5'd3:  {lvl1_id, lvl2_id, lvl3_id, lvl4_id} <= {2'd0, 2'd2, 2'd3, 2'd1};
                5'd4:  {lvl1_id, lvl2_id, lvl3_id, lvl4_id} <= {2'd0, 2'd3, 2'd1, 2'd2};
                5'd5:  {lvl1_id, lvl2_id, lvl3_id, lvl4_id} <= {2'd0, 2'd3, 2'd2, 2'd1};
                
                // Starts with Game 2 (2'd1)
                5'd6:  {lvl1_id, lvl2_id, lvl3_id, lvl4_id} <= {2'd1, 2'd0, 2'd2, 2'd3};
                5'd7:  {lvl1_id, lvl2_id, lvl3_id, lvl4_id} <= {2'd1, 2'd0, 2'd3, 2'd2};
                5'd8:  {lvl1_id, lvl2_id, lvl3_id, lvl4_id} <= {2'd1, 2'd2, 2'd0, 2'd3};
                5'd9:  {lvl1_id, lvl2_id, lvl3_id, lvl4_id} <= {2'd1, 2'd2, 2'd3, 2'd0};
                5'd10: {lvl1_id, lvl2_id, lvl3_id, lvl4_id} <= {2'd1, 2'd3, 2'd0, 2'd2};
                5'd11: {lvl1_id, lvl2_id, lvl3_id, lvl4_id} <= {2'd1, 2'd3, 2'd2, 2'd0};
                
                // Starts with Game 3 (2'd2)
                5'd12: {lvl1_id, lvl2_id, lvl3_id, lvl4_id} <= {2'd2, 2'd0, 2'd1, 2'd3};
                5'd13: {lvl1_id, lvl2_id, lvl3_id, lvl4_id} <= {2'd2, 2'd0, 2'd3, 2'd1};
                5'd14: {lvl1_id, lvl2_id, lvl3_id, lvl4_id} <= {2'd2, 2'd1, 2'd0, 2'd3};
                5'd15: {lvl1_id, lvl2_id, lvl3_id, lvl4_id} <= {2'd2, 2'd1, 2'd3, 2'd0};
                5'd16: {lvl1_id, lvl2_id, lvl3_id, lvl4_id} <= {2'd2, 2'd3, 2'd0, 2'd1};
                5'd17: {lvl1_id, lvl2_id, lvl3_id, lvl4_id} <= {2'd2, 2'd3, 2'd1, 2'd0};
                
                // Starts with Game 4 (2'd3)
                5'd18: {lvl1_id, lvl2_id, lvl3_id, lvl4_id} <= {2'd3, 2'd0, 2'd1, 2'd2};
                5'd19: {lvl1_id, lvl2_id, lvl3_id, lvl4_id} <= {2'd3, 2'd0, 2'd2, 2'd1};
                5'd20: {lvl1_id, lvl2_id, lvl3_id, lvl4_id} <= {2'd3, 2'd1, 2'd0, 2'd2};
                5'd21: {lvl1_id, lvl2_id, lvl3_id, lvl4_id} <= {2'd3, 2'd1, 2'd2, 2'd0};
                5'd22: {lvl1_id, lvl2_id, lvl3_id, lvl4_id} <= {2'd3, 2'd2, 2'd0, 2'd1};
                5'd23: {lvl1_id, lvl2_id, lvl3_id, lvl4_id} <= {2'd3, 2'd2, 2'd1, 2'd0};
            endcase
        end
    end
       
    always @(*) begin
    // Default: Everything is OFF. This ensures the other enables are 0
     enable_g1 = 0;
     enable_g2 = 0;
     enable_g3 = 0;
     enable_g4 = 0;
    
     // Only assign an enable if the game has actually started
     if (begin_flag) begin
         case (current_stage)
            3'd0: begin // Level 1
                if      (lvl1_id == 2'd0) enable_g1 = 1;
                else if (lvl1_id == 2'd1) enable_g2 = 1;
                else if (lvl1_id == 2'd2) enable_g3 = 1;
                else                      enable_g4 = 1;
            end
            3'd1: begin // Level 2
                if      (lvl2_id == 2'd0) enable_g1 = 1;
                else if (lvl2_id == 2'd1) enable_g2 = 1;
                else if (lvl2_id == 2'd2) enable_g3 = 1;
                else                      enable_g4 = 1;
            end
            3'd2: begin // Level 3
                if      (lvl3_id == 2'd0) enable_g1 = 1;
                else if (lvl3_id == 2'd1) enable_g2 = 1;
                else if (lvl3_id == 2'd2) enable_g3 = 1;
                else                      enable_g4 = 1;
            end
            3'd3: begin // Level 4
                if      (lvl4_id == 2'd0) enable_g1 = 1;
                else if (lvl4_id == 2'd1) enable_g2 = 1;
                else if (lvl4_id == 2'd2) enable_g3 = 1;
                else                      enable_g4 = 1;
            end
            3'd4: begin // Win
                enable_g1 = 0;
                enable_g2 = 0;
                enable_g3 = 0;
                enable_g4 = 0;
            end
            endcase
        end
        
        // If dead, disable all games at highest priority
        if (death_flag) begin
            enable_g1 = 0;
            enable_g2 = 0;
            enable_g3 = 0;
            enable_g4 = 0;
        end
    end
    
    
    always @(posedge clk) begin
         // Store the previous state of win flags to detect the "rising edge"
         g1_flag_prev <= win_flag_g1;
         g2_flag_prev <= win_flag_g2;
         g3_flag_prev <= win_flag_g3;
         g4_flag_prev <= win_flag_g4;
         
         if (reset_flag) current_stage <= 0;
     
         if (begin_flag) begin
             // If any game reports a NEW win, move to the next stage
             if ((win_flag_g1 && !g1_flag_prev) || 
                 (win_flag_g2 && !g2_flag_prev) || 
                 (win_flag_g3 && !g3_flag_prev) || 
                 (win_flag_g4 && !g4_flag_prev)) 
             begin
                 current_stage <= current_stage + 1;
             end
         end 
     end
    
    

//-------------------GAME MODULES INITIALISATION -------------------------
    top_timer timer(.clk(clk),           // 100MHz Basys 3 clock
                    .begin_flag(begin_flag),
                    .death_flag(death_flag),
                    .success_flag(success_flag),
                    .reset(reset_flag),
                    .time_up_flag(time_up_flag),
                    .an(an[3:0]),     // 4-digit select
                    .seg(seg [6:0]),    // 7-segment segments
                    .dp(dp),           // Decimal point
                    .JC(audio_timer)      // Pmod Header JC (Pins 1-4)
                    );
                    
    start_screen start_screen (clk,
                               pixel_index_B,
                               oled_data_start);
                                
    exploded_screen exploded_screen (clk,
                                     pixel_index_B,
                                     oled_data_exploded);
                                     
    diffused_screen diffused_screen (clk,
                                      pixel_index_B,
                                      oled_data_diffused);
                                      
    start_instructions_screen start_instructions_screen (clk,
                                                        pixel_index_A,
                                                        oled_data_start_instructions);
                                                        
    reset_instructions_screen reset_instructions_screen (clk,
                                                        pixel_index_A,
                                                        oled_data_reset_instructions);
                                                                          

    cut_the_wire_game chen_wen_game (.clk(clk),
                                     .output_btnU(btnU_debounced),
                                     .output_btnC(btnC_debounced),
                                     .output_btnL(btnL_debounced),
                                     .output_btnR(btnR_debounced),
                                     .reset(reset_flag),
                                     .sw(sw),
                                     .PS2Clk(PS2Clk),
                                     .PS2Data(PS2Data),
                                     .game_start(enable_g1),
                                     .player_health(active_game_health),
                                     .pixel_index(pixel_index_B),
                                     .pixel_index_A(pixel_index_A),
                                     .win_flag(win_flag_g1),
                                     .oled_data(oled_data_g1_B),
                                     .oled_data_A(oled_data_g1_A),
                                     .remaining_health(health_new_g1));
                                     
                    
     game_2 dexter_game (.clk(clk),
                         .btnU_db(btnU_debounced),
                         .btnD_db(btnD_debounced),
                         .btnL_db(btnL_debounced),
                         .btnR_db(btnR_debounced),
                         .reset(reset_flag),
                         .player_health(active_game_health),
                         .pixel_index_B(pixel_index_B),
                         .pixel_index_A(pixel_index_A),
                         .enable_flag(enable_g2),
                         .oled_data_A(oled_data_g2_A),
                         .oled_data_B(oled_data_g2_B),
                         .JC(audio_game_2),
                         .player_health_new(health_new_g2),
                         .win_flag(win_flag_g2));         
  
  maze_game hedley_game (.clk(clk),                                                      
                         .btnL(l_pulse), .btnR(r_pulse), .btnD(d_pulse), .btnU(u_pulse), 
                         .reset(reset_flag),
                         .player_health(active_game_health),                             
                         .pixel_index_B(pixel_index_B),                                  
                         .pixel_index_A(pixel_index_A),                                  
                         .enable_flag(enable_g3),                                        
                         .oled_data_A(oled_data_g3_A),
                         .oled_data_B(oled_data_g3_B),
                         .player_health_new(health_new_g3),
                         .win_flag(win_flag_g3)); 
                         
   game_4 jun_yi_game (.clk(clk),    
                       .btnU_pulse(u_pulse),
                       .btnD_pulse(d_pulse),
                       .btnL_pulse(l_pulse),
                       .btnR_pulse(r_pulse),
                       .pixel_index_B(pixel_index_B),
                       .pixel_index_A(pixel_index_A),
                       .player_health(active_game_health),
                       .enable_flag(enable_g4),
                       .reset_flag(reset_flag),
                       .oled_data_A(oled_data_g4_A),
                       .oled_data_B(oled_data_g4_B),
                       .player_health_new(health_new_g4),
                       .win_flag(win_flag_g4));   
endmodule