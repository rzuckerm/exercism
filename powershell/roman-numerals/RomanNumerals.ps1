$Global:Romans = [ordered]@{
    M = 1000; CM = 900; D = 500; CD = 400; C = 100; XC = 90; L = 50; XL = 40; X = 10; IX = 9; V = 5; IV = 4; I = 1
}

Function Get-RomanNumerals() {
    <#
    .SYNOPSIS
    Given a number, convert it into a roman numeral.

    .DESCRIPTION
    Convert a positive integer into a string representation of that integer in roman numeral form.
    
    .PARAMETER Number
    The number to turn into roman numeral.

    .EXAMPLE
    Get-RomanNumerals -Number 1
    return: 'I'
    Get-RomanNumerals -Number 3999
    return: 'MMMCMXCIX'
    #>
    [CmdletBinding()]
    Param(
        [int]$Number
    )

    if ($Number -lt 1 -or $Number -gt 3999) { throw "Number has to be positive integer in range of 1-3999." }

    -join ($Global:Romans.GetEnumerator() | ForEach-Object { $_.Key * [Math]::Floor($Number / $_.Value); $Number %= $_.Value })
}
