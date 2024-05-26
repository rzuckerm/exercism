def grep(pattern: str, flags: str, files: list[str]):
    n, l, i, v, x = [f"-{flag}" in flags for flag in "nlivx"]
    match_pattern = pattern.lower() if i else pattern
    result = ""
    for file_ in files:
        with open(file_, encoding="utf-8") as f:
            for line_num, line in enumerate(f, start=1):
                match_line = (line.lower() if i else line).rstrip("\r\n")
                if (match_pattern == match_line if x else match_pattern in match_line) ^ v:
                    if l:
                        result += f"{file_}\n"
                        break

                    result += (f"{file_}:" if len(files) > 1 else "") + (f"{line_num}:" if n else "") + line

    return result
