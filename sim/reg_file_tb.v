module reg_file_tb();
    
    reg[31:0] passed;
    reg[31:0] failed;


    reg clk;
    reg rst;
    reg[3:0] addr1;
    reg[3:0] addr2;
    reg write_en;
    reg[31:0] write_data;

    wire[31:0] read_data1;
    wire[31:0] read_data2;
    reg[7:0] i;
    reg[31:0] testcase;
    reg[31:0] memory_start_address;
    reg [31:0] testcases [0:1023];
    parameter [31:0] NUM_CASES = 500;

    parameter dump = 0;

    reg_file dut(clk,rst,addr1,addr2,write_en,write_data,read_data1,read_data2);

    initial begin
        clk = 1;
        forever #5 clk = ~clk;
    end

    initial begin
        if(dump) begin
            $dumpfile("waves/reg_file_tb.vcd");
            $dumpvars(clk,rst,addr1,addr2,write_en,write_data,read_data1,read_data2);
        end

        passed = 0;
        failed = 0;

        addr1 = 0;
        addr2 = 0;
        write_en = 0;
        rst = 1;
        #20;
        if(read_data1 == 0 && read_data2 == 0) 
            passed = passed + 1;
        else
            failed = failed + 1;

        rst = 0;
        
        for(i = 0; i < 32; i = i + 1) begin
            addr1 = i;
            if(read_data1 == 0)
                passed = passed + 1;
            else
                failed = failed + 1;
        end

        #20
        rst = 0;
        write_en = 1;
        $readmemb("testcases/register_file.testcases",testcases,0,2*NUM_CASES-1);
        #10
        for(testcase = 0; testcase < NUM_CASES; testcase = testcase + 1) begin
            // calc offset of current test
            memory_start_address = testcase*2;
            // get data out of array
            addr1 = testcases[memory_start_address];
            write_data = testcases[memory_start_address + 1];
            
            #20
            // TEST
            if(read_data1 == write_data)
                passed = passed + 1;
            else begin
                failed = failed + 1;
                $display("Test #%d - REG_FILE: \nRegister,Expected Data, Actual Data: \n%d,\t%d,\t%d",testcase + 1,addr1,write_data,read_data1);
            end

            addr2 = addr1;

            #20
            if(read_data2 == write_data)
                passed = passed + 1;
            else begin
                failed = failed + 1;
                $display("Test #%d - REG_FILE w Addr2: \nRegister,Expected Data, Actual Data: \n%d,\t%d,\t%d",testcase + 1,addr1,write_data,read_data1);
            end

            // clean up after ourselves
            testcases[memory_start_address] <= 0;
            testcases[memory_start_address + 1] <= 0;
        end


        $display("Register Tests Complete:\nPassed %d\nFailed %d",passed,failed);
        $finish;
    end


endmodule