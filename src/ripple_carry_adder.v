module ripple_carry_adder(
   input  [31:0] a,
   input  [31:0] b,
   output [31:0] sum,
   output carry_out
   );

    wire [31:0] carry;

    // set up first adder with 0 as carry in
    full_adder f(a[0],b[0],1'b0,sum[0],carry[0]);

    // use loop to setup next 31 adders
    genvar i;
    for(i = 1; i <= 31; i = i + 1)
        begin
            full_adder f(a[i],b[i],carry[i-1],sum[i],carry[i]);
        end
    
    // not sure if needed, but more than half the examples I looked at had one, so why not. 
    assign carry_out = carry[31];

endmodule