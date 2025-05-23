Function Get-Proverb() {
    <#
    .SYNOPSIS
    Given a list of inputs, generate the relevant proverb.

    .DESCRIPTION
    Take a list of inputs and output the full text of a proverbial rhyme base on those inputs.

    .PARAMETER Data
    The list of inputs to generate the proverb.

    .EXAMPLE
    Get-Proverb -Data @("nail", "shoe", "horse", "rider", "message", "battle", "kingdom")

    @"
    For want of a nail the shoe was lost.
    For want of a shoe the horse was lost.
    For want of a horse the rider was lost.
    For want of a rider the message was lost.
    For want of a message the battle was lost.
    For want of a battle the kingdom was lost.
    And all for the want of a nail.
    "@
    #>
    [CmdletBinding()]
    Param(
        [string[]]$Data
    )

    (0..$Data.Length | Select-Object -SkipLast 1 | ForEach-Object { $_ -le ($Data.Length - 2) ?
        "For want of a $($Data[$_]) the $($Data[$_ + 1]) was lost." : "And all for the want of a $($Data[0])."}) -join "`r`n"
}
