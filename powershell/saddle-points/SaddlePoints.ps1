<#
.DESCRIPTION
    A helper class act as a data structure for the saddle point.
    It has a two properties: Row and Column, their indexes should be offset by 1 to reflect normal counting.
    It also has an Equals method for comparison in tests.
    Please don't delete or change this class.
#>
Class SaddlePoint {
    [int]$Row
    [int]$Column

    SaddlePoint($row, $col) {
        $this.Row = $row
        $this.Column = $col
    }

    [bool] Equals($other) {
        return $this.Row -eq $other.Row -and $this.Column -eq $other.Column
    }
}

Function Get-SaddlePoints() {
    <#
    .SYNOPSIS
    Find all the available saddle points in a given matrix.

    .DESCRIPTION
    Given a matrix (jagged arrays), return all the available saddle points found.
    The matrix can have a different number of rows and columns (non square), and it may have zero or more saddle points.

    It's called a "saddle point" because it is greater than or equal to every element in its row and less than or equal to every element in its column.

    Your code should be able to provide the (possibly empty) list of all the saddle points for any given matrix.

    .PARAMETER Matrix
    An array of arrays, each inner array contains number that could be a saddle point.

    .EXAMPLE
    Get-SaddlePoints -Matrix @( ,@(1, 2, 3))
    Returns: [SaddlePoint]::new(1, 3)
    #>
    [CmdletBinding()]
    Param(
        [int[][]]$Matrix
    )

    if ($Matrix | Where-Object { $_.Length -ne $Matrix[0].Length }) { throw "Irregular matrix" }

    $Maxes = $Matrix | ForEach-Object { ($_ | Measure-Object -Maximum).Maximum }
    $Mins = for ($C = 0; $C -lt $Matrix[0].Length; $C++) {
        (0..($Matrix.Length - 1) | ForEach-Object { $Matrix[$_][$C] } | Measure-Object -Minimum).Minimum
    }

    for ($R = 1; $R -le $Maxes.Length; $R++) {
        1..$Mins.Length | Where-Object { $Maxes[$R - 1] -eq $Mins[$_ - 1] } | ForEach-Object { [SaddlePoint]::new($R, $_) }
    }
}
