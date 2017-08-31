module alu(
    input clk,
    input [31:0] operand1,
    input [31:0] operand2,
    input [2:0] func,
    output reg zero,
    output reg [31:0] result
    );

    /*
     * Instructions are 3 lsb of simpified WRAMP ISA opcode
     * 000 -> ADD
     * 010 -> SUB
     * 011 -> AND
     * 111 -> XOR
     * 101 -> OR
     */

    always @(posedge clk) begin
      result = 0;
      zero = 0;
      case(func)
          3'b000: result = operand1 + operand2;
          3'b010: result = operand1 - operand2;
          3'b011: result = operand1 & operand2;
          3'b111: result = operand1 ^ operand2;
          3'b101: result = operand1 | operand2;
      endcase

      // couldn't do ternary
      if(result == 0)
        assign zero = 1;
    end
endmodule