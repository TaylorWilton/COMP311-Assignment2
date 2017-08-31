module half_adder_tb();

    reg a;
    reg b;
    wire carry_out;
    wire sum;

    parameter dump = 0;

    reg[3:0] passed;
    reg[3:0] failed;

    half_adder dut(a,b,carry_out,sum);
    
    initial
    begin
        if(dump) begin
            $dumpfile("waves/half_adder.vcd");
            $dumpvars(a,b,sum,carry_out);
        end
    end

    initial begin

        passed = 0;
        failed = 0;
        
        a = 0;
        b = 0;
    
        #10;
        
        // TEST 1: (0,0) => (0,0)
        if(sum == 0 && carry_out == 0)
            passed = passed + 1;
        else
            failed = failed + 1;
        
        #10; 
        
        a = 1;
        
        #10
        // TEST 2: (1,0) => (1,0)
        if(sum == 1 && carry_out == 0)
            passed = passed + 1;
        else
            failed = failed + 1;
            
        #10;
            
        a = 0;
        b = 1;
    
        #10;
        // TEST 3 (0,1) => (1,0)
        if(sum == 1 && carry_out == 0)
            passed = passed + 1;
        else 
            failed = failed + 1;
          
        #10;
        
        a = 1;
        b = 1;
        
        #10; 
        
        // TEST 4: (1,1) => (0,1)
        if(sum ==0 && carry_out == 1)
            passed = passed + 1;
        else 
            failed = failed + 1;
        
        #10;
        
        $display("Half Adder Tests Complete:\nPassed %d\nFailed %d",passed,failed);
        
        $finish;
     end
            
endmodule
