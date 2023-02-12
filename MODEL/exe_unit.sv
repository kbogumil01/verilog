module exe_unit (i_argA, i_argB, i_oper, o_result, o_vf, o_pf, o_nf, o_of);
parameter M=9; //aby wszystkie moduly dzialaly poprawnie, nalezy ustawic M>=9 (nieaktualne)
parameter N=4; //12 operacji - 4bitowe wejscie
input logic [M-1:0] i_argA, i_argB;
input logic [N-1:0] i_oper;
output logic [M-1:0] o_result;
output logic o_vf; //znacznik przepelnienia
output logic o_pf; //znacznik dopelnienia do parzystej ilosci jedynek
output logic o_nf; //znacznik dopelnienia do nieparzystej ilosci jedynek
output logic o_of; //znacznik informujacy ze wynikiem jest '1

logic [M-1:0] s_adder;
logic s_adder_vf;
fulladder #(.BITS(M))
u_fulladder(
    .i_a(i_argA),
    .i_b(i_argB),
    .o_sum(s_adder),
    .o_carry(s_adder_vf)   
    );


logic [M-1:0] s_u2tou1;//instancja u2 na u1
logic s_u2tou1_ovf;
u2tou1 #(.BITS(M))
u_u2tou1(
    .i_input(i_argA),
    .o_output(s_u2tou1),
    .o_overflow(s_u2tou1_ovf)
    );

logic [M-1:0] s_smtou2; //instancja znak modul na u2
sm_to_u2 #(.BITS(M))
u_sm_to_u2(
    .i_input(i_argA),
    .o_output(s_smtou2)
);

logic [M-1:0] s_count; //instancja licznika zer
logic s_count_vf;
count_0 #(.BITS(M))
u_count_0(
    .i_input1(i_argA),
    .i_input2(i_argB),
    .o_output(s_count),
    .o_overflow(s_count_vf)
);

logic [2:0] s_crc3; //wyznaczanie crc_3
crc3#(.WCODE(M), .WPOLY(4))
u_crc_3(
    .i_data(i_argA), //ciag znakow wejsciowych
    .i_poly(i_argB[3:0]), //4-bitowy wielomian
    .i_crc(3'b000), //3 bity wyzerowane dolaczone do i_data
    .o_crc(s_crc3)
);

logic [3:0] s_crc4; //wyznaczanie crc_4
crc4#(.WCODE(M), .WPOLY(5))
u_crc_4(
    .i_data(i_argA),
    .i_poly(i_argB[4:0]), //5-bitowy wielomian
    .i_crc(4'b0000), //4 bity wyzerowane
    .o_crc(s_crc4)
);

logic[M-1:0] s_thermo; //thermo to binary
thermo2bin#(.LEN(M))
u_thermo2bin(
    .i_thermo(i_argA),
    .o_nkb(s_thermo)
);

logic[M-1:0] s_onehot; //binary to one hot
logic s_onehot_vf;
binary2onehot#(.BITS(M))
u_binary2onehot(
    .i_nkb(i_argA),
    .o_onehot(s_onehot),
    .o_overflow(s_onehot_vf)
);

logic s_pf; //instancja modulu- flaga pf, uzupelnienie do parzystej liczby jedynek
logic s_nf; //instancja modulu- flaga nf, uzupelnienie do nieparzystej liczby jedynek
pf_nf#(.BITS(M))
u_pf_nf(
    .i_input(o_result),
    .o_pf(s_pf),
    .o_nf(s_nf)
);

logic[M-1:0] s_arythm_shift;
arythm_shift#(.BITS(M))
u_arythm_shift(
    .i_a(i_argA),
    .i_b(i_argB),
    .o_output(s_arythm_shift)
);


always @(*)//multiplexer
    begin
        case (i_oper)
            4'd0: o_result= s_adder; //dodawanie
            4'd1: o_result= i_argA|i_argB; //or
            4'd2: o_result= ~(i_argA|i_argB); //nor
            4'd3: o_result= s_arythm_shift; //arytm. przesuniecie w prawo o i_argB bitow
            4'd4: o_result= (i_argA >> i_argB);  //log. przesuniecie w prawo o i_argB bitow
            4'd5: o_result= s_u2tou1; //konwersja u2 na u1 
            4'd6: o_result= s_smtou2; //konwersja znak-modul na u2 
            4'd7: o_result= s_crc3; //wyznaczanie kodu crc 3
            4'd8: o_result= s_crc4; //wyznaczanie kodu crc 4
            4'd9: o_result= s_count; //zliczanie zer 
            4'd10: o_result= s_thermo; //thermo to nkb 
            4'd11: o_result= s_onehot; // nkb to one-hot

            default: o_result='d0;
        endcase

        case (i_oper) //przepelnienie -flaga vf
            4'd0: o_vf=s_adder_vf; //dodawanie
            4'd5: o_vf=s_u2tou1_ovf; //konwersja u2 na u1 
            4'd9: o_vf=s_count_vf; //zliczanie zer 
            4'd11: o_vf=s_onehot_vf; //nkb to one hot
            default: o_vf=0;
        endcase

        
        
        o_pf=s_pf; //dopelnienie do parzystej ilosci jedynek
        o_nf=s_nf; //dopelnienie do nieparzystej ilosci jedynek

        if(o_result=='1) //informacja, ze wszystie bity wyjscia maja wartosc 1
        begin
            o_of=1;
        end
        else
        begin
            o_of=0;
        end

    end
endmodule    
