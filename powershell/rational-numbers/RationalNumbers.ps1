<#
.SYNOPSIS
    Implement a class represent a rational number.

.DESCRIPTION
    A rational number is defined as the quotient of two integers 'a' (numerator) and 'b' (denominator) where 'b != 0'.
    Please implement the following operations:
    - addition, subtraction, multiplication and division of two rational numbers,
    - absolute value, exponentiation of a given rational number to an integer power, exponentiation of a given rational number to a real (floating-point) power, exponentiation of a real number to a rational number.
    Your implementation of rational numbers should always be reduced to lowest terms.
    For example, `4/4` should reduce to `1/1`, `30/60` should reduce to `1/2`, `12/8` should reduce to `3/2`, etc.
    
.EXAMPLE
    $r1 = [Rational]::new(3,4)
    $r2 = [Rational]::new(5,6)

    $add = $r1 + $r2
    $add.ToString()
    Return: 19/12

    $sub = $r1 - $r2
    $sub.ToString()
    Return: -1/12

    $exp = $r1.Power(2)
    $exp.ToString()
    Return: 9/16
#>

Class Rational {
    [int] $Numer
    [int] $Denom

    Rational([int]$num, [int]$den) {
        $g = [Rational]::Gcd($num, $den)
        if ($den -lt 0) {
            $den = -$den
            $num = -$num
        }

        $this.Numer = [Math]::floor($num / $g)
        $this.Denom = [Math]::floor($den / $g)
    }

    static [int] Gcd([int]$a, [int]$b) {
        $a, $b = [Math]::Abs($a), [Math]::Abs($b)
        if ($a -eq 0) { return $b }
        while ($b) { $a, $b = $b, ($a % $b) }
        return $a
    }

    [bool] Equals($other) { return $this.Numer * $other.Denom -eq $this.Denom * $other.Numer }

    [string] ToString() { return "$($this.Numer)/$($this.Denom)" }

    static [Rational] op_Addition([Rational]$a, [Rational]$b) {
        return [Rational]::new(($a.Numer * $b.Denom + $a.Denom * $b.Numer), ($a.Denom * $b.Denom))
    }

    static [Rational] op_Subtraction([Rational]$a, [Rational]$b) {
        return [Rational]::new(($a.Numer * $b.Denom - $a.Denom * $b.Numer), ($a.Denom * $b.Denom))
    }

    static [Rational] op_Multiply([Rational]$a, [Rational]$b) {
        return [Rational]::new(($a.Numer * $b.Numer), ($a.Denom * $b.Denom))
    }

    static [Rational] op_Division([Rational]$a, [Rational]$b) {
        return [Rational]::new(($a.Numer * $b.Denom), ($a.Denom * $b.Numer))
    }

    [Rational] Abs() { return [Rational]::new([Math]::Abs($this.Numer), [Math]::Abs($this.Denom)) }

    [Rational] Power([int]$n) {
        return ($n -ge 0) ? [Rational]::new([Math]::Pow($this.Numer, $n), [Math]::Pow($this.Denom, $n)) :
            [Rational]::new([Math]::Pow($this.Denom, -$n), [Math]::Pow($this.Numer, -$n))
    }

    [float] ReversePower([int] $n) { return [Math]::Pow($n, $this.Numer / $this.Denom) }
}
