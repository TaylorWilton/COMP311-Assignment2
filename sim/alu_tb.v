module alu_tb();

    reg clk;

    reg[31:0] passed;
    reg[31:0] failed;

    reg[31:0] operand1;
    reg[31:0] operand2;
    reg[2:0] func;
    wire zero;
    wire[31:0] result;
    
    reg[31:0] expected;
    reg[31:0] testcase;
    reg[31:0] memory_start_address;
    reg [31:0] testcases [0:700];

    parameter [31:0] NUM_CASES = 220;

    parameter [2:0] FUNC_ADD = 3'b000;
    parameter [2:0] FUNC_SUB = 3'b010;
    parameter [2:0] FUNC_AND = 3'b011;
    parameter [2:0] FUNC_OR = 3'b101;
    parameter [2:0] FUNC_XOR = 3'b111;

    parameter dump = 0;

    alu dut(clk,operand1,operand2,func,zero,result);

    initial begin
        clk = 1;
        forever #5 clk = ~clk;
    end

    initial begin
        if(dump) begin
            $dumpfile("waves/alu.vcd");
            $dumpvars(operand1,operand2,func,result);
        end
    end

    initial begin
        passed = 0;
        failed = 0;

        // ADD THINGS
        func = FUNC_ADD;
        $readmemb("testcases/alu-add.testcases",testcases,0,3*NUM_CASES-1);
        #10
        for(testcase = 0; testcase < NUM_CASES; testcase = testcase + 1) begin
            // calc offset of current test
            memory_start_address = testcase*3;
            // get data out of array
            operand1 = testcases[memory_start_address];
            operand2 = testcases[memory_start_address + 1];
            expected = testcases[memory_start_address + 2];
            #10
            // TEST
            if(result == expected)
                passed = passed + 1;
            else begin
                failed = failed + 1;
                $display("ADD Case #%d: a,b,expected,result: %d,%d,%d,%d",testcase,operand1,operand2,expected,result);           
            end
            if (expected == 0) begin
                if(result == 0 && zero == 1)
                    passed = passed + 1;
                else begin
                    failed = failed + 1;
                    $display("ADD: a,b,expected,result: %d,%d,%d,%d",operand1,operand2,expected,result); 
                end
            end

            #10
            // clean up after ourselves
            testcases[memory_start_address] <= 0;
            testcases[memory_start_address + 1] <= 0;
            testcases[memory_start_address + 2] <= 0;
        end

        // SUBTRACT THINGS
        func = FUNC_SUB;

        $readmemb("testcases/alu-subtract.testcases",testcases,0,3*NUM_CASES-1);
        #10
        for(testcase = 0; testcase < NUM_CASES; testcase = testcase + 1) begin
            // calc offset of current test
            memory_start_address = testcase*3;
            // get data out of array
            operand1 = testcases[memory_start_address];
            operand2 = testcases[memory_start_address + 1];
            expected = testcases[memory_start_address + 2];
            #10
            // TEST
            if(result == expected)
                passed = passed + 1;
            else begin
                failed = failed + 1;
                $display("SUBTRACT: a,b,expected,result: %d,%d,%d,%d",operand1,operand2,expected,result);
            end

            if (expected == 0) begin
                if(result == 0 && zero == 1)
                    passed = passed + 1;
                else begin
                    failed = failed + 1;
                    $display("SUB: a,b,expected,result: %d,%d,%d,%d",operand1,operand2,expected,result); 
                end
            end
            #10

            // clean up after ourselves
            testcases[memory_start_address] <= 0;
            testcases[memory_start_address + 1] <= 0;
            testcases[memory_start_address + 2] <= 0;
        end

        // AND THINGS
        func = FUNC_AND;
        $readmemb("testcases/alu-and.testcases",testcases,0, 3* NUM_CASES - 1);
        #10
        for(testcase = 0; testcase < NUM_CASES; testcase = testcase + 1) begin
            // calc offset of current test
            memory_start_address = testcase*3;
            // get data out of array
            operand1 = testcases[memory_start_address];
            operand2 = testcases[memory_start_address + 1];
            expected = testcases[memory_start_address + 2];
            #10
            // TEST
            if(result == expected)
                passed = passed + 1;
            else begin
                failed = failed + 1;
                $display("AND: a,b,expected,result: %d,%d,%d,%d",operand1,operand2,expected,result);
            end

            if (expected == 0) begin
                if(result == 0 && zero == 1)
                    passed = passed + 1;
                else begin
                    failed = failed + 1;
                    $display("AND: a,b,expected,result: %d,%d,%d,%d",operand1,operand2,expected,result); 
                end
            end
            #10
            // clean up after ourselves
            testcases[memory_start_address] <= 0;
            testcases[memory_start_address + 1] <= 0;
            testcases[memory_start_address + 2] <= 0;
        end
        // OR THINGS
        func = FUNC_OR;
        $readmemb("testcases/alu-or.testcases",testcases,0,3*NUM_CASES - 1);
        #10
        for(testcase = 0; testcase < NUM_CASES; testcase = testcase + 1) begin
            // calc offset of current test
            memory_start_address = testcase*3;
            // get data out of array
            operand1 = testcases[memory_start_address];
            operand2 = testcases[memory_start_address + 1];
            expected = testcases[memory_start_address + 2];
            #10
            // TEST
            if(result == expected)
                passed = passed + 1;
            else begin
                failed = failed + 1;
                $display("OR a,b,expected,result: %d,%d,%d,%d",operand1,operand2,expected,result);
            end

            if (expected == 0) begin
                if(result == 0 && zero == 1)
                    passed = passed + 1;
                else begin
                    failed = failed + 1;
                    $display("OR: a,b,expected,result: %d,%d,%d,%d",operand1,operand2,expected,result); 
                end
            end
            #10
            // clean up after ourselves
            testcases[memory_start_address] <= 0;
            testcases[memory_start_address + 1] <= 0;
            testcases[memory_start_address + 2] <= 0;
        end
        
        // XOR THINGS
        func = FUNC_XOR;
        $readmemb("testcases/alu-xor.testcases",testcases,0,3*NUM_CASES - 1);
        #10
        for(testcase = 0; testcase < NUM_CASES; testcase = testcase + 1) begin
            // calc offset of current test
            memory_start_address = testcase*3;
            // get data out of array
            operand1 = testcases[memory_start_address];
            operand2 = testcases[memory_start_address + 1];
            expected = testcases[memory_start_address + 2];
            #10
            // TEST
            if(result == expected)
                passed = passed + 1;
            else begin
                failed = failed + 1;
                $display("XOR: a,b,expected,result: %d,%d,%d,%d",operand1,operand2,expected,result);
            end

            if (expected == 0) begin
                if(result == 0 && zero == 1)
                    passed = passed + 1;
                else begin
                    failed = failed + 1;
                    $display("XOR: a,b,expected,result,zero: %d,%d,%d,%d,%d",operand1,operand2,expected,result,zero); 
                end
            end
            #10
            // clean up after ourselves
            testcases[memory_start_address] <= 0;
            testcases[memory_start_address + 1] <= 0;
            testcases[memory_start_address + 2] <= 0;
        end

        $display("ALU Tests Complete:\nPassed %d\nFailed %d",passed,failed);
        $finish;
    end
endmodule