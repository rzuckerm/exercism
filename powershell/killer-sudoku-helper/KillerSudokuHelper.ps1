Function Invoke-KillerSudokuHelper() {
    <#
    .SYNOPSIS
    Implement a function to help solve killer sudoku.

    .DESCRIPTION
    Given a cage of certain size, a sum and an array of excluded number, follow the rules and find all possible combinations to fill the cage.
    To make the output of your program easy to read, the combinations it returns must be sorted.

    For example:
    7, [][][], No exclusion => Only possible solution is [1][2][4]
    [1][1][5], [1][3][3], [2][2][3] are all in violation of the "A digit may only occur once in a cage" rule.

    .PARAMETER Sum
    The target sum: total of all number in a cage.

    .PARAMETER Size
    The size of the cage: total cells available for the sum.

    .PARAMETER Exlude
    An array of number that should be excluded from consideration for the sum.

    .EXAMPLE
    Invoke-KillerSudokuHelper -Sum 5 -Size 2 -Exclude @(1)
    Return: @( ,@(2, 3))
    #>
    [CmdletBinding()]
    Param(
        [int]$Sum,
        [int]$Size,
        [int[]]$Exclude
    )

    $candidates = 1..9 | Where-Object { $_ -le $Sum -and $_ -notin $Exclude }
    Get-Combinations $Sum $Size $candidates @()
}

Function Get-Combinations([int]$sum, [int]$size, [int[]]$candidates, [int[]]$result) {
    if ($result.Length -eq $size -and $sum -eq 0) { return @(,$result) }

    for ($i = 0; $i -lt $candidates.Length; $i++) {
        $n =$candidates[$i]
        if ($n -le $sum) {
            Get-Combinations ($sum - $n) $size $candidates[($i + 1)..$candidates.Length] ($result + $n)
        }
    }
}
