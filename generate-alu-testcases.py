from random import randint
from enum import Enum


class Operand(Enum):
    ADD = 1
    SUB = 2
    AND = 3
    XOR = 4
    OR = 5


MAX_SIZE = 2147483646

def make_test_cases(op):
    cases = []

    for i in range(0, 200):
        a = randint(0, MAX_SIZE)
        b = randint(0, MAX_SIZE)

        if (op == Operand.ADD):
            comment = "// TEST  # {0}: {1} {2} {3} = {4}".format(i + 1, a, "+", b, a + b)
            cases.append((comment, a, b, a + b))
            continue
        if (op == Operand.SUB):
            if (a > b):
                comment = "// TEST  # {0}: {1} {2} {3} = {4}".format(i + 1, a, "-", b, a - b)
                cases.append((comment, a, b, a - b))
            else:
                comment = "// TEST  # {0}: {1} {2} {3} = {4}".format(i + 1, b, "-", a, b - a)
                cases.append((comment, b, a, b - a))
            continue
        if (op == Operand.AND):
            comment = "// TEST  # {0}: {1} {2} {3} = {4}".format(i + 1, a, "&", b, a & b)
            cases.append((comment, a, b, a & b))
            continue
        if (op == Operand.XOR):
            comment = "// TEST  # {0}: {1} {2} {3} = {4}".format(i + 1, a, "^", b, a ^ b)
            cases.append((comment, a, b, a ^ b))
            continue
        if (op == Operand.OR):
            comment = "// TEST  # {0}: {1} {2} {3} = {4}".format(i + 1, a, "|", b, a | b)
            cases.append((comment, a, b, a | b))
            continue

    for i in range(0, 20):
        a = randint(0, MAX_SIZE)
        b = a

        if (op == Operand.ADD):
            comment = "// TEST  # {0}: {1} {2} {3} = {4}".format(i + 1, a, "+", b, a + b)
            cases.append((comment, a, b, a + b))
            continue
        if (op == Operand.SUB):
            if (a > b):
                comment = "// TEST  # {0}: {1} {2} {3} = {4}".format(i + 1, a, "-", b, a - b)
                cases.append((comment, a, b, a - b))
            else:
                comment = "// TEST  # {0}: {1} {2} {3} = {4}".format(i + 1, b, "-", a, b - a)
                cases.append((comment, b, a, b - a))
            continue
        if (op == Operand.AND):
            comment = "// TEST  # {0}: {1} {2} {3} = {4}".format(i + 1, a, "&", b, a & b)
            cases.append((comment, a, b, a & b))
            continue
        if (op == Operand.XOR):
            comment = "// TEST  # {0}: {1} {2} {3} = {4}".format(i + 1, a, "^", b, a ^ b)
            cases.append((comment, a, b, a ^ b))
            continue
        if (op == Operand.OR):
            comment = "// TEST  # {0}: {1} {2} {3} = {4}".format(i + 1, a, "|", b, a | b)
            cases.append((comment, a, b, a | b))
            continue

    return cases


def op_names(op):
    if (op == Operand.ADD):
        return "add"
    if (op == Operand.SUB):
        return "subtract"
    if (op == Operand.AND):
        return "and"
    if (op == Operand.XOR):
        return "xor"
    if (op == Operand.OR):
        return "or"


for op in Operand:
    test_cases = make_test_cases(op)

    f = open("testcases/alu-" + op_names(op) + ".testcases", 'w+')

    for case in test_cases:
        f.write(format(case[0]) + "\n")
        f.write(format(case[1], 'b') + "\n")
        f.write(format(case[2], 'b') + "\n")
        f.write(format(case[3], 'b') + "\n")

    f.flush()
    f.close()
