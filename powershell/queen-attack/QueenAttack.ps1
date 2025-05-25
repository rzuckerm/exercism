<#
.SYNOPSIS
    Given the positions of two queens on a chess board,
    indicate whether or not they are positioned so that they can attack each other.

.DESCRIPTION
    In a chessboard represented by an 8 by 8 array, check if a queen can attack another queen based on their positions.
    In the game of chess, a queen can attack pieces which are on the same row, column, or diagonal.
    If there are no position provided, queens will be placed at their starting positions: White at bottom (7,3), Black at top (0,3).

.EXAMPLE
    #Positions provided:
    $whitePosition = @(2, 2)
    $blackPosition = @(5, 6)
    $board = [ChessBoard]::new($whitePosition, $blackPosition)
    $board.CanAttack() => False
    $board.DrawBoard()
    @"
    _ _ _ _ _ _ _ _
    _ _ _ _ _ _ _ _
    _ _ W _ _ _ _ _
    _ _ _ _ _ _ _ _
    _ _ _ _ _ _ _ _
    _ _ _ _ _ _ B _
    _ _ _ _ _ _ _ _
    _ _ _ _ _ _ _ _
    "@

    #No positions provided:
    $board2 = [ChessBoard]::new()
    $board2.CanAttack() => True
    $board.DrawBoard()
    @"
    _ _ _ B _ _ _ _
    _ _ _ _ _ _ _ _
    _ _ _ _ _ _ _ _
    _ _ _ _ _ _ _ _
    _ _ _ _ _ _ _ _
    _ _ _ _ _ _ _ _
    _ _ _ _ _ _ _ _
    _ _ _ W _ _ _ _
    "@
#>
Class ChessBoard {
    [int[]]$White = @(7, 3)
    [int[]]$Black = @(0, 3)

    ChessBoard() {}

    ChessBoard([int[]]$white, [int[]]$black) {
        if ($white | Where-Object { $_ -lt 0 -or $_ -gt 7 }) { throw "White queen must be placed on the board" }
        if ($black | Where-Object { $_ -lt 0 -or $_ -gt 7 }) { throw "Black queen must be placed on the board" }
        if ($white[0] -eq $black[0] -and $white[1] -eq $black[1]) { throw "Queens can not share the same space" }

        $this.White = $white
        $this.Black = $black
    }

    [boolean] CanAttack() {
        return ($this.White[0] -eq $this.Black[0] -or $this.White[1] -eq $this.Black[1] -or
            [Math]::Abs($this.White[0] - $this.Black[0]) -eq [Math]::Abs($this.White[1] - $this.Black[1]))
    }

    [string[][]] DrawBoard() {
        $row = @("_") * 8
        $board = 0..7 | ForEach-Object { ,$row.Clone() }
        $board[$this.White[0]][$this.White[1]] = "W"
        $board[$this.Black[0]][$this.Black[1]] = "B"
        return ($board | ForEach-Object { $_ -join " " }) -join "`r`n"
    }
}
