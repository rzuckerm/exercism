Function Get-SpiralMatrix() {
    <#
    .SYNOPSIS
    Implement a function to generate a spiral matrix.

    .DESCRIPTION
    Given the size, return a square matrix of numbers in spiral order.
    The matrix should be filled with natural numbers, starting from 1 in the top-left corner, increasing in an inward, clockwise spiral order

    .PARAMETER Size
    Size of the matrix.

    .EXAMPLE
    Get-SpiralMatrix -Size 2
    Return: @(
        @(1,2),
        @(4,3)
    )
    #>
    [CmdletBinding()]
    Param(
        [int]$Size
    )

    # Initialize matrix
    for (($matrix = @()), ($i = 0); $i -lt $Size; $i++) { $matrix += ,(@(0) * $Size)}

    # Repeat until matrix is full
    for (($value = 1), ($start = 0), ($end = $Size - 1); $start -le $end; ($start++), ($end--)) {
        # Fill top-left to top-right of unoccupied matrix
        for ($i = $start; $i -le $end; ($matrix[$start][$i] = $value++), $i++) {}

        # Fill top-right to bottom-right of unoccupied matrix
        for ($i = $start + 1; $i -le $end; ($matrix[$i][$end] = $value++), $i++) {}

        # Fill bottom-right to bottom-left of unoccupied matrix
        for ($i = $end - 1; $i -ge $start; ($matrix[$end][$i] = $value++), $i--) {}

        # Fill bottom-left to top-left of unoccupied matrix
        for ($i = $end - 1; $i -gt $start; ($matrix[$i][$start] = $value++), $i--) {}
    }

    $matrix
}
