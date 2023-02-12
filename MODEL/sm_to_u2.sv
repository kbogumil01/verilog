module sm_to_u2 (i_input, o_output);
parameter BITS=3;
input logic [BITS-1:0] i_input;
output logic [BITS-1:0] o_output;

always @(*)
    begin
        if (i_input[BITS-1]==0)
        begin
            o_output=i_input;
        end

        else
        begin
            o_output={i_input[BITS-1],(~(i_input[BITS-2:0])+1'b1)};
        end
    end    
endmodule
