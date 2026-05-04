`timescale 1ns / 1ps

module cut_the_wire_game(
    input clk,
    input output_btnC, output_btnL, output_btnR, output_btnU,
    input [15:0] sw,
    inout PS2Clk,
    inout PS2Data,
    input game_start,                       
    input [2:0] player_health,              
    input [15:0] pixel_index,          
    input [15:0] pixel_index_A,  
    input reset,          
    output reg win_flag,                    
    output reg [15:0] oled_data,   
    output reg [15:0] oled_data_A,         
    output reg [2:0] remaining_health
);    

// ------------ GAME STATE VARIABLES ------------------
reg game_start_internal = 1'b1;
reg [2:0] player_health_internal;                   
reg [3:0] round_left = 3'd1;
reg next_round = 1'b0;

//------------------ MOUSE MODULE ---------------------------------

wire [11:0] mouse_xpos, mouse_ypos;
wire left_click;
reg rst = 1;
reg [7:0] rst_count = 0;

reg [11:0] value_in  = 0;
reg        setmax_x  = 0;
reg        setmax_y  = 0;
reg [7:0]  init_count = 0;

always @(posedge clk) begin
    setmax_x <= 0;
    setmax_y <= 0;

    case (init_count)
        8'd0: begin
            rst        <= 1;
            init_count <= init_count + 1;
        end
        8'd50: begin
            rst        <= 0;
            init_count <= init_count + 1;
        end
        8'd51: begin
            value_in   <= 12'd95;
            setmax_x   <= 1;
            init_count <= init_count + 1;
        end
        8'd52: begin
            value_in   <= 12'd63;
            setmax_y   <= 1;
            init_count <= init_count + 1;
        end
        default: begin
            if (init_count < 8'd53)
                init_count <= init_count + 1;
        end
    endcase
end

MouseCtl mouse (
.clk      (clk),
.rst      (rst),
.xpos     (mouse_xpos),
.ypos     (mouse_ypos),
.left     (left_click),
.value    (value_in),
.setx     (1'b0),
.sety     (1'b0),
.setmax_x (setmax_x),    
.setmax_y (setmax_y),
.ps2_clk  (PS2Clk),
.ps2_data (PS2Data)
);

//--------------------- 5 Coloured wires configuration------------------------
localparam WIRE_W = 4;
localparam WIRE_S = 2;
wire [6:0] current_pixel_x = pixel_index % 96;
wire [5:0] current_pixel_y = pixel_index / 96;
wire wire_cut_dimention = (current_pixel_y >= 30) && (current_pixel_y <= 45);
reg [4:0] solution_wires = 5'b00000;
reg [4:0] chosen_wire = 5'b00000;
reg [4:0] final_answer = 5'b00000;
reg [6:0] selector_x = 5;
reg [6:0] selector_x2 = 13;

wire in_w0 = (current_pixel_x >= 8)  && (current_pixel_x < 8 + WIRE_W)  && !(chosen_wire[4] && wire_cut_dimention);
wire in_w1 = (current_pixel_x >= 24) && (current_pixel_x < 24 + WIRE_W) && !(chosen_wire[3] && wire_cut_dimention);
wire in_w2 = (current_pixel_x >= 42) && (current_pixel_x < 42 + WIRE_W) && !(chosen_wire[2] && wire_cut_dimention);
wire in_w3 = (current_pixel_x >= 60) && (current_pixel_x < 60 + WIRE_W) && !(chosen_wire[1] && wire_cut_dimention);
wire in_w4 = (current_pixel_x >= 75) && (current_pixel_x < 75 + WIRE_W) && !(chosen_wire[0] && wire_cut_dimention);
wire selector = (current_pixel_x >= selector_x) && (current_pixel_x < selector_x + WIRE_S);
wire selector2 = (current_pixel_x >= selector_x2) && (current_pixel_x < selector_x2 + WIRE_S);

//----------------------MOUSE POSITION------------------------------------------

wire [6:0] new_mouse_x = (mouse_xpos > 95) ? 7'd95 : mouse_xpos[6:0];
wire [5:0] new_mouse_y = (mouse_ypos > 63) ? 6'd63 : mouse_ypos[5:0];
wire cursor = (current_pixel_x >= new_mouse_x) && (current_pixel_x < (new_mouse_x + 6)) && (current_pixel_y >= (new_mouse_y)) && (current_pixel_y < (new_mouse_y + 6));

//----------------------------coordinates for round 1-----------------------------
parameter [7:0] radius_squared = 36;
reg [6:0] position_x = 89;
reg [5:0] position_y = 10;
wire signed [8:0] dx = $signed({1'b0, current_pixel_x}) - $signed({1'b0, position_x});
wire signed [8:0] dy = $signed({1'b0, current_pixel_y}) - $signed({1'b0, position_y});
wire signed [16:0] dx_sq = dx * dx;
wire signed [16:0] dy_sq = dy * dy;
wire is_draw_circle = (dx_sq + dy_sq  <= radius_squared);

//----------------------------coordinates for round 2-----------------------------
reg [6:0] position_x2 = 89;
reg [5:0] position_y2 = 28;
wire signed [8:0] dx2 = $signed({1'b0, current_pixel_x}) - $signed({1'b0, position_x2});
wire signed [8:0] dy2 = $signed({1'b0, current_pixel_y}) - $signed({1'b0, position_y2});
wire signed [16:0] dx_sq2 = dx2 * dx2;
wire signed [16:0] dy_sq2 = dy2 * dy2;
wire is_draw_circle2 = (dx_sq2 + dy_sq2  <= radius_squared);

//----------------------------coordinates for round 3-----------------------------
reg [6:0] position_x3 = 89;
reg [5:0] position_y3 = 46;
wire signed [8:0] dx3 = $signed({1'b0, current_pixel_x}) - $signed({1'b0, position_x3});
wire signed [8:0] dy3 = $signed({1'b0, current_pixel_y}) - $signed({1'b0, position_y3});
wire signed [16:0] dx_sq3 = dx3 * dx3;
wire signed [16:0] dy_sq3 = dy3 * dy3;
wire is_draw_circle3 = (dx_sq3 + dy_sq3  <= radius_squared);

//--------------Random Colour Shuffler Variables-------------------------------

reg [2:0] wire1_colour = 3'd2;
reg [2:0] wire2_colour = 3'd0;
reg [2:0] wire3_colour = 3'd2;
reg [2:0] wire4_colour = 3'd6;
reg [2:0] wire5_colour = 3'd0;
reg [31:0] lfsr = 32'h2AE3F026;

always @(posedge clk) begin
lfsr <= {lfsr [30:0], lfsr[31] ^ lfsr[21] ^ lfsr[1] ^ lfsr[0]};
end

wire [15:0] output_colour_1;
wire [15:0] output_colour_2;
wire [15:0] output_colour_3;
wire [15:0] output_colour_4;
wire [15:0] output_colour_5;
wire [14:0] wire_number;

colour_mux for_wire1 (clk, wire1_colour, output_colour_1, wire_number[2:0]);
colour_mux for_wire2 (clk, wire2_colour, output_colour_2, wire_number[5:3]);
colour_mux for_wire3 (clk, wire3_colour, output_colour_3, wire_number[8:6]);
colour_mux for_wire4 (clk, wire4_colour, output_colour_4, wire_number[11:9]);
colour_mux for_wire5 (clk, wire5_colour, output_colour_5, wire_number[14:12]);

//---------------- RULE ENGINE VARIABLES--------------------------------
reg [2:0] count_red = 0;
reg [2:0] count_yellow = 0;
integer i, j;

//---------------- SELECTING WIRES VARIABLES------------------------------
reg [2:0] move_counter = 1;
reg btnR_prev, btnL_prev, btnC_prev;
reg wrong_wire = 1'b0;
reg [26:0] counter3;
reg [2:0] chosen_wrong_number;
reg solution_calculated = 0;
reg solution_ready = 0;

always @(posedge clk) begin

    if (reset) begin
    final_answer[4:0] = 5'b00000;
    chosen_wire[4:0] = 5'b00000;
    game_start_internal <= 1'b1;
    round_left <= 3'b1;
    solution_calculated <= 0;
    solution_ready <= 0;
    win_flag <= 1'b0;
    player_health_internal <= player_health;
    move_counter <= 1;
    end

    if ((next_round || (game_start == 1'b1)) && (game_start_internal == 1'b1) && (round_left <= 3)) begin
    game_start_internal <= 1'b0;
    next_round <= 1'b0;
    player_health_internal <= player_health;
    win_flag <= 1'b0;
    
    wire1_colour <= lfsr[2:0] ^ lfsr[31:29];
    wire2_colour <= lfsr[5:3] ^ lfsr[10:8];
    wire3_colour <= lfsr[7:5] ^ lfsr[12:10];
    wire4_colour <= lfsr[15:13] ^ lfsr[20:18];
    wire5_colour <= lfsr[25:23] ^ lfsr[30:28];
    end

//----------------------------- THE START OF THE BIGGEST IF BLOCK -----------------------------------------

    remaining_health <= player_health_internal;

    if ((game_start_internal == 1'b0) && (round_left <= 3) && (player_health_internal != 0) && !win_flag) begin
    remaining_health = player_health_internal;
        if (cursor) begin
        oled_data <= 16'hFFFF;
        end else
        if (in_w0) begin
        oled_data <= output_colour_1;
        end else
        if (in_w1) begin
        oled_data <= output_colour_2;
        end else
        if (in_w2) begin
        oled_data <= output_colour_3;
        end else
        if (in_w3) begin
        oled_data <= output_colour_4;
        end else
        if (in_w4) begin
        oled_data <= output_colour_5;
        end else
        if (selector) begin
        oled_data <= 16'hFFFF;
        end else
        if (selector2) begin
        oled_data <= 16'hFFFF;
        end else
        if (is_draw_circle) begin
            if (round_left >= 2) begin
            oled_data <= 16'h07E0;
            end else oled_data <= 16'hFFFF;
        end else
        if (is_draw_circle2) begin
            if (round_left == 3) begin
            oled_data <= 16'h07E0;
            end else oled_data <= 16'hFFFF;
        end else
        if (is_draw_circle3) begin
        oled_data <= 16'hFFFF;
        end else
        oled_data <= 16'h0000;
    
//------------------------------Rule Engine + Checking Answer-----------------------------------------------

        if (!game_start_internal && !solution_ready && solution_calculated == 1'b0 && !win_flag) begin
            solution_ready <= 1'b1;
        end
    
        if (solution_ready && solution_calculated == 1'b0) begin
            count_red = 0;
            count_yellow = 0;
            solution_wires = 5'b00000;
        
            for (i = 0; i < 15; i = i + 3) begin
                if (wire_number[i+:3] != 3'b000)
                    count_yellow = count_yellow + 1;
                if ((wire_number[i+:3] == 3'b110) || (wire_number[i+:3] == 3'b101))
                    count_red = count_red + 1;
            end
        
            // Rules
            if (count_yellow == 5)              solution_wires[1] = 1'b1;
            if (count_red >= 2)                 solution_wires[3] = 1'b1;
            if (wire_number[14:12] == 3'b010)   solution_wires[4] = 1'b1;
            if (wire_number[5:3] == 3'b011)     solution_wires[0] = 1'b1;
            if (solution_wires == 5'b00000)     solution_wires[2] = 1'b1;
        
            solution_calculated = 1'b1;  // never recalculate again
        end
        
        for (j = 0; j < 5; j = j + 1) begin
            if ((final_answer[j] == 1'b1) && (final_answer[j] != solution_wires[j])) begin
                if (counter3 <= 50000000) begin
                //---------------------------------------------------------------------------------------------
                oled_data <= 16'hF800;          // RED COLOUR
                //---------------------------------------------------------------------------------------------
                    counter3  <= counter3 + 1;
                end else begin
                    counter3 <= 0;
                    final_answer[j] <= 1'b0;
                    player_health_internal <= player_health_internal - 1; 
                        if (player_health_internal == 0) begin
                        win_flag <= 1'b1;
                        round_left <= 3'd1;
                        end                      
                    end
            end
        end
    
        if ((final_answer[4:0] == solution_wires[4:0]) && (solution_wires[4:0] != 5'b00000) && (solution_calculated == 1'b1)) begin
            if (counter3 <= 50000000) begin
            //------------------------------------------------------------------------------------------------------
            oled_data <= 16'h07E0;              // GREEN COLOUR
            //------------------------------------------------------------------------------------------------------
            counter3 <= counter3 + 1;
            end else begin
                counter3 <= 0;
                round_left <= round_left + 1;
                final_answer[4:0] = 5'b00000;
                chosen_wire[4:0] = 5'b00000;
                game_start_internal <= 1'b1;
                next_round <= 1'b1;
                solution_calculated <= 0;
                solution_ready <= 0;
                win_flag <= 1'b0;
                
                if (round_left == 3'd3) begin
                win_flag <= 1'b1;
                round_left <= 3'd1;
                end
                
            end
        end
            
//--------------------------------------Selector Engine-----------------------------------------

    btnR_prev <= output_btnR;
    btnL_prev <= output_btnL;
    btnC_prev <= output_btnC;
        
        if (output_btnR && !btnR_prev) begin
            if (move_counter <= 4)          
                move_counter <= move_counter + 1;
        end
        if (output_btnL && !btnL_prev) begin
            if (move_counter > 1)           
                move_counter <= move_counter - 1;
        end
        
        //-------------ADDING THE MOUSE----------------------
        
        if ((mouse_xpos >= 8)  && (mouse_xpos <= 12)) move_counter <= 1;
        else if ((mouse_xpos >= 24) && (mouse_xpos <= 28)) move_counter <= 2;
        else if ((mouse_xpos >= 42) && (mouse_xpos <= 46)) move_counter <= 3;
        else if ((mouse_xpos >= 60) && (mouse_xpos <= 64)) move_counter <= 4;
        else if ((mouse_xpos >= 75) && (mouse_xpos <= 79)) move_counter <= 5;

        //---------------------------------------------------
    
        case (move_counter)
    
            3'd1: begin 
            selector_x <= 6;
            selector_x2 <= 12;
                if (((output_btnC && !btnC_prev) || left_click) && (chosen_wire[4] == 1'b0) && solution_ready) begin
                chosen_wire[4] = 1'b1;
                final_answer[4] = 1'b1;
                end
            end
        
            3'd2: begin 
            selector_x <= 22;
            selector_x2 <= 28;
                if (((output_btnC && !btnC_prev) || left_click) && (chosen_wire[3] == 1'b0) && solution_ready) begin
                chosen_wire[3] = 1'b1;
                final_answer[3] = 1'b1;
                end
            end
        
            3'd3: begin
            selector_x <= 40;
            selector_x2 <= 46;
                if (((output_btnC && !btnC_prev) || left_click) && (chosen_wire[2] == 1'b0) && solution_ready) begin
                chosen_wire[2] = 1'b1;
                final_answer[2] = 1'b1;
                end
            end
        
            3'd4: begin 
            selector_x <= 58;
            selector_x2 <= 64;
                if (((output_btnC && !btnC_prev) || left_click) && (chosen_wire[1] == 1'b0) && solution_ready) begin
                chosen_wire[1] = 1'b1;
                final_answer[1] = 1'b1;
                end
            end
            
            3'd5: begin 
            selector_x <= 73;
            selector_x2 <= 79;
                if (((output_btnC && !btnC_prev) || left_click) && (chosen_wire[0] == 1'b0) && solution_ready) begin
                chosen_wire[0] = 1'b1;
                final_answer[0] = 1'b1;
                end
            end
        
        endcase
    
//--------------------------------- THE END OF THE BIGGEST IF BLOCK ---------------------------------------
    end 

end

always @(posedge clk) begin

    if ((game_start_internal == 1'b0)) begin

    if (pixel_index_A == 500 || ((pixel_index_A >= 506) && (pixel_index_A <= 507)) || pixel_index_A == 511 || pixel_index_A == 515 || ((pixel_index_A >= 518) && (pixel_index_A <= 519)) || ((pixel_index_A >= 543) && (pixel_index_A <= 544)) || pixel_index_A == 550 || ((pixel_index_A >= 554) && (pixel_index_A <= 555)) || pixel_index_A == 598 || pixel_index_A == 653 || pixel_index_A == 742 || pixel_index_A == 788 || pixel_index_A == 827 || pixel_index_A == 838 || pixel_index_A == 908 || pixel_index_A == 912 || pixel_index_A == 1006 || pixel_index_A == 1010 || pixel_index_A == 1074 || pixel_index_A == 1124 || pixel_index_A == 1132 || pixel_index_A == 1554 || pixel_index_A == 1556 || pixel_index_A == 1569 || pixel_index_A == 1575 || pixel_index_A == 1586 || pixel_index_A == 1594 || pixel_index_A == 1596 || pixel_index_A == 1604 || pixel_index_A == 1609 || pixel_index_A == 1613 || pixel_index_A == 1650 || pixel_index_A == 1681 || pixel_index_A == 1707 || pixel_index_A == 1745 || pixel_index_A == 1853 || pixel_index_A == 1938 || pixel_index_A == 1945 || pixel_index_A == 1953 || pixel_index_A == 1965 || pixel_index_A == 1973 || pixel_index_A == 1975 || pixel_index_A == 1978 || pixel_index_A == 1988 || pixel_index_A == 1991 || pixel_index_A == 2029 || pixel_index_A == 2105 || pixel_index_A == 2506 || pixel_index_A == 2509 || pixel_index_A == 2513 || pixel_index_A == 2518 || pixel_index_A == 2521 || pixel_index_A == 2525 || pixel_index_A == 2536 || pixel_index_A == 2548 || pixel_index_A == 2555 || pixel_index_A == 2560 || pixel_index_A == 2571 || pixel_index_A == 2578 || pixel_index_A == 2698 || pixel_index_A == 2714 || pixel_index_A == 2718 || pixel_index_A == 2722 || pixel_index_A == 2726 || pixel_index_A == 2810 || pixel_index_A == 2856 || pixel_index_A == 2906 || pixel_index_A == 2935 || pixel_index_A == 2946 || ((pixel_index_A >= 3156) && (pixel_index_A <= 3157)) || pixel_index_A == 3564 || pixel_index_A == 3619 || pixel_index_A == 3627 || pixel_index_A == 3711 || pixel_index_A == 3796 || pixel_index_A == 3811 || pixel_index_A == 3821 || pixel_index_A == 3828 || ((pixel_index_A >= 3859) && (pixel_index_A <= 3860)) || pixel_index_A == 3913 || ((pixel_index_A >= 3964) && (pixel_index_A <= 3965)) || pixel_index_A == 3987 || pixel_index_A == 3990 || pixel_index_A == 3995 || pixel_index_A == 4002 || pixel_index_A == 4008 || ((pixel_index_A >= 4018) && (pixel_index_A <= 4019)) || pixel_index_A == 4055 || pixel_index_A == 4518 || pixel_index_A == 4521 || pixel_index_A == 4523 || pixel_index_A == 4525 || pixel_index_A == 4531 || pixel_index_A == 4533 || pixel_index_A == 4539 || pixel_index_A == 4545 || pixel_index_A == 4547 || ((pixel_index_A >= 4549) && (pixel_index_A <= 4550)) || pixel_index_A == 4557 || pixel_index_A == 4559 || pixel_index_A == 4563 || pixel_index_A == 4597 || pixel_index_A == 4601 || pixel_index_A == 4620 || pixel_index_A == 4628 || pixel_index_A == 4712 || pixel_index_A == 4735 || pixel_index_A == 4810 || pixel_index_A == 4818 || pixel_index_A == 4832 || pixel_index_A == 4924 || pixel_index_A == 4938 || pixel_index_A == 4942 || pixel_index_A == 5004 || pixel_index_A == 5012 || pixel_index_A == 5097 || ((pixel_index_A >= 5173) && (pixel_index_A <= 5174)) || pixel_index_A == 5177 || pixel_index_A == 5391 || ((pixel_index_A >= 5394) && (pixel_index_A <= 5396)) || ((pixel_index_A >= 5447) && (pixel_index_A <= 5448)) || pixel_index_A == 5497 || pixel_index_A == 5593 || pixel_index_A == 5689 || pixel_index_A == 5693 || pixel_index_A == 5735) oled_data_A = 16'b0000100001000001;
    else if (pixel_index_A == 523 || pixel_index_A == 600 || pixel_index_A == 627 || pixel_index_A == 645 || pixel_index_A == 725 || pixel_index_A == 732 || pixel_index_A == 734 || pixel_index_A == 791 || pixel_index_A == 814 || ((pixel_index_A >= 820) && (pixel_index_A <= 821)) || pixel_index_A == 836 || pixel_index_A == 897 || pixel_index_A == 911 || pixel_index_A == 917 || pixel_index_A == 922 || pixel_index_A == 1031 || pixel_index_A == 1642 || pixel_index_A == 1659 || pixel_index_A == 1663 || pixel_index_A == 1678 || pixel_index_A == 1684 || pixel_index_A == 1711 || pixel_index_A == 1843 || pixel_index_A == 1930 || pixel_index_A == 1977 || pixel_index_A == 2003 || pixel_index_A == 2530 || pixel_index_A == 2623 || pixel_index_A == 2642 || pixel_index_A == 2664 || pixel_index_A == 2674 || pixel_index_A == 2806 || pixel_index_A == 2809 || pixel_index_A == 2890 || ((pixel_index_A >= 2944) && (pixel_index_A <= 2945)) || pixel_index_A == 2952 || pixel_index_A == 3061 || pixel_index_A == 3561 || pixel_index_A == 3609 || pixel_index_A == 3632 || pixel_index_A == 3706 || pixel_index_A == 3734 || pixel_index_A == 3776 || pixel_index_A == 3813 || pixel_index_A == 3830 || pixel_index_A == 3915 || pixel_index_A == 3926 || pixel_index_A == 4116 || pixel_index_A == 4614 || pixel_index_A == 4622 || pixel_index_A == 4646 || pixel_index_A == 4711 || pixel_index_A == 4728 || pixel_index_A == 4743 || pixel_index_A == 4756 || pixel_index_A == 4806 || pixel_index_A == 4824 || pixel_index_A == 4828 || pixel_index_A == 4844 || pixel_index_A == 4852 || pixel_index_A == 4855 || pixel_index_A == 4883 || pixel_index_A == 4886 || pixel_index_A == 4917 || pixel_index_A == 5550 || ((pixel_index_A >= 5583) && (pixel_index_A <= 5584)) || ((pixel_index_A >= 5621) && (pixel_index_A <= 5622)) || pixel_index_A == 5627 || pixel_index_A == 5647 || pixel_index_A == 5679 || pixel_index_A == 5738 || pixel_index_A == 5788) oled_data_A = 16'b0101001010001010;
    else if (pixel_index_A == 524 || pixel_index_A == 608 || pixel_index_A == 624 || pixel_index_A == 630 || pixel_index_A == 641 || pixel_index_A == 643 || pixel_index_A == 710 || pixel_index_A == 716 || pixel_index_A == 744 || pixel_index_A == 786 || pixel_index_A == 882 || pixel_index_A == 891 || pixel_index_A == 894 || pixel_index_A == 899 || pixel_index_A == 978 || pixel_index_A == 1037 || pixel_index_A == 1083 || pixel_index_A == 1492 || pixel_index_A == 1545 || pixel_index_A == 1560 || pixel_index_A == 1583 || pixel_index_A == 1589 || pixel_index_A == 1595 || pixel_index_A == 1607 || pixel_index_A == 1620 || pixel_index_A == 1625 || pixel_index_A == 1668 || pixel_index_A == 1685 || pixel_index_A == 1753 || pixel_index_A == 1757 || pixel_index_A == 1781 || pixel_index_A == 1786 || pixel_index_A == 1862 || pixel_index_A == 1864 || pixel_index_A == 1869 || pixel_index_A == 1873 || pixel_index_A == 1875 || pixel_index_A == 1877 || pixel_index_A == 1948 || pixel_index_A == 1955 || pixel_index_A == 1964 || pixel_index_A == 1966 || pixel_index_A == 1968 || pixel_index_A == 1970 || pixel_index_A == 1980 || pixel_index_A == 2028 || pixel_index_A == 2036 || pixel_index_A == 2076 || pixel_index_A == 2510 || pixel_index_A == 2572 || pixel_index_A == 2576 || pixel_index_A == 2604 || pixel_index_A == 2613 || pixel_index_A == 2666 || pixel_index_A == 2717 || pixel_index_A == 2741 || pixel_index_A == 2796 || pixel_index_A == 2839 || pixel_index_A == 2845 || pixel_index_A == 2858 || pixel_index_A == 2901 || pixel_index_A == 2908 || pixel_index_A == 2933 || pixel_index_A == 2943 || pixel_index_A == 2995 || pixel_index_A == 3568 || pixel_index_A == 3606 || pixel_index_A == 3668 || pixel_index_A == 3682 || pixel_index_A == 3727 || pixel_index_A == 3804 || pixel_index_A == 3820 || pixel_index_A == 3852 || pixel_index_A == 3949 || pixel_index_A == 3951 || pixel_index_A == 3961 || pixel_index_A == 3967 || pixel_index_A == 3985 || pixel_index_A == 4004 || pixel_index_A == 4006 || pixel_index_A == 4015 || pixel_index_A == 4017 || pixel_index_A == 4040 || pixel_index_A == 4552 || pixel_index_A == 4566 || pixel_index_A == 4594 || pixel_index_A == 4623 || pixel_index_A == 4724 || pixel_index_A == 4812 || pixel_index_A == 4826 || pixel_index_A == 4935 || pixel_index_A == 5399 || pixel_index_A == 5451 || pixel_index_A == 5489 || pixel_index_A == 5501 || pixel_index_A == 5545 || pixel_index_A == 5595 || pixel_index_A == 5711 || pixel_index_A == 5716 || pixel_index_A == 5721 || pixel_index_A == 5724 || pixel_index_A == 5729) oled_data_A = 16'b0001100011000011;
    else if (pixel_index_A == 526 || pixel_index_A == 530 || pixel_index_A == 594 || pixel_index_A == 699 || pixel_index_A == 715 || pixel_index_A == 746 || pixel_index_A == 921 || pixel_index_A == 929 || pixel_index_A == 1075 || pixel_index_A == 1082 || ((pixel_index_A >= 1108) && (pixel_index_A <= 1109)) || pixel_index_A == 1125 || pixel_index_A == 1472 || ((pixel_index_A >= 1481) && (pixel_index_A <= 1482)) || pixel_index_A == 1493 || pixel_index_A == 1546 || pixel_index_A == 1548 || pixel_index_A == 1552 || pixel_index_A == 1557 || pixel_index_A == 1564 || pixel_index_A == 1571 || pixel_index_A == 1573 || pixel_index_A == 1580 || pixel_index_A == 1582 || pixel_index_A == 1584 || pixel_index_A == 1608 || pixel_index_A == 1621 || pixel_index_A == 1670 || pixel_index_A == 1677 || pixel_index_A == 1739 || pixel_index_A == 1773 || pixel_index_A == 1814 || pixel_index_A == 1860 || pixel_index_A == 1933 || ((pixel_index_A >= 1958) && (pixel_index_A <= 1959)) || pixel_index_A == 1962 || pixel_index_A == 1985 || pixel_index_A == 2005 || pixel_index_A == 2054 || pixel_index_A == 2522 || pixel_index_A == 2526 || pixel_index_A == 2547 || pixel_index_A == 2554 || pixel_index_A == 2568 || ((pixel_index_A >= 2579) && (pixel_index_A <= 2580)) || pixel_index_A == 2647 || pixel_index_A == 2743 || pixel_index_A == 2758 || pixel_index_A == 2794 || pixel_index_A == 2958 || pixel_index_A == 3126 || pixel_index_A == 3136 || pixel_index_A == 3560 || pixel_index_A == 3630 || pixel_index_A == 3672 || pixel_index_A == 3715 || pixel_index_A == 3721 || pixel_index_A == 3763 || pixel_index_A == 3768 || pixel_index_A == 3773 || pixel_index_A == 3858 || pixel_index_A == 3920 || pixel_index_A == 3947 || pixel_index_A == 3952 || pixel_index_A == 3963 || pixel_index_A == 3997 || pixel_index_A == 4522 || pixel_index_A == 4530 || ((pixel_index_A >= 4534) && (pixel_index_A <= 4535)) || pixel_index_A == 4542 || pixel_index_A == 4544 || pixel_index_A == 4553 || pixel_index_A == 4595 || pixel_index_A == 4616 || pixel_index_A == 4624 || pixel_index_A == 4642 || pixel_index_A == 4644 || pixel_index_A == 4740 || pixel_index_A == 4758 || pixel_index_A == 4816 || pixel_index_A == 4902 || pixel_index_A == 5000 || pixel_index_A == 5026 || pixel_index_A == 5493 || pixel_index_A == 5502 || pixel_index_A == 5585 || pixel_index_A == 5683 || pixel_index_A == 5699 || pixel_index_A == 5704 || pixel_index_A == 5709 || pixel_index_A == 5726 || pixel_index_A == 5731 || pixel_index_A == 5775 || pixel_index_A == 5782 || pixel_index_A == 5787 || pixel_index_A == 5873 || pixel_index_A == 5886 || pixel_index_A == 5929 || pixel_index_A == 5936) oled_data_A = 16'b0001000010000010;
    else if (pixel_index_A == 595 || pixel_index_A == 611 || pixel_index_A == 691 || pixel_index_A == 721 || pixel_index_A == 743 || pixel_index_A == 920 || pixel_index_A == 932 || pixel_index_A == 937 || pixel_index_A == 1036 || pixel_index_A == 1639 || pixel_index_A == 1656 || pixel_index_A == 1701 || pixel_index_A == 1712 || pixel_index_A == 1735 || pixel_index_A == 1752 || pixel_index_A == 1756 || pixel_index_A == 1831 || pixel_index_A == 1833 || pixel_index_A == 1844 || pixel_index_A == 1848 || pixel_index_A == 1852 || pixel_index_A == 1897 || pixel_index_A == 1998 || pixel_index_A == 2614 || pixel_index_A == 2617 || pixel_index_A == 2626 || pixel_index_A == 2701 || pixel_index_A == 2742 || pixel_index_A == 2750 || pixel_index_A == 2761 || pixel_index_A == 2763 || pixel_index_A == 2795 || pixel_index_A == 2811 || pixel_index_A == 2815 || pixel_index_A == 2857 || pixel_index_A == 3661 || pixel_index_A == 3699 || pixel_index_A == 3712 || pixel_index_A == 3730 || pixel_index_A == 3769 || pixel_index_A == 3799 || pixel_index_A == 3808 || pixel_index_A == 3851 || pixel_index_A == 3853 || pixel_index_A == 3857 || pixel_index_A == 3871 || pixel_index_A == 3955 || pixel_index_A == 4619 || pixel_index_A == 4629 || pixel_index_A == 4718 || pixel_index_A == 4811 || pixel_index_A == 4819 || pixel_index_A == 4821 || pixel_index_A == 4881 || pixel_index_A == 4887 || pixel_index_A == 4905 || pixel_index_A == 5544 || pixel_index_A == 5684) oled_data_A = 16'b1001010010110010;
    else if (pixel_index_A == 596 || pixel_index_A == 625 || ((pixel_index_A >= 639) && (pixel_index_A <= 640)) || pixel_index_A == 652 || pixel_index_A == 730 || pixel_index_A == 738 || pixel_index_A == 748 || pixel_index_A == 789 || pixel_index_A == 822 || pixel_index_A == 834 || pixel_index_A == 884 || pixel_index_A == 927 || pixel_index_A == 1787 || pixel_index_A == 1800 || pixel_index_A == 1808 || pixel_index_A == 1812 || pixel_index_A == 1839 || pixel_index_A == 1896 || pixel_index_A == 1899 || pixel_index_A == 2603 || pixel_index_A == 2650 || pixel_index_A == 2654 || pixel_index_A == 2665 || pixel_index_A == 2705 || pixel_index_A == 2739 || pixel_index_A == 2767 || pixel_index_A == 2769 || pixel_index_A == 2799 || pixel_index_A == 2801 || pixel_index_A == 2841 || ((pixel_index_A >= 2897) && (pixel_index_A <= 2898)) || pixel_index_A == 2909 || pixel_index_A == 2960 || pixel_index_A == 3726 || pixel_index_A == 3803 || pixel_index_A == 3891 || ((pixel_index_A >= 3900) && (pixel_index_A <= 3901)) || pixel_index_A == 3916 || pixel_index_A == 3919 || pixel_index_A == 4021 || pixel_index_A == 4117 || pixel_index_A == 4568 || pixel_index_A == 4617 || pixel_index_A == 4630 || pixel_index_A == 4643 || pixel_index_A == 4655 || pixel_index_A == 4657 || pixel_index_A == 4690 || pixel_index_A == 4697 || pixel_index_A == 4737 || pixel_index_A == 4760 || pixel_index_A == 4815 || pixel_index_A == 4841 || pixel_index_A == 4851 || pixel_index_A == 4903 || pixel_index_A == 4922 || pixel_index_A == 4932 || pixel_index_A == 4978 || pixel_index_A == 5001 || pixel_index_A == 5492 || pixel_index_A == 5495 || pixel_index_A == 5548 || pixel_index_A == 5590 || pixel_index_A == 5642 || pixel_index_A == 5688 || pixel_index_A == 5736 || pixel_index_A == 5789 || pixel_index_A == 5879) oled_data_A = 16'b0111101111001111;
    else if (pixel_index_A == 597 || ((pixel_index_A >= 602) && (pixel_index_A <= 603)) || pixel_index_A == 607 || pixel_index_A == 614 || pixel_index_A == 633 || pixel_index_A == 650 || pixel_index_A == 712 || pixel_index_A == 808 || pixel_index_A == 826 || pixel_index_A == 839 || pixel_index_A == 887 || pixel_index_A == 903 || pixel_index_A == 924 || pixel_index_A == 931 || ((pixel_index_A >= 986) && (pixel_index_A <= 987)) || pixel_index_A == 1646 || pixel_index_A == 1648 || pixel_index_A == 1658 || pixel_index_A == 1660 || pixel_index_A == 1714 || pixel_index_A == 1784 || pixel_index_A == 1797 || pixel_index_A == 1802 || pixel_index_A == 1815 || pixel_index_A == 1838 || pixel_index_A == 1840 || pixel_index_A == 1893 || pixel_index_A == 2618 || pixel_index_A == 2621 || pixel_index_A == 2671 || pixel_index_A == 2699 || pixel_index_A == 2715 || pixel_index_A == 2838 || pixel_index_A == 2863 || pixel_index_A == 3587 || pixel_index_A == 3663 || pixel_index_A == 3675 || pixel_index_A == 3679 || pixel_index_A == 3703 || pixel_index_A == 3716 || pixel_index_A == 3718 || pixel_index_A == 3731 || pixel_index_A == 3757 || pixel_index_A == 3762 || pixel_index_A == 3767 || pixel_index_A == 3793 || pixel_index_A == 3812 || pixel_index_A == 3816 || pixel_index_A == 3819 || pixel_index_A == 3822 || pixel_index_A == 3865 || pixel_index_A == 3889 || pixel_index_A == 3897 || pixel_index_A == 3910 || pixel_index_A == 3912 || pixel_index_A == 4627 || pixel_index_A == 4635 || pixel_index_A == 4639 || ((pixel_index_A >= 4662) && (pixel_index_A <= 4663)) || pixel_index_A == 4691 || pixel_index_A == 4713 || pixel_index_A == 4715 || pixel_index_A == 4723 || pixel_index_A == 4757 || pixel_index_A == 4985 || pixel_index_A == 5081 || pixel_index_A == 5588 || pixel_index_A == 5682 || pixel_index_A == 5686 || pixel_index_A == 5691 || pixel_index_A == 5784) oled_data_A = 16'b1000110001010001;
    else if (pixel_index_A == 599 || pixel_index_A == 644 || pixel_index_A == 695 || pixel_index_A == 718 || pixel_index_A == 723 || pixel_index_A == 793 || pixel_index_A == 795 || pixel_index_A == 802 || pixel_index_A == 886 || pixel_index_A == 892 || pixel_index_A == 916 || pixel_index_A == 991 || pixel_index_A == 1012 || pixel_index_A == 1131 || pixel_index_A == 1547 || pixel_index_A == 1555 || pixel_index_A == 1599 || pixel_index_A == 1645 || pixel_index_A == 1653 || pixel_index_A == 1665 || pixel_index_A == 1692 || pixel_index_A == 1709 || pixel_index_A == 1717 || pixel_index_A == 1761 || pixel_index_A == 1765 || pixel_index_A == 1780 || pixel_index_A == 1788 || pixel_index_A == 1803 || pixel_index_A == 1805 || pixel_index_A == 1884 || pixel_index_A == 1890 || pixel_index_A == 1898 || pixel_index_A == 1901 || pixel_index_A == 1944 || pixel_index_A == 1993 || pixel_index_A == 1997 || pixel_index_A == 2000 || pixel_index_A == 2026 || pixel_index_A == 2610 || pixel_index_A == 2652 || pixel_index_A == 2703 || pixel_index_A == 2765 || pixel_index_A == 2802 || pixel_index_A == 2813 || pixel_index_A == 2837 || pixel_index_A == 2892 || pixel_index_A == 2899 || pixel_index_A == 2905 || pixel_index_A == 2911 || pixel_index_A == 2961 || pixel_index_A == 2999 || pixel_index_A == 3605 || pixel_index_A == 3656 || pixel_index_A == 3660 || pixel_index_A == 3680 || pixel_index_A == 3717 || pixel_index_A == 3801 || pixel_index_A == 3848 || pixel_index_A == 3894 || pixel_index_A == 3898 || pixel_index_A == 3924 || pixel_index_A == 3944 || pixel_index_A == 3950 || pixel_index_A == 3996 || pixel_index_A == 4013 || pixel_index_A == 4020 || pixel_index_A == 4640 || pixel_index_A == 4787 || pixel_index_A == 4808 || pixel_index_A == 4834 || pixel_index_A == 4836 || pixel_index_A == 4846 || pixel_index_A == 4911 || pixel_index_A == 4931 || pixel_index_A == 4934 || pixel_index_A == 5003 || pixel_index_A == 5025 || pixel_index_A == 5592 || pixel_index_A == 5620 || pixel_index_A == 5628 || pixel_index_A == 5695 || pixel_index_A == 5698 || pixel_index_A == 5700 || pixel_index_A == 5703 || pixel_index_A == 5705 || pixel_index_A == 5710 || pixel_index_A == 5715 || pixel_index_A == 5720 || pixel_index_A == 5725 || pixel_index_A == 5727 || pixel_index_A == 5730 || pixel_index_A == 5732 || pixel_index_A == 5781) oled_data_A = 16'b0011000110000110;
    else if (pixel_index_A == 601 || pixel_index_A == 616 || pixel_index_A == 694 || pixel_index_A == 735 || pixel_index_A == 740 || pixel_index_A == 790 || pixel_index_A == 840 || pixel_index_A == 844 || pixel_index_A == 925 || pixel_index_A == 985 || pixel_index_A == 1028 || pixel_index_A == 1577 || pixel_index_A == 1588 || ((pixel_index_A >= 1592) && (pixel_index_A <= 1593)) || pixel_index_A == 1622 || pixel_index_A == 1624 || pixel_index_A == 1664 || pixel_index_A == 1667 || pixel_index_A == 1694 || pixel_index_A == 1749 || pixel_index_A == 1774 || pixel_index_A == 1776 || pixel_index_A == 1778 || pixel_index_A == 1790 || pixel_index_A == 1861 || pixel_index_A == 1870 || pixel_index_A == 1903 || pixel_index_A == 1935 || pixel_index_A == 1957 || pixel_index_A == 1979 || pixel_index_A == 1995 || pixel_index_A == 2002 || pixel_index_A == 2025 || pixel_index_A == 2102 || pixel_index_A == 2706 || pixel_index_A == 2948 || pixel_index_A == 2954 || pixel_index_A == 3563 || pixel_index_A == 3565 || pixel_index_A == 3567 || pixel_index_A == 3575 || pixel_index_A == 3586 || pixel_index_A == 3634 || pixel_index_A == 3674 || pixel_index_A == 3676 || pixel_index_A == 3702 || pixel_index_A == 3752 || pixel_index_A == 3862 || pixel_index_A == 3864 || pixel_index_A == 3892 || pixel_index_A == 3922 || pixel_index_A == 3946 || pixel_index_A == 3966 || pixel_index_A == 3986 || pixel_index_A == 3992 || pixel_index_A == 4007 || pixel_index_A == 4041 || pixel_index_A == 4051 || pixel_index_A == 4618 || pixel_index_A == 4906 || pixel_index_A == 4919 || pixel_index_A == 4921 || pixel_index_A == 4946 || pixel_index_A == 5011 || pixel_index_A == 5078 || pixel_index_A == 5589 || pixel_index_A == 5606 || pixel_index_A == 5610 || pixel_index_A == 5633 || pixel_index_A == 5641 || pixel_index_A == 5783 || pixel_index_A == 5834) oled_data_A = 16'b0011100111000111;
    else if (pixel_index_A == 604 || pixel_index_A == 638 || pixel_index_A == 649 || pixel_index_A == 726 || pixel_index_A == 825 || pixel_index_A == 888 || pixel_index_A == 915 || pixel_index_A == 936 || pixel_index_A == 988 || pixel_index_A == 1551 || pixel_index_A == 1673 || pixel_index_A == 1680 || pixel_index_A == 1682 || pixel_index_A == 1687 || pixel_index_A == 1690 || pixel_index_A == 1718 || pixel_index_A == 1738 || pixel_index_A == 1763 || pixel_index_A == 1809 || ((pixel_index_A >= 1834) && (pixel_index_A <= 1835)) || pixel_index_A == 1868 || pixel_index_A == 1874 || pixel_index_A == 1876 || pixel_index_A == 1886 || pixel_index_A == 1895 || pixel_index_A == 1976 || pixel_index_A == 2032 || pixel_index_A == 2085 || pixel_index_A == 2094 || pixel_index_A == 2616 || pixel_index_A == 2677 || pixel_index_A == 2702 || pixel_index_A == 2710 || pixel_index_A == 2745 || pixel_index_A == 2764 || pixel_index_A == 2768 || pixel_index_A == 2862 || ((pixel_index_A >= 2864) && (pixel_index_A <= 2865)) || pixel_index_A == 2950 || pixel_index_A == 2987 || pixel_index_A == 3040 || pixel_index_A == 3049 || pixel_index_A == 3577 || pixel_index_A == 3709 || pixel_index_A == 3725 || pixel_index_A == 3772 || pixel_index_A == 3798 || pixel_index_A == 3805 || pixel_index_A == 4119 || pixel_index_A == 4615 || pixel_index_A == 4647 || ((pixel_index_A >= 4660) && (pixel_index_A <= 4661)) || pixel_index_A == 4741 || pixel_index_A == 4791 || pixel_index_A == 4814 || pixel_index_A == 4825 || pixel_index_A == 4848 || pixel_index_A == 4908 || pixel_index_A == 4916 || pixel_index_A == 4952 || pixel_index_A == 5487 || pixel_index_A == 5491 || pixel_index_A == 5551 || pixel_index_A == 5600 || pixel_index_A == 5616 || pixel_index_A == 5632) oled_data_A = 16'b0100101001001001;
    else if (pixel_index_A == 606 || pixel_index_A == 690 || pixel_index_A == 707 || pixel_index_A == 711 || pixel_index_A == 739 || pixel_index_A == 803 || pixel_index_A == 806 || pixel_index_A == 812 || pixel_index_A == 1543 || pixel_index_A == 1558 || pixel_index_A == 1570 || pixel_index_A == 1576 || pixel_index_A == 1578 || pixel_index_A == 1587 || pixel_index_A == 1603 || pixel_index_A == 1605 || pixel_index_A == 1610 || pixel_index_A == 1616 || pixel_index_A == 1618 || pixel_index_A == 1666 || pixel_index_A == 1674 || pixel_index_A == 1683 || pixel_index_A == 1744 || pixel_index_A == 1747 || pixel_index_A == 1764 || pixel_index_A == 1766 || pixel_index_A == 1770 || pixel_index_A == 1777 || pixel_index_A == 1798 || pixel_index_A == 1837 || pixel_index_A == 1867 || pixel_index_A == 1905 || pixel_index_A == 1909 || pixel_index_A == 1927 || pixel_index_A == 1934 || pixel_index_A == 1941 || pixel_index_A == 1961 || pixel_index_A == 1963 || pixel_index_A == 1972 || pixel_index_A == 1992 || pixel_index_A == 2007 || pixel_index_A == 2093 || pixel_index_A == 2620 || pixel_index_A == 2627 || pixel_index_A == 2655 || pixel_index_A == 2716 || pixel_index_A == 2753 || pixel_index_A == 2762 || pixel_index_A == 2814 || pixel_index_A == 2847 || pixel_index_A == 2937 || pixel_index_A == 2940 || pixel_index_A == 2949 || pixel_index_A == 2998 || pixel_index_A == 3572 || pixel_index_A == 3603 || pixel_index_A == 3613 || pixel_index_A == 3670 || pixel_index_A == 3696 || pixel_index_A == 3708 || pixel_index_A == 3760 || pixel_index_A == 3856 || pixel_index_A == 3872 || pixel_index_A == 3909 || pixel_index_A == 3956 || pixel_index_A == 3958 || pixel_index_A == 3960 || pixel_index_A == 3988 || pixel_index_A == 4023 || pixel_index_A == 4049 || pixel_index_A == 4472 || pixel_index_A == 4538 || pixel_index_A == 4556 || pixel_index_A == 4560 || pixel_index_A == 4632 || pixel_index_A == 4636 || pixel_index_A == 4638 || pixel_index_A == 4696 || pixel_index_A == 4716 || pixel_index_A == 4754 || pixel_index_A == 4820 || pixel_index_A == 4850 || pixel_index_A == 4882 || pixel_index_A == 4949 || pixel_index_A == 5543 || pixel_index_A == 5598 || pixel_index_A == 5685 || pixel_index_A == 5696 || ((pixel_index_A >= 5701) && (pixel_index_A <= 5702)) || ((pixel_index_A >= 5706) && (pixel_index_A <= 5707)) || pixel_index_A == 5723 || pixel_index_A == 5728 || pixel_index_A == 5733 || pixel_index_A == 5831 || pixel_index_A == 5928) oled_data_A = 16'b0010000100000100;
    else if (pixel_index_A == 609 || pixel_index_A == 700 || pixel_index_A == 703 || pixel_index_A == 717 || pixel_index_A == 724 || pixel_index_A == 733 || pixel_index_A == 749 || pixel_index_A == 799 || pixel_index_A == 817 || pixel_index_A == 829 || ((pixel_index_A >= 889) && (pixel_index_A <= 890)) || pixel_index_A == 900 || pixel_index_A == 918 || pixel_index_A == 934 || pixel_index_A == 940 || pixel_index_A == 1647 || pixel_index_A == 1655 || pixel_index_A == 1689 || pixel_index_A == 1696 || pixel_index_A == 1737 || ((pixel_index_A >= 1741) && (pixel_index_A <= 1742)) || pixel_index_A == 1882 || pixel_index_A == 1888 || pixel_index_A == 1928 || pixel_index_A == 1931 || pixel_index_A == 1947 || pixel_index_A == 1984 || pixel_index_A == 1999 || pixel_index_A == 2602 || pixel_index_A == 2660 || pixel_index_A == 2669 || ((pixel_index_A >= 2711) && (pixel_index_A <= 2713)) || pixel_index_A == 2766 || pixel_index_A == 2772 || pixel_index_A == 2797 || ((pixel_index_A >= 2807) && (pixel_index_A <= 2808)) || pixel_index_A == 2859 || pixel_index_A == 2869 || pixel_index_A == 2907 || pixel_index_A == 2934 || pixel_index_A == 2964 || pixel_index_A == 3060 || ((pixel_index_A >= 3578) && (pixel_index_A <= 3579)) || pixel_index_A == 3628 || pixel_index_A == 3724 || pixel_index_A == 3775 || pixel_index_A == 3823 || pixel_index_A == 3850 || pixel_index_A == 3890 || pixel_index_A == 3911 || pixel_index_A == 3925 || pixel_index_A == 4689 || pixel_index_A == 4710 || pixel_index_A == 4727 || ((pixel_index_A >= 4731) && (pixel_index_A <= 4732)) || pixel_index_A == 4742 || pixel_index_A == 4838 || pixel_index_A == 5005 || pixel_index_A == 5599 || pixel_index_A == 5617 || pixel_index_A == 5626 || pixel_index_A == 5631 || pixel_index_A == 5739 || pixel_index_A == 5838) oled_data_A = 16'b0101101011001011;
    else if (pixel_index_A == 610 || pixel_index_A == 615 || pixel_index_A == 651 || pixel_index_A == 697 || pixel_index_A == 708 || pixel_index_A == 804 || pixel_index_A == 830 || pixel_index_A == 832 || pixel_index_A == 841 || pixel_index_A == 845 || pixel_index_A == 896 || pixel_index_A == 902 || pixel_index_A == 979 || pixel_index_A == 1034 || pixel_index_A == 1688 || pixel_index_A == 1699 || pixel_index_A == 1716 || pixel_index_A == 1795 || pixel_index_A == 1799 || pixel_index_A == 1810 || pixel_index_A == 1881 || pixel_index_A == 1887 || pixel_index_A == 1889 || pixel_index_A == 1910 || pixel_index_A == 1929 || pixel_index_A == 1936 || pixel_index_A == 2605 || pixel_index_A == 2622 || pixel_index_A == 2644 || pixel_index_A == 2651 || pixel_index_A == 2661 || pixel_index_A == 2667 || pixel_index_A == 2675 || pixel_index_A == 2748 || pixel_index_A == 2752 || pixel_index_A == 2848 || pixel_index_A == 2910 || pixel_index_A == 2994 || pixel_index_A == 3755 || pixel_index_A == 3759 || pixel_index_A == 3825 || pixel_index_A == 3827 || pixel_index_A == 3945 || pixel_index_A == 4649 || pixel_index_A == 4653 || pixel_index_A == 4739 || pixel_index_A == 4833 || pixel_index_A == 4835 || pixel_index_A == 4839 || pixel_index_A == 4856 || pixel_index_A == 4889 || pixel_index_A == 5494 || pixel_index_A == 5496 || pixel_index_A == 5586 || pixel_index_A == 5778) oled_data_A = 16'b1000010000010000;
    else if (pixel_index_A == 612 || ((pixel_index_A >= 628) && (pixel_index_A <= 629)) || pixel_index_A == 634 || ((pixel_index_A >= 636) && (pixel_index_A <= 637)) || pixel_index_A == 704 || pixel_index_A == 706 || pixel_index_A == 720 || pixel_index_A == 722 || pixel_index_A == 728 || pixel_index_A == 800 || pixel_index_A == 823 || pixel_index_A == 930 || pixel_index_A == 1559 || pixel_index_A == 1563 || pixel_index_A == 1568 || pixel_index_A == 1600 || pixel_index_A == 1615 || pixel_index_A == 1623 || pixel_index_A == 1669 || pixel_index_A == 1671 || pixel_index_A == 1676 || pixel_index_A == 1705 || pixel_index_A == 1767 || pixel_index_A == 1772 || pixel_index_A == 1832 || pixel_index_A == 1845 || pixel_index_A == 1851 || pixel_index_A == 1857 || pixel_index_A == 1859 || pixel_index_A == 1863 || pixel_index_A == 1865 || pixel_index_A == 1872 || pixel_index_A == 1907 || pixel_index_A == 1946 || pixel_index_A == 1983 || ((pixel_index_A >= 1986) && (pixel_index_A <= 1987)) || pixel_index_A == 1989 || pixel_index_A == 2004 || pixel_index_A == 2075 || pixel_index_A == 2649 || pixel_index_A == 2670 || pixel_index_A == 2740 || pixel_index_A == 2746 || pixel_index_A == 2850 || pixel_index_A == 2854 || pixel_index_A == 2895 || pixel_index_A == 2904 || pixel_index_A == 2957 || pixel_index_A == 3574 || pixel_index_A == 3583 || pixel_index_A == 3620 || pixel_index_A == 3622 || pixel_index_A == 3683 || pixel_index_A == 3756 || pixel_index_A == 3868 || pixel_index_A == 3954 || pixel_index_A == 4626 || pixel_index_A == 4645 || pixel_index_A == 4744 || pixel_index_A == 4749 || pixel_index_A == 4752 || pixel_index_A == 4843 || pixel_index_A == 4888 || pixel_index_A == 4914 || pixel_index_A == 4945 || pixel_index_A == 4982 || pixel_index_A == 5488 || pixel_index_A == 5605 || pixel_index_A == 5611 || pixel_index_A == 5637 || pixel_index_A == 5644 || pixel_index_A == 5681 || pixel_index_A == 5737 || pixel_index_A == 5779 || pixel_index_A == 5934) oled_data_A = 16'b0100001000001000;
    else if (pixel_index_A == 613 || pixel_index_A == 620 || pixel_index_A == 698 || pixel_index_A == 709 || pixel_index_A == 805 || pixel_index_A == 807 || pixel_index_A == 816 || pixel_index_A == 835 || pixel_index_A == 898 || pixel_index_A == 901 || pixel_index_A == 904 || pixel_index_A == 926 || pixel_index_A == 992 || pixel_index_A == 1013 || pixel_index_A == 1130 || pixel_index_A == 1550 || pixel_index_A == 1562 || pixel_index_A == 1614 || pixel_index_A == 1657 || pixel_index_A == 1672 || pixel_index_A == 1679 || pixel_index_A == 1700 || pixel_index_A == 1713 || pixel_index_A == 1721 || pixel_index_A == 1762 || pixel_index_A == 1769 || pixel_index_A == 1783 || pixel_index_A == 1796 || pixel_index_A == 1813 || pixel_index_A == 1816 || pixel_index_A == 1849 || pixel_index_A == 1858 || pixel_index_A == 1866 || pixel_index_A == 1879 || pixel_index_A == 1892 || pixel_index_A == 1911 || pixel_index_A == 1942 || pixel_index_A == 1954 || pixel_index_A == 1960 || pixel_index_A == 1971 || pixel_index_A == 1990 || pixel_index_A == 2009 || pixel_index_A == 2053 || pixel_index_A == 2615 || pixel_index_A == 2645 || pixel_index_A == 2659 || pixel_index_A == 2700 || pixel_index_A == 2751 || pixel_index_A == 2812 || pixel_index_A == 2930 || pixel_index_A == 3491 || pixel_index_A == 3581 || pixel_index_A == 3614 || pixel_index_A == 3624 || pixel_index_A == 3635 || ((pixel_index_A >= 3637) && (pixel_index_A <= 3638)) || pixel_index_A == 3658 || ((pixel_index_A >= 3664) && (pixel_index_A <= 3665)) || pixel_index_A == 3678 || pixel_index_A == 3719 || pixel_index_A == 3729 || pixel_index_A == 3761 || pixel_index_A == 3817 || pixel_index_A == 3993 || ((pixel_index_A >= 3998) && (pixel_index_A <= 3999)) || pixel_index_A == 4012 || pixel_index_A == 4650 || pixel_index_A == 4692 || pixel_index_A == 4729 || pixel_index_A == 4738 || pixel_index_A == 4759 || pixel_index_A == 4920 || pixel_index_A == 4977 || pixel_index_A == 4983 || pixel_index_A == 5603 || pixel_index_A == 5608 || pixel_index_A == 5613 || pixel_index_A == 5618 || pixel_index_A == 5625 || pixel_index_A == 5630 || pixel_index_A == 5635 || pixel_index_A == 5713 || ((pixel_index_A >= 5717) && (pixel_index_A <= 5718)) || pixel_index_A == 5722 || pixel_index_A == 5876) oled_data_A = 16'b0010100101000101;
    else if (pixel_index_A == 619 || pixel_index_A == 631 || pixel_index_A == 729 || pixel_index_A == 787 || pixel_index_A == 1836 || pixel_index_A == 1904 || pixel_index_A == 1906 || pixel_index_A == 2719 || pixel_index_A == 2757 || pixel_index_A == 2836 || pixel_index_A == 2851 || pixel_index_A == 2903 || pixel_index_A == 3659 || pixel_index_A == 3671 || pixel_index_A == 3720 || pixel_index_A == 3902 || pixel_index_A == 3904 || pixel_index_A == 3908 || pixel_index_A == 3953 || pixel_index_A == 3959 || pixel_index_A == 4631 || pixel_index_A == 4641 || pixel_index_A == 4694 || pixel_index_A == 4719 || pixel_index_A == 4725 || pixel_index_A == 4785 || pixel_index_A == 4809 || pixel_index_A == 5740 || pixel_index_A == 5839) oled_data_A = 16'b1001110011110011;
    else if (((pixel_index_A >= 621) && (pixel_index_A <= 622)) || pixel_index_A == 626 || pixel_index_A == 693 || pixel_index_A == 705 || pixel_index_A == 741 || pixel_index_A == 792 || pixel_index_A == 801 || pixel_index_A == 818 || pixel_index_A == 885 || pixel_index_A == 910 || ((pixel_index_A >= 913) && (pixel_index_A <= 914)) || pixel_index_A == 928 || pixel_index_A == 1033 || pixel_index_A == 1651 || pixel_index_A == 1691 || pixel_index_A == 1697 || pixel_index_A == 1740 || pixel_index_A == 1748 || pixel_index_A == 1791 || pixel_index_A == 1801 || pixel_index_A == 1806 || pixel_index_A == 1846 || pixel_index_A == 1850 || pixel_index_A == 1883 || pixel_index_A == 1939 || pixel_index_A == 2008 || pixel_index_A == 2103 || pixel_index_A == 2643 || pixel_index_A == 2646 || pixel_index_A == 2656 || pixel_index_A == 2756 || pixel_index_A == 2798 || pixel_index_A == 2842 || pixel_index_A == 2852 || ((pixel_index_A >= 2860) && (pixel_index_A <= 2861)) || pixel_index_A == 2894 || pixel_index_A == 2932 || ((pixel_index_A >= 2938) && (pixel_index_A <= 2939)) || pixel_index_A == 2956 || pixel_index_A == 2959 || pixel_index_A == 2993 || pixel_index_A == 3677 || pixel_index_A == 3701 || pixel_index_A == 3723 || pixel_index_A == 3753 || pixel_index_A == 3802 || pixel_index_A == 3869 || pixel_index_A == 3907 || pixel_index_A == 3917 || pixel_index_A == 4022 || pixel_index_A == 4118 || pixel_index_A == 4621 || pixel_index_A == 4634 || pixel_index_A == 4648 || ((pixel_index_A >= 4745) && (pixel_index_A <= 4746)) || pixel_index_A == 4788 || pixel_index_A == 4827 || pixel_index_A == 4837 || pixel_index_A == 4904 || pixel_index_A == 4936 || pixel_index_A == 4940 || pixel_index_A == 4944 || pixel_index_A == 4979 || pixel_index_A == 5006 || pixel_index_A == 5080 || pixel_index_A == 5546 || pixel_index_A == 5597 || ((pixel_index_A >= 5776) && (pixel_index_A <= 5777)) || pixel_index_A == 5935) oled_data_A = 16'b0111001110001110;
    else if (pixel_index_A == 623 || pixel_index_A == 642 || ((pixel_index_A >= 646) && (pixel_index_A <= 647)) || pixel_index_A == 831 || pixel_index_A == 833 || pixel_index_A == 909 || pixel_index_A == 923 || pixel_index_A == 1567 || pixel_index_A == 1641 || pixel_index_A == 1643 || pixel_index_A == 1652 || pixel_index_A == 1704 || pixel_index_A == 1792 || pixel_index_A == 1880 || pixel_index_A == 1894 || pixel_index_A == 2030 || pixel_index_A == 2104 || pixel_index_A == 2607 || pixel_index_A == 2619 || pixel_index_A == 2738 || pixel_index_A == 2747 || pixel_index_A == 2755 || pixel_index_A == 2773 || pixel_index_A == 2849 || pixel_index_A == 2868 || pixel_index_A == 2893 || pixel_index_A == 2947 || pixel_index_A == 2955 || pixel_index_A == 2965 || pixel_index_A == 3562 || ((pixel_index_A >= 3569) && (pixel_index_A <= 3570)) || pixel_index_A == 3608 || pixel_index_A == 3629 || pixel_index_A == 3666 || pixel_index_A == 3710 || pixel_index_A == 3771 || pixel_index_A == 3794 || pixel_index_A == 3806 || pixel_index_A == 3814 || pixel_index_A == 3829 || pixel_index_A == 3854 || pixel_index_A == 3870 || pixel_index_A == 3896 || pixel_index_A == 3899 || pixel_index_A == 3918 || pixel_index_A == 3923 || pixel_index_A == 4050 || pixel_index_A == 4652 || pixel_index_A == 4656 || pixel_index_A == 4693 || pixel_index_A == 4720 || pixel_index_A == 4751 || pixel_index_A == 4789 || pixel_index_A == 4813 || pixel_index_A == 4823 || pixel_index_A == 4840 || pixel_index_A == 4842 || pixel_index_A == 4885 || pixel_index_A == 4909 || pixel_index_A == 4923 || pixel_index_A == 4930 || pixel_index_A == 5077 || pixel_index_A == 5547 || pixel_index_A == 5596 || pixel_index_A == 5602 || pixel_index_A == 5604 || pixel_index_A == 5607 || pixel_index_A == 5609 || pixel_index_A == 5612 || pixel_index_A == 5614 || pixel_index_A == 5619 || pixel_index_A == 5624 || pixel_index_A == 5629 || pixel_index_A == 5634 || pixel_index_A == 5636 || pixel_index_A == 5643 || pixel_index_A == 5878) oled_data_A = 16'b0110001100001100;
    else if (pixel_index_A == 696 || ((pixel_index_A >= 736) && (pixel_index_A <= 737)) || pixel_index_A == 819 || pixel_index_A == 828 || pixel_index_A == 837 || pixel_index_A == 933 || pixel_index_A == 941 || pixel_index_A == 1029 || pixel_index_A == 1035 || pixel_index_A == 1644 || pixel_index_A == 1695 || pixel_index_A == 1719 || pixel_index_A == 1750 || pixel_index_A == 1785 || pixel_index_A == 2031 || pixel_index_A == 2606 || pixel_index_A == 2609 || pixel_index_A == 2668 || ((pixel_index_A >= 2672) && (pixel_index_A <= 2673)) || pixel_index_A == 2853 || pixel_index_A == 2941 || pixel_index_A == 3571 || pixel_index_A == 3582 || pixel_index_A == 3623 || pixel_index_A == 3697 || pixel_index_A == 3733 || pixel_index_A == 3797 || pixel_index_A == 3824 || pixel_index_A == 3826 || pixel_index_A == 3867 || pixel_index_A == 3895 || pixel_index_A == 3903 || pixel_index_A == 4543 || pixel_index_A == 4633 || pixel_index_A == 4651 || pixel_index_A == 4807 || pixel_index_A == 4933 || pixel_index_A == 4937 || pixel_index_A == 4951 || pixel_index_A == 4981 || pixel_index_A == 5490 || pixel_index_A == 5640 || pixel_index_A == 5680 || pixel_index_A == 5687 || pixel_index_A == 5692 || pixel_index_A == 5833 || pixel_index_A == 5874 || pixel_index_A == 5880) oled_data_A = 16'b0110101101001101;
    else if (pixel_index_A == 719 || pixel_index_A == 745 || pixel_index_A == 794 || pixel_index_A == 813 || pixel_index_A == 1703 || pixel_index_A == 1793 || pixel_index_A == 1940 || pixel_index_A == 2006 || pixel_index_A == 2658 || pixel_index_A == 2676 || pixel_index_A == 2754 || pixel_index_A == 2846 || pixel_index_A == 2902 || pixel_index_A == 3657 || pixel_index_A == 4753 || pixel_index_A == 4845 || pixel_index_A == 4847 || pixel_index_A == 4849) oled_data_A = 16'b1010010100110100;
    else if (pixel_index_A == 727 || pixel_index_A == 815 || pixel_index_A == 883 || pixel_index_A == 895 || pixel_index_A == 1654 || pixel_index_A == 1710 || pixel_index_A == 1902 || pixel_index_A == 1908 || pixel_index_A == 1932 || pixel_index_A == 3667 || pixel_index_A == 3673 || pixel_index_A == 3855 || pixel_index_A == 4717 || pixel_index_A == 5832) oled_data_A = 16'b1010110101110101;
    else if (pixel_index_A == 824 || pixel_index_A == 1891 || pixel_index_A == 3795 || pixel_index_A == 3849 || pixel_index_A == 3863 || pixel_index_A == 3893 || pixel_index_A == 3921 || pixel_index_A == 4910) oled_data_A = 16'b1011010110110110;
    else if (pixel_index_A == 935 || pixel_index_A == 1706 || pixel_index_A == 1720 || pixel_index_A == 4907 || pixel_index_A == 4915) oled_data_A = 16'b1100011000111000;
    else if (pixel_index_A == 2437 || pixel_index_A == 2832) oled_data_A = 16'b0010100010000100;
    else if (pixel_index_A == 2438 || pixel_index_A == 2445 || pixel_index_A == 2534 || pixel_index_A == 2540 || pixel_index_A == 2826 || pixel_index_A == 2916 || pixel_index_A == 3906 || pixel_index_A == 5885) oled_data_A = 16'b0001000001000010;
    else if (pixel_index_A == 2446 || pixel_index_A == 2824) oled_data_A = 16'b0011100100000111;
    else if (pixel_index_A == 2447 || pixel_index_A == 2532) oled_data_A = 16'b0010100010000101;
    else if (pixel_index_A == 2531 || pixel_index_A == 5790) oled_data_A = 16'b0010000101000100;
    else if (pixel_index_A == 2533 || pixel_index_A == 2633) oled_data_A = 16'b0111101000001110;
    else if (pixel_index_A == 2537 || pixel_index_A == 5455) oled_data_A = 16'b0000100000000001;
    else if (pixel_index_A == 2541 || pixel_index_A == 2735) oled_data_A = 16'b1000001000001111;
    else if (pixel_index_A == 2542 || pixel_index_A == 2728 || pixel_index_A == 2922) oled_data_A = 16'b0011100011000110;
    else if (pixel_index_A == 2543 || pixel_index_A == 2923) oled_data_A = 16'b0110100111001101;
    else if (pixel_index_A == 2544) oled_data_A = 16'b0011000011000110;
    else if (pixel_index_A == 2628) oled_data_A = 16'b0111000111001110;
    else if (pixel_index_A == 2629) oled_data_A = 16'b0101100110001010;
    else if (pixel_index_A == 2631 || (pixel_index_A >= 2724) && (pixel_index_A <= 2725)) oled_data_A = 16'b0111100111001110;
    else if (pixel_index_A == 2632 || pixel_index_A == 2825) oled_data_A = 16'b0101000101001010;
    else if (pixel_index_A == 2634 || pixel_index_A == 3607 || pixel_index_A == 4000 || pixel_index_A == 5719) oled_data_A = 16'b0001100010000011;
    else if (pixel_index_A == 2635) oled_data_A = 16'b0011100011000111;
    else if (pixel_index_A == 2636) oled_data_A = 16'b0100100101001000;
    else if (pixel_index_A == 2637) oled_data_A = 16'b0101100101001010;
    else if (pixel_index_A == 2638) oled_data_A = 16'b0110000111001100;
    else if (pixel_index_A == 2639) oled_data_A = 16'b1000101000001111;
    else if (pixel_index_A == 2640) oled_data_A = 16'b0010000010000011;
    else if (pixel_index_A == 2723 || pixel_index_A == 5714) oled_data_A = 16'b0001100010000010;
    else if (pixel_index_A == 2727) oled_data_A = 16'b1000101001010000;
    else if (pixel_index_A == 2729) oled_data_A = 16'b0111000111001101;
    else if (pixel_index_A == 2730 || pixel_index_A == 2733 || pixel_index_A == 2830) oled_data_A = 16'b0010000010000100;
    else if (pixel_index_A == 2731 || pixel_index_A == 2820 || pixel_index_A == 2919) oled_data_A = 16'b0100000100000111;
    else if (pixel_index_A == 2732 || pixel_index_A == 2819 || pixel_index_A == 2828 || pixel_index_A == 2915) oled_data_A = 16'b0100100101001001;
    else if (pixel_index_A == 2734 || pixel_index_A == 2926) oled_data_A = 16'b0110100110001100;
    else if (pixel_index_A == 2736) oled_data_A = 16'b0001000001000011;
    else if (pixel_index_A == 2821 || pixel_index_A == 2921) oled_data_A = 16'b0101000110001010;
    else if (pixel_index_A == 2822) oled_data_A = 16'b0100000011000111;
    else if (pixel_index_A == 2823) oled_data_A = 16'b1000001000010000;
    else if (pixel_index_A == 2827 || pixel_index_A == 2920) oled_data_A = 16'b0110000110001011;
    else if (pixel_index_A == 2829) oled_data_A = 16'b0110000110001100;
    else if (pixel_index_A == 2831 || pixel_index_A == 2925) oled_data_A = 16'b0110100111001100;
    else if (pixel_index_A == 2834 || pixel_index_A == 3704 || pixel_index_A == 5601) oled_data_A = 16'b0011000111000110;
    else if (pixel_index_A == 2835) oled_data_A = 16'b0101101010001011;
    else if (pixel_index_A == 2843 || pixel_index_A == 2942 || pixel_index_A == 4747) oled_data_A = 16'b0111001110001101;
    else if (pixel_index_A == 2844) oled_data_A = 16'b0111101111010000;
    else if (pixel_index_A == 2891 || pixel_index_A == 2953 || pixel_index_A == 3728) oled_data_A = 16'b1100111001111001;
    else if (pixel_index_A == 2917 || pixel_index_A == 3021) oled_data_A = 16'b0001100001000011;
    else if (pixel_index_A == 2918) oled_data_A = 16'b0100000101001000;
    else if (pixel_index_A == 2924) oled_data_A = 16'b0011000011000101;
    else if (pixel_index_A == 2927) oled_data_A = 16'b0101000101001001;
    else if (pixel_index_A == 2928 || pixel_index_A == 3127 || pixel_index_A == 3588 || pixel_index_A == 3807 || pixel_index_A == 3979 || pixel_index_A == 3982 || pixel_index_A == 4493 || pixel_index_A == 4582 || pixel_index_A == 4784) oled_data_A = 16'b0000000001000001;
    else if (pixel_index_A == 2931) oled_data_A = 16'b0111101111001110;
    else if (pixel_index_A == 3030 || pixel_index_A == 3601 || pixel_index_A == 4755) oled_data_A = 16'b0100101010001010;
    else if (pixel_index_A == 3031 || pixel_index_A == 3612) oled_data_A = 16'b0001000001000001;
    else if (pixel_index_A == 3039) oled_data_A = 16'b0001000010000011;
    else if (pixel_index_A == 3135) oled_data_A = 16'b0000100001000000;
    else if (pixel_index_A == 3589 || pixel_index_A == 3784 || pixel_index_A == 3886) oled_data_A = 16'b0000100110001000;
    else if (pixel_index_A == 3590 || pixel_index_A == 3786) oled_data_A = 16'b0000101000001010;
    else if (pixel_index_A == 3591) oled_data_A = 16'b0000000101000111;
    else if (pixel_index_A == 3593) oled_data_A = 16'b0000100101000111;
    else if (pixel_index_A == 3594 || pixel_index_A == 3689) oled_data_A = 16'b0000101000001011;
    else if (pixel_index_A == 3595 || (pixel_index_A >= 3597) && (pixel_index_A <= 3598)) oled_data_A = 16'b0000000011000100;
    else if (pixel_index_A == 3600 || pixel_index_A == 3610) oled_data_A = 16'b0000100000000000;
    else if (pixel_index_A == 3602) oled_data_A = 16'b0110101100001100;
    else if (pixel_index_A == 3611) oled_data_A = 16'b0011000111000111;
    else if (pixel_index_A == 3615) oled_data_A = 16'b0000000000000001;
    else if (pixel_index_A == 3616) oled_data_A = 16'b0100001000000111;
    else if (pixel_index_A == 3684 || pixel_index_A == 3690 || pixel_index_A == 3876) oled_data_A = 16'b0000000011000101;
    else if (pixel_index_A == 3685 || pixel_index_A == 3885) oled_data_A = 16'b0000101101010001;
    else if (pixel_index_A == 3686) oled_data_A = 16'b0000100011000101;
    else if (pixel_index_A == 3687 || pixel_index_A == 3879) oled_data_A = 16'b0000101011001111;
    else if (pixel_index_A == 3688) oled_data_A = 16'b0000000100000101;
    else if (pixel_index_A == 3691) oled_data_A = 16'b0000101100001111;
    else if (pixel_index_A == 3692 || pixel_index_A == 3788 || pixel_index_A == 3975 || pixel_index_A == 3977) oled_data_A = 16'b0000000001000010;
    else if (pixel_index_A == 3693 || pixel_index_A == 3789 || pixel_index_A == 3878) oled_data_A = 16'b0000100111001001;
    else if (pixel_index_A == 3694) oled_data_A = 16'b0000100110001001;
    else if (pixel_index_A == 3698) oled_data_A = 16'b0010100110000110;
    else if (pixel_index_A == 3705) oled_data_A = 16'b0111001101001110;
    else if (pixel_index_A == 3707 || pixel_index_A == 4664) oled_data_A = 16'b0111110000001111;
    else if (pixel_index_A == 3780 || pixel_index_A == 3972) oled_data_A = 16'b0000100100000101;
    else if (pixel_index_A == 3781) oled_data_A = 16'b0000101001001100;
    else if (pixel_index_A == 3783) oled_data_A = 16'b0000101001001101;
    else if (pixel_index_A == 3785) oled_data_A = 16'b0000101010001110;
    else if (pixel_index_A == 3787) oled_data_A = 16'b0000101110010010;
    else if (pixel_index_A == 3790) oled_data_A = 16'b0000000110001000;
    else if (pixel_index_A == 3792 || pixel_index_A == 5708) oled_data_A = 16'b0011000110000101;
    else if (pixel_index_A == 3877) oled_data_A = 16'b0000101101010010;
    else if (pixel_index_A == 3880) oled_data_A = 16'b0000000011000011;
    else if (pixel_index_A == 3881 || pixel_index_A == 3973) oled_data_A = 16'b0000101011001110;
    else if (pixel_index_A == 3882) oled_data_A = 16'b0000100111001010;
    else if (pixel_index_A == 3883) oled_data_A = 16'b0000101010001101;
    else if (pixel_index_A == 3884) oled_data_A = 16'b0000100100000110;
    else if (pixel_index_A == 3888 || pixel_index_A == 4792) oled_data_A = 16'b0001100011000100;
    else if (pixel_index_A == 3974 || pixel_index_A == 3978 || pixel_index_A == 4069) oled_data_A = 16'b0000000100000110;
    else if ((pixel_index_A >= 3980) && (pixel_index_A <= 3981)) oled_data_A = 16'b0000000010000011;
    else if (pixel_index_A == 3989 || pixel_index_A == 4750 || pixel_index_A == 5697) oled_data_A = 16'b0010000011000100;
    else if (pixel_index_A == 4003 || pixel_index_A == 5712) oled_data_A = 16'b0010000101000101;
    else if (pixel_index_A == 4068) oled_data_A = 16'b0000000010000010;
    else if (pixel_index_A == 4471) oled_data_A = 16'b0000100010000001;
    else if (pixel_index_A == 4494 || pixel_index_A == 4672 || pixel_index_A == 4865 || pixel_index_A == 4955) oled_data_A = 16'b0000000101000010;
    else if (pixel_index_A == 4567 || pixel_index_A == 5840) oled_data_A = 16'b0100000111001000;
    else if (pixel_index_A == 4572 || pixel_index_A == 4574 || pixel_index_A == 4580 || pixel_index_A == 4684 || pixel_index_A == 4879 || pixel_index_A == 5157 || pixel_index_A == 5159 || pixel_index_A == 5454) oled_data_A = 16'b0000000001000000;
    else if (((pixel_index_A >= 4577) && (pixel_index_A <= 4578)) || ((pixel_index_A >= 4585) && (pixel_index_A <= 4586)) || pixel_index_A == 4671 || pixel_index_A == 4686 || ((pixel_index_A >= 4769) && (pixel_index_A <= 4770)) || pixel_index_A == 4877 || pixel_index_A == 4956 || pixel_index_A == 4963 || pixel_index_A == 4968) oled_data_A = 16'b0000000010000001;
    else if (pixel_index_A == 4589 || pixel_index_A == 4682 || pixel_index_A == 4859 || pixel_index_A == 4874 || pixel_index_A == 4961) oled_data_A = 16'b0000001010000101;
    else if (pixel_index_A == 4590 || pixel_index_A == 4667 || pixel_index_A == 4959) oled_data_A = 16'b0000001000000011;
    else if (pixel_index_A == 4654) oled_data_A = 16'b0010100101000100;
    else if (pixel_index_A == 4659) oled_data_A = 16'b0101001001001001;
    else if (pixel_index_A == 4668 || pixel_index_A == 4764 || pixel_index_A == 4771 || pixel_index_A == 4878) oled_data_A = 16'b0000001100000110;
    else if (pixel_index_A == 4670 || pixel_index_A == 4861) oled_data_A = 16'b0000001111000111;
    else if (((pixel_index_A >= 4673) && (pixel_index_A <= 4674)) || pixel_index_A == 4763 || pixel_index_A == 4768 || pixel_index_A == 4779 || ((pixel_index_A >= 4863) && (pixel_index_A <= 4864)) || pixel_index_A == 4867 || pixel_index_A == 4876) oled_data_A = 16'b0000001011000101;
    else if (pixel_index_A == 4675 || pixel_index_A == 4680) oled_data_A = 16'b0000000110000010;
    else if (pixel_index_A == 4676 || pixel_index_A == 4678 || pixel_index_A == 4775 || pixel_index_A == 4778 || pixel_index_A == 4782 || pixel_index_A == 4871 || pixel_index_A == 4873 || pixel_index_A == 4957 || ((pixel_index_A >= 4969) && (pixel_index_A <= 4970)) || pixel_index_A == 5061 || pixel_index_A == 5063) oled_data_A = 16'b0000001001000100;
    else if (pixel_index_A == 4677 || pixel_index_A == 4765 || pixel_index_A == 4860 || pixel_index_A == 4972) oled_data_A = 16'b0000000111000011;
    else if (pixel_index_A == 4679 || pixel_index_A == 4767 || ((pixel_index_A >= 4776) && (pixel_index_A <= 4777)) || pixel_index_A == 4780 || pixel_index_A == 4974) oled_data_A = 16'b0000000110000011;
    else if (pixel_index_A == 4681 || pixel_index_A == 4773 || pixel_index_A == 4872 || pixel_index_A == 4875 || pixel_index_A == 4962 || pixel_index_A == 4965 || pixel_index_A == 4967) oled_data_A = 16'b0000001010000100;
    else if (pixel_index_A == 4683 || pixel_index_A == 4774 || pixel_index_A == 4862 || pixel_index_A == 4866 || pixel_index_A == 4870 || pixel_index_A == 4964 || pixel_index_A == 4966 || pixel_index_A == 5060) oled_data_A = 16'b0000000100000010;
    else if (pixel_index_A == 4685) oled_data_A = 16'b0000010001001000;
    else if (pixel_index_A == 4748) oled_data_A = 16'b0110101101001110;
    else if (pixel_index_A == 4766) oled_data_A = 16'b0000001110000110;
    else if (pixel_index_A == 4772 || pixel_index_A == 4954 || pixel_index_A == 4971 || pixel_index_A == 5062) oled_data_A = 16'b0000000011000010;
    else if (pixel_index_A == 4781) oled_data_A = 16'b0000001100000101;
    else if (pixel_index_A == 4790 || pixel_index_A == 4929 || pixel_index_A == 4984 || pixel_index_A == 5780) oled_data_A = 16'b1011110111110111;
    else if (pixel_index_A == 4793 || pixel_index_A == 4853) oled_data_A = 16'b1000110001010000;
    else if (pixel_index_A == 4854 || pixel_index_A == 4948) oled_data_A = 16'b0010100101000110;
    else if (pixel_index_A == 4858 || pixel_index_A == 4960 || pixel_index_A == 4975) oled_data_A = 16'b0000000011000001;
    else if (pixel_index_A == 4868) oled_data_A = 16'b0000000100000001;
    else if (pixel_index_A == 4869) oled_data_A = 16'b0000001001000101;
    else if (pixel_index_A == 4884) oled_data_A = 16'b0110101101001100;
    else if (pixel_index_A == 4928) oled_data_A = 16'b0011000101000110;
    else if (pixel_index_A == 4939) oled_data_A = 16'b0011000110000111;
    else if (pixel_index_A == 4941) oled_data_A = 16'b0110001100001011;
    else if (pixel_index_A == 4943) oled_data_A = 16'b0100001001001001;
    else if (pixel_index_A == 4947) oled_data_A = 16'b0111101110001110;
    else if (pixel_index_A == 4950) oled_data_A = 16'b1000010000001111;
    else if (pixel_index_A == 4980) oled_data_A = 16'b0000100001000010;
    else if (pixel_index_A == 5615) oled_data_A = 16'b0011100110000110;
    else if (pixel_index_A == 5623) oled_data_A = 16'b0010100110000101;
    else if (pixel_index_A == 5646) oled_data_A = 16'b0101101011001100;
    else if (pixel_index_A == 5742) oled_data_A = 16'b0110001011001011;
    else if (pixel_index_A == 5743) oled_data_A = 16'b0100101010001001;
    else if (pixel_index_A == 5835) oled_data_A = 16'b0110001100001101;
    else if (pixel_index_A == 5836) oled_data_A = 16'b0100101001001000;
    else oled_data_A = 0;

        end
    end

endmodule
