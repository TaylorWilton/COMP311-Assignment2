module ripple_adder_tb();

    reg[31:0] a;
    reg[31:0] b;
    wire [31:0] sum;
    wire carry;
    
    reg[31:0] i;
    reg[31:0] j;

    reg[64:0] passed;
    reg[64:0] failed;
 
    reg[31:0] NUM_CASES = 1000;
    reg[31:0] expected;
    reg[31:0] testcase;
    reg[31:0] memory_start_address;
    reg [31:0] testcases [0:4084];
    integer expectedCarry;
    integer expectedSum;
    integer diff;

    parameter dump = 0;

    ripple_carry_adder dut(a,b,sum,carry);

    initial begin
        if(dump) begin
            $dumpfile("waves/ripple_adder.vcd");
            $dumpvars(a,b,sum,carry);
        end
    end

    initial begin
        passed = 0;
        failed = 0;

        $readmemb("testcases/ripple_adder.testcases",testcases,0,4*NUM_CASES-1);
        #10
        for(testcase = 0; testcase < NUM_CASES; testcase = testcase + 1) begin
            // calc offset of current test
            memory_start_address = testcase*4;
            // get data out of array
            a = testcases[memory_start_address];
            b = testcases[memory_start_address + 1];
            expectedSum = testcases[memory_start_address + 2];
            expectedCarry = testcases[memory_start_address + 3];
            #10
            // TEST
            if(sum == expectedSum && carry == expectedCarry)
                passed = passed + 1;
            else begin
                failed = failed + 1;
                diff = sum - expectedSum;
                #10
                $display("TEST %d: a,b,eSum,eCarry,sum,carry,diff: %d,%d,%d,%d,%d,%d,%d",testcase,a,b,expectedSum,expectedCarry,sum,carry,diff);
            end
            #10
            // clean up after ourselves
            testcases[memory_start_address] <= 0;
            testcases[memory_start_address + 1] <= 0;
            testcases[memory_start_address + 2] <= 0;
            testcases[memory_start_address + 3] <= 0;
        end
        
       
        $display("Ripple Adder Tests Complete:\nPassed %d\nFailed %d",passed,failed);
        $finish;
    
    end

endmodule