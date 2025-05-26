$Global:Wriggled = "wriggled and jiggled and tickled inside her"
$Global:Song = @{
    # Animal, 2nd line, 2nd line suffix (if any)
    1 = @("fly", "I don't know why she swallowed the fly. Perhaps she'll die.", "")
    2 = @("spider", "It ${Global:Wriggled}.", " that ${Global:Wriggled}")
    3 = @("bird", "How absurd to swallow a bird!", "")
    4 = @("cat", "Imagine that, to swallow a cat!", "")
    5 = @("dog", "What a hog, to swallow a dog!", "")
    6 = @("goat", "Just opened her throat and swallowed a goat!", "")
    7 = @("cow", "I don't know how she swallowed a cow!", "")
    8 = @("horse", "She's dead, of course!", "")
}

Function Invoke-FoodChain() {
    <#
    .SYNOPSIS
    Generate the lyrics of the song 'I Know an Old Lady Who Swallowed a Fly'.

    .DESCRIPTION
    Given a start verse and an end verse, generate a string lyric from the song 'I Know an Old Lady Who Swallowed a Fly'.

    .PARAMETER Start
    The starting verse. This parameter is mandatory.

    .PARAMETER End
    The ending verse. This parameter is optional.
    If not provided, it should be the same as starting verse.

    .EXAMPLE
    Invoke-FoodChain -Start 2
    Return:
    @"
    I know an old lady who swallowed a spider.
    It wriggled and jiggled and tickled inside her.
    She swallowed the spider to catch the fly.
    I don't know why she swallowed the fly. Perhaps she'll die.
    "@
    #>
    [CmdletBinding()]
    Param(
        [int]$Start,
        [object]$End
    )

    ($Start..($End ?? $Start) | ForEach-Object { (Get-Verses $_) -join "`n" }) -join "`n`n"
}

Function Get-Verses([int]$verseNum) {
    @("I know an old lady who swallowed a $($Global:Song[$verseNum][0]).", $Global:Song[$verseNum][1])
    if ($verseNum -ge 2 -and $verseNum -le 7) {
        for ($n = $verseNum; $n -ge 2; $n--) {
            "She swallowed the $($Global:Song[$n][0]) to catch the $($Global:Song[$n - 1][0])$($Global:Song[$n - 1][2])."
        }

        $Global:Song[1][1]
    }
}
