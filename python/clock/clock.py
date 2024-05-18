class Clock:
    def __init__(self, hour: int, minute: int):
        self.hour, self.minute = (hour + minute // 60) % 24, minute % 60

    def __repr__(self) -> str:
        return f"Clock({self.hour}, {self.minute})"

    def __str__(self) -> str:
        return f"{self.hour:02d}:{self.minute:02d}"

    def __eq__(self, other) -> bool:
        return self.hour == other.hour and self.minute == other.minute

    def __add__(self, minutes: int):
        return Clock(self.hour, self.minute + minutes)

    def __sub__(self, minutes: int):
        return Clock(self.hour, self.minute - minutes)
