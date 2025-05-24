<#
.SYNOPSIS
    Write a robot simulator that take in instructions of how to move.
    
.DESCRIPTION
    A robot factory's test facility needs a program to verify robot movements.
    The robots have three possible movements:
    - turn right
    - turn left
    - advance

    Robots are placed on a hypothetical infinite grid, facing a particular direction (north, east, south, or west) at a set of {x,y} coordinates,
    e.g., {3,8}, with coordinates increasing to the north and east.

    A robot instance without any input should be at the default location : facing North at (0, 0)
    
.EXAMPLE
    $robot = [Robot]::new('NORTH', 7, 3)
    $robot.Move("RAALAL")

    $robot.Direction
    Returns: WEST

    $robot.GetPosition()
    Returns: @(9, 4)
#>

Enum Direction { NORTH; EAST; SOUTH; WEST }

Class Robot {
    [Direction]$Direction = [Direction]::NORTH
    [int[]]$Position = @(0, 0)

    #                               NORTH    EAST     SOUTH     WEST
    static [int[][]]$Increments = @(@(0, 1), @(1, 0), @(0, -1), @(-1, 0))

    Robot() {}
    Robot([string]$direction, $x, $y) {
        if (-not [Enum]::IsDefined([Direction], $direction)) { throw "Error: Invalid direction" }
        if ($x -isnot [int]) { throw "Error: Invalid X position" }
        if ($y -isnot [int]) { throw "Error: Invalid Y position" }

        $this.Direction = [Direction]($direction)
        $this.Position = @($x, $y)
    }

    Move([string]$instructions) {
        switch ($instructions.ToCharArray()) {
            "L" { $this.Direction = ($this.Direction + 3) % 4 }
            "R" { $this.Direction = ($this.Direction + 1) % 4 }
            "A" {
                $dx, $dy = [Robot]::Increments[[int]$this.Direction]
                $this.Position = @(($this.Position[0] + $dx), ($this.Position[1] + $dy))
            }
            default { throw "Error: Invalid instruction" }
        }
    }

    [int[]] GetPosition() { return $this.Position }
}
