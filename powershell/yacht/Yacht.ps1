# Score categories. Change the values as you see fit.
Enum Category { YACHT; ONES; TWOS; THREES; FOURS; FIVES; SIXES; FULL_HOUSE; FOUR_OF_A_KIND; LITTLE_STRAIGHT; BIG_STRAIGHT; CHOICE }

Function Get-Score() {
    <#
    .SYNOPSIS
    Implement a function to get the score of a yacht game.

    .DESCRIPTION
    Given a list of values for five dice and a category, your solution should return the score of the dice for that category.
    If the dice do not satisfy the requirements of the category your solution should return 0.
    You can assume that five values will always be presented, and the value of each will be between one and six inclusively.
    You should not assume that the dice are ordered.

    .PARAMETER Dice
    An array of 5 integer, each represent a dice value.

    .PARAMETER Category
    An Enum value represent a category in the game of yacht.

    .EXAMPLE
    Get-Score -Dice @(1,2,3,4,5) -Category CHOICE
    Return: 15
    #>
    [CmdletBinding()]
    Param(
        [int[]]$Dice,
        [Category]$Category
    )

    $SD = $Dice | Sort-Object
    $U = ($Dice | Select-Object -Unique).Length
    $Total = ($Dice | Measure-Object -Sum).Sum
    switch ($Category) {
        ([Category]::YACHT) { return ($U -eq 1) ? 50 : 0 }
        { $_ -in [Category]::ONES..[Category]::SIXES } { return ($Dice | Where-Object { $_ -eq $Category }).Length * $Category }
        ([Category]::FULL_HOUSE) { return ($U -eq 2 -and ($SD[0] -eq $SD[1] -or $SD[0] -eq $SD[2])) ? $Total : 0 }
        ([Category]::FOUR_OF_A_KIND) { return ($U -le 2 -and $SD[1] -eq $SD[3]) ? 4 * $SD[1] : 0 }
        ([Category]::LITTLE_STRAIGHT) { return ($U -eq 5 -and $SD[0] -eq 1 -and $SD[4] -eq 5) ? 30 : 0 }
        ([Category]::BIG_STRAIGHT) { return ($U -eq 5 -and $SD[0] -eq 2 -and $SD[4] -eq 6) ? 30 : 0 }
    }

    $Total
}
