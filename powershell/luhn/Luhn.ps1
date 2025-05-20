Function Test-Luhn() {
    <#
    .SYNOPSIS
    Determine if a number is valid per the Luhn formula.
    
    .DESCRIPTION
    The Luhn formula is a simple checksum formula used to validate a variety of identification numbers,
    such as credit card numbers and Canadian Social Insurance Numbers.
    
    .PARAMETER Value
    The number to validate
    
    .EXAMPLE
    Test-Luhn -Value "59"
    
    Returns: $true
    #>
    [CmdletBinding()]
    Param(
        [string]$Value
    )

    $Value = $Value -replace " ", ""
    if ($Value.Length -lt 2 -or $Value -match "\D") { return $false }

    $D = ($Value.Length - 1)..0 | ForEach-Object { $Value[$_] - [char]"0" }
    (0..($D.Length - 1) | ForEach-Object { ($_ % 2) ? 2 * ($D[$_] % 5) + [Math]::floor($D[$_] / 5) : $D[$_] } |
        Measure-Object -Sum).Sum % 10 -eq 0
}
