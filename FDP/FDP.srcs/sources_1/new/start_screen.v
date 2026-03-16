`timescale 1ns / 1ps

module start_screen(
    input clk, [15:0] sw, btnC, btnL, btnR, btnD, btnU, [15:0] pixel_index, sample_pixel,
    output reg [15:0] oled_data, reg [2:0] game_state = 0, reg begin_flag = 0
    );
    
    wire [6:0] x = pixel_index % 96; // 0 to 95
    wire [5:0] y = pixel_index / 96; // 0 to 63
    reg [25:0] clk_count = 0;
    reg clk2hz = 0;
    
    //5Hz clock gen
    always @(posedge clk) begin
        if (clk_count == 50_000_000) begin                           
            clk_count <= 0;
            clk2hz <= ~clk2hz; 
        end else begin
            clk_count <= clk_count + 1;
        end      
    end
    
   //3 bit state generator
   always @ (posedge clk)
   begin
        if(btnC || btnL || btnR || btnD || btnU) begin_flag <= 1; //currently no debouncing
        if(begin_flag == 0) game_state <= game_state + 1;
   end
   
   //start game screen blinking
   always @ (posedge clk)
   begin
   if (clk2hz) 
   begin
           if (pixel_index == 723) oled_data = 16'b0100000111000101;
           else if (pixel_index == 724) oled_data = 16'b0100101001000001;
           else if (pixel_index == 725) oled_data = 16'b0011100111000011;
           else if (pixel_index == 726 || pixel_index == 3817) oled_data = 16'b0000000000000001;
           else if (pixel_index == 817 || pixel_index == 912 || pixel_index == 1202 || ((pixel_index >= 2540) && (pixel_index <= 2541)) || pixel_index == 2543 || pixel_index == 2545 || pixel_index == 3131 || pixel_index == 3234 || pixel_index == 3288 || pixel_index == 3301 || pixel_index == 3394 || pixel_index == 3416 || ((pixel_index >= 3489) && (pixel_index <= 3490)) || pixel_index == 3569 || pixel_index == 3586 || pixel_index == 3672 || pixel_index == 3680 || pixel_index == 3682) oled_data = 16'b0010000100000100;
           else if (pixel_index == 818) oled_data = 16'b1001010010101100;
           else if (pixel_index == 819) oled_data = 16'b1010010100101010;
           else if (pixel_index == 820) oled_data = 16'b1111111111100000;
           else if (pixel_index == 821) oled_data = 16'b1111011101101001;
           else if (pixel_index == 822 || pixel_index == 913) oled_data = 16'b0011000110000101;
           else if (pixel_index == 911 || pixel_index == 1393 || pixel_index == 2357 || pixel_index == 2544 || ((pixel_index >= 3093) && (pixel_index <= 3094)) || pixel_index == 3102 || pixel_index == 3196 || pixel_index == 3293 || pixel_index == 3315 || pixel_index == 3377 || pixel_index == 3381 || pixel_index == 3494 || ((pixel_index >= 3527) && (pixel_index <= 3528)) || pixel_index == 3570 || pixel_index == 3700) oled_data = 16'b0001100011000011;
           else if (pixel_index == 914) oled_data = 16'b1100111001101011;
           else if (pixel_index == 915) oled_data = 16'b1111011101101000;
           else if (pixel_index == 916) oled_data = 16'b1111011101100011;
           else if (pixel_index == 917) oled_data = 16'b1110111100101011;
           else if (pixel_index == 918 || pixel_index == 1974 || pixel_index == 2166) oled_data = 16'b0010100101000100;
           else if (pixel_index == 1006 || pixel_index == 1008 || pixel_index == 1103 || pixel_index == 1105 || pixel_index == 1781 || pixel_index == 1961 || ((pixel_index >= 3095) && (pixel_index <= 3096)) || ((pixel_index >= 3098) && (pixel_index <= 3099)) || pixel_index == 3108 || pixel_index == 3113 || ((pixel_index >= 3115) && (pixel_index <= 3116)) || ((pixel_index >= 3143) && (pixel_index <= 3144)) || pixel_index == 3185 || pixel_index == 3325 || ((pixel_index >= 3419) && (pixel_index <= 3420)) || pixel_index == 3609) oled_data = 16'b0100101001001001;
           else if (pixel_index == 1007 || pixel_index == 1106 || pixel_index == 1684 || pixel_index == 2250 || pixel_index == 3092 || pixel_index == 3236 || pixel_index == 3428 || ((pixel_index >= 3582) && (pixel_index <= 3583)) || ((pixel_index >= 3611) && (pixel_index <= 3612)) || pixel_index == 3687) oled_data = 16'b0101001010001010;
           else if (pixel_index == 1009 || pixel_index == 3524) oled_data = 16'b0101001010001011;
           else if (pixel_index == 1010 || pixel_index == 1199) oled_data = 16'b0010000100000101;
           else if (pixel_index == 1011) oled_data = 16'b0111001101000111;
           else if (pixel_index == 1012) oled_data = 16'b1001110011101010;
           else if (pixel_index == 1013 || pixel_index == 1587 || pixel_index == 1674 || pixel_index == 1878 || pixel_index == 2546 || pixel_index == 3103 || pixel_index == 3117 || pixel_index == 3125 || pixel_index == 3128 || pixel_index == 3132 || ((pixel_index >= 3135) && (pixel_index <= 3136)) || pixel_index == 3202 || pixel_index == 3298 || pixel_index == 3317 || pixel_index == 3322 || pixel_index == 3329 || pixel_index == 3384 || pixel_index == 3480 || pixel_index == 3510 || pixel_index == 3576 || pixel_index == 3616 || pixel_index == 3618 || pixel_index == 3717) oled_data = 16'b0010100101000101;
           else if (pixel_index == 1101 || pixel_index == 1579 || pixel_index == 3090 || pixel_index == 3109 || pixel_index == 3139 || pixel_index == 3145 || pixel_index == 3213 || pixel_index == 3237 || pixel_index == 3307 || pixel_index == 3391 || pixel_index == 3403 || pixel_index == 3415 || pixel_index == 3429 || pixel_index == 3433 || pixel_index == 3507 || pixel_index == 3520) oled_data = 16'b0011100111000111;
           else if (pixel_index == 1102 || pixel_index == 1294 || pixel_index == 1388 || pixel_index == 1877 || pixel_index == 2153 || pixel_index == 2165 || pixel_index == 2346 || pixel_index == 3127 || pixel_index == 3187 || pixel_index == 3296 || pixel_index == 3390 || pixel_index == 3617 || pixel_index == 3620 || pixel_index == 3665 || pixel_index == 3715) oled_data = 16'b0101101011001011;
           else if (pixel_index == 1104 || pixel_index == 3525) oled_data = 16'b0100001000000111;
           else if (pixel_index == 1107 || pixel_index == 1198 || pixel_index == 1392 || pixel_index == 3091 || pixel_index == 3126 || pixel_index == 3220 || pixel_index == 3224 || pixel_index == 3241 || pixel_index == 3398) oled_data = 16'b0110001100001100;
           else if (pixel_index == 1108) oled_data = 16'b0100001000001001;
           else if (pixel_index == 1197 || pixel_index == 2443 || pixel_index == 2451 || ((pixel_index >= 3222) && (pixel_index <= 3223)) || pixel_index == 3330 || pixel_index == 3389 || pixel_index == 3523 || pixel_index == 3676 || pixel_index == 3711) oled_data = 16'b0110101101001101;
           else if (pixel_index == 1201 || pixel_index == 1204 || pixel_index == 1483 || pixel_index == 3106 || ((pixel_index >= 3110) && (pixel_index <= 3111)) || pixel_index == 3200 || pixel_index == 3207 || pixel_index == 3229 || pixel_index == 3303 || pixel_index == 3386 || pixel_index == 3478 || pixel_index == 3509 || pixel_index == 3513 || pixel_index == 3529 || pixel_index == 3574 || pixel_index == 3578 || pixel_index == 3591 || pixel_index == 3603 || pixel_index == 3684 || pixel_index == 3762 || pixel_index == 3799) oled_data = 16'b0000100001000001;
           else if (pixel_index == 1203 || pixel_index == 1293 || pixel_index == 2057 || pixel_index == 2249 || pixel_index == 2261 || pixel_index == 2452 || pixel_index == 2542 || pixel_index == 3097 || pixel_index == 3107 || pixel_index == 3112 || pixel_index == 3114 || pixel_index == 3142 || pixel_index == 3189 || pixel_index == 3333 || pixel_index == 3411 || pixel_index == 3499 || pixel_index == 3580 || pixel_index == 3595 || pixel_index == 3669 || pixel_index == 3677 || pixel_index == 3716) oled_data = 16'b0100001000001000;
           else if (pixel_index == 1295) oled_data = 16'b0011100111000110;
           else if (pixel_index == 1389 || pixel_index == 1580 || pixel_index == 2251 || pixel_index == 3211 || pixel_index == 3231 || pixel_index == 3282 || ((pixel_index >= 3431) && (pixel_index <= 3432)) || pixel_index == 3476 || pixel_index == 3584 || pixel_index == 3681 || pixel_index == 3719) oled_data = 16'b1001110011110011;
           else if (pixel_index == 1390 || pixel_index == 1582 || pixel_index == 1876 || pixel_index == 2260 || pixel_index == 3327 || pixel_index == 3380 || ((pixel_index >= 3424) && (pixel_index <= 3425)) || ((pixel_index >= 3515) && (pixel_index <= 3516)) || pixel_index == 3519 || pixel_index == 3522 || pixel_index == 3615) oled_data = 16'b1000010000010000;
           else if (pixel_index == 1391) oled_data = 16'b1010110101110110;
           else if (pixel_index == 1484 || pixel_index == 1488 || pixel_index == 2356 || pixel_index == 3192 || ((pixel_index >= 3426) && (pixel_index <= 3427)) || pixel_index == 3486 || pixel_index == 3585 || pixel_index == 3605 || pixel_index == 3710) oled_data = 16'b1000110001010001;
           else if (pixel_index == 1485 || ((pixel_index >= 1676) && (pixel_index <= 1677)) || pixel_index == 1972 || pixel_index == 2347 || pixel_index == 3228 || pixel_index == 3232 || pixel_index == 3328 || pixel_index == 3508 || pixel_index == 3573 || pixel_index == 3577) oled_data = 16'b1100111001111001;
           else if (pixel_index == 1486 || pixel_index == 1586 || pixel_index == 3208 || pixel_index == 3492 || pixel_index == 3589 || pixel_index == 3614 || pixel_index == 3705) oled_data = 16'b0111001110001110;
           else if (pixel_index == 1487) oled_data = 16'b1111011110111101;
           else if (pixel_index == 1489) oled_data = 16'b0011000110000111;
           else if (pixel_index == 1581 || pixel_index == 1770 || pixel_index == 2164 || pixel_index == 3188 || pixel_index == 3191 || ((pixel_index >= 3194) && (pixel_index <= 3195)) || pixel_index == 3204 || pixel_index == 3209 || pixel_index == 3212 || ((pixel_index >= 3239) && (pixel_index <= 3240)) || pixel_index == 3281 || pixel_index == 3396 || pixel_index == 3418 || pixel_index == 3423 || pixel_index == 3487 || pixel_index == 3704) oled_data = 16'b0111101111001111;
           else if (pixel_index == 1583) oled_data = 16'b1111011110111111;
           else if (pixel_index == 1584 || pixel_index == 1866 || pixel_index == 1962 || pixel_index == 2058 || pixel_index == 2354 || pixel_index == 3221 || pixel_index == 3306 || pixel_index == 3402 || pixel_index == 3477 || pixel_index == 3485 || pixel_index == 3498 || pixel_index == 3526 || pixel_index == 3590 || pixel_index == 3594 || pixel_index == 3604 || pixel_index == 3622 || pixel_index == 3718) oled_data = 16'b1011110111110111;
           else if (pixel_index == 1585) oled_data = 16'b1000110001010000;
           else if (pixel_index == 1675 || pixel_index == 3198 || pixel_index == 3673 || pixel_index == 3683 || pixel_index == 3686 || pixel_index == 3690) oled_data = 16'b1001010010110010;
           else if (pixel_index == 1678 || pixel_index == 1780 || pixel_index == 2069 || pixel_index == 2445 || pixel_index == 3238 || pixel_index == 3316 || pixel_index == 3395 || pixel_index == 3491 || pixel_index == 3493) oled_data = 16'b1101011010111010;
           else if (pixel_index == 1679 || ((pixel_index >= 1772) && (pixel_index <= 1779)) || ((pixel_index >= 1867) && (pixel_index <= 1875)) || ((pixel_index >= 1963) && (pixel_index <= 1971)) || ((pixel_index >= 2059) && (pixel_index <= 2067)) || ((pixel_index >= 2156) && (pixel_index <= 2163)) || ((pixel_index >= 2252) && (pixel_index <= 2259)) || (pixel_index >= 2348) && (pixel_index <= 2353)) oled_data = 16'b1111111111111111;
           else if (pixel_index == 1680) oled_data = 16'b1111111111111110;
           else if (pixel_index == 1681) oled_data = 16'b1101011010111011;
           else if (pixel_index == 1682 || pixel_index == 3235) oled_data = 16'b1111011110111110;
           else if (pixel_index == 1683) oled_data = 16'b1101011010111001;
           else if (pixel_index == 1685 || pixel_index == 3624) oled_data = 16'b0000100001000010;
           else if (pixel_index == 1769 || pixel_index == 2262 || pixel_index == 2442 || pixel_index == 3100 || ((pixel_index >= 3140) && (pixel_index <= 3141)) || pixel_index == 3414 || pixel_index == 3518 || pixel_index == 3606 || pixel_index == 3625 || pixel_index == 3763 || pixel_index == 3798) oled_data = 16'b0001000010000010;
           else if (pixel_index == 1771 || ((pixel_index >= 2446) && (pixel_index <= 2449)) || pixel_index == 3193 || pixel_index == 3199 || pixel_index == 3488 || pixel_index == 3517) oled_data = 16'b1110011100111100;
           else if (pixel_index == 1865 || pixel_index == 3190 || pixel_index == 3475 || pixel_index == 3572 || pixel_index == 3691 || pixel_index == 3706 || pixel_index == 3709) oled_data = 16'b0011000110000110;
           else if (pixel_index == 1973 || pixel_index == 2444 || pixel_index == 3186 || pixel_index == 3324 || pixel_index == 3334 || pixel_index == 3392 || pixel_index == 3397 || (pixel_index >= 3702) && (pixel_index <= 3703)) oled_data = 16'b1011010110110110;
           else if (pixel_index == 2068 || pixel_index == 2155) oled_data = 16'b1110111101111101;
           else if (pixel_index == 2070) oled_data = 16'b0001100011000100;
           else if (pixel_index == 2154 || pixel_index == 2450 || ((pixel_index >= 3205) && (pixel_index <= 3206)) || pixel_index == 3294 || pixel_index == 3323 || pixel_index == 3421 || pixel_index == 3610 || pixel_index == 3667 || pixel_index == 3701 || pixel_index == 3720) oled_data = 16'b1010010100110100;
           else if (pixel_index == 2355 || pixel_index == 3227 || pixel_index == 3295 || pixel_index == 3378 || ((pixel_index >= 3511) && (pixel_index <= 3512)) || pixel_index == 3581 || pixel_index == 3613 || pixel_index == 3666 || pixel_index == 3668) oled_data = 16'b1010110101110101;
           else if (pixel_index == 3203 || pixel_index == 3210 || pixel_index == 3302 || pixel_index == 3521) oled_data = 16'b1101111011111011;
           else if (pixel_index == 3289 || pixel_index == 3299 || pixel_index == 3331 || pixel_index == 3379 || pixel_index == 3385 || pixel_index == 3412 || pixel_index == 3481 || pixel_index == 3514 || pixel_index == 3587) oled_data = 16'b1100011000111000;
           else if (pixel_index == 3332) oled_data = 16'b0101001010001001;
           else if (pixel_index == 3430) oled_data = 16'b1101111011111100;
           else if (pixel_index == 3607) oled_data = 16'b0100001001001001;
           else if (pixel_index == 3608) oled_data = 16'b1011010101110101;
           else if (pixel_index == 3619) oled_data = 16'b0111101111001110;
           else if (pixel_index == 3621) oled_data = 16'b0011100111001000;
           else if (pixel_index == 3623) oled_data = 16'b0001000010000001;
           else if (pixel_index == 3712) oled_data = 16'b0001100100000100;
           else if (pixel_index == 3721) oled_data = 16'b1001110011110010;
           else if (pixel_index == 3722) oled_data = 16'b0001000010000011;
           else oled_data = 0;
   end else
   begin
           if (pixel_index == 723) oled_data = 16'b0100000111000101;
           else if (pixel_index == 724) oled_data = 16'b0100101001000001;
           else if (pixel_index == 725) oled_data = 16'b0011100111000011;
           else if (pixel_index == 726 || pixel_index == 4974) oled_data = 16'b0000000000000001;
           else if (pixel_index == 817 || pixel_index == 912 || pixel_index == 1202 || ((pixel_index >= 2540) && (pixel_index <= 2541)) || pixel_index == 2543 || pixel_index == 2545 || ((pixel_index >= 2704) && (pixel_index <= 2736)) || ((pixel_index >= 2738) && (pixel_index <= 2763)) || pixel_index == 3117 || pixel_index == 3234 || pixel_index == 3276 || pixel_index == 3288 || pixel_index == 3301 || pixel_index == 3394 || pixel_index == 3416 || pixel_index == 3438 || ((pixel_index >= 3489) && (pixel_index <= 3490)) || pixel_index == 3537 || pixel_index == 3569 || pixel_index == 3586 || pixel_index == 3672 || pixel_index == 3680 || pixel_index == 3682 || pixel_index == 3712 || pixel_index == 3729 || pixel_index == 4142 || pixel_index == 4533 || pixel_index == 4628 || pixel_index == 4648 || pixel_index == 4655 || pixel_index == 4832 || pixel_index == 4866 || pixel_index == 4938 || pixel_index == 4952 || pixel_index == 4957) oled_data = 16'b0010000100000100;
           else if (pixel_index == 818) oled_data = 16'b1001010010101100;
           else if (pixel_index == 819) oled_data = 16'b1010010100101010;
           else if (pixel_index == 820) oled_data = 16'b1111111111100000;
           else if (pixel_index == 821) oled_data = 16'b1111011101101001;
           else if (pixel_index == 822 || pixel_index == 913 || pixel_index == 4096 || pixel_index == 4098 || pixel_index == 4107) oled_data = 16'b0011000110000101;
           else if (pixel_index == 911 || pixel_index == 1393 || pixel_index == 2357 || pixel_index == 2544 || pixel_index == 2703 || pixel_index == 2737 || pixel_index == 2764 || ((pixel_index >= 3093) && (pixel_index <= 3094)) || pixel_index == 3102 || pixel_index == 3131 || pixel_index == 3196 || pixel_index == 3293 || pixel_index == 3315 || pixel_index == 3371 || pixel_index == 3373 || pixel_index == 3377 || pixel_index == 3381 || pixel_index == 3494 || ((pixel_index >= 3527) && (pixel_index <= 3528)) || pixel_index == 3570 || pixel_index == 3700 || pixel_index == 4537 || pixel_index == 4539 || pixel_index == 4543 || pixel_index == 4552 || pixel_index == 4562 || pixel_index == 4571 || pixel_index == 4583 || pixel_index == 4636 || pixel_index == 4639 || pixel_index == 4659 || pixel_index == 4674 || pixel_index == 4678 || pixel_index == 4747 || pixel_index == 4751 || pixel_index == 4828 || pixel_index == 4847 || pixel_index == 4850 || pixel_index == 4870 || pixel_index == 4915 || ((pixel_index >= 4939) && (pixel_index <= 4940)) || pixel_index == 4942 || pixel_index == 4962 || pixel_index == 4964 || pixel_index == 4969 || pixel_index == 4971 || pixel_index == 4973) oled_data = 16'b0001100011000011;
           else if (pixel_index == 914) oled_data = 16'b1100111001101011;
           else if (pixel_index == 915) oled_data = 16'b1111011101101000;
           else if (pixel_index == 916) oled_data = 16'b1111011101100011;
           else if (pixel_index == 917) oled_data = 16'b1110111100101011;
           else if (pixel_index == 918 || pixel_index == 1974 || pixel_index == 2166) oled_data = 16'b0010100101000100;
           else if (pixel_index == 1006 || pixel_index == 1008 || pixel_index == 1103 || pixel_index == 1105 || pixel_index == 1781 || pixel_index == 1961 || pixel_index == 2798 || pixel_index == 2956 || pixel_index == 2990 || pixel_index == 3052 || pixel_index == 3095 || pixel_index == 3098 || pixel_index == 3108 || pixel_index == 3113 || pixel_index == 3116 || ((pixel_index >= 3143) && (pixel_index <= 3144)) || pixel_index == 3185 || pixel_index == 3278 || pixel_index == 3325 || pixel_index == 3340 || pixel_index == 3374 || ((pixel_index >= 3419) && (pixel_index <= 3420)) || pixel_index == 3470 || pixel_index == 3532 || pixel_index == 3607 || pixel_index == 3609 || pixel_index == 3758 || pixel_index == 4012 || pixel_index == 4588 || pixel_index == 4649 || pixel_index == 4677 || pixel_index == 4826 || pixel_index == 4829 || pixel_index == 4833 || pixel_index == 4944 || pixel_index == 5040) oled_data = 16'b0100101001001001;
           else if (pixel_index == 1007 || pixel_index == 1106 || pixel_index == 1684 || pixel_index == 2250 || pixel_index == 2894 || pixel_index == 3086 || pixel_index == 3092 || pixel_index == 3148 || pixel_index == 3182 || pixel_index == 3236 || pixel_index == 3244 || pixel_index == 3248 || pixel_index == 3428 || pixel_index == 3436 || pixel_index == 3566 || ((pixel_index >= 3582) && (pixel_index <= 3583)) || ((pixel_index >= 3611) && (pixel_index <= 3612)) || pixel_index == 3628 || pixel_index == 3662 || pixel_index == 3687 || pixel_index == 3724 || pixel_index == 3730 || pixel_index == 3854 || pixel_index == 3916 || pixel_index == 3950 || pixel_index == 4046 || pixel_index == 4472 || pixel_index == 4535 || pixel_index == 4538 || pixel_index == 4542 || pixel_index == 4546 || pixel_index == 4553 || pixel_index == 4569 || pixel_index == 4584 || pixel_index == 4673 || pixel_index == 4733 || pixel_index == 4744 || pixel_index == 4778 || pixel_index == 4835) oled_data = 16'b0101001010001010;
           else if (pixel_index == 1009) oled_data = 16'b0101001010001011;
           else if (pixel_index == 1010 || pixel_index == 1199) oled_data = 16'b0010000100000101;
           else if (pixel_index == 1011) oled_data = 16'b0111001101000111;
           else if (pixel_index == 1012) oled_data = 16'b1001110011101010;
           else if (pixel_index == 1013 || pixel_index == 1587 || pixel_index == 1674 || pixel_index == 1878 || pixel_index == 2546 || pixel_index == 3103 || pixel_index == 3125 || pixel_index == 3128 || pixel_index == 3132 || pixel_index == 3190 || pixel_index == 3202 || pixel_index == 3298 || pixel_index == 3317 || pixel_index == 3322 || pixel_index == 3329 || pixel_index == 3384 || pixel_index == 3480 || pixel_index == 3576 || pixel_index == 3618 || pixel_index == 3717 || pixel_index == 4049 || pixel_index == 4051 || pixel_index == 4054 || pixel_index == 4057 || pixel_index == 4059 || pixel_index == 4062 || pixel_index == 4064 || pixel_index == 4067 || pixel_index == 4070 || pixel_index == 4072 || pixel_index == 4074 || pixel_index == 4076 || pixel_index == 4078 || pixel_index == 4080 || pixel_index == 4082 || pixel_index == 4085 || pixel_index == 4087 || pixel_index == 4089 || pixel_index == 4091 || pixel_index == 4529 || pixel_index == 4556 || pixel_index == 4560 || pixel_index == 4585 || pixel_index == 4632 || pixel_index == 4671 || pixel_index == 4682 || pixel_index == 4874 || pixel_index == 4923) oled_data = 16'b0010100101000101;
           else if (pixel_index == 1101 || pixel_index == 1579 || pixel_index == 2895 || pixel_index == 3087 || pixel_index == 3107 || pixel_index == 3109 || pixel_index == 3145 || pixel_index == 3149 || pixel_index == 3153 || pixel_index == 3237 || pixel_index == 3274 || pixel_index == 3307 || pixel_index == 3391 || pixel_index == 3403 || pixel_index == 3415 || pixel_index == 3429 || pixel_index == 3433 || pixel_index == 3437 || pixel_index == 3520 || pixel_index == 3525 || pixel_index == 3535 || pixel_index == 3567 || pixel_index == 3629 || pixel_index == 3855 || pixel_index == 3951 || pixel_index == 4531 || pixel_index == 4545 || pixel_index == 4558 || pixel_index == 4581 || pixel_index == 4642 || pixel_index == 4724 || pixel_index == 4827 || pixel_index == 4843 || pixel_index == 4922 || pixel_index == 4926 || pixel_index == 4929 || pixel_index == 4953 || pixel_index == 4961 || pixel_index == 4968 || pixel_index == 5009) oled_data = 16'b0011100111000111;
           else if (pixel_index == 1102 || pixel_index == 1294 || pixel_index == 1388 || pixel_index == 1877 || pixel_index == 2153 || pixel_index == 2165 || pixel_index == 2346 || ((pixel_index >= 3126) && (pixel_index <= 3127)) || pixel_index == 3220 || pixel_index == 3296 || pixel_index == 3390 || pixel_index == 3524 || pixel_index == 3617 || pixel_index == 3658 || pixel_index == 3665 || pixel_index == 3715 || pixel_index == 4143 || pixel_index == 4145 || ((pixel_index >= 4147) && (pixel_index <= 4148)) || ((pixel_index >= 4150) && (pixel_index <= 4151)) || pixel_index == 4153 || ((pixel_index >= 4155) && (pixel_index <= 4156)) || pixel_index == 4158 || ((pixel_index >= 4160) && (pixel_index <= 4161)) || ((pixel_index >= 4163) && (pixel_index <= 4164)) || pixel_index == 4166 || pixel_index == 4168 || pixel_index == 4170 || pixel_index == 4172 || pixel_index == 4174 || pixel_index == 4176 || ((pixel_index >= 4178) && (pixel_index <= 4179)) || pixel_index == 4181 || pixel_index == 4183 || pixel_index == 4185 || pixel_index == 4187 || pixel_index == 4195 || pixel_index == 4198 || pixel_index == 4200 || pixel_index == 4626 || pixel_index == 4634 || pixel_index == 4665 || pixel_index == 4667 || pixel_index == 4730 || pixel_index == 4745 || pixel_index == 4818 || pixel_index == 4865 || pixel_index == 4872) oled_data = 16'b0101101011001011;
           else if (pixel_index == 1104 || pixel_index == 3821) oled_data = 16'b0100001000000111;
           else if (pixel_index == 1107 || pixel_index == 1198 || pixel_index == 1392 || pixel_index == 3091 || pixel_index == 3187 || pixel_index == 3224 || pixel_index == 3241 || ((pixel_index >= 3343) && (pixel_index <= 3344)) || pixel_index == 3398 || pixel_index == 3562 || pixel_index == 4047 || pixel_index == 4144 || pixel_index == 4146 || pixel_index == 4149 || pixel_index == 4152 || pixel_index == 4154 || pixel_index == 4157 || pixel_index == 4159 || pixel_index == 4162 || pixel_index == 4165 || pixel_index == 4167 || pixel_index == 4169 || pixel_index == 4171 || pixel_index == 4173 || pixel_index == 4175 || pixel_index == 4177 || pixel_index == 4180 || pixel_index == 4182 || pixel_index == 4184 || pixel_index == 4186 || pixel_index == 4204 || pixel_index == 4684 || pixel_index == 4737 || pixel_index == 4752 || pixel_index == 4754 || pixel_index == 4760 || pixel_index == 4763 || pixel_index == 4841 || pixel_index == 4858) oled_data = 16'b0110001100001100;
           else if (pixel_index == 1108 || pixel_index == 4680) oled_data = 16'b0100001000001001;
           else if (pixel_index == 1197 || pixel_index == 2443 || pixel_index == 2451 || ((pixel_index >= 2800) && (pixel_index <= 2859)) || ((pixel_index >= 3222) && (pixel_index <= 3223)) || pixel_index == 3330 || pixel_index == 3389 || pixel_index == 3523 || pixel_index == 3676 || pixel_index == 3711 || pixel_index == 4631 || pixel_index == 4653 || pixel_index == 4670 || pixel_index == 4731 || pixel_index == 4766 || pixel_index == 4831 || pixel_index == 4857 || pixel_index == 4862) oled_data = 16'b0110101101001101;
           else if (pixel_index == 1201 || pixel_index == 1204 || pixel_index == 1483 || pixel_index == 2702 || pixel_index == 2765 || pixel_index == 3106 || pixel_index == 3111 || pixel_index == 3200 || pixel_index == 3207 || pixel_index == 3229 || pixel_index == 3303 || pixel_index == 3342 || pixel_index == 3345 || pixel_index == 3370 || ((pixel_index >= 3440) && (pixel_index <= 3441)) || pixel_index == 3478 || pixel_index == 3482 || pixel_index == 3529 || pixel_index == 3574 || pixel_index == 3591 || pixel_index == 3603 || pixel_index == 3674 || pixel_index == 3753 || pixel_index == 3762 || pixel_index == 3783 || pixel_index == 3799 || pixel_index == 4484 || pixel_index == 4536 || pixel_index == 4559 || pixel_index == 4582 || pixel_index == 4657 || pixel_index == 4686 || pixel_index == 4732 || pixel_index == 4736 || pixel_index == 4782 || pixel_index == 4845 || pixel_index == 4867 || pixel_index == 4918 || pixel_index == 4924 || pixel_index == 4928 || pixel_index == 4943 || pixel_index == 4951 || pixel_index == 4967 || pixel_index == 5039) oled_data = 16'b0000100001000001;
           else if (pixel_index == 1203 || pixel_index == 1293 || pixel_index == 2057 || pixel_index == 2249 || pixel_index == 2261 || pixel_index == 2452 || pixel_index == 2542 || pixel_index == 2957 || pixel_index == 2991 || pixel_index == 3053 || ((pixel_index >= 3096) && (pixel_index <= 3097)) || pixel_index == 3099 || pixel_index == 3112 || ((pixel_index >= 3114) && (pixel_index <= 3115)) || pixel_index == 3142 || pixel_index == 3183 || pixel_index == 3189 || pixel_index == 3213 || pixel_index == 3245 || pixel_index == 3279 || pixel_index == 3333 || pixel_index == 3341 || pixel_index == 3375 || pixel_index == 3411 || pixel_index == 3467 || pixel_index == 3471 || pixel_index == 3499 || pixel_index == 3533 || pixel_index == 3580 || pixel_index == 3595 || pixel_index == 3621 || pixel_index == 3663 || pixel_index == 3669 || pixel_index == 3677 || pixel_index == 3716 || pixel_index == 3725 || pixel_index == 3759 || pixel_index == 4013 || pixel_index == 4109 || pixel_index == 4530 || pixel_index == 4557 || pixel_index == 4567 || pixel_index == 4577 || pixel_index == 4638 || pixel_index == 4663 || pixel_index == 4675 || pixel_index == 4735 || pixel_index == 4759 || ((pixel_index >= 4764) && (pixel_index <= 4765)) || pixel_index == 4855 || pixel_index == 4859 || pixel_index == 4914) oled_data = 16'b0100001000001000;
           else if (pixel_index == 1295 || pixel_index == 4579) oled_data = 16'b0011100111000110;
           else if (pixel_index == 1389 || pixel_index == 1580 || pixel_index == 2251 || pixel_index == 3211 || pixel_index == 3231 || pixel_index == 3282 || ((pixel_index >= 3431) && (pixel_index <= 3432)) || pixel_index == 3439 || pixel_index == 3476 || pixel_index == 3681 || pixel_index == 3683 || pixel_index == 3719 || pixel_index == 4576 || pixel_index == 4627 || pixel_index == 4685 || pixel_index == 4775 || pixel_index == 4856 || pixel_index == 4861) oled_data = 16'b1001110011110011;
           else if (pixel_index == 1390 || pixel_index == 1582 || pixel_index == 1876 || pixel_index == 2260 || ((pixel_index >= 3249) && (pixel_index <= 3250)) || pixel_index == 3327 || pixel_index == 3380 || pixel_index == 3424 || pixel_index == 3468 || pixel_index == 3519 || pixel_index == 3536 || pixel_index == 3585 || pixel_index == 3615 || pixel_index == 3634 || pixel_index == 4568 || pixel_index == 4658 || pixel_index == 4750 || pixel_index == 4753 || pixel_index == 4834 || pixel_index == 4846 || pixel_index == 4871) oled_data = 16'b1000010000010000;
           else if (pixel_index == 1391) oled_data = 16'b1010110101110110;
           else if (pixel_index == 1484 || pixel_index == 1488 || pixel_index == 2356 || pixel_index == 2799 || pixel_index == 3177 || pixel_index == 3275 || ((pixel_index >= 3426) && (pixel_index <= 3427)) || pixel_index == 3486 || pixel_index == 3605 || pixel_index == 3710 || pixel_index == 4630 || pixel_index == 4633 || pixel_index == 4635 || pixel_index == 4679 || pixel_index == 4734 || pixel_index == 4748 || pixel_index == 4768 || pixel_index == 4772 || pixel_index == 4779 || pixel_index == 4844 || pixel_index == 4864 || pixel_index == 4875 || pixel_index == 4877) oled_data = 16'b1000110001010001;
           else if (pixel_index == 1485 || ((pixel_index >= 1676) && (pixel_index <= 1677)) || pixel_index == 1972 || pixel_index == 2347 || pixel_index == 3228 || pixel_index == 3232 || pixel_index == 3328 || pixel_index == 3514 || pixel_index == 3573 || pixel_index == 3577) oled_data = 16'b1100111001111001;
           else if (pixel_index == 1486 || pixel_index == 1586 || pixel_index == 3208 || pixel_index == 3273 || pixel_index == 3346 || pixel_index == 3369 || pixel_index == 3442 || pixel_index == 3492 || pixel_index == 3538 || pixel_index == 3563 || pixel_index == 3589 || pixel_index == 3614 || pixel_index == 3705 || pixel_index == 4108 || pixel_index == 4723 || pixel_index == 4725 || pixel_index == 4777 || pixel_index == 4821 || pixel_index == 4830 || pixel_index == 4945) oled_data = 16'b0111001110001110;
           else if (pixel_index == 1487) oled_data = 16'b1111011110111101;
           else if (pixel_index == 1489) oled_data = 16'b0011000110000111;
           else if (pixel_index == 1581 || pixel_index == 1770 || pixel_index == 2164 || pixel_index == 3154 || pixel_index == 3188 || pixel_index == 3191 || ((pixel_index >= 3194) && (pixel_index <= 3195)) || pixel_index == 3204 || pixel_index == 3209 || pixel_index == 3212 || pixel_index == 3240 || pixel_index == 3281 || pixel_index == 3396 || pixel_index == 3418 || pixel_index == 3423 || pixel_index == 3465 || pixel_index == 3487 || pixel_index == 3561 || pixel_index == 3704 || pixel_index == 4629 || pixel_index == 4666) oled_data = 16'b0111101111001111;
           else if (pixel_index == 1583) oled_data = 16'b1111011110111111;
           else if (pixel_index == 1584 || pixel_index == 1866 || pixel_index == 1962 || pixel_index == 2058 || pixel_index == 2354 || pixel_index == 3306 || pixel_index == 3402 || pixel_index == 3477 || pixel_index == 3485 || pixel_index == 3498 || pixel_index == 3526 || pixel_index == 3590 || pixel_index == 3594 || pixel_index == 3604 || pixel_index == 3622 || pixel_index == 3718 || pixel_index == 4729) oled_data = 16'b1011110111110111;
           else if (pixel_index == 1585) oled_data = 16'b1000110001010000;
           else if (pixel_index == 1675 || pixel_index == 2860 || pixel_index == 3178 || pixel_index == 3192 || pixel_index == 3198 || pixel_index == 3372 || pixel_index == 3633 || pixel_index == 3657 || pixel_index == 3673 || pixel_index == 3686 || pixel_index == 3690 || pixel_index == 4656 || pixel_index == 4681 || pixel_index == 4721 || pixel_index == 4738 || pixel_index == 4762 || pixel_index == 4781 || pixel_index == 4819 || pixel_index == 4825 || pixel_index == 4840 || pixel_index == 4868 || pixel_index == 4873 || pixel_index == 4913) oled_data = 16'b1001010010110010;
           else if (pixel_index == 1678 || pixel_index == 1780 || pixel_index == 2069 || pixel_index == 2445 || pixel_index == 3302 || pixel_index == 3316 || pixel_index == 3395 || pixel_index == 3491 || pixel_index == 3493 || pixel_index == 3508) oled_data = 16'b1101011010111010;
           else if (pixel_index == 1679 || ((pixel_index >= 1772) && (pixel_index <= 1779)) || ((pixel_index >= 1867) && (pixel_index <= 1875)) || ((pixel_index >= 1963) && (pixel_index <= 1971)) || ((pixel_index >= 2059) && (pixel_index <= 2067)) || ((pixel_index >= 2156) && (pixel_index <= 2163)) || ((pixel_index >= 2252) && (pixel_index <= 2259)) || (pixel_index >= 2348) && (pixel_index <= 2353)) oled_data = 16'b1111111111111111;
           else if (pixel_index == 1680) oled_data = 16'b1111111111111110;
           else if (pixel_index == 1681) oled_data = 16'b1101011010111011;
           else if (pixel_index == 1682 || pixel_index == 3235) oled_data = 16'b1111011110111110;
           else if (pixel_index == 1683) oled_data = 16'b1101011010111001;
           else if (pixel_index == 1685 || pixel_index == 3623) oled_data = 16'b0000100001000010;
           else if (pixel_index == 1769 || pixel_index == 2262 || pixel_index == 2442 || pixel_index == 3082 || pixel_index == 3100 || pixel_index == 3140 || pixel_index == 3179 || pixel_index == 3414 || pixel_index == 3469 || pixel_index == 3518 || pixel_index == 3606 || pixel_index == 3625 || pixel_index == 3722 || pixel_index == 3763 || pixel_index == 3798 || pixel_index == 4547 || pixel_index == 4563 || pixel_index == 4570 || ((pixel_index >= 4572) && (pixel_index <= 4573)) || pixel_index == 4643 || pixel_index == 4651 || pixel_index == 4771 || pixel_index == 4774 || pixel_index == 4820 || pixel_index == 4824 || pixel_index == 4848 || pixel_index == 4917 || pixel_index == 4921 || pixel_index == 4936 || pixel_index == 4958 || pixel_index == 4960 || pixel_index == 4966 || pixel_index == 5041) oled_data = 16'b0001000010000010;
           else if (pixel_index == 1771 || ((pixel_index >= 2446) && (pixel_index <= 2449)) || pixel_index == 3193 || pixel_index == 3430 || pixel_index == 3488 || pixel_index == 3517) oled_data = 16'b1110011100111100;
           else if (pixel_index == 1865 || pixel_index == 2861 || pixel_index == 3081 || pixel_index == 3090 || pixel_index == 3475 || pixel_index == 3507 || pixel_index == 3510 || pixel_index == 3572 || pixel_index == 3632 || pixel_index == 3691 || pixel_index == 3706 || pixel_index == 3709 || pixel_index == 4048 || pixel_index == 4050 || ((pixel_index >= 4052) && (pixel_index <= 4053)) || ((pixel_index >= 4055) && (pixel_index <= 4056)) || pixel_index == 4058 || ((pixel_index >= 4060) && (pixel_index <= 4061)) || pixel_index == 4063 || ((pixel_index >= 4065) && (pixel_index <= 4066)) || ((pixel_index >= 4068) && (pixel_index <= 4069)) || pixel_index == 4071 || pixel_index == 4073 || pixel_index == 4075 || pixel_index == 4077 || pixel_index == 4079 || pixel_index == 4081 || ((pixel_index >= 4083) && (pixel_index <= 4084)) || pixel_index == 4086 || pixel_index == 4088 || pixel_index == 4090 || pixel_index == 4092 || pixel_index == 4100 || pixel_index == 4103 || pixel_index == 4105 || pixel_index == 4471 || pixel_index == 4534 || pixel_index == 4541 || pixel_index == 4554 || pixel_index == 4589 || pixel_index == 4640 || pixel_index == 4726 || pixel_index == 4728 || pixel_index == 4739 || pixel_index == 4822 || pixel_index == 4925 || pixel_index == 4930 || pixel_index == 4937) oled_data = 16'b0011000110000110;
           else if (pixel_index == 1973 || pixel_index == 2444 || pixel_index == 3186 || pixel_index == 3324 || pixel_index == 3392 || pixel_index == 3397 || pixel_index == 3512 || ((pixel_index >= 3702) && (pixel_index <= 3703)) || pixel_index == 4672 || pixel_index == 4676 || pixel_index == 4683) oled_data = 16'b1011010110110110;
           else if (pixel_index == 2068 || pixel_index == 2155) oled_data = 16'b1110111101111101;
           else if (pixel_index == 2070) oled_data = 16'b0001100011000100;
           else if (pixel_index == 2154 || pixel_index == 2450 || pixel_index == 3206 || pixel_index == 3294 || pixel_index == 3323 || pixel_index == 3421 || pixel_index == 3511 || pixel_index == 3584 || pixel_index == 3610 || pixel_index == 3667 || pixel_index == 3701 || pixel_index == 3720 || pixel_index == 4625 || pixel_index == 4641 || pixel_index == 4650 || pixel_index == 4652 || pixel_index == 4654 || pixel_index == 4664 || pixel_index == 4746 || pixel_index == 4817 || pixel_index == 4842) oled_data = 16'b1010010100110100;
           else if (pixel_index == 2355 || pixel_index == 3205 || pixel_index == 3227 || pixel_index == 3295 || pixel_index == 3334 || pixel_index == 3378 || pixel_index == 3581 || pixel_index == 3608 || pixel_index == 3613 || pixel_index == 3666 || pixel_index == 3668 || pixel_index == 4637) oled_data = 16'b1010110101110101;
           else if (pixel_index == 3135 || pixel_index == 3616) oled_data = 16'b0010000101000101;
           else if (pixel_index == 3136) oled_data = 16'b0010100100000100;
           else if (pixel_index == 3139) oled_data = 16'b0011000111000111;
           else if (pixel_index == 3141) oled_data = 16'b0001000001000001;
           else if (pixel_index == 3199 || pixel_index == 3203 || pixel_index == 3210 || pixel_index == 3521) oled_data = 16'b1101111011111011;
           else if (pixel_index == 3221 || pixel_index == 3289 || pixel_index == 3299 || pixel_index == 3331 || pixel_index == 3379 || pixel_index == 3385 || pixel_index == 3412 || pixel_index == 3481 || pixel_index == 3587 || pixel_index == 4849) oled_data = 16'b1100011000111000;
           else if (pixel_index == 3238) oled_data = 16'b1101011011111011;
           else if (pixel_index == 3239) oled_data = 16'b0111101111001110;
           else if (pixel_index == 3332) oled_data = 16'b0101001001001001;
           else if (pixel_index == 3425) oled_data = 16'b1000110000010000;
           else if (pixel_index == 3515 || pixel_index == 3522) oled_data = 16'b0111110000010000;
           else if (pixel_index == 3516) oled_data = 16'b1000001111001111;
           else if (pixel_index == 3619) oled_data = 16'b0111101110001110;
           else if (pixel_index == 3620) oled_data = 16'b0101001011001011;
           else if (pixel_index == 3624) oled_data = 16'b0001000010000001;
           else if (pixel_index == 3721 || pixel_index == 4580) oled_data = 16'b1001010010110011;
           else if (pixel_index == 3816 || pixel_index == 4480 || pixel_index == 4876) oled_data = 16'b0000100000000000;
           else if (pixel_index == 3817) oled_data = 16'b0000000001000000;
           else if (pixel_index == 3820) oled_data = 16'b0100101001001010;
           else if (pixel_index == 3917 || pixel_index == 4965) oled_data = 16'b0011100111001000;
           else if (pixel_index == 4093 || pixel_index == 4095 || pixel_index == 4099 || pixel_index == 4102 || pixel_index == 4106) oled_data = 16'b0011000101000110;
           else if (pixel_index == 4094 || pixel_index == 4101) oled_data = 16'b0010100110000101;
           else if (pixel_index == 4097 || pixel_index == 4587) oled_data = 16'b0010100101000110;
           else if (pixel_index == 4104) oled_data = 16'b0010100110000110;
           else if (pixel_index == 4188 || pixel_index == 4190 || pixel_index == 4194 || pixel_index == 4197 || pixel_index == 4202) oled_data = 16'b0101101100001011;
           else if (pixel_index == 4189 || pixel_index == 4196) oled_data = 16'b0110001011001100;
           else if (pixel_index == 4191 || pixel_index == 4193 || pixel_index == 4203) oled_data = 16'b0101101011001100;
           else if (pixel_index == 4192 || pixel_index == 4199) oled_data = 16'b0110001100001011;
           else if (pixel_index == 4201) oled_data = 16'b0110001011001011;
           else if (pixel_index == 4205) oled_data = 16'b0001100011000010;
           else if (pixel_index == 4574) oled_data = 16'b0010000011000100;
           else if (pixel_index == 4575) oled_data = 16'b0010000101000100;
           else if (pixel_index == 4578) oled_data = 16'b0001000010000011;
           else if (pixel_index == 4668) oled_data = 16'b0101001001001010;
           else if (pixel_index == 4669) oled_data = 16'b0011101000000111;
           else if (pixel_index == 4860) oled_data = 16'b1001010011110010;
           else if (pixel_index == 4869) oled_data = 16'b0101001010001001;
           else if (pixel_index == 4878) oled_data = 16'b0000100010000001;
           else if (pixel_index == 4956) oled_data = 16'b0011100110000111;
           else oled_data = 0;
       end
   end 
endmodule
