class Robot:  # pylint: disable=too-few-public-methods
    NAMES = {f"{chr(n//26000 + ord('A'))}{chr((n//1000)%26 + ord('A'))}{(n%1000):03d}" for n in range(676000)}

    def __init__(self):
        self.name = Robot.NAMES.pop()

    def reset(self):
        Robot.NAMES.add(self.name)
        self.name = Robot.NAMES.pop()
