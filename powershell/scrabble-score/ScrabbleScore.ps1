#                  A  B  C  D  E  F  G  H  I  J  K  L  M  N  O  P  Q   R  S  T  U  V  W  X  Y  Z
$Global:Scores = @(1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10)

Function Get-ScrabbleScore() {
    <#
    .SYNOPSIS
    Given a word, compute the Scrabble score for that word.

    .DESCRIPTION
    Take a string and return an integer value as score based on the values of letters.
    If the word landed on a bonus, double the point for that word.

    Letter                           Value
    A, E, I, O, U, L, N, R, S, T       1
    D, G                               2
    B, C, M, P                         3
    F, H, V, W, Y                      4
    K                                  5
    J, X                               8
    Q, Z                               10

    .PARAMETER Word
    The string to calculate scrabble score.

    .PARAMETER Bonus
    A boolean value that activate the bonus point if present.

    .EXAMPLE
    Get-ScrabbleScore -Word "Hello"
    Return: 8
    #>
    [CmdletBinding()]
    Param(
        [string]$Word,
        [switch]$Bonus
    )
    ($Word.ToUpper().ToCharArray() | ForEach-Object { $Global:Scores[$_ - [char]'A'] } |
        Measure-Object -Sum).Sum * ($Bonus ? 2 : 1)
}
