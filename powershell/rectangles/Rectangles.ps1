Function Get-Rectangles() {
    <#
    .SYNOPSIS
    Count the rectangles in an ASCII diagram.

    .DESCRIPTION
    Given an ASCII diagram, count all the rectangles exist in it.
    A complete rectangle should have 4 corners and 4 valid sides.
    Example of possilbe sides:
    Valid: "+--+", "++"
    Invalid: "+--  +", "-+"

    .PARAMETER Strings
    An array of string that represent an ASCII diagram.
    You may assume that the input is always a proper rectangle (every string in the array has equal length).
    
    .EXAMPLE
    $diagram = @(
        "+-+-+",
        "+-+-+"
    )

    Get-Rectangles -Strings $diagram
    Returns: 3
    #>
    [CmdletBinding()]
    Param(
        [string[]]$Strings
    )

    # Find horizonal connections
    $conns = @{}
    for ($r = 0; $r -lt $Strings.Length; $r++) {
        $line = $Strings[$r]
        $currC = $null
        for ($c = 0; $c -lt $line.Length; $c++) {
            $ch = $line[$c]
            if ($ch -eq "+") {
                $conns["$r,$c"] = @{
                    h = [Collections.Generic.HashSet[int]]::new(); v = [Collections.Generic.HashSet[int]]::new()
                }
                if ($currC -eq $null) { $currC = $c }
                else {
                    $conns["$r,$currC"].h | ForEach-Object { [void]$conns["$r,$_"].h.Add($c) }
                    [void]$conns["$r,$currC"].h.Add($c)
                }
            }
            elseif ($ch -ne "-") { $currC = $null }
        }
    }

    # Find vertical connections
    $numCols = ($Strings | ForEach-Object { $_.Length } | Measure-Object -Maximum).Maximum
    for ($c = 0; $c -lt $numCols; $c++) {
        $currR = $null
        for ($r = 0; $r -lt $Strings.Length; $r++) {
            $ch = $Strings[$r]?[$c] ?? " "
            if ($ch -eq "+") {
                if ($currR -eq $null) { $currR = $r }
                else {
                    $conns["$currR,$c"].v | ForEach-Object { [void]$conns["$_,$c"].v.Add($r) }
                    [void]$conns["$currR,$c"].v.Add($r)
                }
            }
            elseif ($ch -ne "|") { $currR = $null }
        }
    }

    <#
       a            b
    (r1, c1) --- (r1, c2)
       |            |
    (r2, c1) --- (r2, c2)
       c            d

    Rectangle if all the following are true:
    - Point d exists
    - Point b and d are connected
    - Point c and d are connected
    #>
    ($conns.GetEnumerator() | ForEach-Object {
        ($r1, $c1), $ptConns = $_.Key.Split(","), $_.Value
        $ptConns.v | ForEach-Object { $r2 = $_; $ptConns.h | ForEach-Object {
            $conns.ContainsKey("$r2,$_") -and $r2 -in $conns["$r1,$_"].v -and $_ -in $conns["$r2,$c1"].h
        } }
    } | Measure-Object -Sum).Sum
}
