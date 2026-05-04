`timescale 1ns / 1ps

module symbol_renderer_B (
    input [9:0] pixel_index,
    input [2:0] symbol_id,
    output reg [15:0] out_color
);
    //STORE 25X25 SYMBOL AND RETURN PIXEL COLOUR 

    // Intermediate wires for each symbol's logic
    reg [15:0] color_s0, color_s1, color_s2, color_s3, 
               color_s4, color_s5, color_s6, color_s7;

    // --- Symbol 1 Logic ---
    always @(*) begin
        if (pixel_index == 7 || pixel_index == 88 || pixel_index == 133 || pixel_index == 220 || ((pixel_index >= 278) && (pixel_index <= 279)) || ((pixel_index >= 334) && (pixel_index <= 342)) || pixel_index == 455 || pixel_index == 515 || pixel_index == 521 || pixel_index == 545 || pixel_index == 591) color_s0 = 16'b0001000010000010;
        else if (pixel_index == 8 || pixel_index == 16 || pixel_index == 202 || pixel_index == 227 || pixel_index == 418 || pixel_index == 453 || pixel_index == 477 || pixel_index == 502 || pixel_index == 527 || pixel_index == 568) color_s0 = 16'b0010100101000101;
        else if (pixel_index == 9 || ((pixel_index >= 115) && (pixel_index <= 116)) || ((pixel_index >= 134) && (pixel_index <= 136)) || pixel_index == 166 || pixel_index == 207 || pixel_index == 240 || pixel_index == 272 || pixel_index == 467 || pixel_index == 537) color_s0 = 16'b0001100011000011;
        else if (pixel_index == 15 || pixel_index == 68 || pixel_index == 177 || pixel_index == 246 || pixel_index == 252 || pixel_index == 552) color_s0 = 16'b0010000100000100;
        else if (pixel_index == 31 || pixel_index == 81 || pixel_index == 373 || pixel_index == 398 || pixel_index == 578) color_s0 = 16'b0100101001001001;
        else if (pixel_index == 32 || pixel_index == 34 || pixel_index == 186 || pixel_index == 322 || ((pixel_index >= 582) && (pixel_index <= 583)) || pixel_index == 586) color_s0 = 16'b1101011010111010;
        else if (pixel_index == 33 || pixel_index == 83 || ((pixel_index >= 159) && (pixel_index <= 161)) || pixel_index == 203 || pixel_index == 218 || pixel_index == 242 || pixel_index == 422 || pixel_index == 478 || pixel_index == 503 || pixel_index == 528 || pixel_index == 562) color_s0 = 16'b1111011110111110;
        else if (pixel_index == 35 || pixel_index == 153 || pixel_index == 383) color_s0 = 16'b0100001000001000;
        else if (pixel_index == 38 || pixel_index == 43 || pixel_index == 93 || pixel_index == 152 || pixel_index == 212 || pixel_index == 292 || pixel_index == 323 || pixel_index == 333 || pixel_index == 452 || pixel_index == 497 || pixel_index == 506 || pixel_index == 532 || pixel_index == 536 || pixel_index == 577 || (pixel_index >= 609) && (pixel_index <= 610)) color_s0 = 16'b0000100001000001;
        else if (pixel_index == 39 || pixel_index == 267 || pixel_index == 480 || pixel_index == 559) color_s0 = 16'b1000010000010000;
        else if (pixel_index == 40 || ((pixel_index >= 90) && (pixel_index <= 91)) || pixel_index == 191 || pixel_index == 254 || pixel_index == 360 || pixel_index == 363 || pixel_index == 365) color_s0 = 16'b1110011100111100;
        else if (pixel_index == 41 || pixel_index == 158 || pixel_index == 182 || pixel_index == 205 || pixel_index == 359 || ((pixel_index >= 361) && (pixel_index <= 362)) || pixel_index == 364 || ((pixel_index >= 366) && (pixel_index <= 368)) || pixel_index == 543) color_s0 = 16'b1110111101111101;
        else if (pixel_index == 42 || pixel_index == 92 || pixel_index == 192) color_s0 = 16'b1000110001010001;
        else if (pixel_index == 56 || pixel_index == 60 || pixel_index == 162 || ((pixel_index >= 184) && (pixel_index <= 185)) || pixel_index == 520) color_s0 = 16'b1011010110110110;
        else if (((pixel_index >= 57) && (pixel_index <= 59)) || ((pixel_index >= 64) && (pixel_index <= 67)) || ((pixel_index >= 178) && (pixel_index <= 181)) || ((pixel_index >= 188) && (pixel_index <= 190)) || pixel_index == 204 || ((pixel_index >= 216) && (pixel_index <= 217)) || ((pixel_index >= 228) && (pixel_index <= 229)) || ((pixel_index >= 243) && (pixel_index <= 244)) || ((pixel_index >= 268) && (pixel_index <= 270)) || ((pixel_index >= 294) && (pixel_index <= 296)) || ((pixel_index >= 319) && (pixel_index <= 321)) || ((pixel_index >= 344) && (pixel_index <= 347)) || ((pixel_index >= 369) && (pixel_index <= 372)) || ((pixel_index >= 394) && (pixel_index <= 397)) || ((pixel_index >= 419) && (pixel_index <= 421)) || ((pixel_index >= 444) && (pixel_index <= 446)) || ((pixel_index >= 469) && (pixel_index <= 471)) || pixel_index == 479 || ((pixel_index >= 493) && (pixel_index <= 495)) || pixel_index == 504 || ((pixel_index >= 517) && (pixel_index <= 519)) || ((pixel_index >= 529) && (pixel_index <= 530)) || ((pixel_index >= 541) && (pixel_index <= 542)) || ((pixel_index >= 553) && (pixel_index <= 556)) || (pixel_index >= 563) && (pixel_index <= 565)) color_s0 = 16'b1111111111111111;
        else if (pixel_index == 63 || pixel_index == 85 || pixel_index == 108 || pixel_index == 213 || pixel_index == 343 || pixel_index == 423 || pixel_index == 454) color_s0 = 16'b0011000110000110;
        else if (pixel_index == 82 || pixel_index == 84 || pixel_index == 245 || pixel_index == 271 || ((pixel_index >= 384) && (pixel_index <= 392)) || pixel_index == 505) color_s0 = 16'b1100011000111000;
        else if (pixel_index == 89 || pixel_index == 155 || pixel_index == 164 || pixel_index == 297 || pixel_index == 443 || pixel_index == 579) color_s0 = 16'b0111101111001111;
        else if (pixel_index == 154 || pixel_index == 472) color_s0 = 16'b0110001100001100;
        else if (pixel_index == 156 || pixel_index == 580) color_s0 = 16'b1010010100110100;
        else if (pixel_index == 157 || pixel_index == 496 || pixel_index == 567) color_s0 = 16'b1010110101110101;
        else if (pixel_index == 163 || pixel_index == 230 || pixel_index == 560) color_s0 = 16'b1001110011110011;
        else if (pixel_index == 165 || pixel_index == 318 || pixel_index == 358 || pixel_index == 590) color_s0 = 16'b0101001010001010;
        else if (pixel_index == 183 || pixel_index == 215 || pixel_index == 293 || pixel_index == 393 || pixel_index == 587) color_s0 = 16'b1100111001111001;
        else if (pixel_index == 187 || pixel_index == 253 || pixel_index == 468 || pixel_index == 540 || pixel_index == 557 || pixel_index == 561 || pixel_index == 566 || (pixel_index >= 584) && (pixel_index <= 585)) color_s0 = 16'b1101111011111011;
        else if (pixel_index == 193 || pixel_index == 348 || pixel_index == 538) color_s0 = 16'b0011100111000111;
        else if (pixel_index == 206 || pixel_index == 531) color_s0 = 16'b0101101011001011;
        else if (pixel_index == 214 || pixel_index == 255 || pixel_index == 539) color_s0 = 16'b0111001110001110;
        else if (pixel_index == 219 || pixel_index == 241 || pixel_index == 492 || pixel_index == 516 || pixel_index == 544 || pixel_index == 589) color_s0 = 16'b1001010010110010;
        else if (pixel_index == 447 || pixel_index == 558 || pixel_index == 581 || pixel_index == 588) color_s0 = 16'b1011110111110111;
        else color_s0 = 0;
    end

    // --- Symbol 2 Logic ---
    always @(*) begin
        if (pixel_index == 36 || pixel_index == 110 || pixel_index == 298 || pixel_index == 345 || pixel_index == 406) color_s1 = 16'b0001000010000010;
        else if (pixel_index == 37 || pixel_index == 164 || pixel_index == 382 || pixel_index == 392) color_s1 = 16'b1000010000010000;
        else if (pixel_index == 38 || pixel_index == 184 || pixel_index == 494) color_s1 = 16'b0000100001000001;
        else if (pixel_index == 61 || pixel_index == 225 || pixel_index == 274) color_s1 = 16'b0100101001001001;
        else if (pixel_index == 62 || pixel_index == 87 || pixel_index == 112 || ((pixel_index >= 136) && (pixel_index <= 137)) || ((pixel_index >= 161) && (pixel_index <= 163)) || ((pixel_index >= 186) && (pixel_index <= 188)) || ((pixel_index >= 210) && (pixel_index <= 214)) || ((pixel_index >= 235) && (pixel_index <= 239)) || ((pixel_index >= 252) && (pixel_index <= 272)) || ((pixel_index >= 278) && (pixel_index <= 295)) || ((pixel_index >= 305) && (pixel_index <= 319)) || ((pixel_index >= 331) && (pixel_index <= 343)) || ((pixel_index >= 358) && (pixel_index <= 366)) || ((pixel_index >= 383) && (pixel_index <= 391)) || ((pixel_index >= 408) && (pixel_index <= 416)) || ((pixel_index >= 432) && (pixel_index <= 441)) || ((pixel_index >= 457) && (pixel_index <= 461)) || ((pixel_index >= 464) && (pixel_index <= 467)) || ((pixel_index >= 482) && (pixel_index <= 484)) || ((pixel_index >= 490) && (pixel_index <= 492)) || ((pixel_index >= 506) && (pixel_index <= 508)) || ((pixel_index >= 517) && (pixel_index <= 518)) || pixel_index == 531 || pixel_index == 543 || pixel_index == 555) color_s1 = 16'b1111111111111111;
        else if (pixel_index == 63 || pixel_index == 567 || pixel_index == 595) color_s1 = 16'b0010100101000101;
        else if (pixel_index == 86 || pixel_index == 568) color_s1 = 16'b1011010110110110;
        else if (pixel_index == 88) color_s1 = 16'b0111101111001111;
        else if (pixel_index == 111 || pixel_index == 367 || pixel_index == 532 || pixel_index == 542) color_s1 = 16'b1110011100111100;
        else if (pixel_index == 113 || pixel_index == 304) color_s1 = 16'b1101011010111010;
        else if (pixel_index == 135 || pixel_index == 488) color_s1 = 16'b0011100111000111;
        else if (pixel_index == 138 || pixel_index == 296 || pixel_index == 442 || pixel_index == 463 || pixel_index == 516) color_s1 = 16'b1111011110111110;
        else if (pixel_index == 139 || pixel_index == 215 || pixel_index == 443 || pixel_index == 510) color_s1 = 16'b0011000110000110;
        else if (pixel_index == 160) color_s1 = 16'b1001010010110010;
        else if (pixel_index == 185 || pixel_index == 320 || pixel_index == 530) color_s1 = 16'b1100111001111001;
        else if (pixel_index == 189 || pixel_index == 462 || pixel_index == 509) color_s1 = 16'b1011110111110111;
        else if (pixel_index == 209 || pixel_index == 249 || pixel_index == 321 || pixel_index == 554 || pixel_index == 579) color_s1 = 16'b0100001000001000;
        else if (((pixel_index >= 226) && (pixel_index <= 233)) || ((pixel_index >= 241) && (pixel_index <= 248)) || pixel_index == 431 || pixel_index == 486 || pixel_index == 533 || pixel_index == 580) color_s1 = 16'b0110001100001100;
        else if (pixel_index == 234 || pixel_index == 240 || pixel_index == 277 || pixel_index == 330 || pixel_index == 456 || pixel_index == 556) color_s1 = 16'b1010110101110101;
        else if (pixel_index == 250 || pixel_index == 303 || pixel_index == 368) color_s1 = 16'b0101101011001011;
        else if (pixel_index == 251 || pixel_index == 481 || pixel_index == 485) color_s1 = 16'b1110111101111101;
        else if (pixel_index == 273 || pixel_index == 357 || pixel_index == 407 || pixel_index == 489 || pixel_index == 493 || pixel_index == 569) color_s1 = 16'b1101111011111011;
        else if (pixel_index == 276 || pixel_index == 329 || pixel_index == 480 || pixel_index == 514 || pixel_index == 570) color_s1 = 16'b0001100011000011;
        else if (pixel_index == 297 || pixel_index == 344 || pixel_index == 468 || pixel_index == 544) color_s1 = 16'b1000110001010001;
        else if (pixel_index == 356) color_s1 = 16'b0110101101001101;
        else if (pixel_index == 417) color_s1 = 16'b1100011000111000;
        else if (pixel_index == 505 || pixel_index == 594) color_s1 = 16'b0111001110001110;
        else if (pixel_index == 515) color_s1 = 16'b1010010100110100;
        else if (pixel_index == 519 || pixel_index == 541) color_s1 = 16'b0101001010001010;
        else if (pixel_index == 557) color_s1 = 16'b0010000100000100;
        else color_s1 = 0;
    end
    
    // --- Symbol 3 Logic ---
    always @(*) begin
        if (pixel_index == 33 || pixel_index == 160 || pixel_index == 171 || pixel_index == 234 || pixel_index == 510) color_s2 = 16'b0011000110000110;
        else if (pixel_index == 34 || pixel_index == 93 || pixel_index == 164 || pixel_index == 177 || pixel_index == 251 || pixel_index == 421 || pixel_index == 466 || pixel_index == 486 || pixel_index == 509) color_s2 = 16'b0111101111001111;
        else if (pixel_index == 35 || pixel_index == 84 || pixel_index == 512) color_s2 = 16'b1010010100110100;
        else if (pixel_index == 36 || pixel_index == 112 || pixel_index == 470) color_s2 = 16'b1001010010110010;
        else if (pixel_index == 37 || pixel_index == 64 || pixel_index == 94 || pixel_index == 206 || pixel_index == 217 || pixel_index == 222 || pixel_index == 364 || pixel_index == 401 || pixel_index == 457 || pixel_index == 556 || pixel_index == 572 || pixel_index == 590) color_s2 = 16'b0000100001000001;
        else if (pixel_index == 56 || pixel_index == 88 || pixel_index == 359 || pixel_index == 557) color_s2 = 16'b0101101011001011;
        else if (pixel_index == 57 || pixel_index == 268 || pixel_index == 318 || pixel_index == 465 || pixel_index == 531 || pixel_index == 558) color_s2 = 16'b1011110111110111;
        else if (((pixel_index >= 58) && (pixel_index <= 60)) || ((pixel_index >= 81) && (pixel_index <= 83)) || ((pixel_index >= 90) && (pixel_index <= 91)) || ((pixel_index >= 105) && (pixel_index <= 107)) || ((pixel_index >= 113) && (pixel_index <= 114)) || ((pixel_index >= 117) && (pixel_index <= 118)) || ((pixel_index >= 129) && (pixel_index <= 131)) || ((pixel_index >= 137) && (pixel_index <= 138)) || ((pixel_index >= 143) && (pixel_index <= 144)) || ((pixel_index >= 154) && (pixel_index <= 155)) || ((pixel_index >= 162) && (pixel_index <= 163)) || ((pixel_index >= 168) && (pixel_index <= 169)) || ((pixel_index >= 178) && (pixel_index <= 180)) || ((pixel_index >= 186) && (pixel_index <= 187)) || ((pixel_index >= 194) && (pixel_index <= 195)) || ((pixel_index >= 203) && (pixel_index <= 204)) || ((pixel_index >= 211) && (pixel_index <= 212)) || ((pixel_index >= 219) && (pixel_index <= 220)) || ((pixel_index >= 227) && (pixel_index <= 229)) || ((pixel_index >= 235) && (pixel_index <= 237)) || ((pixel_index >= 244) && (pixel_index <= 245)) || ((pixel_index >= 252) && (pixel_index <= 254)) || ((pixel_index >= 260) && (pixel_index <= 262)) || ((pixel_index >= 269) && (pixel_index <= 271)) || ((pixel_index >= 277) && (pixel_index <= 279)) || ((pixel_index >= 285) && (pixel_index <= 287)) || ((pixel_index >= 294) && (pixel_index <= 295)) || ((pixel_index >= 302) && (pixel_index <= 304)) || ((pixel_index >= 310) && (pixel_index <= 312)) || ((pixel_index >= 319) && (pixel_index <= 320)) || ((pixel_index >= 327) && (pixel_index <= 329)) || ((pixel_index >= 335) && (pixel_index <= 337)) || ((pixel_index >= 344) && (pixel_index <= 345)) || ((pixel_index >= 352) && (pixel_index <= 354)) || ((pixel_index >= 360) && (pixel_index <= 362)) || ((pixel_index >= 369) && (pixel_index <= 371)) || ((pixel_index >= 378) && (pixel_index <= 379)) || ((pixel_index >= 386) && (pixel_index <= 387)) || ((pixel_index >= 394) && (pixel_index <= 395)) || ((pixel_index >= 403) && (pixel_index <= 404)) || ((pixel_index >= 411) && (pixel_index <= 413)) || ((pixel_index >= 418) && (pixel_index <= 420)) || ((pixel_index >= 428) && (pixel_index <= 430)) || ((pixel_index >= 436) && (pixel_index <= 438)) || ((pixel_index >= 443) && (pixel_index <= 444)) || ((pixel_index >= 454) && (pixel_index <= 455)) || ((pixel_index >= 462) && (pixel_index <= 464)) || ((pixel_index >= 467) && (pixel_index <= 469)) || ((pixel_index >= 480) && (pixel_index <= 481)) || ((pixel_index >= 487) && (pixel_index <= 493)) || ((pixel_index >= 506) && (pixel_index <= 507)) || ((pixel_index >= 513) && (pixel_index <= 517)) || ((pixel_index >= 532) && (pixel_index <= 534)) || ((pixel_index >= 538) && (pixel_index <= 542)) || pixel_index == 546 || ((pixel_index >= 560) && (pixel_index <= 563)) || (pixel_index >= 567) && (pixel_index <= 570)) color_s2 = 16'b1111111111111111;
        else if (pixel_index == 61 || pixel_index == 139 || pixel_index == 153 || pixel_index == 170 || pixel_index == 193 || pixel_index == 393 || pixel_index == 505 || pixel_index == 508 || pixel_index == 543 || pixel_index == 559 || pixel_index == 564 || pixel_index == 566) color_s2 = 16'b1110111101111101;
        else if (pixel_index == 62 || pixel_index == 65 || pixel_index == 86 || pixel_index == 152 || pixel_index == 189 || pixel_index == 192 || pixel_index == 247 || pixel_index == 384 || pixel_index == 389 || pixel_index == 392 || pixel_index == 446 || pixel_index == 497 || pixel_index == 589 || pixel_index == 591) color_s2 = 16'b0010000100000100;
        else if (pixel_index == 66 || ((pixel_index >= 140) && (pixel_index <= 141)) || pixel_index == 272 || pixel_index == 297 || pixel_index == 322 || pixel_index == 347 || pixel_index == 372 || pixel_index == 376 || pixel_index == 478 || pixel_index == 483 || pixel_index == 523 || pixel_index == 530 || pixel_index == 584) color_s2 = 16'b0010100101000101;
        else if (pixel_index == 67 || pixel_index == 103 || pixel_index == 440 || pixel_index == 460 || pixel_index == 495) color_s2 = 16'b0001100011000011;
        else if (pixel_index == 79 || pixel_index == 201 || pixel_index == 209 || pixel_index == 397 || pixel_index == 406 || pixel_index == 452 || pixel_index == 511 || pixel_index == 520 || pixel_index == 548 || pixel_index == 596) color_s2 = 16'b0001000010000010;
        else if (pixel_index == 80 || pixel_index == 230 || pixel_index == 547) color_s2 = 16'b1010110101110101;
        else if (pixel_index == 85 || pixel_index == 108 || pixel_index == 226 || pixel_index == 280 || pixel_index == 284 || pixel_index == 305 || pixel_index == 309 || pixel_index == 330 || pixel_index == 334 || pixel_index == 355 || pixel_index == 431) color_s2 = 16'b0110001100001100;
        else if (pixel_index == 89 || pixel_index == 218 || pixel_index == 439 || pixel_index == 544) color_s2 = 16'b1100111001111001;
        else if (pixel_index == 92 || ((pixel_index >= 115) && (pixel_index <= 116)) || pixel_index == 142 || pixel_index == 405 || pixel_index == 445 || pixel_index == 461 || pixel_index == 479 || pixel_index == 518) color_s2 = 16'b1110011100111100;
        else if (pixel_index == 104 || pixel_index == 363 || pixel_index == 368 || pixel_index == 410 || pixel_index == 453 || pixel_index == 571) color_s2 = 16'b1100011000111000;
        else if (pixel_index == 119 || pixel_index == 185 || pixel_index == 238 || pixel_index == 521) color_s2 = 16'b1001110011110011;
        else if (pixel_index == 128 || pixel_index == 145 || pixel_index == 167 || pixel_index == 255) color_s2 = 16'b1000010000010000;
        else if (pixel_index == 132 || pixel_index == 136 || pixel_index == 263 || pixel_index == 276 || pixel_index == 288 || pixel_index == 301 || pixel_index == 313 || pixel_index == 326 || pixel_index == 338 || pixel_index == 427) color_s2 = 16'b0111001110001110;
        else if (pixel_index == 156 || pixel_index == 243 || pixel_index == 293 || pixel_index == 343 || pixel_index == 482) color_s2 = 16'b1011010110110110;
        else if (pixel_index == 161 || pixel_index == 188 || pixel_index == 246 || pixel_index == 296 || pixel_index == 321 || pixel_index == 346 || pixel_index == 377 || pixel_index == 385 || pixel_index == 388 || pixel_index == 522 || pixel_index == 535) color_s2 = 16'b1111011110111110;
        else if (pixel_index == 181 || pixel_index == 504 || pixel_index == 519 || pixel_index == 587 || pixel_index == 593 || pixel_index == 595) color_s2 = 16'b0100001000001000;
        else if (pixel_index == 196 || pixel_index == 380) color_s2 = 16'b1000110001010001;
        else if (pixel_index == 202 || pixel_index == 205 || pixel_index == 210 || pixel_index == 494 || pixel_index == 545) color_s2 = 16'b1101111011111011;
        else if (pixel_index == 213 || pixel_index == 221 || pixel_index == 396 || pixel_index == 402 || pixel_index == 442 || pixel_index == 456 || ((pixel_index >= 536) && (pixel_index <= 537)) || pixel_index == 565) color_s2 = 16'b1101011010111010;
        else if (pixel_index == 259) color_s2 = 16'b0101001010001010;
        else if (pixel_index == 351 || pixel_index == 417 || pixel_index == 435) color_s2 = 16'b0110101101001101;
        else if (pixel_index == 414 || ((pixel_index >= 585) && (pixel_index <= 586)) || pixel_index == 588 || pixel_index == 592 || pixel_index == 594) color_s2 = 16'b0100101001001001;
        else color_s2 = 0;
    end
    
    // --- Symbol 4 Logic ---
    always @(*) begin
       if (pixel_index == 15 || pixel_index == 87 || pixel_index == 181 || pixel_index == 228 || pixel_index == 282 || pixel_index == 298 || pixel_index == 342 || pixel_index == 369 || pixel_index == 371 || pixel_index == 376 || pixel_index == 527) color_s3 = 16'b0000100001000001;
        else if (pixel_index == 16 || pixel_index == 60 || pixel_index == 194 || pixel_index == 255 || pixel_index == 259 || pixel_index == 389 || pixel_index == 416 || pixel_index == 511) color_s3 = 16'b0010000100000100;
        else if (pixel_index == 40 || pixel_index == 182 || pixel_index == 273) color_s3 = 16'b0101101011001011;
        else if (pixel_index == 41 || pixel_index == 65 || pixel_index == 219 || pixel_index == 290) color_s3 = 16'b1101111011111011;
        else if (pixel_index == 42 || pixel_index == 308 || pixel_index == 492) color_s3 = 16'b1001010010110010;
        else if (pixel_index == 43 || pixel_index == 120 || pixel_index == 221 || pixel_index == 583 || pixel_index == 607) color_s3 = 16'b0010100101000101;
        else if (pixel_index == 57 || pixel_index == 70 || pixel_index == 130 || pixel_index == 248 || pixel_index == 252 || pixel_index == 315 || pixel_index == 322 || pixel_index == 403 || pixel_index == 443 || pixel_index == 454 || pixel_index == 517 || pixel_index == 565) color_s3 = 16'b0001100011000011;
        else if (pixel_index == 58 || pixel_index == 317 || pixel_index == 388) color_s3 = 16'b1011110111110111;
        else if (pixel_index == 59 || pixel_index == 69 || pixel_index == 95 || pixel_index == 220 || pixel_index == 430 || pixel_index == 534) color_s3 = 16'b1000010000010000;
        else if (pixel_index == 64 || pixel_index == 208 || pixel_index == 325 || pixel_index == 350 || pixel_index == 559 || pixel_index == 606) color_s3 = 16'b0001000010000010;
        else if (((pixel_index >= 66) && (pixel_index <= 67)) || ((pixel_index >= 83) && (pixel_index <= 84)) || ((pixel_index >= 90) && (pixel_index <= 94)) || ((pixel_index >= 108) && (pixel_index <= 111)) || ((pixel_index >= 114) && (pixel_index <= 118)) || ((pixel_index >= 132) && (pixel_index <= 143)) || ((pixel_index >= 157) && (pixel_index <= 167)) || ((pixel_index >= 184) && (pixel_index <= 192)) || ((pixel_index >= 211) && (pixel_index <= 218)) || ((pixel_index >= 236) && (pixel_index <= 245)) || ((pixel_index >= 261) && (pixel_index <= 272)) || ((pixel_index >= 278) && (pixel_index <= 279)) || ((pixel_index >= 285) && (pixel_index <= 289)) || ((pixel_index >= 292) && (pixel_index <= 296)) || ((pixel_index >= 302) && (pixel_index <= 306)) || ((pixel_index >= 309) && (pixel_index <= 313)) || ((pixel_index >= 318) && (pixel_index <= 320)) || ((pixel_index >= 327) && (pixel_index <= 338)) || pixel_index == 345 || ((pixel_index >= 352) && (pixel_index <= 362)) || ((pixel_index >= 379) && (pixel_index <= 387)) || ((pixel_index >= 406) && (pixel_index <= 413)) || ((pixel_index >= 431) && (pixel_index <= 440)) || ((pixel_index >= 456) && (pixel_index <= 467)) || ((pixel_index >= 480) && (pixel_index <= 484)) || ((pixel_index >= 487) && (pixel_index <= 491)) || ((pixel_index >= 505) && (pixel_index <= 508)) || ((pixel_index >= 513) && (pixel_index <= 515)) || ((pixel_index >= 529) && (pixel_index <= 533)) || (pixel_index >= 555) && (pixel_index <= 557)) color_s3 = 16'b1111111111111111;
        else if (pixel_index == 68 || pixel_index == 119 || pixel_index == 246 || pixel_index == 280 || pixel_index == 405 || pixel_index == 414 || pixel_index == 441 || pixel_index == 485 || pixel_index == 540) color_s3 = 16'b1110111101111101;
        else if (pixel_index == 82 || pixel_index == 113 || pixel_index == 284 || pixel_index == 297 || pixel_index == 512) color_s3 = 16'b1010010100110100;
        else if (pixel_index == 85 || pixel_index == 210 || pixel_index == 260 || pixel_index == 314 || pixel_index == 321 || pixel_index == 378 || pixel_index == 486 || pixel_index == 516 || pixel_index == 582) color_s3 = 16'b1110011100111100;
        else if (pixel_index == 86 || pixel_index == 346 || pixel_index == 541 || pixel_index == 580) color_s3 = 16'b0110001100001100;
        else if (pixel_index == 89 || pixel_index == 247 || pixel_index == 254 || pixel_index == 277 || pixel_index == 404 || pixel_index == 479) color_s3 = 16'b1001110011110011;
        else if (pixel_index == 106 || pixel_index == 155 || pixel_index == 316) color_s3 = 16'b0011100111000111;
        else if (pixel_index == 107 || pixel_index == 291 || pixel_index == 504 || pixel_index == 509) color_s3 = 16'b1111011110111110;
        else if (pixel_index == 112 || pixel_index == 253 || pixel_index == 326 || pixel_index == 455 || pixel_index == 528 || pixel_index == 581) color_s3 = 16'b1101011010111010;
        else if (pixel_index == 131 || pixel_index == 156 || pixel_index == 183 || pixel_index == 344 || pixel_index == 558) color_s3 = 16'b1100111001111001;
        else if (pixel_index == 144 || pixel_index == 281 || pixel_index == 339 || pixel_index == 343) color_s3 = 16'b0110101101001101;
        else if (pixel_index == 168 || pixel_index == 539) color_s3 = 16'b1010110101110101;
        else if (pixel_index == 193 || pixel_index == 415 || pixel_index == 442) color_s3 = 16'b1000110001010001;
        else if (pixel_index == 209 || pixel_index == 377) color_s3 = 16'b0111001110001110;
        else if (pixel_index == 235) color_s3 = 16'b0111101111001111;
        else if (pixel_index == 301 || pixel_index == 468 || pixel_index == 503 || pixel_index == 510 || pixel_index == 538) color_s3 = 16'b0100001000001000;
        else if (pixel_index == 307 || pixel_index == 351 || pixel_index == 554) color_s3 = 16'b1100011000111000;
        else if (pixel_index == 363) color_s3 = 16'b1011010110110110;
        else if (pixel_index == 370) color_s3 = 16'b0100101001001001;
        else if (pixel_index == 553) color_s3 = 16'b0101001010001010;
        else color_s3 = 0;
    end
    
    // --- Symbol 5 Logic ---
    always @(*) begin
       if (pixel_index == 27 || pixel_index == 91 || pixel_index == 105 || pixel_index == 126 || pixel_index == 337 || pixel_index == 382 || pixel_index == 586) color_s4 = 16'b0100001000001000;
        else if (((pixel_index >= 28) && (pixel_index <= 30)) || pixel_index == 46 || pixel_index == 85 || pixel_index == 97 || pixel_index == 132 || pixel_index == 587) color_s4 = 16'b0111001110001110;
        else if (pixel_index == 31 || pixel_index == 45 || pixel_index == 256) color_s4 = 16'b0110101101001101;
        else if (pixel_index == 32 || pixel_index == 127 || pixel_index == 146 || pixel_index == 157 || pixel_index == 286 || pixel_index == 341 || pixel_index == 372 || pixel_index == 440 || pixel_index == 516 || pixel_index == 539) color_s4 = 16'b0100101001001001;
        else if (pixel_index == 33 || pixel_index == 67 || pixel_index == 111 || pixel_index == 122 || pixel_index == 139 || pixel_index == 279 || pixel_index == 303 || pixel_index == 327 || pixel_index == 369 || pixel_index == 413 || pixel_index == 452) color_s4 = 16'b0001100011000011;
        else if (pixel_index == 44 || pixel_index == 161 || pixel_index == 186 || pixel_index == 316 || pixel_index == 367 || pixel_index == 397) color_s4 = 16'b0010100101000101;
        else if (pixel_index == 47 || pixel_index == 334 || ((pixel_index >= 346) && (pixel_index <= 347)) || pixel_index == 569) color_s4 = 16'b0010000100000100;
        else if (pixel_index == 51 || pixel_index == 182 || pixel_index == 312 || pixel_index == 467 || pixel_index == 538) color_s4 = 16'b0101001010001010;
        else if (((pixel_index >= 52) && (pixel_index <= 57)) || ((pixel_index >= 70) && (pixel_index <= 71)) || ((pixel_index >= 77) && (pixel_index <= 84)) || ((pixel_index >= 93) && (pixel_index <= 96)) || ((pixel_index >= 108) && (pixel_index <= 109)) || ((pixel_index >= 117) && (pixel_index <= 120)) || ((pixel_index >= 133) && (pixel_index <= 135)) || ((pixel_index >= 141) && (pixel_index <= 144)) || ((pixel_index >= 158) && (pixel_index <= 160)) || ((pixel_index >= 165) && (pixel_index <= 168)) || ((pixel_index >= 183) && (pixel_index <= 185)) || ((pixel_index >= 189) && (pixel_index <= 192)) || ((pixel_index >= 208) && (pixel_index <= 209)) || ((pixel_index >= 213) && (pixel_index <= 216)) || ((pixel_index >= 233) && (pixel_index <= 240)) || ((pixel_index >= 257) && (pixel_index <= 261)) || ((pixel_index >= 263) && (pixel_index <= 265)) || ((pixel_index >= 281) && (pixel_index <= 284)) || ((pixel_index >= 288) && (pixel_index <= 290)) || ((pixel_index >= 305) && (pixel_index <= 308)) || ((pixel_index >= 313) && (pixel_index <= 315)) || ((pixel_index >= 329) && (pixel_index <= 332)) || ((pixel_index >= 339) && (pixel_index <= 340)) || ((pixel_index >= 353) && (pixel_index <= 356)) || ((pixel_index >= 364) && (pixel_index <= 365)) || ((pixel_index >= 377) && (pixel_index <= 380)) || ((pixel_index >= 389) && (pixel_index <= 391)) || ((pixel_index >= 395) && (pixel_index <= 396)) || ((pixel_index >= 402) && (pixel_index <= 404)) || ((pixel_index >= 415) && (pixel_index <= 420)) || ((pixel_index >= 443) && (pixel_index <= 445)) || ((pixel_index >= 468) && (pixel_index <= 470)) || ((pixel_index >= 493) && (pixel_index <= 494)) || ((pixel_index >= 518) && (pixel_index <= 519)) || pixel_index == 536 || ((pixel_index >= 542) && (pixel_index <= 543)) || (pixel_index >= 561) && (pixel_index <= 567)) color_s4 = 16'b1111111111111111;
        else if (pixel_index == 58 || pixel_index == 110 || pixel_index == 121 || pixel_index == 169 || pixel_index == 262 || pixel_index == 357 || pixel_index == 371 || pixel_index == 442) color_s4 = 16'b1110011100111100;
        else if (pixel_index == 59 || pixel_index == 104 || pixel_index == 266 || pixel_index == 376 || pixel_index == 520) color_s4 = 16'b0110001100001100;
        else if (pixel_index == 68 || pixel_index == 72) color_s4 = 16'b1000110001010001;
        else if (pixel_index == 69 || pixel_index == 381 || ((pixel_index >= 393) && (pixel_index <= 394)) || pixel_index == 541) color_s4 = 16'b1110111101111101;
        else if (pixel_index == 76 || pixel_index == 101 || pixel_index == 429 || pixel_index == 540) color_s4 = 16'b0111101111001111;
        else if (pixel_index == 92 || pixel_index == 116 || pixel_index == 333 || pixel_index == 363 || pixel_index == 405 || pixel_index == 428) color_s4 = 16'b1101111011111011;
        else if (pixel_index == 102 || pixel_index == 107 || pixel_index == 145 || pixel_index == 210 || pixel_index == 338 || pixel_index == 392 || pixel_index == 427 || pixel_index == 517) color_s4 = 16'b1111011110111110;
        else if (pixel_index == 103 || pixel_index == 446) color_s4 = 16'b1010110101110101;
        else if (pixel_index == 106 || pixel_index == 188 || pixel_index == 388) color_s4 = 16'b1001010010110010;
        else if (pixel_index == 115 || pixel_index == 136 || pixel_index == 358 || pixel_index == 406 || pixel_index == 560) color_s4 = 16'b0011000110000110;
        else if (pixel_index == 140 || pixel_index == 212 || pixel_index == 421) color_s4 = 16'b1101011010111010;
        else if (pixel_index == 163 || pixel_index == 242 || pixel_index == 351 || pixel_index == 362 || pixel_index == 422 || pixel_index == 451 || pixel_index == 453 || pixel_index == 496 || pixel_index == 510) color_s4 = 16'b0000100001000001;
        else if (pixel_index == 164 || pixel_index == 309 || pixel_index == 414 || pixel_index == 568 || pixel_index == 588) color_s4 = 16'b1011110111110111;
        else if (pixel_index == 170 || pixel_index == 194 || pixel_index == 291 || pixel_index == 511 || pixel_index == 535 || pixel_index == 592) color_s4 = 16'b0011100111000111;
        else if (pixel_index == 193 || pixel_index == 304 || pixel_index == 401 || pixel_index == 495 || pixel_index == 589) color_s4 = 16'b1100111001111001;
        else if (pixel_index == 207 || pixel_index == 287 || pixel_index == 370 || pixel_index == 471) color_s4 = 16'b0101101011001011;
        else if (pixel_index == 211) color_s4 = 16'b1010010100110100;
        else if (pixel_index == 217 || pixel_index == 426 || pixel_index == 544) color_s4 = 16'b1001110011110011;
        else if (pixel_index == 218 || pixel_index == 310 || pixel_index == 368 || pixel_index == 430) color_s4 = 16'b0001000010000010;
        else if (pixel_index == 232 || pixel_index == 241 || pixel_index == 285 || pixel_index == 328 || pixel_index == 352 || pixel_index == 590) color_s4 = 16'b1100011000111000;
        else if (pixel_index == 280 || pixel_index == 366 || pixel_index == 441 || pixel_index == 537) color_s4 = 16'b1011010110110110;
        else if (pixel_index == 492 || pixel_index == 591) color_s4 = 16'b1000010000010000;
        else color_s4 = 0;
    end
    
    // --- Symbol 6 Logic ---
    always @(*) begin
       if (pixel_index == 45 || pixel_index == 184) color_s5 = 16'b0001100011000011;
        else if (pixel_index == 59 || pixel_index == 105 || pixel_index == 121 || pixel_index == 203 || pixel_index == 218 || pixel_index == 260 || pixel_index == 270 || pixel_index == 504 || pixel_index == 520) color_s5 = 16'b0000100001000001;
        else if (pixel_index == 60 || pixel_index == 143 || pixel_index == 191 || pixel_index == 228 || pixel_index == 283 || pixel_index == 332 || pixel_index == 371 || pixel_index == 432) color_s5 = 16'b0010100101000101;
        else if (pixel_index == 61 || pixel_index == 138 || pixel_index == 141 || pixel_index == 264 || pixel_index == 466 || pixel_index == 512 || pixel_index == 585) color_s5 = 16'b0011100111000111;
        else if (((pixel_index >= 62) && (pixel_index <= 66)) || pixel_index == 259 || pixel_index == 428 || pixel_index == 557) color_s5 = 16'b0101001010001010;
        else if (pixel_index == 67 || pixel_index == 185 || pixel_index == 483) color_s5 = 16'b0110101101001101;
        else if (pixel_index == 68 || pixel_index == 303 || pixel_index == 307 || pixel_index == 328 || pixel_index == 519) color_s5 = 16'b1000010000010000;
        else if (pixel_index == 69 || pixel_index == 120 || pixel_index == 381) color_s5 = 16'b1011010110110110;
        else if (pixel_index == 70 || pixel_index == 84 || pixel_index == 134 || pixel_index == 182 || pixel_index == 235) color_s5 = 16'b1101011010111010;
        else if (pixel_index == 71 || pixel_index == 96 || pixel_index == 144 || pixel_index == 159 || pixel_index == 290 || pixel_index == 346 || pixel_index == 446 || pixel_index == 453) color_s5 = 16'b0001000010000010;
        else if (pixel_index == 82 || pixel_index == 586 || pixel_index == 588) color_s5 = 16'b0100101001001001;
        else if (pixel_index == 83 || pixel_index == 106 || pixel_index == 179 || pixel_index == 189 || pixel_index == 208 || pixel_index == 457 || pixel_index == 470) color_s5 = 16'b1001110011110011;
        else if (pixel_index == 85 || pixel_index == 155 || pixel_index == 209 || pixel_index == 216 || pixel_index == 239 || pixel_index == 331 || pixel_index == 431 || pixel_index == 515) color_s5 = 16'b1111011110111110;
        else if (((pixel_index >= 86) && (pixel_index <= 94)) || ((pixel_index >= 107) && (pixel_index <= 117)) || ((pixel_index >= 131) && (pixel_index <= 133)) || ((pixel_index >= 156) && (pixel_index <= 157)) || ((pixel_index >= 180) && (pixel_index <= 181)) || ((pixel_index >= 205) && (pixel_index <= 206)) || ((pixel_index >= 210) && (pixel_index <= 215)) || ((pixel_index >= 230) && (pixel_index <= 234)) || ((pixel_index >= 240) && (pixel_index <= 242)) || ((pixel_index >= 254) && (pixel_index <= 257)) || ((pixel_index >= 266) && (pixel_index <= 268)) || ((pixel_index >= 279) && (pixel_index <= 281)) || ((pixel_index >= 292) && (pixel_index <= 294)) || ((pixel_index >= 304) && (pixel_index <= 306)) || ((pixel_index >= 317) && (pixel_index <= 319)) || ((pixel_index >= 329) && (pixel_index <= 330)) || ((pixel_index >= 343) && (pixel_index <= 344)) || ((pixel_index >= 354) && (pixel_index <= 355)) || ((pixel_index >= 368) && (pixel_index <= 370)) || ((pixel_index >= 379) && (pixel_index <= 380)) || ((pixel_index >= 393) && (pixel_index <= 395)) || ((pixel_index >= 404) && (pixel_index <= 405)) || ((pixel_index >= 418) && (pixel_index <= 419)) || ((pixel_index >= 429) && (pixel_index <= 430)) || ((pixel_index >= 443) && (pixel_index <= 444)) || ((pixel_index >= 455) && (pixel_index <= 456)) || ((pixel_index >= 467) && (pixel_index <= 469)) || ((pixel_index >= 480) && (pixel_index <= 482)) || ((pixel_index >= 492) && (pixel_index <= 494)) || ((pixel_index >= 506) && (pixel_index <= 508)) || ((pixel_index >= 516) && (pixel_index <= 518)) || ((pixel_index >= 532) && (pixel_index <= 541)) || (pixel_index >= 560) && (pixel_index <= 564)) color_s5 = 16'b1111111111111111;
        else if (pixel_index == 95 || pixel_index == 118 || pixel_index == 229 || pixel_index == 282 || pixel_index == 420 || pixel_index == 542 || pixel_index == 559 || pixel_index == 565) color_s5 = 16'b1110111101111101;
        else if (pixel_index == 119 || pixel_index == 345 || pixel_index == 445 || pixel_index == 454) color_s5 = 16'b1110011100111100;
        else if (pixel_index == 130 || pixel_index == 367 || pixel_index == 543) color_s5 = 16'b1000110001010001;
        else if (pixel_index == 135 || pixel_index == 353) color_s5 = 16'b1010010100110100;
        else if (pixel_index == 136 || pixel_index == 190 || pixel_index == 392) color_s5 = 16'b0111101111001111;
        else if (pixel_index == 137 || ((pixel_index >= 139) && (pixel_index <= 140)) || pixel_index == 142 || pixel_index == 154 || pixel_index == 316 || pixel_index == 396) color_s5 = 16'b0011000110000110;
        else if (pixel_index == 158 || pixel_index == 186 || pixel_index == 217 || pixel_index == 417 || pixel_index == 514) color_s5 = 16'b1001010010110010;
        else if (((pixel_index >= 187) && (pixel_index <= 188)) || pixel_index == 291 || pixel_index == 320 || pixel_index == 378 || pixel_index == 566) color_s5 = 16'b1010110101110101;
        else if (pixel_index == 204 || pixel_index == 258 || pixel_index == 491) color_s5 = 16'b1101111011111011;
        else if (pixel_index == 207 || pixel_index == 243 || pixel_index == 265 || pixel_index == 269 || pixel_index == 356 || pixel_index == 505 || pixel_index == 509 || pixel_index == 531 || pixel_index == 558) color_s5 = 16'b1011110111110111;
        else if (pixel_index == 236 || pixel_index == 342 || pixel_index == 406 || pixel_index == 442) color_s5 = 16'b1100011000111000;
        else if ((pixel_index >= 237) && (pixel_index <= 238)) color_s5 = 16'b1100111001111001;
        else if (pixel_index == 244 || pixel_index == 421 || pixel_index == 530 || pixel_index == 584 || pixel_index == 590) color_s5 = 16'b0010000100000100;
        else if (pixel_index == 253 || pixel_index == 295) color_s5 = 16'b0101101011001011;
        else if (pixel_index == 278 || pixel_index == 403 || pixel_index == 510) color_s5 = 16'b0110001100001100;
        else if (pixel_index == 479) color_s5 = 16'b0111001110001110;
        else if (pixel_index == 490 || pixel_index == 495 || pixel_index == 511 || pixel_index == 513 || pixel_index == 567 || pixel_index == 587 || pixel_index == 589) color_s5 = 16'b0100001000001000;
        else color_s5 = 0; 
    end

    // --- Symbol 7 Logic ---
    always @(*) begin
      if (pixel_index == 12 || pixel_index == 114 || pixel_index == 163 || pixel_index == 235 || pixel_index == 239 || pixel_index == 252 || pixel_index == 305 || pixel_index == 383 || pixel_index == 455 || pixel_index == 461 || pixel_index == 557 || pixel_index == 593) color_s6 = 16'b0001000010000010;
        else if (pixel_index == 36 || pixel_index == 110 || ((pixel_index >= 227) && (pixel_index <= 229)) || ((pixel_index >= 245) && (pixel_index <= 247)) || pixel_index == 274 || pixel_index == 432 || ((pixel_index >= 462) && (pixel_index <= 463)) || ((pixel_index >= 532) && (pixel_index <= 533)) || pixel_index == 556) color_s6 = 16'b0011000110000110;
        else if (pixel_index == 37) color_s6 = 16'b1100011000111000;
        else if (pixel_index == 38 || pixel_index == 87 || pixel_index == 161 || pixel_index == 190 || pixel_index == 256 || pixel_index == 258 || ((pixel_index >= 266) && (pixel_index <= 267)) || pixel_index == 295 || pixel_index == 342 || pixel_index == 345 || pixel_index == 355 || pixel_index == 358 || pixel_index == 418 || pixel_index == 484 || pixel_index == 487 || pixel_index == 490 || pixel_index == 517 || pixel_index == 531 || pixel_index == 534 || pixel_index == 540 || pixel_index == 543) color_s6 = 16'b0000100001000001;
        else if (((pixel_index >= 61) && (pixel_index <= 62)) || pixel_index == 135 || ((pixel_index >= 232) && (pixel_index <= 233)) || ((pixel_index >= 241) && (pixel_index <= 242)) || pixel_index == 251 || pixel_index == 277 || pixel_index == 554) color_s6 = 16'b0110001100001100;
        else if (pixel_index == 63 || pixel_index == 184 || pixel_index == 272 || pixel_index == 319 || pixel_index == 321 || pixel_index == 366 || pixel_index == 485 || pixel_index == 488 || pixel_index == 567 || pixel_index == 595) color_s6 = 16'b0010100101000101;
        else if (pixel_index == 85 || pixel_index == 276 || pixel_index == 329 || pixel_index == 467 || pixel_index == 494 || pixel_index == 506 || pixel_index == 510 || pixel_index == 516 || pixel_index == 529 || pixel_index == 570) color_s6 = 16'b0001100011000011;
        else if (pixel_index == 86 || pixel_index == 249 || pixel_index == 330 || pixel_index == 343 || pixel_index == 468 || pixel_index == 530 || pixel_index == 594) color_s6 = 16'b0110101101001101;
        else if (pixel_index == 88 || pixel_index == 164 || pixel_index == 226 || pixel_index == 250 || pixel_index == 296 || pixel_index == 331 || pixel_index == 344 || pixel_index == 442 || pixel_index == 481 || pixel_index == 555) color_s6 = 16'b0101001010001010;
        else if (pixel_index == 111 || pixel_index == 189 || pixel_index == 489 || pixel_index == 515 || pixel_index == 519 || pixel_index == 544 || pixel_index == 568 || pixel_index == 580) color_s6 = 16'b0100101001001001;
        else if (pixel_index == 113 || pixel_index == 231 || pixel_index == 243 || pixel_index == 304 || pixel_index == 320 || pixel_index == 356 || pixel_index == 579) color_s6 = 16'b0101101011001011;
        else if (pixel_index == 136 || pixel_index == 486 || pixel_index == 508 || pixel_index == 514) color_s6 = 16'b0010000100000100;
        else if (((pixel_index >= 138) && (pixel_index <= 139)) || ((pixel_index >= 214) && (pixel_index <= 215)) || pixel_index == 230 || pixel_index == 244 || pixel_index == 278 || pixel_index == 368 || pixel_index == 391 || pixel_index == 406 || (pixel_index >= 541) && (pixel_index <= 542)) color_s6 = 16'b0011100111000111;
        else if (pixel_index == 160 || pixel_index == 209 || pixel_index == 248 || pixel_index == 273 || pixel_index == 456) color_s6 = 16'b0111101111001111;
        else if (pixel_index == 185 || pixel_index == 240 || pixel_index == 357 || pixel_index == 392 || pixel_index == 407 || pixel_index == 493) color_s6 = 16'b0111001110001110;
        else if (pixel_index == 210 || pixel_index == 297 || pixel_index == 303 || pixel_index == 443 || pixel_index == 480 || pixel_index == 509 || pixel_index == 518) color_s6 = 16'b0100001000001000;
        else if (pixel_index == 225 || pixel_index == 234 || pixel_index == 382) color_s6 = 16'b1000110001010001;
        else if (pixel_index == 367) color_s6 = 16'b1001010010110010;
        else if (pixel_index == 417 || pixel_index == 431 || pixel_index == 505) color_s6 = 16'b1000010000010000;
        else if (pixel_index == 569) color_s6 = 16'b1010010100110100;
        else color_s6 = 0;  
    end
    
    // --- Symbol 8 Logic ---
    always @(*) begin
       if (pixel_index == 83 || pixel_index == 85 || pixel_index == 116 || pixel_index == 286 || pixel_index == 318 || pixel_index == 343 || ((pixel_index >= 557) && (pixel_index <= 559)) || (pixel_index >= 561) && (pixel_index <= 562)) color_s7 = 16'b0010100101000101;
        else if (pixel_index == 84 || pixel_index == 86 || pixel_index == 156 || pixel_index == 560) color_s7 = 16'b0011000110000110;
        else if (pixel_index == 102 || ((pixel_index >= 228) && (pixel_index <= 229)) || pixel_index == 337 || pixel_index == 398 || pixel_index == 481 || pixel_index == 519 || pixel_index == 527 || pixel_index == 542 || pixel_index == 563) color_s7 = 16'b0001100011000011;
        else if (pixel_index == 103 || pixel_index == 180 || pixel_index == 298 || pixel_index == 373) color_s7 = 16'b0110001100001100;
        else if (pixel_index == 104 || pixel_index == 191 || pixel_index == 442 || pixel_index == 455) color_s7 = 16'b1000010000010000;
        else if (pixel_index == 105 || pixel_index == 422 || pixel_index == 507 || pixel_index == 528) color_s7 = 16'b1001110011110011;
        else if (((pixel_index >= 106) && (pixel_index <= 107)) || pixel_index == 137 || pixel_index == 243 || pixel_index == 512 || pixel_index == 529) color_s7 = 16'b1100011000111000;
        else if (((pixel_index >= 108) && (pixel_index <= 111)) || ((pixel_index >= 128) && (pixel_index <= 131)) || ((pixel_index >= 139) && (pixel_index <= 140)) || ((pixel_index >= 153) && (pixel_index <= 154)) || ((pixel_index >= 166) && (pixel_index <= 168)) || ((pixel_index >= 178) && (pixel_index <= 179)) || ((pixel_index >= 192) && (pixel_index <= 194)) || ((pixel_index >= 218) && (pixel_index <= 220)) || ((pixel_index >= 244) && (pixel_index <= 246)) || ((pixel_index >= 270) && (pixel_index <= 271)) || ((pixel_index >= 295) && (pixel_index <= 297)) || pixel_index == 310 || ((pixel_index >= 320) && (pixel_index <= 322)) || pixel_index == 335 || ((pixel_index >= 345) && (pixel_index <= 347)) || ((pixel_index >= 370) && (pixel_index <= 372)) || ((pixel_index >= 395) && (pixel_index <= 396)) || ((pixel_index >= 419) && (pixel_index <= 421)) || ((pixel_index >= 443) && (pixel_index <= 445)) || ((pixel_index >= 453) && (pixel_index <= 454)) || ((pixel_index >= 468) && (pixel_index <= 469)) || ((pixel_index >= 478) && (pixel_index <= 479)) || ((pixel_index >= 492) && (pixel_index <= 493)) || ((pixel_index >= 503) && (pixel_index <= 505)) || ((pixel_index >= 514) && (pixel_index <= 516)) || (pixel_index >= 532) && (pixel_index <= 537)) color_s7 = 16'b1111111111111111;
        else if (pixel_index == 112 || pixel_index == 132) color_s7 = 16'b1101011010111010;
        else if (pixel_index == 113 || pixel_index == 136 || pixel_index == 165 || pixel_index == 169) color_s7 = 16'b1011110111110111;
        else if (pixel_index == 114 || ((pixel_index >= 134) && (pixel_index <= 135)) || pixel_index == 540) color_s7 = 16'b1001010010110010;
        else if (pixel_index == 115 || pixel_index == 323 || pixel_index == 348) color_s7 = 16'b0111001110001110;
        else if (pixel_index == 127 || pixel_index == 152 || pixel_index == 164 || pixel_index == 177 || pixel_index == 205 || pixel_index == 309 || pixel_index == 334 || pixel_index == 430 || pixel_index == 452 || pixel_index == 477 || pixel_index == 495 || pixel_index == 502 || pixel_index == 510) color_s7 = 16'b0101001010001010;
        else if (pixel_index == 133) color_s7 = 16'b1011010110110110;
        else if (pixel_index == 138 || pixel_index == 141 || pixel_index == 195 || ((pixel_index >= 203) && (pixel_index <= 204)) || pixel_index == 272 || pixel_index == 311 || pixel_index == 336 || pixel_index == 429 || pixel_index == 467) color_s7 = 16'b1110111101111101;
        else if (pixel_index == 142 || pixel_index == 490) color_s7 = 16'b1010110101110101;
        else if (pixel_index == 143 || pixel_index == 466) color_s7 = 16'b0101101011001011;
        else if (pixel_index == 144 || pixel_index == 190 || pixel_index == 227 || pixel_index == 293 || pixel_index == 402 || pixel_index == 488 || pixel_index == 555 || pixel_index == 564) color_s7 = 16'b0000100001000001;
        else if (pixel_index == 155 || pixel_index == 418 || pixel_index == 506 || pixel_index == 539) color_s7 = 16'b1100111001111001;
        else if (pixel_index == 163 || pixel_index == 222 || pixel_index == 273 || pixel_index == 312 || pixel_index == 361 || ((pixel_index >= 403) && (pixel_index <= 404)) || pixel_index == 447 || pixel_index == 556) color_s7 = 16'b0010000100000100;
        else if (pixel_index == 170 || pixel_index == 268 || pixel_index == 360 || pixel_index == 489 || pixel_index == 541) color_s7 = 16'b0011100111000111;
        else if (pixel_index == 196 || pixel_index == 285 || pixel_index == 471 || pixel_index == 509) color_s7 = 16'b0100001000001000;
        else if (pixel_index == 202 || pixel_index == 393 || pixel_index == 427) color_s7 = 16'b0100101001001001;
        else if (pixel_index == 217) color_s7 = 16'b1000110001010001;
        else if (pixel_index == 221 || pixel_index == 494 || pixel_index == 513 || pixel_index == 517 || pixel_index == 530) color_s7 = 16'b1101111011111011;
        else if (pixel_index == 242 || pixel_index == 368 || pixel_index == 417) color_s7 = 16'b0001000010000010;
        else if (pixel_index == 247 || pixel_index == 511) color_s7 = 16'b1010010100110100;
        else if (pixel_index == 269 || pixel_index == 319 || pixel_index == 344 || pixel_index == 394 || pixel_index == 428 || pixel_index == 470 || pixel_index == 491 || pixel_index == 531 || pixel_index == 538) color_s7 = 16'b1111011110111110;
        else if (pixel_index == 294 || pixel_index == 369 || pixel_index == 397 || pixel_index == 446 || pixel_index == 480) color_s7 = 16'b1110011100111100;
        else if (pixel_index == 508) color_s7 = 16'b0111101111001111;
        else if (pixel_index == 518) color_s7 = 16'b0110101101001101;
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