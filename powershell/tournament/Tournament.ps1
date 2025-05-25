Function Invoke-Tournament {
    <#
    .SYNOPSIS
    Tally the results of a small football competition.

    .DESCRIPTION
    Given an array of string containing which team played against which and what the outcome was, create a tally table.

    .PARAMETER Results
    An array of the string, each line represent a match being played and its outcome.

    .EXAMPLE
    Invoke-Tournament -Results @("Annalyn;Elyses;win")
    
    return:
    @"
    Team                           | MP |  W |  D |  L |  P
    Annalyn                        |  1 |  1 |  0 |  0 |  3
    Elyses                         |  1 |  0 |  0 |  1 |  0
    "@
    #>
    [CmdletBinding()]
    Param(
        [string[]]$Results
    )

    $teams = @{}
    foreach ($result in $Results) {
        $team1, $team2, $outcome = $result -split ";"
        $teams[$team1] = Get-Score $teams[$team1] ($outcome -eq "win") ($outcome -eq "draw") ($outcome -eq "loss")
        $teams[$team2] = Get-Score $teams[$team2] ($outcome -eq "loss") ($outcome -eq "draw") ($outcome -eq "win")
    }

    (@("Team                           | MP |  W |  D |  L |  P") +
        ($teams.GetEnumerator() | Sort-Object -Property { -$_.Value[4] }, Key |
        ForEach-Object { "{0,-30} | {1,2} | {2,2} | {3,2} | {4,2} | {5,2}" -f (@($_.Key) + $_.Value) })) -join "`n"
}

Function Get-Score([object] $current, [boolean]$win, [boolean]$draw, [boolean]$loss) {
    $current = $current ?? @(0, 0, 0, 0, 0)
    @(($current[0] + 1), ($current[1] + $win), ($current[2] + $draw), ($current[3] + $loss), ($current[4] + 3 * $win + $draw))
}
