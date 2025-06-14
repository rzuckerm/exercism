$Global:Directions = @(@(-1, -1), @(-1, 0), @(-1, 1), @(0, -1), @(0, 1), @(1, -1), @(1, 0), @(1, 1))

Function Invoke-GameOfLife() {
    <#
    .SYNOPSIS
    Compute the next generation of cells for Conway's Game of Life.

    .DESCRIPTION
    Given a matrix of integer acting as cells in Conway's Game of Life, compute the next generation.
    Each cell has two states : alive (1) or dead (0).
    Each cell have eight neighbors, and the following rules are applied to each cell:
    - Any live cell with two or three live neighbors lives on.
    - Any dead cell with exactly three live neighbors becomes a live cell.
    - All other cells die or stay dead.

    .PARAMETER Matrix
    A matrix represent the current state of the game.

    .EXAMPLE
    $matrix = @(
        @(1, 1),
        @(1, 0)
    )
    
    Invok-GameOfLife -Matrix $matrix
    Returns:
    @(
        @(1, 1),
        @(1, 1)
    )
    #Bottom right cell come alive and the other three cells stay alive follow the logic of the rules.
    #>
    [CmdletBinding()]
    Param(
        [int[][]] $Matrix
    )

    for ($r = 0; $r -lt $Matrix.Length; $r++) {
        @(, @(for ($c = 0; $c -lt $Matrix[0].Length; $c++) {
            $n = ($Global:Directions |
                ForEach-Object { $r + $_[0] -ge 0 -and $c + $_[1] -ge 0 -and $Matrix[$r + $_[0]]?[$c + $_[1]] } |
                Measure-Object -Sum).Sum
            [int](($Matrix[$r][$c] -and ($n -eq 2 -or $n -eq 3)) -or (-not $Matrix[$r][$c] -and $n -eq 3))
        }))
    }
}
