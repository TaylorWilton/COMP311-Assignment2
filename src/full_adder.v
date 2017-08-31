module full_adder(
        input a,
        input b,
        input carry_in,
        output sum_out,
        output carry_out
    );
    
    wire carry_1;
    wire sum_1;
    wire carry_2;
    wire sum_2;
    
    half_adder adder_1(a,b,carry_1,sum_1);
    half_adder adder_2(sum_1,carry_in,carry_2,sum_2);
    
    assign sum_out = sum_2;
    assign carry_out= carry_1 | carry_2;
       
endmodule