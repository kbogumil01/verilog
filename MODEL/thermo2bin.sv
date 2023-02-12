module thermo2bin(i_thermo, o_nkb);
    parameter LEN = 4;
    input logic  [LEN-1:0] i_thermo;
    output logic [LEN-1:0] o_nkb;

    always @(*)
    begin
        o_nkb = '0;
        for (int i=0; i < LEN; i++)
            if (i_thermo[i] == 1'b1)
                o_nkb = i;
    end
endmodule
