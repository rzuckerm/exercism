<#
.SYNOPSIS
    Implement a custom set data type.

.DESCRIPTION
    Implement a class CustomSet to represent the set data structure with its typical behaviors and methods.
    Set behavior: elements inside a set are unique. 
    Set methods: IsEmpty, Contains, IsSubset, IsDisjoint, Add, Union, Difference and Intersection.

    How it being contructed internally doesn't matter, but the class also need an 'Equals' method to compare with other set.

.EXAMPLE
    $set  = [CustomSet]::new(@(3, 4, 5))
    $set2 = [CustomSet]::new(@(3, 2, 4, 5, 1))

    $set.IsEmpty()
    Returns: $false

    $set.Contains(3)
    Returns: $true

    $set.IsSubset($set2)
    Returns: $true
#>
Class CustomSet {
    [object[]]$Data = @()

    CustomSet() {}

    CustomSet([object[]]$data) { $this.Data = ($data | Select-Object -Unique) ?? @() }

    [bool] IsEmpty() { return $this.Data.Count -eq 0 }
    
    [bool] Contains([object]$element) { return $element -in $this.Data }

    [bool] IsSubset([CustomSet]$other) {
        return ($this.Data | Where-Object { $other.Contains($_) }).Count -eq $this.Data.Count
    }

    [bool] IsDisjoint([CustomSet]$other) { return -not ($this.Data | Where-Object { $other.Contains($_) }) }

    [CustomSet] Add([object]$element) {
        if (-not $this.Contains($element)) { $this.Data += $element }
        return $this
    }

    [CustomSet] Union([CustomSet]$other) { return [CustomSet]::new($this.Data + $other.Data) }
    
    [CustomSet] Difference([CustomSet]$other) {
        return [CustomSet]::new(($this.Data | Where-Object { -not $other.Contains($_) }))
    }

    [CustomSet] Intersection([object]$other) {
        return [CustomSet]::new(($this.Data | Where-Object { $other.Contains($_) }))
    }

    [bool] Equals([object]$other) { return -not (Compare-Object $this.Data $other.Data) }
}
