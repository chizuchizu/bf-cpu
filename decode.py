# TODO: update
inst_to_binray = {
    ">": "00",
    "<": "01",
    "+": "02",
    "-": "03",
    "[": "04",
    "]": "05",
    ",": "06",
    ".": "07",
    " ": "08",
}

strings = input()

for instruction in strings:
    print(inst_to_binray[instruction], end=" ")
