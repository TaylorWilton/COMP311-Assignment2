from random import randint

''' 
Test format:
    1. set an address to move data in
    2. set some data
    3. check that that data is set
    
In verilog, I'll also be changing the address of addr2, 
then checking that the data propagates over
'''

MAX_SIZE = 2147483646 # SIGNED INT MAX
REGISTER_COUNT = 16
NUM_TESTS = 500

def make_tests():
    cases=[]

    for i in range(0,NUM_TESTS):
        addr1 = randint(0, REGISTER_COUNT)
        write_data = randint(0, MAX_SIZE)
        comment = "// Test #{0}: Register: {1}, Data: {2}".format(i+1,addr1,write_data)

        cases.append((comment,addr1,write_data))

    return cases


test_cases = make_tests()
with open("testcases/register_file.testcases", 'w+') as f:
    for case in test_cases:
        f.write(format(case[0]) + "\n")
        f.write(format(case[1], 'b') + "\n")
        f.write(format(case[2], 'b') + "\n")