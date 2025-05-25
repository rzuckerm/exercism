Function Get-LargestSeriesProduct() {
    <#
    .SYNOPSIS
    Get the largest product in a given span of long sequence of digits.
    
    .DESCRIPTION
    Given a string made up by number and a span lenght, find the largest product of all the number in that span.
    
    .PARAMETER Digits
    The string digits to be analyzed.

    .PARAMETER Span
    The lenght of the span.
    
    .EXAMPLE
    Get-LargestSeriesProduct -Digits "63915" -Span 3
    Return: 162
    #>
    [CmdletBinding()]
    Param(
        [string]$Digits,
        [int]$Span
    )

    $len = $Digits.Length
    if ($Span -gt $len) { throw "Error: span must be smaller than string length" }
    if ($Digits -match '\D') { throw "Error: digits input must only contain digits" }
    if ($Span -lt 0) { throw "Error: span must not be negative" }

    (@(for ($i = 0; $i -le ($len - $Span); $i++) {
        $product = 1
        $Digits.Substring($i, $Span).ToCharArray() | ForEach-Object { $product *= $_ - [char]'0' }
        $product
    }) | Measure-Object -Maximum).Maximum
}
