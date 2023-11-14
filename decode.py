# TODO: update
inst_to_byte = {
    ">": "00000000",
    "<": "00000000",
    "+": "00000000",
    "-": "00000000",
    ",": "00000000",
    ".": "00000000",
    "[": "00000000",
    "]": "00000000",
}

strings = input()

for instruction in strings:
    print(inst_to_byte[instruction])
