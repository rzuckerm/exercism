NUMS = ["no", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"]


def recite(start: int, take: int = 1) -> list[str]:
    return sum((_verse(start - n) + [""] for n in range(take)), [])[:-1]


def _verse(v: int) -> list[str]:
    return [f"{NUMS[v].title()} green bottle{'s' if v != 1 else ''} hanging on the wall,"] * 2 + [
        "And if one green bottle should accidentally fall,",
        f"There'll be {NUMS[v - 1]} green bottle{'s' if v != 2 else ''} hanging on the wall.",
    ]
