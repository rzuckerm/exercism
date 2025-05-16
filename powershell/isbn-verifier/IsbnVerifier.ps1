Function Test-Isbn() {
    <#
    .SYNOPSIS
    Determine if an ISBN is valid or not.
    
    .DESCRIPTION
    Given a string the function should check if the provided string is a valid ISBN-10.
    
    .PARAMETER Isbn
    The ISBN to check
    
    .EXAMPLE
    Test-Isbn -Isbn "3-598-21508-8"
    
    Returns: $true
    #>
    [CmdletBinding()]
    Param(
        [string]$Isbn
    )

    $Digits = $Isbn -replace "-", ""
    $Digits.Length -eq 10 -and $Digits -cmatch "^\d{9}[\d|X]" -and (
        (0..9 | ForEach-Object { (10 - $_) * (($Digits[$_] -eq "X") ? 10 : ($Digits[$_] - [char]"0")) } |
        Measure-Object -Sum).Sum % 11 -eq 0
    )
}
