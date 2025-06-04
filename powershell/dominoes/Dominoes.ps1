Function Test-DominoesChain() {
    <#
    .SYNOPSIS
    Implement a function to test if a dominoes chain can be made.

    .DESCRIPTION
    Given a list of dominoes, check to see if they can form a chain.
    A correct chain mean the dots on one half of a stone match the dots on the neighboring half of an adjacent stone,
    and that dots on the halves of the stones which don't have a neighbor (the first and last stone) match each other.

    .PARAMETER Dominoes
    A list of 2-elements arrays, each array represent a domino.

    .EXAMPLE
    Test-DominoesChain -Dominoes @( @(1, 5), @(5, 6), @(6, 1))
    Return: true
    #>
    [CmdletBinding()]
    Param(
        [Collections.Generic.List[int[]]]$Dominoes
    )

    if ($Dominoes.Count -le 1) { return $Dominoes.Count -eq 0 -or $Dominoes[0][0] -eq $Dominoes[0][1] }

    $chainables = Get-Chainables $Dominoes
    if (-not $chainables) { return $false }

    $visited = [Collections.Generic.HashSet[int]]::new()
    $chain = [Collections.Generic.List[int[]]]::new()
    Test-Chain 0 $Dominoes $chainables $visited $chain
}

Function Get-Chainables($dominoes) {
    # Figure out which dominoes can be chained together and in which orientation
    $chainables = @(, @() * (2 * $dominoes.Count))
    for ($i = 0; $i -lt $dominoes.Count; $i++) {
        $f1, $s1 = $Dominoes[$i]
        foreach ($k in 0..1) {
            $s = @($s1, $f1)[$k]
            for ($j = 0; $j -lt $dominoes.Count; $j++) {
                if ($i -ne $j -and $s -in $dominoes[$j]) {
                    $chainables[2 * $i + $k] += 2 * $j + ($s -eq $dominoes[$j][1])
                }
            }
        }
    }

    # Return chainables if all dominoes have at least one match, else empty chainable
    ($chainables | Where-Object { -not $_ }) ? @() : $chainables
}

Function Test-Chain($key, $dominoes, $chainables, $visited, $chain) {
    # Indicate this domino has been tried
    $index, $first = @(($key -shr 1), ($key -band 1))
    [void]$visited.Add($index)

    # Append domino in desired orientation to chain
    $chain.Add(@($dominoes[$index][$first], $dominoes[$index][1 - $first]))

    # If all dominoes are in chain, indicate match if first and last dominoes match
    if ($chain.Count -eq $dominoes.Count) { return $chain[0][0] -eq $chain[-1][1] }

    # Recursively try each domino that can be chained with this one
    foreach ($nextKey in $chainables[$key]) {
        if (-not $visited.Contains($nextKey -shr 1) -and (Test-Chain $nextKey $dominoes $chainables $visited $chain)) {
            return $true
        }
    }

    # Remove this domino from the chain and indicate no match
    [void]$visited.Remove($index)
    $chain.RemoveAt($chain.Count -1)
    $false
}
