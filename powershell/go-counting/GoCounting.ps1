Enum Owner { BLACK; WHITE; NONE }

<#
.SYNOPSIS
    Count territories of each player in a Go game

.DESCRIPTION
    Implement a class that take in an array of string to represent a two-dimensoinal Go board.

    Territory method: Take in a two integers array @(column, row) represent a coordinate on the board.
    It should return an object with Owner and Coordinates properties (representing the owner's territories)

    Territories method: Find the owners and the territories of the whole board
    It should return an object with ALL Owners and their properties.

    Owner is of Enum value, e.g., [Owner]::NONE
    Coordinates is of SORTED collection of arrays, e.g., @( @(0,0), @(0,1), @(0,2) )

.EXAMPLE
    The board below has 3 spaces to count for territories.
    Black surrounded (0,0) so it owns that, (0,2) and (1,1) is undisputed so None owns those.

    $input = @(
        " B "
        "B W"
    )
    $board = [Board]::new($input)

    $board.Territory(@(1,1))
    Return: @{
                Owner = [Owner]::BLACK
                Coordinates = @()
            }

    $board.Territories()
    Returns: @{
                [Owner]::BLACK = @(@(0,0))
                [Owner]::WHITE = @()
                [Owner]::NONE  = @(@(0,2), @(1,1))
            }
#>

Class Board {
    [string[]]$Board

    Board([string[]]$board) { $this.Board = $board }

    [object] Territory([int[]]$coord) {
        $x, $y = $coord
        if (-not $this.IsValid($x, $y)) { throw "Invalid coordinate" }

        $stack = [Collections.Generic.Stack[int[]]]::new()
        $stack.Push(@($x, $y))
        $owners = [Collections.Generic.HashSet[Owner]]::new()
        $territory = [Collections.Generic.HashSet[string]]::new()
        while ($stack.Count) {
            $x, $y = $stack.Pop()
            if ($this.IsValid($x, $y) -and "$x,$y" -notin $territory) {
                $stone = $this.Board[$y][$x]
                if ($stone -eq " ") {
                    [void]$territory.Add("$x,$y")
                    @($x, ($y - 1)), @(($x - 1), $y), @($x, ($y + 1)), @(($x + 1), $y) | ForEach-Object { $stack.Push($_) }
                } else { [void]$owners.Add(($stone -eq "B") ? [Owner]::BLACK : [Owner]::WHITE) }
            }
        }

        return [PSCustomObject]@{
            Owner = ($owners.Count -eq 1 -and $territory.Count) ? $owners[0] : [Owner]::NONE
            Coordinates = $this.SortCoords($territory)
        }
    }

    [object] Territories() {
        $result = @{BLACK = @(); WHITE = @(); NONE = @()}
        $visited = [Collections.Generic.HashSet[string]]::new()
        for ($y = 0; $y -lt $this.Board.Length; $y++) {
            for ($x = 0; $x -lt $this.Board[$y].Length; $x++) {
                if ("$x,$y" -notin $visited) {
                    $t = $this.Territory(@($x, $y))
                    $territory = $t.Coordinates | ForEach-Object { $_ -join "," }
                    $result[[string]$t.Owner] += $territory
                    $territory | ForEach-Object { [void]$visited.Add($_) }
                }
            }
        }

        return [PSCustomObject]@{
            BLACK = $this.SortCoords($result.BLACK)
            WHITE = $this.SortCoords($result.WHITE)
            NONE = $this.SortCoords($result.NONE)
        }
    }

    [bool] hidden IsValid([int]$x, [int]$y) { return $x -ge 0 -and $y -ge 0 -and $this.Board[$y]?[$x] }

    [int[][]] hidden SortCoords([Collections.Generic.HashSet[string]]$coords) {
        $coordValues = @($coords | ForEach-Object { @(, @($_.Split(",") | ForEach-Object { [int]$_ })) })
        return @($coordValues | Sort-Object -Property { $_[0] }, { $_[1] })
    }
}
