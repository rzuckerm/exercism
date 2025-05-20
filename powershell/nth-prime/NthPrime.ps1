Function Get-NthPrime() {
    <#
    .SYNOPSIS
    Given a number n, determine what the nth prime is.

    .DESCRIPTION
    By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.

    .PARAMETER Number
    The number of the prime to return.

    .EXAMPLE
    Get-NthPrime -Number 5
    #>
    [CmdletBinding()]
    Param(
        [Int64]$Number
    )

    if ($Number -lt 1) { throw "error: there is no zeroth prime" }
    $Prime = 1
    for ($N = 1; $N -le $Number; $N++) {
        for ($Prime++; -not (Test-IsPrime $Prime); $Prime++) {}
    }

    $Prime
}

function Test-IsPrime([int]$Prime) {
    $IsPrime = $true
    for ($K = 2; $K * $K -le $Prime -and ($IsPrime = $Prime % $K -ne 0); $K++) {}
    $IsPrime
}
