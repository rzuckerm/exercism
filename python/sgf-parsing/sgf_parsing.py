from __future__ import annotations
from dataclasses import dataclass, field


@dataclass
class SgfTree:
    properties: dict[str, list[str]] = field(default_factory=dict)
    children: list[SgfTree] = field(default_factory=list)


def parse(input_string: str) -> SgfTree:
    input_string = "".join(" " if ch.isspace() and ch != "\n" else ch for ch in input_string.replace("\\\n", ""))
    return _parse_node(input_string, 0, start_delim="(", end_delim=")")[1]


def _parse_node(input_string: str, idx: int, start_delim: str = "", end_delim: str = "") -> tuple[int, SgfTree]:
    if start_delim and not input_string[idx:].startswith(start_delim):
        raise ValueError("tree missing")

    idx += 1 if start_delim else 0

    if not input_string[idx:].startswith(";"):
        raise ValueError("tree with no nodes")

    properties, children = {}, []
    idx += 1
    while idx < len(input_string) and (not end_delim or input_string[idx] != end_delim):
        key_idx = input_string.find("[", idx)
        key = input_string[idx:key_idx]
        if key_idx < 0 or any(ch in input_string[idx:key_idx] for ch in ";()]"):
            raise ValueError("properties without delimiter")

        if not key:
            raise ValueError("property is empty")

        if not key.isupper():
            raise ValueError("property must be in uppercase")

        idx, values = _parse_values(input_string, key_idx)
        properties.setdefault(key, []).extend(values)

        if input_string[idx:].startswith(";"):
            idx, child = _parse_node(input_string, idx, end_delim=")")
            idx -= 1
            children.append(child)
        elif input_string[idx:].startswith("("):
            children = []
            while idx < len(input_string):
                if input_string[idx] != "(":
                    break

                idx, child = _parse_node(input_string, idx, start_delim="(", end_delim=")")
                children.append(child)

            idx -= 1

    if end_delim and not input_string[idx:].endswith(end_delim):
        raise ValueError("tree missing")

    idx += 1 if end_delim else 0
    return idx, SgfTree(properties=properties, children=children)


def _parse_values(input_string: str, idx: int) -> tuple[int, list[str]]:
    values = []
    while idx < len(input_string) and input_string[idx] == "[":
        idx += 1
        value = ""
        while idx < len(input_string) and input_string[idx] != "]":
            if input_string[idx] == "\\":
                idx += 1
                value += input_string[idx : idx + 1]
            else:
                value += input_string[idx]

            idx += 1

        if not input_string[idx:].startswith("]"):
            raise ValueError("property value not terminated")

        idx += 1
        values.append(value)

    return idx, values
