Function Invoke-Counter() {
    <#
    .SYNOPSIS
    Count the number of '1' bit in the binary representation of a decimal number.

    .DESCRIPTION
    Given an integer, count all the '1' bit from the binary representation of that integer.
    Example: 25 is '11001' in binary form, and has 3 bits which are '1'.

    .PARAMETER Value
    Integer represent the decimal value being displayed.

    .EXAMPLE
    Invoke-Counter -Value 12345
    Returns: 6
    #>
    [CmdletBinding()]
    Param(
        [int]$Value
    )

    (0..31 | Where-Object { ($Value -shr $_) -band 1 }).Length
}
