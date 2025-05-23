Function Invoke-PigLatin() {
    <#
    .SYNOPSIS
    Implement a program that translates from English to Pig Latin.

    .DESCRIPTION
    Pig Latin is a made-up children's language that's intended to be confusing.
    It obeys a few simple rules (below), but when it's spoken quickly it's really difficult for non-children (and non-native speakers) to understand.

    - **Rule 1**: If a word begins with a vowel sound, add an "ay" sound to the end of the word.
    Please note that "xr" and "yt" at the beginning of a word make vowel sounds (e.g. "xray" -> "xrayay", "yttria" -> "yttriaay").
    - **Rule 2**: If a word begins with a consonant sound, move it to the end of the word and then add an "ay" sound to the end of the word.
    Consonant sounds can be made up of multiple consonants, such as the "ch" in "chair" or "st" in "stand" (e.g. "chair" -> "airchay").
    - **Rule 3**: If a word starts with a consonant sound followed by "qu", move it to the end of the word, and then add an "ay" sound to the end of the word (e.g. "square" -> "aresquay").
    - **Rule 4**: If a word contains a "y" after a consonant cluster or as the second letter in a two letter word it makes a vowel sound (e.g. "rhythm" -> "ythmrhay", "my" -> "ymay").

    There are a few more rules for edge cases, and there are regional variants too.
    Check the tests for all the details.

    .PARAMETER Text
    A string represent a word or phrase in English.

    .EXAMPLE
    Invoke-PigLatin -Text "exercism"
    Returns: "exercismay"
    #>
    [CmdletBinding()]
    Param(
        [string]$Text
    )

    @(switch -regex ($Text -split " ") {
        "^(xr|yt|[aeiou])" { "${_}ay"; continue }
        "^(y|[bcdfghjklmnprstvwxz]*qu|[bcdfghjklmnpqrstvwxz]+)(.*)" { "$($Matches[2])$($Matches[1])ay"; continue }
    }) -join " "
}
