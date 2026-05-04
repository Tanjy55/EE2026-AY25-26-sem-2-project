`timescale 1ns / 1ps

module char_rom (
    input [5:0] char_id,    // 6 bits = 64 possible characters
    input [2:0] local_x,    // 0-7
    input [2:0] local_y,    // 0-7
    output pixel_on
);
    reg [7:0] bitmap [0:511]; 

    initial begin
        // ID 0: Space
        bitmap[0]=8'h00; bitmap[1]=8'h00; bitmap[2]=8'h00; bitmap[3]=8'h00;
        bitmap[4]=8'h00; bitmap[5]=8'h00; bitmap[6]=8'h00; bitmap[7]=8'h00;

        // ID 1: B, ID 2: T, ID 3: N, ID 4: U (Already defined)
        bitmap[8]=8'hF0; bitmap[9]=8'h88; bitmap[10]=8'h88; bitmap[11]=8'hF0; bitmap[12]=8'h88; bitmap[13]=8'h88; bitmap[14]=8'hF0; bitmap[15]=8'h00;
        bitmap[16]=8'hF8; bitmap[17]=8'h20; bitmap[18]=8'h20; bitmap[19]=8'h20; bitmap[20]=8'h20; bitmap[21]=8'h20; bitmap[22]=8'h20; bitmap[23]=8'h00;
        bitmap[24]=8'h88; bitmap[25]=8'hC8; bitmap[26]=8'hA8; bitmap[27]=8'h98; bitmap[28]=8'h88; bitmap[29]=8'h88; bitmap[30]=8'h88; bitmap[31]=8'h00;
        bitmap[32]=8'h88; bitmap[33]=8'h88; bitmap[34]=8'h88; bitmap[35]=8'h88; bitmap[36]=8'h88; bitmap[37]=8'h88; bitmap[38]=8'h70; bitmap[39]=8'h00;

        // ID 5: P, ID 6: R, ID 7: E, ID 8: S, ID 9: C, ID 10: O, ID 11: D (Already defined)
        bitmap[40]=8'hF0; bitmap[41]=8'h88; bitmap[42]=8'h88; bitmap[43]=8'hF0; bitmap[44]=8'h80; bitmap[45]=8'h80; bitmap[46]=8'h80; bitmap[47]=8'h00;
        bitmap[48]=8'hF0; bitmap[49]=8'h88; bitmap[50]=8'h88; bitmap[51]=8'hF0; bitmap[52]=8'hA0; bitmap[53]=8'h90; bitmap[54]=8'h88; bitmap[55]=8'h00;
        bitmap[56]=8'hF8; bitmap[57]=8'h80; bitmap[58]=8'h80; bitmap[59]=8'hF0; bitmap[60]=8'h80; bitmap[61]=8'h80; bitmap[62]=8'hF8; bitmap[63]=8'h00;
        bitmap[64]=8'h78; bitmap[65]=8'h80; bitmap[66]=8'h80; bitmap[67]=8'h70; bitmap[68]=8'h08; bitmap[69]=8'h08; bitmap[70]=8'hF0; bitmap[71]=8'h00;
        bitmap[72]=8'h78; bitmap[73]=8'h80; bitmap[74]=8'h80; bitmap[75]=8'h80; bitmap[76]=8'h80; bitmap[77]=8'h80; bitmap[78]=8'h78; bitmap[79]=8'h00;
        bitmap[80]=8'h70; bitmap[81]=8'h88; bitmap[82]=8'h88; bitmap[83]=8'h88; bitmap[84]=8'h88; bitmap[85]=8'h88; bitmap[86]=8'h70; bitmap[87]=8'h00;
        bitmap[88]=8'hE0; bitmap[89]=8'h90; bitmap[90]=8'h88; bitmap[91]=8'h88; bitmap[92]=8'h88; bitmap[93]=8'h90; bitmap[94]=8'hE0; bitmap[95]=8'h00;

        // ID 12: A
        bitmap[96]=8'h20; bitmap[97]=8'h50; bitmap[98]=8'h88; bitmap[99]=8'h88; bitmap[100]=8'hF8; bitmap[101]=8'h88; bitmap[102]=8'h88; bitmap[103]=8'h00;
        // ID 13: F
        bitmap[104]=8'hF8; bitmap[105]=8'h80; bitmap[106]=8'h80; bitmap[107]=8'hF0; bitmap[108]=8'h80; bitmap[109]=8'h80; bitmap[110]=8'h80; bitmap[111]=8'h00;
        // ID 14: G
        bitmap[112]=8'h78; bitmap[113]=8'h80; bitmap[114]=8'h80; bitmap[115]=8'hB8; bitmap[116]=8'h88; bitmap[117]=8'h88; bitmap[118]=8'h78; bitmap[119]=8'h00;
        // ID 15: H
        bitmap[120]=8'h88; bitmap[121]=8'h88; bitmap[122]=8'h88; bitmap[123]=8'hF8; bitmap[124]=8'h88; bitmap[125]=8'h88; bitmap[126]=8'h88; bitmap[127]=8'h00;
        // ID 16: I
        bitmap[128]=8'h70; bitmap[129]=8'h20; bitmap[130]=8'h20; bitmap[131]=8'h20; bitmap[132]=8'h20; bitmap[133]=8'h20; bitmap[134]=8'h70; bitmap[135]=8'h00;
        // ID 17: J
        bitmap[136]=8'h38; bitmap[137]=8'h10; bitmap[138]=8'h10; bitmap[139]=8'h10; bitmap[140]=8'h10; bitmap[141]=8'h90; bitmap[142]=8'h60; bitmap[143]=8'h00;
        // ID 18: K
        bitmap[144]=8'h88; bitmap[145]=8'h90; bitmap[146]=8'hA0; bitmap[147]=8'hC0; bitmap[148]=8'hA0; bitmap[149]=8'h90; bitmap[150]=8'h88; bitmap[151]=8'h00;
        // ID 19: L
        bitmap[152]=8'h80; bitmap[153]=8'h80; bitmap[154]=8'h80; bitmap[155]=8'h80; bitmap[156]=8'h80; bitmap[157]=8'h80; bitmap[158]=8'hF8; bitmap[159]=8'h00;
        // ID 20: M
        bitmap[160]=8'h88; bitmap[161]=8'hD8; bitmap[162]=8'hA8; bitmap[163]=8'h88; bitmap[164]=8'h88; bitmap[165]=8'h88; bitmap[166]=8'h88; bitmap[167]=8'h00;
        // ID 21: Q
        bitmap[168]=8'h70; bitmap[169]=8'h88; bitmap[170]=8'h88; bitmap[171]=8'h88; bitmap[172]=8'hA8; bitmap[173]=8'h90; bitmap[174]=8'h68; bitmap[175]=8'h00;
        // ID 22: V
        bitmap[176]=8'h88; bitmap[177]=8'h88; bitmap[178]=8'h88; bitmap[179]=8'h88; bitmap[180]=8'h88; bitmap[181]=8'h50; bitmap[182]=8'h20; bitmap[183]=8'h00;
        // ID 23: W
        bitmap[184]=8'h88; bitmap[185]=8'h88; bitmap[186]=8'h88; bitmap[187]=8'hA8; bitmap[188]=8'hA8; bitmap[189]=8'hA8; bitmap[190]=8'h50; bitmap[191]=8'h00;
        // ID 24: X
        bitmap[192]=8'h88; bitmap[193]=8'h88; bitmap[194]=8'h50; bitmap[195]=8'h20; bitmap[196]=8'h50; bitmap[197]=8'h88; bitmap[198]=8'h88; bitmap[199]=8'h00;
        // ID 25: Y
        bitmap[200]=8'h88; bitmap[201]=8'h88; bitmap[202]=8'h50; bitmap[203]=8'h20; bitmap[204]=8'h20; bitmap[205]=8'h20; bitmap[206]=8'h20; bitmap[207]=8'h00;
        // ID 26: Z
        bitmap[208]=8'hF8; bitmap[209]=8'h08; bitmap[210]=8'h10; bitmap[211]=8'h20; bitmap[212]=8'h40; bitmap[213]=8'h80; bitmap[214]=8'hF8; bitmap[215]=8'h00;
        
        // ID 27: ? (Question Mark)
        bitmap[216]=8'h70; bitmap[217]=8'h88; bitmap[218]=8'h08; bitmap[219]=8'h30;
        bitmap[220]=8'h20; bitmap[221]=8'h00; bitmap[222]=8'h20; bitmap[223]=8'h00;
    end

    assign pixel_on = bitmap[(char_id * 8) + local_y][7 - local_x];

endmodule