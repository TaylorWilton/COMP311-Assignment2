	module full_adder_tb();    
    
    reg a;
    reg b;
    reg carry_in;
    wire sum_out;
    wire carry_out;
    
    parameter dump = 0;
    
    reg[3:0] passed;
    reg[3:0] failed;
    
    full_adder dut(a,b,carry_in,sum_out,carry_out);

    initial
    begin
        if(dump) begin
            $dumpfile("waves/full_adder.vcd");
            $dumpvars(a,b,carry_in,sum_out,carry_out);
        end
    end

    initial begin
        passed = 0;
        failed = 0;
        
        // TEST 1: (0,0,0) => (0,0)
        
        a = 0;
        b = 0;
        carry_in = 0;
        
        #10
       
        if(sum_out == 0 && carry_out == 0)
			passed = passed + 1;
        else 
			failed = failed + 1;

        // TEST 2: (0,0,1) => (1,0)
        a = 0;
        b = 0;
        carry_in = 1;
        
        #10             
      
        if(sum_out == 1 && carry_out == 0)
			passed = passed + 1;
        else 
			failed = failed + 1;
  
        #10
        // TEST 3: (0,1,0) => (1,0)
        a = 0;
        b = 1;
        carry_in = 0;
        
        #10
        
        if(sum_out == 1 && carry_out == 0)
			passed = passed + 1;
        else 
			failed = failed + 1;

        #10
        
        // TEST 4: (0,1,1) => (0,1)
        a = 0;
        b = 1;
        carry_in = 1;
        
        #10
        
        if(sum_out == 0 && carry_out == 1)
			passed = passed + 1;
        else 
			failed = failed + 1;
        
        #10        
        
        // TEST 5 (1,0,0) => (1,0)
        a = 1;
        b = 0;
        carry_in = 0;
        
        #10
        
        if(sum_out == 1 && carry_out == 0)
			passed = passed + 1;
        else 
			failed = failed + 1;
        
        #10   
             
        // TEST 6 (1,0,1) => (0,1)
        a = 1;
        b = 0;
        carry_in = 1;
        
        #10
        
        if(sum_out == 0 && carry_out == 1)
			passed = passed + 1;
        else
			failed = failed + 1;
        
        #10

        // TEST 7 (1,1,0) => (0,1)
        a = 1;
        b = 1;
        carry_in = 0;
        
        #10
        
        if(sum_out == 0 && carry_out == 1)
			passed = passed + 1;
        else 
			failed = failed + 1;
        
        #10   

        // TEST 8 (1,1,1) => (1,1)
        a = 1;
        b = 1;
        carry_in = 1;
        
        #10
        
        if(sum_out == 1 && carry_out == 1)
			passed = passed + 1;
        else 
			failed = failed + 1;
        
        #10   
        
        $display("Full Adder Tests Complete:\nPassed %d\nFailed %d",passed,failed);
        
        $finish;
     end
    
endmodule
