$Global:Colors = @("black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white")
$Global:Units = @("", "kilo", "mega", "giga")

Function Get-ResistorLabel() {
    <#
    .SYNOPSIS
    Implement a function to get the label of a resistor with three color-coded bands.

    .DESCRIPTION
    Given an array of colors from a resistor, decode their resistance values and return a string represent the resistor's label.

    .PARAMETER Colors
    The array repesent the 3 colors from left to right.

    .EXAMPLE
    Get-ResistorLabel -Colors @("red", "white", "blue")
    Return: "29 megaohms"
     #>
    [CmdletBinding()]
    Param(
        [string[]]$Colors
    )
    $Value = ($Global:Colors.IndexOf($Colors[0]) * 10 + $Global:Colors.IndexOf($Colors[1])) *
        [Math]::Pow(10, $Global:Colors.IndexOf($Colors[2]))
    $Order = 0
    While ($Value -ge 1000) {
        $Value /= 1000
        $Order++
    }
    "$Value " + $Global:Units[$Order] + "ohms"
}
