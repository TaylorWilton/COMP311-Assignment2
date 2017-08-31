all: test_adders test_pc test_alu test_reg

test_adders: test_half_adder test_full_adder test_ripple_adder

test_half_adder: sim/half_adder_tb.v src/half_adder.v
	@iverilog -o out/half_adder_test sim/half_adder_tb.v src/half_adder.v
	@vvp out/half_adder_test

test_full_adder: sim/full_adder_tb.v src/full_adder.v test_half_adder
	@iverilog -o out/full_adder_test sim/full_adder_tb.v src/full_adder.v src/half_adder.v
	@vvp out/full_adder_test

test_ripple_adder: sim/ripple_adder_tb.v test_full_adder
	@iverilog -o out/ripple_adder_test sim/ripple_adder_tb.v src/ripple_carry_adder.v src/full_adder.v src/half_adder.v
	@vvp out/ripple_adder_test

test_alu: sim/alu_tb.v src/alu.v 
	@iverilog -o out/alu_test sim/alu_tb.v src/alu.v
	@vvp out/alu_test

test_pc: sim/pc_tb.v src/pc.v 
	@iverilog -o out/pc_test -c sim/deps/pc.txt
	@vvp out/pc_test

test_reg: sim/reg_file_tb.v src/reg_file.v
	@iverilog -o out/reg_file sim/reg_file_tb.v src/reg_file.v
	@vvp out/reg_file