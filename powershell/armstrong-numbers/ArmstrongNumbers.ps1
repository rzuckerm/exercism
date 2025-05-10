Function Invoke-ArmstrongNumbers() {
    <#
    .SYNOPSIS
    Determine if a number is an Armstrong number.

    .DESCRIPTION
    An Armstrong number is a number that is the sum of its own digits each raised to the power of the number of digits.

    .PARAMETER Number
    The number to check.

    .EXAMPLE
    Invoke-ArmstrongNumbers -Number 12
    #>
    [CmdletBinding()]
    Param(
        [Int64]$Number
    )

    $Digits = ([string]$Number).ToCharArray() | ForEach-Object { [int][string]$_ }
    ($Digits | ForEach-Object { [Math]::Pow($_, $Digits.Length) } | Measure-Object -sum).sum -eq $Number
}
