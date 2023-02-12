module count_0 (i_input1, i_input2, o_output, o_overflow);
parameter BITS=3;
input logic [BITS-1:0] i_input1, i_input2;
output logic [BITS-1:0] o_output;
output logic o_overflow;

logic [BITS-1:0] s_counter1, s_counter2;

always @(*)
    begin
        s_counter1='d0;
        s_counter2='d0;
        for(int i=0; i<BITS; i++)
        begin: LOOP
        if(i_input1[i]=='b0)
        begin
            s_counter1=s_counter1 +'d1;
        end
        else
        begin
            s_counter1=s_counter1 + 'd0;
        end
        
        end:LOOP

        for(int j=0; j<BITS; j++)
        begin: LOOP
        if(i_input2[j]=='b0)
        begin
            s_counter2=s_counter2+ 'd1;
        end
        else
        begin
            s_counter2=s_counter2 + 'd0;
        end
    
        end: LOOP

        o_output= s_counter1+s_counter2;

        
        if(BITS<3)
        begin
            if((i_input1=='0) & (i_input2=='0)) 
                begin
                    o_overflow=1'b1;
                end
            else 
                begin
                    o_overflow=1'b0;

                end
        end
        
        else
            begin
                o_overflow=1'b0;
            end
    end        

endmodule    
