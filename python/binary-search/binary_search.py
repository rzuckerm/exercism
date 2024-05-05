from bisect import bisect_left


def find(search_list: list[int], value: int) -> int:
    index = bisect_left(search_list, value)
    if index == len(search_list) or value != search_list[index]:
        raise ValueError("value not in array")

    return index
