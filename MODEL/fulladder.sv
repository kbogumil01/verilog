module fulladder( i_a, i_b, o_sum, o_carry);
    parameter BITS = 4;
    input  logic [BITS-1:0] i_a, i_b;
    output logic [BITS-1:0] o_sum;
    output logic            o_carry; //przeniesienie
    
    
    always @(*)
    begin

        o_sum = i_a + i_b;
        
        if(((i_a[BITS-1]==0 & i_b[BITS-1]==0) & o_sum[BITS-1]==1)|((i_a[BITS-1]==1 & i_b[BITS-1]==1) & o_sum[BITS-1]==0))
        begin
            o_carry=1;
        end
        
        // else ((i_a[BITS-1]==1 & i_b[BITS-1]==1) & o_sum[BITS-1]==0)
        // begin
        //     o_carry=1;
        // end
        
        else
        begin
            o_carry=0;
        end

        
    end
endmodule