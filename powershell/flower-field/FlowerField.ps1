$Global:Dirs = @(@(-1, -1), @(-1, 0), @(-1, 1), @(0, -1), @(0, 1), @(1, -1), @(1, 0), @(1, 1))

Function Get-Annotate() {
    <#
    .SYNOPSIS
    Add the flower counts to a completed Flower Field board.

    .DESCRIPTION
    Flower Field is a popular game where the user has to find the flowers using numeric hints that indicate how many flowers are directly adjacent (horizontally, vertically, diagonally) to a square.

    In this exercise you have to create some code that counts the number of flowers adjacent to a given empty square and replaces that square with the count.

    The board is a rectangle composed of blank space (' ') characters.
    A flower is represented by an asterisk (`*`) character.

    If a given space has no adjacent flowers at all, leave that square blank.

    .PARAMETER Garden
    An array of string, each representing a row of the garden.
    This parameter should be validated to check that only blank spaces and asterisks are in it.

    .EXAMPLE
    Get-Annotate Garden @(" *** ")
    Returns: @("1***1")
    #>
    [CmdletBinding()]
    Param(
        [string[]]$Garden
    )

    if ((-join $Garden) -match "[^ *]") { throw "Invalid garden" }

    $board = @($Garden | ForEach-Object { @(, $_.ToCharArray() )})
    for ($r = 0; $r -lt $board.Length; $r++) {
        for ($c = 0; $c -lt $board[$r].Length; $c++) {
            if ($board[$r][$c] -eq '*') { continue }
            $count = ($Global:Dirs | ForEach-Object {
                $r2, $c2 = ($r + $_[0]), ($c + $_[1])
                [int]($r2 -ge 0 -and $c2 -ge 0 -and $board[$r2]?[$c2] -eq '*')
            } | Measure-Object -Sum).Sum
            if ($count) { $board[$r][$c] = [string]($count) }
        }
    }

    $board | ForEach-Object { @(, (-join $_ ))}
}