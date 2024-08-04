import itertools

PROTEIN_TABLE = {
    **dict.fromkeys(["AUG"], "Methionine"),
    **dict.fromkeys(["UUU", "UUC"], "Phenylalanine"),
    **dict.fromkeys(["UUA", "UUG"], "Leucine"),
    **dict.fromkeys(["UCU", "UCC", "UCA", "UCG"], "Serine"),
    **dict.fromkeys(["UAU", "UAC"], "Tyrosine"),
    **dict.fromkeys(["UGU", "UGC"], "Cysteine"),
    **dict.fromkeys(["UGG"], "Tryptophan"),
    **dict.fromkeys(["UAA", "UAG", "UGA"], None),
}


def proteins(strand: str) -> list[str]:
    return list(itertools.takewhile(lambda x: x, (PROTEIN_TABLE[strand[n : n + 3]] for n in range(0, len(strand), 3))))
