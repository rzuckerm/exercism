ACTIONS = ["wink", "double blink", "close your eyes", "jump"]


def commands(binary_str: str) -> list[str]:
    return [ACTIONS[n] for n, bit in enumerate(binary_str[:0:-1]) if bit == "1"][
        :: (-1 if binary_str[0] == "1" else 1)
    ]
