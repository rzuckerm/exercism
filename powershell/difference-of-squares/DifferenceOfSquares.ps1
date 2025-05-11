Function Get-SquareOfSum() {
    <#
    .SYNOPSIS
    Get the square of sum of a number.

    .DESCRIPTION
    Given a number, return the square of sum of all numbers up to and including that number.

    .PARAMETER Number
    The number to calculate the square of sum.
    
    .EXAMPLE
    Get-SquareOfSum -Number 12
    #>
    [CmdletBinding()]
    Param(
        [Int64]$Number
    )

    $Number * $Number * ($Number + 1) * ($Number + 1) / 4
}

Function Get-SumOfSquares() {
    <#
    .SYNOPSIS
    Get the sum of squares of a number.

    .DESCRIPTION
    Given a number, return the sum of squares of all numbers up to and including that number.

    .PARAMETER Number
    The number to calculate the sum of squares.

    .EXAMPLE
    Get-SumOfSquares -Number 12
    #>
    [CmdletBinding()]
    Param(
        [Int64]$Number
    )

    $Number * ($Number + 1) * (2 * $Number + 1) / 6
}

Function Get-DifferenceOfSquares() {
    <#
    .SYNOPSIS
    Get the difference of squares of a number.

    .DESCRIPTION
    Given a number, return the difference of squares of all numbers up to and including that number.

    .PARAMETER Number
    The number to calculate the difference of squares.

    .EXAMPLE
    Get-DifferenceOfSquares -Number 12
    #>
    [CmdletBinding()]
    Param(
        [Int64]$Number
    )

    (Get-SquareOfSum -Number $Number) - (Get-SumOfSquares -Number $Number)
}
