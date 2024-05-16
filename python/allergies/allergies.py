ALLEGIES = "eggs peanuts shellfish strawberries tomatoes chocolate pollen cats".split()


class Allergies:
    def __init__(self, score: int):
        self.lst = [item for n, item in enumerate(ALLEGIES) if score & (1 << n)]

    def allergic_to(self, item: str) -> bool:
        return item in self.lst
