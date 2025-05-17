Function Get-SquareRoot() {
    <#
    .SYNOPSIS
    Given a natural radicand, return its square root.
    
    .DESCRIPTION
    The function takes a positive integer and return its square root value.

    .PARAMETER Radicand
    The number to get its square root.
    
    .EXAMPLE
    Get-SquareRoot -Radicand 25
    Retuns: 5
    #>
    [CmdletBinding()]
    Param(
        [int]$Radicand
    )

    # Reference: https://en.wikipedia.org/wiki/Integer_square_root#Example_implementation_in_C
    if ($Radicand -le 1) { return $Radicand }
    $X0 = $Radicand -shr 1
    while (($X1 = ($X0 + [Math]::Floor($Radicand / $X0)) -shr 1) -lt $X0) { $X0 = $X1 }
    $X0
}