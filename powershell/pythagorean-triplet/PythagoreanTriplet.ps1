Function Get-PythagoreanTriplet() {
    <#
    .SYNOPSIS
    Given input integer N, find all Pythagorean triplets for which 'a + b + c = N'.

    .DESCRIPTION
    Given an integer, find all the possible Pythagorean triplets whose sum is equal to that integer.
    Return the array of Pythagorean triplets in sorted ascending order.

    A Pythagorean triplet is a set of three natural numbers, {a, b, c}, for which:
    a² + b² = c²
    a < b < c

    .PARAMETER Number
    The sum of a Pythagorean triplet

    .EXAMPLE
    Get-PythagoreanTriplet -Sum 12
    Return: @( ,@(3, 4, 5))
    #>
    [CmdletBinding()]
    Param(
        [int]$Sum
    )

    <#
    sum = p = a + b + c
    c = p - a - b
    a² + b² = c²
    a² + b² = [p - (a + b)]²
    a² + b² = p² - 2*p*(a + b) + (a + b)²
    a² + b² = p² - 2*p*(a + b) + a² + 2*a*b + b²
    p² - 2*p*(a + b) + 2*a*b = 0
    p² - 2*p*a - 2*p*b + 2*a*b = 0
    p*(p - 2*a) = 2*b*(p - a)
    b = [p*(p - 2*a)] / [2*(p - a)]

    Find value of a that equals b:

    [p*(p - 2*a)] / [2*(p - a)] = a
    p*(p - 2*a) = 2*a*(p - a)
    p² - 2*p*a = 2*p*a - 2*a²
    p² - 4*p*a + 2*a² = 0

    a = [4*p +/- sqrt(16*p² - 4*2*p²)] / (2*2)
      = [4*p +/- sqrt(8*p²)] / 4
      = p*[1 +/- 1/sqrt(2)]

    Since a < p:

    a = p*[1 - 1/sqrt(2)]

    Therefore:

    a <= p*[1 - 1/sqrt(2)]

    The smallest Pythagorean Triplet is [3, 4, 5], so a >= 3
    #>

    $triplets = @()
    $m = [Math]::Floor((1 - 1 / [Math]::Sqrt(2)) * $Sum)
    for ($a = 3; $a -le $m; $a++) {
        $num = $Sum * ($Sum - 2 * $a)
        $den = 2 * ($Sum - $a)
        if ($num % $den -eq 0) {
            $b = [Math]::Floor($num / $den)
            $triplets += ,@($a, $b, ($Sum - $a - $b))
        }
    }

    $triplets
}
