class BowlingGame:
    def __init__(self):
        self.rolls, self.curr_frame, self.frame = [], [], 0

    def roll(self, pins: int):
        if self.frame >= 10:
            raise ValueError("game is over")

        if pins < 0 or pins > 10 - sum(self.curr_frame) % 10:
            raise ValueError("invalid roll")

        self.rolls.append(pins)
        self.curr_frame.append(pins)
        nr, total = len(self.curr_frame), sum(self.curr_frame)
        if nr == 3 or (self.frame < 9 and (nr == 2 or total == 10)) or (self.frame >= 9 and nr == 2 and total < 10):
            self.frame += 1
            self.curr_frame = []

    def score(self) -> int:
        if self.frame < 10:
            raise IndexError("game is not over")

        total = 0
        n = 0
        for _ in range(10):
            frame_total = self.rolls[n] + self.rolls[n + 1]
            total += frame_total + (self.rolls[n + 2] if self.rolls[n] == 10 or frame_total == 10 else 0)
            n += 1 if self.rolls[n] == 10 else 2

        return total
