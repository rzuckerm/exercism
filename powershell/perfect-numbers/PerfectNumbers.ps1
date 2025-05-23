Function Invoke-PerfectNumbers() {
    <#
    .SYNOPSIS
    Determine if a number is perfect, abundant, or deficient based on Nicomachus' (60 - 120 CE) classification scheme for natural numbers.

    .DESCRIPTION
    Calculate the aliquot sum of a number: the sum of its positive divisors not including the number itself.
    Compare the sum to the original number.
    Determine the classification: perfect, abundant, or deficient.

    .PARAMETER Number
    The number to perform the classification on.

    .EXAMPLE
    Invoke-PerfectNumbers -Number 12
    #>
    [CmdletBinding()]
    Param(
        [Int64]$Number
    )

    if ($Number -le 0) { throw "error: Classification is only possible for positive integers." }
    $S = (1..([Math]::Sqrt($Number)) | Where-Object { $Number % $_ -eq 0 } | ForEach-Object { $_; $Number / $_ } |
        Select-Object -unique | Measure-Object -sum).sum - $Number
    @("perfect", "deficient", "abundant")[($S -lt $Number) + 2 * ($S -gt $Number)]
}
