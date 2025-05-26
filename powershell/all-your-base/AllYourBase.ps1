Function Invoke-Rebase() {
    <#
    .SYNOPSIS
    Convert a number, represented as a sequence of digits in one base, to any other base.

    .DESCRIPTION
    Implement general base conversion of a number.
    Given an array of digits represent a number in base "a", convert it and return an array of digits represent the same number in base "b".

    .PARAMETER Digits
    Array of digits represent the number to be converted.

    .PARAMETER InputBase
    The original base of the number.

    .PARAMETER OutputBase
    The base to be converted to.

    .EXAMPLE
    Invoke-Rebase -Digits @(1, 0, 1 , 0 ,1 ) -InputBase 2 -OutputBase 10
    return : @(2, 1)
    #>
    [CmdletBinding()]
    Param(
        [int[]]$Digits,
        [int]$InputBase,
        [int]$OutputBase
    )

    if ($InputBase -lt 2) { throw "input base must be >= 2" }
    if ($OutputBase -lt 2) { throw "output base must be >= 2" }
    if ($Digits | Where-Object { $_ -lt 0 -or $_ -ge $InputBase }) { throw "all digits must satisfy 0 <= digit < input base" }

    $output = @()
    $q = 0
    for ($Digits | ForEach-Object { $q = $q * $InputBase + $_ }; $q; $q = [int][Math]::Floor($q / $OutputBase)) {
        $output += $q % $OutputBase
    }

    $output ? $output[$output.Length..0] : @(0)
}
