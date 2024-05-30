class BowlingGame:
    def __init__(self):
        self.rolls: list[int] = []
        self.frame = 0
        self.roll_num = 0
        self.left = 10

    def roll(self, pins: int):
        if self.frame >= 10:
            raise ValueError("game is over")

        if pins < 0 or pins > self.left:
            raise ValueError("invalid roll")

        # Adjust number of pins left. Reset if all pins knocked down
        self.left = 10 if self.left == pins or (self.roll_num == 2 and self.frame < 9) else self.left - pins

        self.roll_num += 1
        if self.roll_num == 1:
            # First roll: Next frame if strike and not last frame
            if self.frame < 9 and pins == 10:
                self.roll_num = 0
                self.frame += 1
        elif self.roll_num == 2:
            # Second roll: Next frame if not last frame and reset pins left
            if self.frame < 9:
                self.frame += 1
                self.roll_num = 0
                self.left = 10
            # Game over if less than 10 pins in last frame
            elif self.rolls[-1] + pins < 10:
                self.frame += 1
        else:
            # Game over if third roll in last frame
            self.frame += 1

        self.rolls.append(pins)

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
