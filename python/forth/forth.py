from itertools import takewhile

L = list[int]

OPS = {
    "+": lambda stack: stack.append(stack.pop() + stack.pop()),
    "-": lambda stack: stack.append(stack.pop(-2) - stack.pop()),
    "*": lambda stack: stack.append(stack.pop() * stack.pop()),
    "/": lambda stack: stack.append(stack.pop(-2) // stack.pop()),
    "dup": lambda stack: stack.append(stack[-1]),
    "drop": lambda stack: stack.pop(),
    "swap": lambda stack: stack.extend([stack.pop(), stack.pop()]),
    "over": lambda stack: stack.append(stack[-2]),
}


class StackUnderflowError(Exception):
    pass


def evaluate(input_data: L, stack: L | None = None, user_defs: dict[str, L] | None = None) -> L:
    stack, user_defs = stack or [], user_defs or {}
    word_iter = iter(" ".join(input_data).lower().split())
    while word := next(word_iter, None):
        if word == ":":
            name = next(word_iter)
            if name.lstrip("-").isdigit():
                raise ValueError("illegal operation")

            old_instructions = user_defs.get(name)
            user_defs[name] = list(takewhile(lambda word: word != ";", word_iter))
            if old_instructions:
                for name2, instructions in user_defs.items():
                    user_defs[name2] = sum((old_instructions if x == name else [x] for x in instructions), [])
        elif word in user_defs:
            stack = evaluate(user_defs[word], stack, user_defs)
        elif word in OPS:
            try:
                OPS[word](stack)
            except IndexError as exc:
                raise StackUnderflowError("Insufficient number of items in stack") from exc
            except ZeroDivisionError as exc:
                raise ZeroDivisionError("divide by zero") from exc
        elif word.lstrip("-").isdigit():
            stack.append(int(word))
        else:
            raise ValueError("undefined operation")

    return stack
