Function Get-Slices() {
    <#
    .SYNOPSIS
    Given a string of digits, output all the contiguous substrings of length `n` in that string.
    
    .DESCRIPTION
    The function takes a string of digits and returns all the contiguous substrings of length `n` in that string.

    .PARAMETER Series
    The string of digits

    .PARAMETER SliceLength
    The length of the slices to return
    
    .EXAMPLE
    Get-Slices -Series "01234" -SliceLength 2
    
    Returns: @("01", "12", "23", "34")
    #>
    [CmdletBinding()]
    Param(
        [string]$Series,
        [int]$SliceLength
    )

    $SeriesLength = $Series.Length
    if ($SliceLength -eq 0) { throw "Slice length cannot be zero." }
    if ($SliceLength -lt 0) { throw "Slice length cannot be negative."}
    if ($SeriesLength -eq 0) { throw "Series cannot be empty." }
    if ($SliceLength -gt $SeriesLength) { throw "Slice length cannot be greater than series length."}
    0..($SeriesLength - $SliceLength) | ForEach-Object { $Series.Substring($_, $SliceLength) }
}
