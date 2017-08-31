from random import randint

NUM_TESTS = 1000


def make_tests():
    cases = []
    MAX_SIZE = 4294967292

    for i in range(0, NUM_TESTS):
        a = randint(0, MAX_SIZE - 1)
        b = randint(0, MAX_SIZE - 1)
        expected = a + b

        carry = 1 if expected > MAX_SIZE else  0

        comment = "// TEST {0}: {1} + {2} = {3}. Carry is {4}".format(i + 1, a, b, expected, carry)
        print(comment)
        cases.append((comment, a, b, expected, carry))

    return cases


test_cases = make_tests()
with open("testcases/ripple_adder.testcases", 'w+') as f:
    for case in test_cases:
        f.write(format(case[0]) + "\n")
        f.write(format(case[1], 'b') + "\n")
        f.write(format(case[2], 'b') + "\n")
        f.write(format(case[3], 'b') + "\n")
        f.write(format(case[4], 'b') + "\n")
