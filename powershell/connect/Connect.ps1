<#
.SYNOPSIS
    Compute the result for a game of Hex / Polygon.

.DESCRIPTION
    Your goal is to build a program that given a simple representation of a board computes the winner (or lack thereof).
    Note that all games need not be "fair".
    Player 'O' plays from top to bottom, and player 'X' plays from left to right.
    
.EXAMPLE
    $board = @(
        "O O X",
        " X O X",
        "  X X O"
    )

    $game = [Connect]::new($board)
    $game.GetWinner()
    Returns: [Winner]::X
#>

Enum Winner { X; O; NONE }

Class Connect {
    [hashtable]$Boards
    static [int[][]]$Moves = @(@(-1, 0), @(-1, 1), @(0, -1), @(0, 1), @(1, -1), @(1, 0))

    Connect([string[]]$board) {
        $lines = $board -replace " ", ""
        $this.Boards = @{"O" = $lines; "X" = 0..($lines[0].Length - 1) |
            ForEach-Object { $c = $_; -join (0..($lines.Length - 1) | ForEach-Object { $lines[$_][$c] }) }}
    }

    [Winner] GetWinner() {
        foreach ($player in @("O", "X")) {
            $thisBoard = $this.Boards[$player]
            for ($c = 0 ; $c -lt $thisBoard[0].Length; $c++) {
                if ($thisBoard[0][$c] -eq $player -and $this.IsWinner($player, @(0, $c), @("0,$c"))) {
                    return [Winner]($player)
                }
            }
        }

        return [Winner]::NONE
    }

    hidden [bool] IsWinner([string]$player, [int[]]$pt, [string[]]$path) {
        if ($pt[0] -eq $this.Boards[$player].Length - 1) { return $true }
        foreach ($delta in [Connect]::Moves) {
            $newPt = @(($pt[0] + $delta[0]), ($pt[1] + $delta[1]))
            if ($newPt[0] -lt 0 -or $newPt[1] -lt 0) { continue }
            $key = "$($newPt[0]),$($newPt[1])"
            if ($this.Boards[$player][$newPt[0]]?[$newPt[1]] -eq $player -and $key -notin $path) {
                if ($this.IsWinner($player, $newPt, ($path + $key))) { return $true }
            }
        }

        return $false
    }
}
