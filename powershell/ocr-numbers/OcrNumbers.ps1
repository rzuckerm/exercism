$Global:OcrNumbers = @{
    " _ | ||_|   " = "0"; "     |  |   " = "1"; " _  _||_    " = "2"; " _  _| _|   " = "3"; "   |_|  |   " = "4";
    " _ |_  _|   " = "5"; " _ |_ |_|   " = "6"; " _   |  |   " = "7"; " _ |_||_|   " = "8"; " _ |_| _|   " = "9"
}

Function Invoke-OCR() {
    <#
    .SYNOPSIS
    Implement a function for OCR (optical character recognition) to convert it into a number.

    .DESCRIPTION
    Given a grid of pipes, underscores, and spaces, determine which number is represented, or whether it is garbled.
    Return the number string or "?" if it is garbled.

    .PARAMETER Grid
    An array of strings, each represent a row of the grid.

    .EXAMPLE
    $lines = (
        "   ",
        "  |",
        "  |",
        "   "
    )
    Convert-OCR -Grid $lines
    Return: "1"
    #>
    [CmdletBinding()]
    Param(
        [string[]]$Grid
    )

    if ($Grid.Length % 4) { throw "Number of input lines is not a multiple of four" }
    if ($Grid | Where-Object { $_.Length % 3 }) { throw "Number of input columns is not a multiple of three" }

    @(for ($i = 0; $i -lt $Grid.Length; $i += 4) {
        -join @(for ($j = 0; $j -lt $Grid[$i].Length; $j += 3) {
            $Global:OcrNumbers[-join (0..3 | ForEach-Object { $Grid[$i + $_].Substring($j, 3) })] ?? "?"
        })
    }) -join ","
}
