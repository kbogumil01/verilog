module pf_nf(i_input, o_pf, o_nf); //dopelnienie do parzystych jedynek, znacznik PF
parameter BITS=4;              //wystawia 1, jesli liczba jedynek jest nieparzysta
input logic [BITS-1:0] i_input;
output logic o_pf;
output logic o_nf;
logic [BITS-1:0] s_counter;

always @(*)
begin
    s_counter=0;
    for(int i=0; i<BITS; i++)
    begin: LOOP
    if(i_input[i]==1)
    begin
        s_counter=s_counter+1;
    end
    else
    begin
        s_counter=s_counter+0;
    end  

    end: LOOP

    if(s_counter%2!=0) //wykrycie nieparzystosci
    begin
        o_pf=1;
        o_nf=0;
    end
    else
    begin
        o_pf=0;
        o_nf=1;
    end



end
endmodule
