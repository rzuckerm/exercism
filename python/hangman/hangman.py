# Game status categories
STATUS_WIN, STATUS_LOSE, STATUS_ONGOING = range(3)


class Hangman:
    def __init__(self, word: str):
        self.remaining_guesses = 9
        self.status = STATUS_ONGOING
        self.word = word
        self.masked_word = "_" * len(word)

    def guess(self, char: str):
        # Check status
        if self.status != STATUS_ONGOING:
            raise ValueError("The game has already ended.")

        # Update remaining guesses
        self.remaining_guesses -= int(char not in self.word or char in self.masked_word)

        # Update masked word
        self.masked_word = "".join(char if char == w else mw for w, mw in zip(self.word, self.masked_word))

        # Update status
        self.status = STATUS_WIN if self.masked_word == self.word else self.status
        self.status = STATUS_LOSE if self.remaining_guesses < 0 else self.status

    def get_masked_word(self):
        return self.masked_word

    def get_status(self):
        return self.status
