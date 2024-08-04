# Key is outcome. Values are a tuple of score and table key for each team
TALLY = {"win": ((3, "W"), (0, "L")), "draw": ((1, "D"), (1, "D")), "loss": ((0, "L"), (3, "W"))}
HEADER = f"{'Team':30} | MP |  W |  D |  L |  P"


def tally(rows: list[str]) -> list[str]:
    table = {}
    for team1, team2, outcome in (row.split(";") for row in rows):
        for t, (p, k) in zip((team1, team2), TALLY[outcome]):
            table.setdefault(t, {"MP": 0, "W": 0, "D": 0, "L": 0, "P": 0})
            table[t]["MP"], table[t][k], table[t]["P"] = table[t]["MP"] + 1, table[t][k] + 1, table[t]["P"] + p

    return [HEADER] + [line for _, line in sorted(_format_line(k, v) for k, v in table.items())]


def _format_line(k: str, v: dict[str, dict[str, int]]) -> tuple[int, str]:
    return (-v["P"], f"{k:30} | {v['MP']:>2} | {v['W']:>2} | {v['D']:>2} | {v['L']:>2} | {v['P']:>2}")
