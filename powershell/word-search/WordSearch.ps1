$Global:Directions = @(@(-1, -1), @(-1, 0), @(-1, 1), @(0, -1), @(0, 1), @(1, -1), @(1, 0), @(1, 1))

<#
.SYNOPSIS
    Implement a program to find word in a search puzzle.

.DESCRIPTION
    Given a grid of letters, find the targey word that hides inside it.
    Words can be hidden in all kinds of directions: left-to-right, right-to-left, vertical and diagonal.

    Implement a class that will take in an array of string(s) represent the grid.
    Inside the class, implement a Search method that will take in a string as the target word.
    If found, return the result in an object that contain the location of the first and last letter.
    If the word doesn't exist in the grid, return $null.

    The object return must have these properties and their value in this format:
    - Start: @(row value, column value)
    - End  : @(row value, column value)
    Value of row and column follow the standard of 0-based index.

.EXAMPLE
    $grid = @(
        "jefblpepre",
        "camdcimgtc",
        "oivokprjsm",
        "pbwasqroua",
        "rixilelhrs",
        "wolcqlirpc",
        "screeaumgr",
        "alxhpburyi",
        "jalaycalmp",
        "clojurermt"
    )
    $puzzle = [WordSearch]::new($grid)
    $puzzle.Search("clojure")

    Returns: [PsCustomObject]@{
        Start = @(9, 0)
        End   = @(9, 6)
    }
#>
Class WordSearch {
    [string[]]$Grid

    WordSearch($grid) { $this.Grid = $grid }

    [object]Search([string]$word) {
        $l = $word.Length - 1
        for ($r = 0; $r -lt $this.Grid.Length; $r++) {
            for ($c = 0; $c -lt $this.Grid[$r].Length; $c++) {
                foreach ($d in $Global:Directions) {
                    foreach ($n in 0..$l) {
                        $r2, $c2 = @(($r + $d[0] * $n), ($c + $d[1] * $n))
                        if ($r2 -ge 0 -and $c2 -ge 0 -and $word[$n] -eq $this.Grid[$r2]?[$c2]) {
                            if ($n -eq $l) { return [PsCustomObject]@{Start = @($r, $c); End = @($r2, $c2)} }
                        } else { break }
                    }
                }
            }
        }

        return $null
    }
}
