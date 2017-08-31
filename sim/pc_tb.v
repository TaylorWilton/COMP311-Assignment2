module pc_tb();

    reg[31:0] passed;
    reg[31:0] failed;

    reg[31:0] i;

    reg clk;
    reg rst;
    reg inc;
    reg write_en;
    reg[19:0] write_data;
    wire[19:0] ctr;
    
    parameter dump = 0;

    pc dut(clk,rst,inc,write_en,write_data,ctr);

    initial begin
        clk = 1;
        forever #5 clk = ~clk;
    end

    initial begin
        if(dump) begin
            $dumpfile("waves/pc_tb.vcd");
            $dumpvars(clk,ctr,inc);
        end

        passed = 0;
        failed = 0;

        inc = 1;
        
        rst = 1;
        #5
        rst = 0;

        // TEST SET 1 - Increment Counter with clk
        for (i = 1; i <= 64; i++) begin
           #10
            if(ctr == i)
                passed = passed + 1;
            else
                failed = failed + 1;
        end


        // TEST TWO = RESET SET
        inc = 0;
        rst = 1;

        for (i = 1; i <= 64; i++) begin
           #10

            if(ctr == 0)
                passed = passed + 1;
            else
                failed = failed + 1;
        end

        rst = 0;
        write_en = 1;
        write_data = 20'h3BEEF;

        #10

        if(ctr == 20'h3BEEF)
            passed = passed + 1;
        else
            failed = failed + 1;

        $display("PC Tests Complete:\nPassed %d\nFailed %d",passed,failed);
        $finish;

    end
endmodule