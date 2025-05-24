<#
.SYNOPSIS
    Implement a clock that handles times without dates.

.DESCRIPTION
    Implement a clock that handles times without dates in 24 hours format.
    You should be able to add and subtract minutes to it.
    Two clocks that represent the same time should be equal to each other.
    Note: Please try to implement the class and its method instead of using built-in module Datetime.

.EXAMPLE
    $clock1 = [Clock]::new(5,0)
    $clock1.ToString()
    Return: "05:00"

    $clock2 = [Clock]::new(6,-120)
    $clock2.Add(60).ToString()
    Return: "05:00"

    $clock1 -eq $clock2
    Return: $true
#>

class Clock {
    [int]$Minutes

    Clock([int]$hours, [int]$minutes) { $this.Minutes = (($hours * 60 + $minutes) % 1440 + 1440) % 1440 }
    [string] ToString() { return "{0:d2}:{1:d2}" -f [int][Math]::Floor($this.Minutes / 60), ($this.Minutes % 60) }
    [bool] Equals($other) { return $this.Minutes -eq $other.Minutes }
    [Clock] Add([int]$minutes) { return [Clock]::new(0, $this.Minutes + $minutes) }
}
