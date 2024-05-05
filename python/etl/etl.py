def transform(legacy_data: dict[int, list[str]]) -> dict[str, int]:
    return {ltr.lower(): val for val, ltrs in legacy_data.items() for ltr in ltrs}
