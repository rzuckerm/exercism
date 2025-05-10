Function Invoke-Anagram() {
    <#
    .SYNOPSIS
    Determine if a word is an anagram of other words in a list.

    .DESCRIPTION
    An anagram is a word formed by rearranging the letters of another word, e.g., spar, formed from rasp.
    Given a word and a list of possible anagrams, find the anagrams in the list.

    .PARAMETER Subject
    The word to check

    .PARAMETER Candidates
    The list of possible anagrams

    .EXAMPLE
    Invoke-Anagram -Subject "listen" -Candidates @("enlists" "google" "inlets" "banana")
    #>
    [CmdletBinding()]
    Param(
        [string]$Subject,
        [string[]]$Candidates
    )

    function Get-SortedLetters([string]$Str) { -join ($Str.ToLower().ToCharArray() | Sort-Object) }
    $SubjectLetters = Get-SortedLetters($Subject)
    $Candidates | Where-Object { $Subject -ne $_ -and $SubjectLetters -eq (Get-SortedLetters($_)) }
}
