module arythm_shift(i_a, i_b, o_output);
parameter BITS=8;
input logic signed [BITS-1:0] i_a, i_b;
output logic signed [BITS-1:0] o_output;

always @(*)
    begin

        o_output=(i_a>>>i_b);

    end
endmodule