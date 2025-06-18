<#
.SYNOPSIS
    Implement a class to score a bowling game.

.DESCRIPTION
    For the detailed rules of the game, check instructions.

    Write code to keep track of the score of a game of bowling.
    It should support two operations:

    - roll(pins): is called each time the player rolls a ball.
    The argument is an integer represent the number of pins got knocked down (0 - 10)

    - score(): is called only at the very end of the game.
    It returns an integer represent the total score for that game.

    The class also should handle various cases of errors based on invalid or illegal inputs.
    You can decide what error message you want to throw.

.EXAMPLE
    $rolls = @(10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10)
    $game = [BowlingGame]::new()

    foreach ($roll in $rolls) {
        $game.Roll($roll)
    }
    $game.Score()
    Returns: 300
#>
Class BowlingGame {
    [int[]]$rolls = @()
    [int[]]$currFrame = @()
    [int]$frame = 0

    BowlingGame() {}

    Roll($pins) {
        if ($this.frame -ge 10) { throw "Cannot roll after game is over" }
        if ($pins -lt 0) { throw "Negative roll is invalid" }
        if ($pins -gt (10 - (($this.currFrame | Measure-Object -Sum).Sum % 10))) { throw "Too many pins" }

        $this.rolls += $pins
        $this.currFrame += $pins
        $nr = $this.currFrame.Length
        $total = ($this.currFrame | Measure-Object -Sum).Sum
        if ($nr -eq 3 -or ($this.frame -lt 9 -and ($nr -eq 2 -or $total -eq 10)) -or
            ($this.frame -ge 9 -and $nr -eq 2 -and $total -lt 10)) {
            $this.frame++
            $this.currFrame = @()
        }
    }

    [int] Score() {
        if ($this.frame -lt 10) { throw "Score cannot be taken until the end of the game" }

        $total, $n = 0, 0
        foreach ($i in 0..9) {
            $frameTotal = $this.rolls[$n] + $this.rolls[$n + 1]
            $total += $frameTotal + (($this.rolls[$n] -eq 10 -or $frameTotal -eq 10) ? $this.rolls[$n + 2] : 0)
            $n += ($this.rolls[$n] -eq 10) ? 1 : 2
        }

        return $total
    }
}
