`timescale 1ns / 1ps

module test_state_display(
    input clk, 
    input [15:0] pixel_index, 
    input [2:0] state,
    output reg [15:0] oled_data
    );
    wire [6:0] x = pixel_index % 96; // 0 to 95
    wire [5:0] y = pixel_index / 96; // 0 to 63
    
    always @ (posedge clk)
       begin
       case(state)
            3'b000: begin
            if (pixel_index == 1772 || pixel_index == 2153 || ((pixel_index >= 3398) && (pixel_index <= 3401)) || ((pixel_index >= 3406) && (pixel_index <= 3409)) || pixel_index == 3698) oled_data = 16'b0000100001000001;
            else if (pixel_index == 1773 || pixel_index == 1958 || pixel_index == 2250 || pixel_index == 2346 || pixel_index == 2442 || pixel_index == 2538 || pixel_index == 2634 || pixel_index == 2730 || pixel_index == 2922 || pixel_index == 3018 || pixel_index == 3114 || pixel_index == 3402) oled_data = 16'b0001100011000011;
            else if (pixel_index == 1865 || pixel_index == 2053 || pixel_index == 2149 || pixel_index == 2154 || pixel_index == 2826 || pixel_index == 3210 || pixel_index == 3306 || pixel_index == 3493 || pixel_index == 3589 || (pixel_index >= 3686) && (pixel_index <= 3697)) oled_data = 16'b0001000010000010;
            else if (pixel_index == 1866) oled_data = 16'b0100001000001000;
            else if (pixel_index == 1867) oled_data = 16'b1001010010110010;
            else if (pixel_index == 1868 || pixel_index == 3496 || pixel_index == 3502 || pixel_index == 3590) oled_data = 16'b1101011010111010;
            else if (pixel_index == 1869 || pixel_index == 2061 || pixel_index == 2253 || pixel_index == 2445 || pixel_index == 2541 || pixel_index == 2733 || pixel_index == 2829 || pixel_index == 3021 || pixel_index == 3213 || pixel_index == 3309) oled_data = 16'b0111101111001111;
            else if (pixel_index == 1959) oled_data = 16'b0101001010001010;
            else if (pixel_index == 1960) oled_data = 16'b1010010100110100;
            else if (pixel_index == 1961 || pixel_index == 2155 || pixel_index == 2347 || pixel_index == 2539 || pixel_index == 2635 || pixel_index == 2923 || pixel_index == 3019 || pixel_index == 3593 || ((pixel_index >= 3595) && (pixel_index <= 3597)) || (pixel_index >= 3599) && (pixel_index <= 3600)) oled_data = 16'b1110011100111100;
            else if (((pixel_index >= 1962) && (pixel_index <= 1964)) || ((pixel_index >= 2055) && (pixel_index <= 2056)) || pixel_index == 2060 || pixel_index == 2156 || pixel_index == 2252 || pixel_index == 2348 || pixel_index == 2444 || pixel_index == 2540 || pixel_index == 2636 || pixel_index == 2732 || pixel_index == 2828 || pixel_index == 2924 || pixel_index == 3020 || pixel_index == 3116 || pixel_index == 3212 || pixel_index == 3308 || pixel_index == 3404 || (pixel_index >= 3499) && (pixel_index <= 3500)) oled_data = 16'b1111111111111111;
            else if (pixel_index == 1965 || pixel_index == 2157 || pixel_index == 2349 || pixel_index == 2637 || pixel_index == 2925 || pixel_index == 3117 || pixel_index == 3405) oled_data = 16'b1000010000010000;
            else if (pixel_index == 2054 || pixel_index == 2057 || pixel_index == 3495 || ((pixel_index >= 3497) && (pixel_index <= 3498)) || (pixel_index >= 3503) && (pixel_index <= 3505)) oled_data = 16'b1101111011111011;
            else if (pixel_index == 2058) oled_data = 16'b1011010110110110;
            else if (pixel_index == 2059) oled_data = 16'b1111011110111110;
            else if (pixel_index == 2150) oled_data = 16'b1000110001010001;
            else if (pixel_index == 2151) oled_data = 16'b0101101011001011;
            else if (pixel_index == 2152) oled_data = 16'b0010100101000101;
            else if (pixel_index == 2251 || pixel_index == 2443 || pixel_index == 2731 || pixel_index == 2827 || pixel_index == 3115 || pixel_index == 3211 || pixel_index == 3307 || pixel_index == 3403 || pixel_index == 3501 || ((pixel_index >= 3591) && (pixel_index <= 3592)) || pixel_index == 3594 || pixel_index == 3598 || pixel_index == 3601) oled_data = 16'b1110111101111101;
            else if (pixel_index == 3494) oled_data = 16'b1100011000111000;
            else if (pixel_index == 3506) oled_data = 16'b0110101101001101;
            else if (pixel_index == 3602) oled_data = 16'b0111001110001110;
            else oled_data = 0;

            end
            3'b001: begin
            if (pixel_index == 2343 || pixel_index == 2639) oled_data = 16'b0001100011000011;
            else if (pixel_index == 2344 || pixel_index == 2924 || pixel_index == 4068) oled_data = 16'b0011100111000111;
            else if (pixel_index == 2345) oled_data = 16'b0100101001001001;
            else if (pixel_index == 2346 || pixel_index == 2445 || pixel_index == 3023) oled_data = 16'b0100001000001000;
            else if (pixel_index == 2347 || pixel_index == 3880) oled_data = 16'b0010100101000101;
            else if (pixel_index == 2437 || pixel_index == 3499 || pixel_index == 3591 || pixel_index == 3594 || ((pixel_index >= 3976) && (pixel_index <= 3982)) || pixel_index == 4175) oled_data = 16'b0101001010001010;
            else if (pixel_index == 2438 || pixel_index == 2444) oled_data = 16'b1011110111110111;
            else if (pixel_index == 2439 || pixel_index == 3498 || pixel_index == 3687 || pixel_index == 3973) oled_data = 16'b1110111101111101;
            else if (((pixel_index >= 2440) && (pixel_index <= 2442)) || pixel_index == 2534 || pixel_index == 2540 || pixel_index == 2637 || ((pixel_index >= 2733) && (pixel_index <= 2734)) || ((pixel_index >= 2829) && (pixel_index <= 2830)) || ((pixel_index >= 2925) && (pixel_index <= 2926)) || ((pixel_index >= 3021) && (pixel_index <= 3022)) || pixel_index == 3117 || pixel_index == 3212 || pixel_index == 3307 || pixel_index == 3402 || pixel_index == 3497 || pixel_index == 3688 || pixel_index == 3783 || pixel_index == 3878 || pixel_index == 3974 || (pixel_index >= 4069) && (pixel_index <= 4078)) oled_data = 16'b1111111111111111;
            else if (pixel_index == 2443 || pixel_index == 2539 || pixel_index == 2541 || pixel_index == 3213 || pixel_index == 3308 || pixel_index == 3403 || ((pixel_index >= 3592) && (pixel_index <= 3593)) || pixel_index == 3879) oled_data = 16'b1111011110111110;
            else if (pixel_index == 2533 || pixel_index == 3118 || (pixel_index >= 4165) && (pixel_index <= 4174)) oled_data = 16'b1100011000111000;
            else if (pixel_index == 2535 || pixel_index == 2636 || pixel_index == 2638) oled_data = 16'b1110011100111100;
            else if (pixel_index == 2536 || pixel_index == 2538) oled_data = 16'b1010110101110101;
            else if (pixel_index == 2537) oled_data = 16'b1001110011110011;
            else if (pixel_index == 2542 || pixel_index == 2630 || pixel_index == 2735 || pixel_index == 3309 || pixel_index == 3404) oled_data = 16'b0101101011001011;
            else if (pixel_index == 2629 || pixel_index == 3877) oled_data = 16'b1000010000010000;
            else if (pixel_index == 2631 || pixel_index == 3781) oled_data = 16'b0001000010000010;
            else if (pixel_index == 2635 || pixel_index == 2828 || pixel_index == 3214 || pixel_index == 3686 || pixel_index == 4164) oled_data = 16'b0011000110000110;
            else if (pixel_index == 2732 || pixel_index == 3020 || pixel_index == 3496 || pixel_index == 3689 || pixel_index == 4079) oled_data = 16'b0110101101001101;
            else if (pixel_index == 2831) oled_data = 16'b0111101111001111;
            else if (pixel_index == 2927 || pixel_index == 3306 || pixel_index == 3401) oled_data = 16'b0111001110001110;
            else if (pixel_index == 3115 || pixel_index == 3119) oled_data = 16'b0000100001000001;
            else if (pixel_index == 3116) oled_data = 16'b1101011010111010;
            else if (pixel_index == 3211) oled_data = 16'b1000110001010001;
            else if (pixel_index == 3782) oled_data = 16'b1100111001111001;
            else if (pixel_index == 3784) oled_data = 16'b1011010110110110;
            else if (pixel_index == 3972 || pixel_index == 3983) oled_data = 16'b0010000100000100;
            else if (pixel_index == 3975) oled_data = 16'b1101111011111011;
            else oled_data = 0;

            end
            3'b010: begin
            if (pixel_index == 2149 || pixel_index == 2154 || pixel_index == 2924 || pixel_index == 3306 || pixel_index == 3598 || pixel_index == 3971 || pixel_index == 4073) oled_data = 16'b0010000100000100;
            else if (pixel_index == 2150 || pixel_index == 4071) oled_data = 16'b0100001000001000;
            else if (pixel_index == 2151 || pixel_index == 3979) oled_data = 16'b0101101011001011;
            else if (pixel_index == 2152 || pixel_index == 2445 || pixel_index == 3789) oled_data = 16'b0110001100001100;
            else if (pixel_index == 2153 || pixel_index == 2733 || pixel_index == 2920) oled_data = 16'b0101001010001010;
            else if (pixel_index == 2243 || pixel_index == 2339 || pixel_index == 2435 || pixel_index == 2634 || pixel_index == 2829 || pixel_index == 3208 || pixel_index == 3694 || pixel_index == 3885 || pixel_index == 4068) oled_data = 16'b0000100001000001;
            else if (pixel_index == 2244 || pixel_index == 2251 || pixel_index == 2342 || pixel_index == 3111 || pixel_index == 3786) oled_data = 16'b1010110101110101;
            else if (pixel_index == 2245 || pixel_index == 2250 || pixel_index == 2731 || pixel_index == 3405 || pixel_index == 3501 || pixel_index == 3597 || pixel_index == 3973 || pixel_index == 3977) oled_data = 16'b1111011110111110;
            else if (((pixel_index >= 2246) && (pixel_index <= 2249)) || ((pixel_index >= 2346) && (pixel_index <= 2347)) || ((pixel_index >= 2443) && (pixel_index <= 2444)) || pixel_index == 2540 || pixel_index == 2636 || pixel_index == 2732 || pixel_index == 2827 || pixel_index == 2922 || ((pixel_index >= 3014) && (pixel_index <= 3017)) || ((pixel_index >= 3113) && (pixel_index <= 3114)) || pixel_index == 3211 || pixel_index == 3308 || pixel_index == 3404 || pixel_index == 3500 || pixel_index == 3596 || pixel_index == 3692 || ((pixel_index >= 3787) && (pixel_index <= 3788)) || pixel_index == 3876 || ((pixel_index >= 3882) && (pixel_index <= 3883)) || (pixel_index >= 3974) && (pixel_index <= 3976)) oled_data = 16'b1111111111111111;
            else if (pixel_index == 2252 || pixel_index == 3406 || pixel_index == 3779 || pixel_index == 3781 || pixel_index == 3785 || pixel_index == 4069) oled_data = 16'b0001100011000011;
            else if (((pixel_index >= 2340) && (pixel_index <= 2341)) || pixel_index == 3307 || pixel_index == 3881) oled_data = 16'b1110011100111100;
            else if (((pixel_index >= 2343) && (pixel_index <= 2344)) || pixel_index == 2442 || pixel_index == 3499) oled_data = 16'b1000010000010000;
            else if (pixel_index == 2345 || pixel_index == 2828 || pixel_index == 2923 || pixel_index == 3878) oled_data = 16'b1011110111110111;
            else if (pixel_index == 2348 || pixel_index == 3115 || pixel_index == 3210 || pixel_index == 3972) oled_data = 16'b1100111001111001;
            else if (pixel_index == 2349 || pixel_index == 2437 || pixel_index == 2538 || pixel_index == 2917 || pixel_index == 3019 || pixel_index == 3690) oled_data = 16'b0001000010000010;
            else if (pixel_index == 2436 || pixel_index == 3109 || pixel_index == 3780) oled_data = 16'b0100101001001001;
            else if (pixel_index == 2539 || pixel_index == 3212 || pixel_index == 3877) oled_data = 16'b1110111101111101;
            else if (pixel_index == 2541 || pixel_index == 2637) oled_data = 16'b1000110001010001;
            else if (pixel_index == 2635 || pixel_index == 3691) oled_data = 16'b1101111011111011;
            else if (pixel_index == 2730) oled_data = 16'b0010100101000101;
            else if (pixel_index == 2826 || pixel_index == 3110 || pixel_index == 3403 || pixel_index == 3879) oled_data = 16'b1010010100110100;
            else if (((pixel_index >= 2918) && (pixel_index <= 2919)) || pixel_index == 3502 || pixel_index == 4070) oled_data = 16'b0011000110000110;
            else if (pixel_index == 2921 || pixel_index == 3018 || pixel_index == 3309 || pixel_index == 3880) oled_data = 16'b1011010110110110;
            else if (pixel_index == 3013) oled_data = 16'b0111101111001111;
            else if (pixel_index == 3112 || pixel_index == 3693) oled_data = 16'b1101011010111010;
            else if (pixel_index == 3116 || pixel_index == 3209 || pixel_index == 3213 || pixel_index == 3875 || pixel_index == 4072) oled_data = 16'b0011100111000111;
            else if (pixel_index == 3595 || pixel_index == 3884) oled_data = 16'b1001010010110010;
            else if (pixel_index == 3978) oled_data = 16'b1100011000111000;
            else oled_data = 0;

            end
            3'b011: begin
            if (((pixel_index >= 2738) && (pixel_index <= 2740)) || pixel_index == 3895) oled_data = 16'b0000100001000001;
            else if (pixel_index == 2833 || pixel_index == 3119 || pixel_index == 3313 || pixel_index == 3405) oled_data = 16'b0001000010000010;
            else if (pixel_index == 2834 || pixel_index == 2932 || pixel_index == 3892) oled_data = 16'b1011110111110111;
            else if (pixel_index == 2835 || pixel_index == 3406 || pixel_index == 3598 || pixel_index == 3692) oled_data = 16'b1101111011111011;
            else if (pixel_index == 2836 || pixel_index == 3217 || pixel_index == 3314 || pixel_index == 3501 || pixel_index == 3698 || pixel_index == 3787 || pixel_index == 3789 || pixel_index == 4178) oled_data = 16'b1001110011110011;
            else if (pixel_index == 2929 || pixel_index == 3215) oled_data = 16'b1001010010110010;
            else if (((pixel_index >= 2930) && (pixel_index <= 2931)) || ((pixel_index >= 3026) && (pixel_index <= 3027)) || pixel_index == 3121 || pixel_index == 3123 || pixel_index == 3216 || pixel_index == 3219 || pixel_index == 3311 || pixel_index == 3315 || pixel_index == 3407 || pixel_index == 3411 || pixel_index == 3502 || pixel_index == 3507 || pixel_index == 3597 || pixel_index == 3603 || pixel_index == 3693 || pixel_index == 3699 || pixel_index == 3788 || pixel_index == 3795 || pixel_index == 3883 || pixel_index == 3891 || ((pixel_index >= 3979) && (pixel_index <= 3980)) || pixel_index == 3982 || ((pixel_index >= 3984) && (pixel_index <= 3990)) || pixel_index == 4083 || pixel_index == 4179 || pixel_index == 4275 || pixel_index == 4371) oled_data = 16'b1111111111111111;
            else if (pixel_index == 3024 || pixel_index == 3310 || pixel_index == 3596 || pixel_index == 3882) oled_data = 16'b0100101001001001;
            else if (pixel_index == 3025 || pixel_index == 3981 || pixel_index == 3983) oled_data = 16'b1111011110111110;
            else if (pixel_index == 3028 || pixel_index == 3124 || pixel_index == 3220 || pixel_index == 3316 || pixel_index == 3412 || pixel_index == 3508 || pixel_index == 3604 || pixel_index == 3700 || pixel_index == 3796 || pixel_index == 4180 || pixel_index == 4276 || pixel_index == 4372) oled_data = 16'b1011010110110110;
            else if (pixel_index == 3120) oled_data = 16'b1101011010111010;
            else if (pixel_index == 3122 || pixel_index == 3312 || pixel_index == 3884 || pixel_index == 4082) oled_data = 16'b1110011100111100;
            else if (pixel_index == 3218 || pixel_index == 3410 || pixel_index == 3503 || pixel_index == 3506 || pixel_index == 3602 || pixel_index == 3794 || pixel_index == 4274 || pixel_index == 4370) oled_data = 16'b1010010100110100;
            else if (pixel_index == 3408 || pixel_index == 3694 || pixel_index == 4074) oled_data = 16'b0101001010001010;
            else if (pixel_index == 3599 || pixel_index == 3691) oled_data = 16'b0001100011000011;
            else if (pixel_index == 3885 || pixel_index == 3991) oled_data = 16'b0011100111000111;
            else if (((pixel_index >= 3886) && (pixel_index <= 3889)) || (pixel_index >= 3893) && (pixel_index <= 3894)) oled_data = 16'b0010000100000100;
            else if (pixel_index == 3890) oled_data = 16'b1010110101110101;
            else if (pixel_index == 3978) oled_data = 16'b0110101101001101;
            else if (((pixel_index >= 4075) && (pixel_index <= 4081)) || ((pixel_index >= 4085) && (pixel_index <= 4086)) || pixel_index == 4467) oled_data = 16'b1100011000111000;
            else if (pixel_index == 4084) oled_data = 16'b1110111101111101;
            else if (pixel_index == 4087) oled_data = 16'b0010100101000101;
            else if (pixel_index == 4466) oled_data = 16'b0111101111001111;
            else if (pixel_index == 4468) oled_data = 16'b1000110001010001;
            else oled_data = 0;

            end
            3'b100: begin
            if (pixel_index == 2349 || pixel_index == 3507) oled_data = 16'b0011100111000111;
            else if ((pixel_index >= 2350) && (pixel_index <= 2357)) oled_data = 16'b0101001010001010;
            else if (pixel_index == 2358 || pixel_index == 2643 || pixel_index == 2645 || pixel_index == 3026 || pixel_index == 3124) oled_data = 16'b0000100001000001;
            else if (pixel_index == 2445 || pixel_index == 2637 || pixel_index == 2829 || pixel_index == 3117 || pixel_index == 3220) oled_data = 16'b1010110101110101;
            else if (((pixel_index >= 2446) && (pixel_index <= 2453)) || pixel_index == 2542 || pixel_index == 2638 || pixel_index == 2734 || pixel_index == 2830 || pixel_index == 2926 || pixel_index == 3022 || ((pixel_index >= 3118) && (pixel_index <= 3120)) || ((pixel_index >= 3218) && (pixel_index <= 3219)) || ((pixel_index >= 3315) && (pixel_index <= 3316)) || ((pixel_index >= 3412) && (pixel_index <= 3413)) || ((pixel_index >= 3508) && (pixel_index <= 3509)) || pixel_index == 3605 || pixel_index == 3701 || ((pixel_index >= 3796) && (pixel_index <= 3797)) || pixel_index == 3892 || (pixel_index >= 3987) && (pixel_index <= 3988)) oled_data = 16'b1111111111111111;
            else if (pixel_index == 2454 || pixel_index == 3699 || pixel_index == 3983) oled_data = 16'b0010100101000101;
            else if (pixel_index == 2541 || pixel_index == 2733 || pixel_index == 2925 || pixel_index == 3021 || pixel_index == 3411) oled_data = 16'b1010010100110100;
            else if (pixel_index == 2543 || pixel_index == 4077 || pixel_index == 4079 || pixel_index == 4083) oled_data = 16'b1110011100111100;
            else if ((pixel_index >= 2544) && (pixel_index <= 2547)) oled_data = 16'b1101011010111010;
            else if (((pixel_index >= 2548) && (pixel_index <= 2549)) || pixel_index == 3122 || pixel_index == 3891) oled_data = 16'b1100111001111001;
            else if (pixel_index == 2550 || pixel_index == 3025 || pixel_index == 3313 || pixel_index == 3603 || pixel_index == 3984) oled_data = 16'b0010000100000100;
            else if (pixel_index == 2639 || pixel_index == 2735 || pixel_index == 2831 || pixel_index == 3510 || pixel_index == 4084) oled_data = 16'b0111001110001110;
            else if (pixel_index == 2927 || pixel_index == 3123 || pixel_index == 3989) oled_data = 16'b0110101101001101;
            else if (pixel_index == 3023 || pixel_index == 3215 || pixel_index == 3317 || pixel_index == 3981) oled_data = 16'b1001110011110011;
            else if (pixel_index == 3024 || pixel_index == 3985) oled_data = 16'b0100001000001000;
            else if (pixel_index == 3121 || pixel_index == 3700 || pixel_index == 4082) oled_data = 16'b1111011110111110;
            else if (pixel_index == 3213 || pixel_index == 3798 || pixel_index == 3982) oled_data = 16'b0110001100001100;
            else if (pixel_index == 3214 || pixel_index == 3314 || pixel_index == 3702) oled_data = 16'b1000110001010001;
            else if (pixel_index == 3216) oled_data = 16'b1011010110110110;
            else if (pixel_index == 3217 || pixel_index == 3604 || pixel_index == 3893 || pixel_index == 4078 || pixel_index == 4081) oled_data = 16'b1110111101111101;
            else if (pixel_index == 3221 || pixel_index == 3890 || pixel_index == 4179) oled_data = 16'b0001000010000010;
            else if (pixel_index == 3414) oled_data = 16'b0011000110000110;
            else if (pixel_index == 3606) oled_data = 16'b1001010010110010;
            else if (pixel_index == 3795) oled_data = 16'b0101101011001011;
            else if (pixel_index == 3894 || pixel_index == 3980 || pixel_index == 4076 || (pixel_index >= 4173) && (pixel_index <= 4178)) oled_data = 16'b0001100011000011;
            else if (pixel_index == 3986) oled_data = 16'b1011110111110111;
            else if (pixel_index == 4080) oled_data = 16'b1101111011111011;
            else oled_data = 0;

            end
            3'b101: begin
            if (pixel_index == 2349 || pixel_index == 3309 || pixel_index == 3316 || pixel_index == 3404 || pixel_index == 3977 || (pixel_index >= 4270) && (pixel_index <= 4271)) oled_data = 16'b0001000010000010;
            else if (pixel_index == 2350 || pixel_index == 2353 || pixel_index == 3112 || pixel_index == 3219 || pixel_index == 3409 || pixel_index == 3892) oled_data = 16'b0100001000001000;
            else if (((pixel_index >= 2351) && (pixel_index <= 2352)) || pixel_index == 3400) oled_data = 16'b0101101011001011;
            else if (pixel_index == 2354 || pixel_index == 2642 || pixel_index == 2828 || pixel_index == 3688 || pixel_index == 3984 || pixel_index == 4178) oled_data = 16'b0001100011000011;
            else if (pixel_index == 2444 || pixel_index == 2637) oled_data = 16'b0110101101001101;
            else if (pixel_index == 2445 || pixel_index == 3315 || pixel_index == 3978 || pixel_index == 4176) oled_data = 16'b1101111011111011;
            else if (((pixel_index >= 2446) && (pixel_index <= 2449)) || ((pixel_index >= 2540) && (pixel_index <= 2541)) || ((pixel_index >= 2635) && (pixel_index <= 2636)) || pixel_index == 2731 || pixel_index == 2826 || pixel_index == 2922 || pixel_index == 3018 || ((pixel_index >= 3113) && (pixel_index <= 3114)) || pixel_index == 3119 || ((pixel_index >= 3209) && (pixel_index <= 3210)) || pixel_index == 3217 || ((pixel_index >= 3305) && (pixel_index <= 3307)) || pixel_index == 3314 || ((pixel_index >= 3401) && (pixel_index <= 3402)) || pixel_index == 3411 || ((pixel_index >= 3497) && (pixel_index <= 3498)) || pixel_index == 3507 || ((pixel_index >= 3593) && (pixel_index <= 3594)) || pixel_index == 3603 || pixel_index == 3690 || pixel_index == 3699 || pixel_index == 3786 || pixel_index == 3795 || pixel_index == 3882 || pixel_index == 3891 || pixel_index == 3979 || pixel_index == 3986 || pixel_index == 4076 || pixel_index == 4081) oled_data = 16'b1111111111111111;
            else if (pixel_index == 2450 || pixel_index == 2730 || pixel_index == 3017 || pixel_index == 3212 || pixel_index == 3216 || pixel_index == 3218 || pixel_index == 3689 || pixel_index == 4075 || pixel_index == 4077) oled_data = 16'b1110111101111101;
            else if (pixel_index == 2451) oled_data = 16'b1001010010110010;
            else if (pixel_index == 2539 || pixel_index == 3691 || pixel_index == 4177) oled_data = 16'b1001110011110011;
            else if (pixel_index == 2542 || pixel_index == 2547 || pixel_index == 3785 || pixel_index == 3787 || pixel_index == 3794 || pixel_index == 3985) oled_data = 16'b1100011000111000;
            else if (pixel_index == 2543 || pixel_index == 2732 || pixel_index == 3595 || pixel_index == 3796) oled_data = 16'b1000110001010001;
            else if (pixel_index == 2544 || pixel_index == 3211) oled_data = 16'b1000010000010000;
            else if (pixel_index == 2545 || pixel_index == 2923 || ((pixel_index >= 3214) && (pixel_index <= 3215)) || pixel_index == 3308 || pixel_index == 3508 || pixel_index == 3602 || pixel_index == 3698 || pixel_index == 4079) oled_data = 16'b1010110101110101;
            else if (pixel_index == 2546 || pixel_index == 2827 || pixel_index == 3213 || pixel_index == 3403 || pixel_index == 4080 || (pixel_index >= 4173) && (pixel_index <= 4175)) oled_data = 16'b1110011100111100;
            else if (pixel_index == 2634 || pixel_index == 3019 || pixel_index == 3881) oled_data = 16'b0111001110001110;
            else if (pixel_index == 2638 || pixel_index == 2920 || pixel_index == 3784 || pixel_index == 4269 || pixel_index == 4272) oled_data = 16'b0000100001000001;
            else if (pixel_index == 2643 || pixel_index == 3122 || pixel_index == 3592 || pixel_index == 4171) oled_data = 16'b0011100111000111;
            else if (pixel_index == 2729 || pixel_index == 3016 || pixel_index == 3022 || pixel_index == 3024 || pixel_index == 4083) oled_data = 16'b0010000100000100;
            else if (pixel_index == 2825) oled_data = 16'b0111101111001111;
            else if (pixel_index == 2921) oled_data = 16'b1100111001111001;
            else if (pixel_index == 3023 || pixel_index == 3116 || pixel_index == 3884) oled_data = 16'b0011000110000110;
            else if (pixel_index == 3115 || pixel_index == 4074) oled_data = 16'b0100101001001001;
            else if (pixel_index == 3117 || pixel_index == 3604 || pixel_index == 3987 || pixel_index == 4172) oled_data = 16'b1011110111110111;
            else if (pixel_index == 3118 || pixel_index == 3120 || pixel_index == 3410 || pixel_index == 3883 || pixel_index == 3890) oled_data = 16'b1111011110111110;
            else if (pixel_index == 3121 || pixel_index == 3700 || pixel_index == 4078) oled_data = 16'b1011010110110110;
            else if (pixel_index == 3208 || pixel_index == 3496) oled_data = 16'b0101001010001010;
            else if (pixel_index == 3304 || pixel_index == 3412) oled_data = 16'b0110001100001100;
            else if (pixel_index == 3312 || pixel_index == 3889 || pixel_index == 3981) oled_data = 16'b0010100101000101;
            else if (pixel_index == 3313 || pixel_index == 3506 || pixel_index == 3980 || pixel_index == 4082) oled_data = 16'b1101011010111010;
            else if (pixel_index == 3499) oled_data = 16'b1010010100110100;
            else oled_data = 0;

            end
            3'b110: begin
            if (pixel_index == 2923 || pixel_index == 3601 || pixel_index == 4464 || pixel_index == 4556 || pixel_index == 4748) oled_data = 16'b0010100101000101;
            else if ((pixel_index >= 2924) && (pixel_index <= 2933)) oled_data = 16'b0101001010001010;
            else if (pixel_index == 2934) oled_data = 16'b0100001000001000;
            else if (pixel_index == 3019 || pixel_index == 3890) oled_data = 16'b1000010000010000;
            else if (((pixel_index >= 3020) && (pixel_index <= 3029)) || pixel_index == 3125 || pixel_index == 3221 || pixel_index == 3316 || pixel_index == 3507 || pixel_index == 3698 || pixel_index == 3793 || pixel_index == 3889 || pixel_index == 3984 || pixel_index == 4080 || ((pixel_index >= 4175) && (pixel_index <= 4176)) || pixel_index == 4271 || ((pixel_index >= 4366) && (pixel_index <= 4367)) || pixel_index == 4462 || ((pixel_index >= 4557) && (pixel_index <= 4558)) || (pixel_index >= 4653) && (pixel_index <= 4654)) oled_data = 16'b1111111111111111;
            else if (pixel_index == 3030 || pixel_index == 4461 || pixel_index == 4559) oled_data = 16'b1100111001111001;
            else if (pixel_index == 3115 || pixel_index == 4174 || pixel_index == 4365 || pixel_index == 4368) oled_data = 16'b0111001110001110;
            else if (((pixel_index >= 3116) && (pixel_index <= 3123)) || pixel_index == 3603 || pixel_index == 3794 || pixel_index == 3985) oled_data = 16'b1110111101111101;
            else if (pixel_index == 3124 || pixel_index == 3412 || pixel_index == 3602 || pixel_index == 4463) oled_data = 16'b1111011110111110;
            else if (pixel_index == 3126 || pixel_index == 3317) oled_data = 16'b1011110111110111;
            else if (pixel_index == 3211 || pixel_index == 4078) oled_data = 16'b0001000010000010;
            else if (((pixel_index >= 3212) && (pixel_index <= 3218)) || pixel_index == 3410 || pixel_index == 3795 || pixel_index == 4269) oled_data = 16'b0001100011000011;
            else if (pixel_index == 3219 || pixel_index == 3604 || pixel_index == 3986) oled_data = 16'b0010000100000100;
            else if (pixel_index == 3220 || pixel_index == 4079) oled_data = 16'b1101111011111011;
            else if (pixel_index == 3222 || pixel_index == 3983 || (pixel_index >= 4749) && (pixel_index <= 4750)) oled_data = 16'b0110001100001100;
            else if (pixel_index == 3315) oled_data = 16'b0110101101001101;
            else if (pixel_index == 3411 || pixel_index == 4270) oled_data = 16'b1110011100111100;
            else if (pixel_index == 3413) oled_data = 16'b0011100111000111;
            else if (pixel_index == 3506) oled_data = 16'b1001010010110010;
            else if (pixel_index == 3508 || pixel_index == 4081) oled_data = 16'b1001110011110011;
            else if (pixel_index == 3697) oled_data = 16'b1010110101110101;
            else if (pixel_index == 3699) oled_data = 16'b1000110001010001;
            else if (pixel_index == 3792) oled_data = 16'b0100101001001001;
            else if (pixel_index == 3887 || pixel_index == 4273 || pixel_index == 4460) oled_data = 16'b0000100001000001;
            else if (pixel_index == 3888 || pixel_index == 4272) oled_data = 16'b1100011000111000;
            else if (pixel_index == 4177 || pixel_index == 4751) oled_data = 16'b0011000110000110;
            else if (pixel_index == 4652) oled_data = 16'b0101101011001011;
            else if (pixel_index == 4655) oled_data = 16'b1010010100110100;
            else oled_data = 0;

            end
            3'b111: begin
            if (pixel_index == 2923 || pixel_index == 3601 || pixel_index == 4464 || pixel_index == 4556 || pixel_index == 4748) oled_data = 16'b0010100101000101;
            else if ((pixel_index >= 2924) && (pixel_index <= 2933)) oled_data = 16'b0101001010001010;
            else if (pixel_index == 2934) oled_data = 16'b0100001000001000;
            else if (pixel_index == 3019 || pixel_index == 3890) oled_data = 16'b1000010000010000;
            else if (((pixel_index >= 3020) && (pixel_index <= 3029)) || pixel_index == 3125 || pixel_index == 3221 || pixel_index == 3316 || pixel_index == 3507 || pixel_index == 3698 || pixel_index == 3793 || pixel_index == 3889 || pixel_index == 3984 || pixel_index == 4080 || ((pixel_index >= 4175) && (pixel_index <= 4176)) || pixel_index == 4271 || ((pixel_index >= 4366) && (pixel_index <= 4367)) || pixel_index == 4462 || ((pixel_index >= 4557) && (pixel_index <= 4558)) || (pixel_index >= 4653) && (pixel_index <= 4654)) oled_data = 16'b1111111111111111;
            else if (pixel_index == 3030 || pixel_index == 4461 || pixel_index == 4559) oled_data = 16'b1100111001111001;
            else if (pixel_index == 3115 || pixel_index == 4174 || pixel_index == 4365 || pixel_index == 4368) oled_data = 16'b0111001110001110;
            else if (((pixel_index >= 3116) && (pixel_index <= 3123)) || pixel_index == 3603 || pixel_index == 3794 || pixel_index == 3985) oled_data = 16'b1110111101111101;
            else if (pixel_index == 3124 || pixel_index == 3412 || pixel_index == 3602 || pixel_index == 4463) oled_data = 16'b1111011110111110;
            else if (pixel_index == 3126 || pixel_index == 3317) oled_data = 16'b1011110111110111;
            else if (pixel_index == 3211 || pixel_index == 4078) oled_data = 16'b0001000010000010;
            else if (((pixel_index >= 3212) && (pixel_index <= 3218)) || pixel_index == 3410 || pixel_index == 3795 || pixel_index == 4269) oled_data = 16'b0001100011000011;
            else if (pixel_index == 3219 || pixel_index == 3604 || pixel_index == 3986) oled_data = 16'b0010000100000100;
            else if (pixel_index == 3220 || pixel_index == 4079) oled_data = 16'b1101111011111011;
            else if (pixel_index == 3222 || pixel_index == 3983 || (pixel_index >= 4749) && (pixel_index <= 4750)) oled_data = 16'b0110001100001100;
            else if (pixel_index == 3315) oled_data = 16'b0110101101001101;
            else if (pixel_index == 3411 || pixel_index == 4270) oled_data = 16'b1110011100111100;
            else if (pixel_index == 3413) oled_data = 16'b0011100111000111;
            else if (pixel_index == 3506) oled_data = 16'b1001010010110010;
            else if (pixel_index == 3508 || pixel_index == 4081) oled_data = 16'b1001110011110011;
            else if (pixel_index == 3697) oled_data = 16'b1010110101110101;
            else if (pixel_index == 3699) oled_data = 16'b1000110001010001;
            else if (pixel_index == 3792) oled_data = 16'b0100101001001001;
            else if (pixel_index == 3887 || pixel_index == 4273 || pixel_index == 4460) oled_data = 16'b0000100001000001;
            else if (pixel_index == 3888 || pixel_index == 4272) oled_data = 16'b1100011000111000;
            else if (pixel_index == 4177 || pixel_index == 4751) oled_data = 16'b0011000110000110;
            else if (pixel_index == 4652) oled_data = 16'b0101101011001011;
            else if (pixel_index == 4655) oled_data = 16'b1010010100110100;
            else oled_data = 0;

            end
        endcase
        end
endmodule