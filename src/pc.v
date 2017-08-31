module pc(
    input clk,
    input rst,
    input inc,
    input write_en,
    input [19:0] write_data,
    output reg [19:0] ctr
    );

    wire[31:0] out;

    // we don't care about carry out, so set it to null
    // also have to extend the ports we have to be the right size for the adder
    ripple_carry_adder incremeter({12'h000,ctr},{{31{1'b0}},inc},out,null);

    always @(posedge clk) begin
        // SET COUNTER to the value of the adder
        if(inc) 
            ctr = out;

        // WRITE DATA
        if(write_en) 
            ctr <= write_data;

        // RESET
        if(rst)
            ctr <= 0;

    end

endmodule
