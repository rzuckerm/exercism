Enum Triangle { EQUILATERAL = 1; ISOSCELES = 2; SCALENE = 3 }

Function Get-Triangle() {
    <#
    .SYNOPSIS
    Determine if a triangle is equilateral, isosceles, or scalene.

    .DESCRIPTION
    Given 3 sides of a triangle, return the type of that triangle if it is a valid triangle.
    
    .PARAMETER Sides
    The lengths of a triangle's sides.

    .EXAMPLE
    Get-Triangle -Sides @(1,2,3)
    Return: [Triangle]::SCALENE
    #>
    
    [CmdletBinding()]
    Param (
        [double[]]$Sides
    )
    $A, $B, $C = $Sides | Sort-Object
    if ($A -le 0) { throw "All side lengths must be positive." }
    if ($A + $B -lt $C) { throw "Side lengths violate triangle inequality." }
    [Triangle].GetEnumName(($Sides | Group-Object).Length)
}
