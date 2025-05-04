$Global:Colors = @("black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white")
$Global:Units = @("", "kilo", "mega", "giga")
$Global:TolColors = @("grey", "violet", "blue", "green", "brown", "red", "gold", "silver")
$Global:Tols = @(0.05, 0.1, 0.25, 0.5, 1, 2, 5, 10)

Function Get-ResistorLabel() {
    <#
    .SYNOPSIS
    Implement a function to get the label of a resistor from its color-coded bands.

    .DESCRIPTION
    Given an array of 1, 4 or 5 colors from a resistor, decode their resistance values and return a string represent the resistor's label.

    .PARAMETER Colors
    The array represent the colors from left to right.

    .EXAMPLE
    Get-ResistorLabel -Colors @("red", "black", "green", "red")
    Return: "2 megaohms ±2%"

    Get-ResistorLabel -Colors @("blue", "blue", "blue", "blue", "blue")
    Return: "666 megaohms ±0.25%"
     #>
    [CmdletBinding()]
    Param(
        [string[]]$Colors
    )
    If ($Colors.Count -eq 1) { return $Global:Colors.IndexOf($Colors[0]).ToString() + " ohms" }

    $Value = [Int](($Colors[0..($Colors.Count - 3)] | 
        ForEach-Object { $Global:Colors.IndexOf($_).ToString() }) -join "") *
        [Math]::Pow(10, $Global:Colors.IndexOf($Colors[-2]))
    $Order = 0
    While ($Value -ge 1000) {
        $Value /= 1000
        $Order++
    }

    "$Value $($Global:Units[$Order])ohms ±$($Global:Tols[$Global:TolColors.IndexOf($Colors[-1])])%"
}
