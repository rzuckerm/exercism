<#
.SYNOPSIS
    Stimulate a game of hangman.
.DESCRIPTION
    Implement the logic and functionalities of a hangman game.
    The game started with 9 remaining guesses.
    Each incorrect guess will decrease the remaining guesses by 1.
    The game has 3 states: WIN, LOSE and ONGOING.
    You win when you correctly guess the word.
    You lose when you spent all of your guesses.
.EXAMPLE
    $game = [Hangman]::new("welcome")

    $game.RemainingGuesses
    Returns: 9
    $game.Display()
    Returns: "_______"

    $game.Guess("e")
    $game.Display()
    Returns: "_e____e"

    $game.Guess("z")
    $game.RemainingGuesses
    Returns: 8
#>


Enum Status {
    WIN
    LOSE
    ONGOING
}

Class Hangman {
    [int] $RemainingGuesses = 9
    hidden [char[]]$Word
    hidden [char[]]$Displayed

    Hangman([string]$word) {
        $this.Word = $word.ToCharArray()
        $this.Displayed = @("_") * $word.Length
    }

    Guess($char) {
        if ($this.GetStatus() -ne [Status]::ONGOING) { throw "The game has already ended." }
        if ($char -in $this.Word -and $char -notin $this.Displayed) {
            0..$this.word.Length | Where-Object { $this.Word[$_] -eq $char } | ForEach-Object { $this.Displayed[$_] = $char }
        } else { $this.RemainingGuesses-- }
    }

    [string] Display() { return -join $this.Displayed }
    [Status] GetStatus() {
        if ("_" -notin $this.Displayed) { return [Status]::WIN }
        if ($this.RemainingGuesses -lt 0) { return [Status]::LOSE }
        return [Status]::ONGOING
    }
}
