Function Get-BestHand() {
    <#
    .SYNOPSIS
    Pick the best hand(s) from a list of poker hands.

    .DESCRIPTION
    Given an array of poke hands, pick out the best (highest value) hand(s) and return them in an array.

    .PARAMETER Hands
    An array of string(s), each representing a poker hand.

    .EXAMPLE
    Get-BestHand -Hands @("AS QS KS 10S JS", "JS AH QD 10S KC")
    Return: @("AS QS KS 10S JS")
    #>
    [CmdletBinding()]
    Param(
        [string[]]$Hands
    )

    $rankedHands = @($Hands | ForEach-Object { @(, (Invoke-RankHand $_)) } |
        Sort-Object -Stable -Property { $_[0] } -Descending)
    $rankedHands | Where-Object { $_[0] -eq $rankedHands[0][0] } | ForEach-Object { $_[1..5] }
}

Function Invoke-RankHand([string]$hand) {
    # Convert face value to a number from 2 to 14, where: J=11, Q=12, K=13, A=14, and sort in descending order
    $values = [int[]]($hand.Split() -replace "[JQKA]", { "JQKA".IndexOf($_) + 11 }  -replace ".$", "") |
        Sort-Object -Descending

    # Convert Ace Low Straight
    if (-not (Compare-Object -PassThru $values @(14, 5, 4, 3, 2))) { $values = 5..1 }

    # Organize values so that values with highest frequency are first and cards with same frequency are in
    # descending order
    $orgValues = $values | Group-Object | Sort-Object -Property Count, { $_.Group[0] } -Descending |
        ForEach-Object { $_.Group }

    # Indicate whether this is a Flush
    $isFlush = ($hand.Split() -replace '[\dJQKA]', "" | Select-Object -Unique).Length -eq 1

    # Indicate whether this is a Straight
    $isStraight = -not (Compare-Object -PassThru $values @($values[0]..($values[0] - 4)))

    # Find best rank based on organized values
    if ($orgValues[0] -eq $orgValues[4]) { $rank = 9 } # Five of a Kind
    elseif ($isFlush -and $isStraight) { $rank = 8 } # Straight Flush
    elseif ($orgValues[0] -eq $orgValues[3]) { $rank = 7 } # Four of a Kind
    elseif ($orgValues[0] -eq $orgValues[2] -and $orgValues[3] -eq $orgValues[4]) { $rank = 6 } # Full House
    elseif ($isFlush) { $rank = 5 } # Flush
    elseif ($isStraight) { $rank = 4 } # Straight
    elseif ($orgValues[0] -eq $orgValues[2]) { $rank = 3 } # Three of a Kind
    elseif ($orgValues[0] -eq $orgValues[1] -and $orgValues[2] -eq $orgValues[3]) { $rank = 2 } # Two Pair
    elseif ($orgValues[0] -eq $orgValues[1]) { $rank = 1 } # One Pair
    else { $rank = 0 } # High Card

    # Calculate score for hand: (rank * 16**5) + sum(values[k]**(4 - k), k=0..4)
    $score = $rank
    foreach ($x in $orgValues) { $score = $score * 16 + $x }

    # Return score and hand
    @($score, $hand)
}
