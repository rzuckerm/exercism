Function Get-PascalsTriangleRows() {
    <#
    .SYNOPSIS
    Returns the first n rows of Pascal's triangle.
    
    .DESCRIPTION
    Given a count, returns the first n rows of Pascal's triangle.
    
    .PARAMETER Count
    The number of rows to return.
    
    .EXAMPLE
    Get-PascalsTriangleRows -Count 1
    
    Returns: @(
        @(1)
    )
    #>
    [CmdletBinding()]
    Param(
        [string]$Count
    )

    $rows = ($Count -gt 0) ? @(@(1)) : @()
    for ($l = 1; $l -lt $Count; $l++) {
        $rows += @(,(0..$l | ForEach-Object { (($_ -lt 1) ? 0 : $rows[$l - 1][$_ - 1]) + ($rows[$l - 1][$_] ?? 0) }))
    }

    $rows
}
