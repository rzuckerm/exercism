from random import randint


class Character:  # pylint: disable=too-few-public-methods
    def __init__(self):
        for name in ["strength", "dexterity", "constitution", "intelligence", "wisdom", "charisma"]:
            setattr(self, name, self.ability())

        self.hitpoints = 10 + modifier(self.constitution)

    def ability(self) -> int:
        return sum(sorted([randint(1, 6) for _ in range(4)])[1:])


def modifier(consitution: int) -> int:
    return (consitution - 10) // 2
