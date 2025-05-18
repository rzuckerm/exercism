$Global:Lyrics = @(
    @("first", "a Partridge in a Pear Tree."), @("second", "two Turtle Doves, and"), @("third", "three French Hens,"),
    @("fourth", "four Calling Birds,"), @("fifth", "five Gold Rings,"), @("sixth", "six Geese-a-Laying,"),
    @("seventh", "seven Swans-a-Swimming,"), @("eighth", "eight Maids-a-Milking,"), @("ninth", "nine Ladies Dancing,"),
    @("tenth", "ten Lords-a-Leaping,"), @("eleventh", "eleven Pipers Piping,"), @("twelfth", "twelve Drummers Drumming,")
)

Function Invoke-TwelveDays() {
    <#
    .SYNOPSIS
    Recite the lyrics of the song: "The Twelve Days of Christmas" based on given verses.

    .DESCRIPTION
    Given a start verse and an end verse, return the string lyric of the English Christmas carol "The Twelve Days of Christmas".
    Each subsequent verse of the song builds on the previous verse.

    .PARAMETER Start
    The starting verse.

    .PARAMETER End
    The ending verse.

    .EXAMPLE
    Invoke-TwelveDays -Start 1 -End 1
    Return: "On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree."
    #>
    [CmdletBinding()]
    Param(
        [int]$Start,
        [int]$End
    )

    ($Start..$End | ForEach-Object { "On the $($Global:Lyrics[$_ - 1][0]) day of Christmas my true love gave to me: " +
        ($_..1 | ForEach-Object { $Global:Lyrics[$_ - 1][1] }) -join " "}) -join "`n"
}
