module u2tou1 (i_input, o_output, o_overflow);
parameter BITS=3;
input logic [BITS-1:0] i_input;
output logic [BITS-1:0] o_output;
output logic o_overflow;

always @(*)
    begin
        if (i_input[BITS-1]==0) 
        begin
            o_output=i_input;
        end
        
        else
        begin
            o_output= (i_input -1'b1);
        end

    if(i_input[BITS-1]==1 & i_input[BITS-2:0]=='0)
    begin
        o_overflow=1'b1;
    end
    else
    begin
        o_overflow=1'b0;
    end

    end
endmodule    
