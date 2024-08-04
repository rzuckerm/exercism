MATCHING_BRACKETS = {"(": ")", "{": "}", "[": "]"}
ENDING_BRACKETS = ")}]"


def is_paired(input_string: str) -> bool:
    stack = []
    for ch in input_string:
        if ch in MATCHING_BRACKETS:
            stack.append(MATCHING_BRACKETS[ch])
        elif ch in ENDING_BRACKETS and not (stack and stack.pop() == ch):
            return False

    return not stack
