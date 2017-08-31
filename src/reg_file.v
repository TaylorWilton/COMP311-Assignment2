module reg_file(
    input clk,
    input rst,
    input [3:0] addr1,
    input [3:0] addr2,
    input write_en,
    input [31:0] write_data,
    output reg [31:0] read_data1,
    output reg [31:0] read_data2
    );

    reg[31:0] registers [0:15];
    reg[7:0] counter;

    always @(posedge clk) begin
      
         if(rst) begin
            for(counter = 0; counter < 32; counter = counter + 1) begin
                registers[counter] = 0;
            end
            read_data1 = 0;
            read_data2 = 0;
        end

        if(write_en) begin
            registers[addr1] = write_data;
        end

        read_data1 = registers[addr1];
        read_data2 = registers[addr2];

    end
endmodule
