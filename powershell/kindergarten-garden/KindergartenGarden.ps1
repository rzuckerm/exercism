<#
.SYNOPSIS
    Given a diagram, determine which plants each child in the kindergarten class is responsible for.

.DESCRIPTION
    There are 12 children in the class:
    - Alice, Bob, Charlie, David,
    - Eve, Fred, Ginny, Harriet,
    - Ileana, Joseph, Kincaid, and Larry.
    Each child take care of 4 plants, two on each row.
    The children are being seated alphabetically from left to right.

    Note: the class constructor should accept an optional list of differnt students if provided.

.EXAMPLE
    $garden = [Garden]::new("VCCCGG`nVGCCGG")
    $garden.GetPlants("Alice")
    Return : @("Violets", "Clover", "Violets", "Grass")
#>
Class Garden {
    static [hashtable] $Plants = @{G = "Grass"; C = "Clover"; R = "Radishes"; V = "Violets"}
    static [string[]] $DefaultChildren = @(
        "Alice", "Bob", "Charlie", "David", "Eve", "Fred", "Ginny", "Harriet", "Ileana", "Joseph", "Kincaid", "Larry"
    )
    [string[]] $Children
    [string[]] $Garden

    Garden([string]$Diagram) { $this.InitGarden($Diagram, [Garden]::DefaultChildren) }
    Garden([string]$Diagram, [string[]]$Children) { $this.InitGarden($Diagram, $Children) }

    hidden InitGarden([string]$Diagram, [string[]]$Children) {
        $this.Children = $Children | Sort-Object
        $this.Garden = $Diagram -split "`n" -split "" -ne "" | ForEach-Object { [Garden]::Plants[$_] }
    }

    [string[]] GetPlants([string]$Child) {
        $Idx1 = [array]::IndexOf($this.Children, $Child) * 2
        $Idx2 = $Idx1 + ($this.Garden.Length -shr 1)
        return $this.Garden[$Idx1..($Idx1 + 1)] + $this.Garden[$Idx2..($Idx2 + 1)]
    }
}