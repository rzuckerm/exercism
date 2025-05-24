$Global:Counts = @("No", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten")

Function Get-Lyric() {
    <#
    .SYNOPSIS
    Recite the lyrics to that popular children's repetitive song: Ten Green Bottles.

    .DESCRIPTION
    Given a start bottles and a number of bottles to be taken away, return a string made of lyric from the song Ten Green Bottles.
    Note that not all verses are identical.

    .PARAMETER Start
    Number of bottles to start with, in range 1-10

    .PARAMETER Take
    Number of bottles to be taken away, in range 1-10
    Taken bottles can't be larger than starting bottles.

    .EXAMPLE
    Get-Lyric -Start 7
    Return:
    @"
    Seven green bottles hanging on the wall,
    Seven green bottles hanging on the wall,
    And if one green bottle should accidentally fall,
    There'll be six green bottles hanging on the wall.
    "@"
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [ValidateRange(1, 10)]
        [int]$Start,
        [ValidateRange(1, 10)]
        [ValidateScript({ $_ -le $Start}, ErrorMessage = "You can't take more bottle than what you started with.")]
        [int]$Take = 1
    )

    ($Start..($Start - $Take + 1) | ForEach-Object { (Get-Verse $_) -join "`n" }) -join "`n`n"
}

function Get-Verse([int]$Verse) {
    @("$(Get-Line $Verse),") * 2 +
        @("And if one green bottle should accidentally fall,", "There'll be $((Get-Line ($Verse - 1)).ToLower()).")
}

function Get-Line([int]$Verse) { "$($Global:Counts[$Verse]) green bottle$(($Verse -ne 1) ? 's' : '') hanging on the wall" }
