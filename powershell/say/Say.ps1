$Global:First20 = @(
    "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine",
    "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"
)
$Global:MultiplesOfTen = @("", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety")
$Global:Powers = [ordered]@{1000000000 = " billion"; 1000000 = " million"; 1000 = " thousand"; 1 = ""}

Function Invoke-Say() {
    <#
    .SYNOPSIS
    Given a number from 0 to 999,999,999,999, spell out that number in English.

    .DESCRIPTION
    Implement a program to convert a number in a specific range to a string of that number in English.

    .PARAMETER Number
    An int in the range of 0 - 999,999,999,999 to be converted into english words.

    .EXAMPLE
    Invoke-Say -Number 12345
    Returns: "twelve thousand three hundred forty-five"
    #>
    [CmdletBinding()]
    Param(
        [ValidateRange(0, 999999999999)]
        [int64]$Number
    )

    if ($Number -lt 20) { return $Global:First20[$Number] }
    if ($Number -lt 100) { 
        return $Global:MultiplesOfTen[[int64][Math]::Floor($Number / 10)] + (($x = $Number % 10) ? "-$(Invoke-Say $x)" : "")
    }
    if ($Number -lt 1000) {
        return "$(Invoke-Say ([int64][Math]::Floor($Number / 100))) hundred" + (($x = $Number % 100) ? " $(Invoke-Say $x)" : "")
    }

    ($Global:Powers.GetEnumerator() | ForEach-Object {
        ($x = [int64][Math]::Floor($Number / $_.Key) % 1000) ? "$(Invoke-Say $x)$($_.Value)" : ""
    } | Where-Object { $_ }) -join " "
}
