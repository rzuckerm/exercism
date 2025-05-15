Enum Sublist { EQUAL; SUBLIST; SUPERLIST; UNEQUAL }

Function Invoke-Sublist() {
    <#
    .SYNOPSIS
    Determine the relationship of two arrays.

    .DESCRIPTION
    Given two arrays, determine the relationship of the first array relating to the second array.
    There are four possible categories: EQUAL, UNEQUAL, SUBLIST and SUPERLIST.
    Note: This exercise use Enum values for return.
    
    .PARAMETER Data1
    The first array

    .PARAMETER Data2
    The second array

    .EXAMPLE
    Invoke-Sublist -Data1 @(1,2,3) -Data2 @(1,2,3)
    Return: [Sublist]::EQUAL

    Invoke-Sublist -Data1 @(1,2) -Data2 @(1,2,3)
    Return: [Sublist]::SUBLIST
    #>
    [CmdletBinding()]
    Param (
        [object[]]$Data1,
        [object[]]$Data2
    )
    if ([Linq.Enumerable]::SequenceEqual([object[]]$Data1, [object[]]$Data2)) { return [Sublist]::EQUAL }
    if ($Data1.Length -eq 0 -or (Test-Sublist $Data1 $Data2)) { return [Sublist]::SUBLIST }
    if ($Data2.Length -eq 0 -or (Test-Sublist $Data2 $Data1)) { return [Sublist]::SUPERLIST }
    return [Sublist]::UNEQUAL
}

function Test-Sublist([object[]]$Data1, [object[]]$Data2) {
    $Result = $false
    if ($Data1.Length -lt $Data2.Length) {
        for ($X = 0; -not $Result -and $X -le ($Data2.Length - $Data1.Length); $X++) { 
            $Result = [Linq.Enumerable]::SequenceEqual([object[]]$Data1, [object[]]$Data2[$X..($X + $Data1.Length - 1)])
        }
    }
    $Result
}
