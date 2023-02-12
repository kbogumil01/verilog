module binary2onehot(i_nkb, o_onehot, o_overflow);
    parameter BITS=9;
    input logic  [BITS-1:0] i_nkb;
    output logic [BITS-1:0]  o_onehot;
    output logic o_overflow;

    always @(*)
    begin
        o_onehot = '0;
        o_overflow= '0;
        if(i_nkb>BITS-1) o_overflow='1;
        else o_overflow='0;
        
        for (int i=0; i < BITS; i++)
            if (i == i_nkb)
                o_onehot[i] = '1;
    end

endmodule
