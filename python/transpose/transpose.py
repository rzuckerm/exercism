import itertools


def transpose(lines: str) -> list[str]:
    tlines = ["".join(line).rstrip("\0") for line in itertools.zip_longest(*lines.splitlines(), fillvalue="\0")]
    return "\n".join(tline.replace("\0", " ") for tline in tlines)
