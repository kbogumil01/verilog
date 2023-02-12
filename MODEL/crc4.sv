module crc4(i_data, i_poly, i_crc, o_crc);
    parameter WCODE = 9;    // parametry modulu
    parameter WPOLY = 5;
    input logic [WCODE-1:0]  i_data;
    input logic [WPOLY-1:0]  i_poly;
    input logic [WPOLY-2:0]  i_crc;
    output logic [WPOLY-2:0] o_crc;
    // lokalny parametr - nie dostepny poza 
    localparam LEN = WCODE+WPOLY-1; // modulem crc

    logic [LEN-1:0] crc_tmp;  // sygnaly wewnetrzne
    logic [LEN-1:0] poly_tmp; //   pomocnicze 
    always @(*)
    begin
        {o_crc, crc_tmp, poly_tmp}  = '0;

        crc_tmp     = {i_data, i_crc};
        poly_tmp    = {i_poly, {(WCODE-1){1'b0}}};

        for (int i=WCODE-1; i >= 0; i--)
        begin : LOOP
            if (crc_tmp[i+4] == 1'b1)
                    crc_tmp = crc_tmp ^ poly_tmp;
        poly_tmp = poly_tmp >> 1;
        end : LOOP
        o_crc = crc_tmp[WPOLY-2:0];
    end
endmodule
