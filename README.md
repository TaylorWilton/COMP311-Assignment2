# COMP311 Assignment 2
Taylor Wilton (Deakin) - **1256357**

## Directory Structure
```
out             - compiled program files
sim             - simulation testbench files
deps            - text files with dependency lists for compiling files
src             - component files
testcases       - testcase files
waves           - .vcd wavefiles
```

For my submission, out & waves are empty, however I have included them, since using the makefile and $dumpfile commands rely on their existence. 

## Compiling Verilog Files
Included with this project is a makefile that will automatically compile the files. It requires that [Icarus Verilog](iverilog.icarus.com) is installed.

Run `make all` to compile and test all components. 

## Testbenches
Since I used Icarus Verilog & GTKWave for this project, I had to include a $dumpfile command. 
By default, dumps are disabled with the parameter `dump`. If this parameter is changed to a truthy value (e.g 1), 
the $dumpfile command will be run. 




### Generated Testbenchs
This project contains a number of generated testbenches. 
These are used for the ALU, Ripple Carry Adder & Register File. 
Testing every single possible input would be impractical, so instead I did the next best thing, and wrote a set of python scripts to generate annotated testcase files. 

My methodolgy is effectively a smaller version QuickCheck without the reduced failure case. In brief, the idea is to throw a bunch of input at the components and see what breaks. 

These cases are also augmented by specific edge cases. For example, the ripple carry adder is tested to see how it handles overflows and carries. 

