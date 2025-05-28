Function Invoke-RelativeDistance() {
    <#
    .SYNOPSIS
    Determine the degree of separation between two individuals in a family tree

    .DESCRIPTION
    Given a family tree with all unique names, find the shortest number of connections from one person to another.

    .PARAMETER FamilyTree
    A PSObject represent the family tree.

    .PARAMETER PersonA
    Name of the first person.

    .PARAMETER PersonB
    Name of the second person.

    .EXAMPLE
    $tree = @{
        "Dalia" = @("Olga", "Yassin")
    }
    
    Invoke-RelativeDistance -FamilyTree $tree -PersonA "Olga" -PersonB "Yassin"
    Returns: 1
    #>
    [CmdletBinding()]
    Param(
        [object]$FamilyTree,
        [string]$PersonA,
        [string]$PersonB
    )

    # Convert family tree into an undirected graph
    $relatives = @{}
    $FamilyTree.GetEnumerator() | ForEach-Object {
        $i = 0
        foreach ($childA in $_.Value) {
            # Connect parent and children
            Invoke-Connect $relatives $_.Key $childA

            # Connect siblings
            foreach ($childB in $_.Value[$i..$_Value.Length]) { Invoke-Connect $relatives $childA $childB }
            $i++
        }
    }

    # If either person is not in the graph, indicate not related
    if (-not $relatives[$PersonA] -or -not $relatives[$personB]) { return $null }

    # Do breadth first search from person A to person B
    $queue = @(, @($PersonA, 0))
    $visited = [Collections.Generic.HashSet[string]]($PersonA)
    while ($queue.Length) {
        $person, $distance = $queue[0][0..1]
        $queue = $queue[1..$queue.Length]
        if ($person -eq $PersonB) { return $distance }

        foreach ($relative in $relatives[$person]) {
            if (-not $visited.Contains($relative)) {
                $dummy = $visited.Add($relative)
                $queue += ,@($relative, ($distance + 1))
            }
        }
    }
}

# Connect relatives to each other
Function Invoke-Connect([object]$Relatives, [string]$PersonA, [string]$PersonB) {
    if (-not $Relatives[$PersonA]) { $Relatives[$PersonA] = [Collections.Generic.HashSet[string]]::new() }
    if (-not $Relatives[$PersonB]) { $Relatives[$PersonB] = [Collections.Generic.HashSet[string]]::new() }
    $dummy = $Relatives[$PersonA].Add($PersonB)
    $dummy = $Relatives[$PersonB].Add($PersonA)
}
