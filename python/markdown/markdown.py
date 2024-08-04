import re


def parse(markdown: str) -> str:
    # Bold
    res = re.sub(r"__(.*)__", r"<strong>\1</strong>", markdown)

    # Italics
    res = re.sub(r"_(.*)_", r"<em>\1</em>", res)

    # Headers
    res = re.sub(r"^(#{1,6}) (.*)", lambda m: f"<h{len(m.group(1))}>{m.group(2)}</h{len(m.group(1))}>", res)

    # List items
    res = re.sub(r"^\* (.*)", r"<li>\1</li>", res, flags=re.M)

    # Unorder list
    res = re.sub(r"(<li>.*</li>)", r"<ul>\1</ul>", res, flags=re.S)

    # Paragraphs
    return re.sub(r"^(?!<h[1-6]>|<li>|<ul>)(.*)", r"<p>\1</p>", res, flags=re.M).replace("\n", "")
