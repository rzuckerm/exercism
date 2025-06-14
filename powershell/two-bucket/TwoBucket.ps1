<#
.SYNOPSIS
    Given two buckets of different size and which bucket to fill first, determine how many actions are required to measure an exact number of liters by strategically transferring fluid between the buckets.

.DESCRIPTION
    Please read the rules of how to implement the solution in instructions.
    
    Your task here is to implement a class to solve for the solution.
    The class should take in : size of bucket 1, size of bucket 2, and which bucket to start with "one" or "two"
    The class should have the Measure method that take in the target, and if possible return an object for the result.

    If it is not possible to reach the target, please throw an error.
    
.EXAMPLE
    $buckets = [TwoBucket]::new(6, 7, "one")
    $buckets.Measure(5) | Format-List

    Returns:
    Moves       : 4
    GoalBucket  : one
    OtherBucket : 7
#>

Class TwoBucket {
    [string[]]$BucketNames
    [int[]]$Capacities

    TwoBucket([int]$size1, [int]$size2, [string]$start) {
        $this.BucketNames = ($start -eq "one") ? @("one", "two") : @("two", "one")
        $this.Capacities = ($start -eq "one") ? @($size1, $size2) : @($size2, $size1)
    }

    [object] Measure([int]$target) {
        if ($this.Capacities[0] -eq $this.Capacities[1]) { throw "Two buckets can't be of the same size" }
        if ($target -lt 0 -or $target -gt [Math]::Max($this.Capacities[0], $this.Capacities[1]) -or
            $target % $this.Gcd()) {
            throw "Target is impossible to reach"
        }

        # Starting bucket is full, other bucket is empty
        $buckets = @($this.Capacities[0], 0)

        # Keep going until goal is met with either bucket
        for (($i = 1), ($j = $buckets.IndexOf($target)); $j -lt 0; ($i++), ($j = $buckets.IndexOf($target))) {
            # Fill other bucket if goal can be met with it
            if ($this.Capacities[1] -eq $Target) { $buckets[1] = $target }
            # Empty other bucket if full
            elseif ($buckets[1] -eq $this.Capacities[1]) { $buckets[1] = 0 }
            # Fill start bucket if empty
            elseif ($buckets[0] -eq 0) { $buckets[0] = $this.Capacities[0] }
            # Otherwise, pour maximum amount from one bucket into the other
            else {
                $total = $buckets[0] + $buckets[1]
                $buckets = @([Math]::Max(0, $total - $this.Capacities[1]), [Math]::Min($total, $this.Capacities[1]))
            }
        }

        return @{Moves = $i; GoalBucket = $this.BucketNames[$j]; OtherBucket = $buckets[1 - $j] }
    }

    hidden [int] Gcd() {
        $a, $b = $this.Capacities
        while ($b) { $a, $b = $b, ($a % $b) }
        return $a
    }
}
