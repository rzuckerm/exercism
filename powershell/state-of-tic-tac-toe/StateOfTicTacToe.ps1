$Global:Wins = @(@(0, 1, 2), @(3, 4, 5), @(6, 7, 8), @(0, 3, 6), @(1, 4, 7), @(2, 5, 8), @(0, 4, 8), @(2, 4, 6))

Enum GameStatus { ONGOING; DRAW; WIN }

Function Get-StateOfTicTacToe() {
    <#
    .SYNOPSIS
    Implement a program that determines the state of a tic-tac-toe game.

    .DESCRIPTION
    The games is played on a 3×3 grid represent by an array of 3 strings.
    Players take turns to place `X`s and `O`s on the grid.
    The game ends:
    - when one player has won by placing three of marks in a row, column, or along a diagonal of the grid
    - when the entire grid is filled up

    In this exercise, we will assume that `X` always starts first.

    .PARAMETER Board
    An array of 3 strings represeting the board in the form of 3x3 grid.

    .EXAMPLE
    $board = @(
        "XXO",
        "X  ",
        "X  "
    )
    Get-StateOfTicTacToe -Board $board
    Returns: [GameStatus]::WIN
    #>
    [CmdletBinding()]
    Param(
        [string[]]$Board
    )

    $squares = $Board | ForEach-Object { $_.ToCharArray() }
    $counts =@("X", "O") | ForEach-Object { ($squares -eq $_).Length }
    if ($counts[0] -gt $counts[1] + 1) { throw "Wrong turn order: X went twice" }
    if ($counts[0] -lt $counts[1]) { throw "Wrong turn order: O started" }

    $wins = @{X = 0; O = 0}
    0..1 | ForEach-Object {
        $piece = ($_ -eq 0) ? "X" : "O"
        foreach ($w in $Global:Wins) { $wins[$piece] += (($squares[$w] -eq $piece).Length -eq 3) }
    }

    if ($wins["X"] -and $wins["O"]) { throw "Impossible board: game should have ended after the game was won" }
    if ($wins["X"] -or $wins["O"]) { return [GameStatus]::WIN }
    ($counts[0] + $counts[1] -lt 9) ? [GameStatus]::ONGOING : [GameStatus]::DRAW
}
