<#
.SYNOPSIS
    Given a tree, reorientate it based on a selected node.

.DESCRIPTION
    A tree is a special type of graph where all nodes are connected but there are no cycles.
    That means, there is exactly one path to get from one node to another for any pair of nodes.

    Implement a class to represent the Tree along with these methods:
    - FromPov: accept a value of a node, return a new Tree object orientated based on that node.
        Throw error if the value/node does't exist in the tree.
    - Path: accept the source and destination values of two nodes, return an array of string represent the path from source to destination.
        Throw error if the path doesn't exist.
    - Equals: equality method to compare trees for the test suite.

.EXAMPLE
    Read instructions for visual example.
#>

Class Tree {
    [string]$Value
    [Tree[]]$Children = @()

    Tree([string]$value) { $this.Value = $value }

    Tree([string]$value, [Tree[]]$children) {
        $this.Value = $value
        $this.Children = $children
    }

    [Tree] Clone() { return [Tree]::new($this.Value, @($this.Children | ForEach-Object { $_.Clone() })) }

    [Tree] FromPov([string]$from) {
        # Find the "from" node. Error if not found
        if (-not ($path = $this.Clone().FindPath($from, $null))) { throw "Tree could not be reoriented" }

        # Start tree with current "from" node and its children
        $tree = $node = $path[-1]

        # Iterate from "from" node's parent (if any) to root
        for ($i = $path.Length - 2; $i -ge 0; $i--) {
            # Create new node from ex-parent of this node and its children, excluding this node.
            # Add new node to children of this node, and move to new node
            $parent = $path[$i]
            $nextNode = [Tree]::new($parent.Value, @($parent.Children | Where-Object { $_.Value -ne $node.Value }))
            $node.Children += $nextNode
            $node = $nextNode
        }

        return $tree
    }

    [string[]] Path([string]$from, [string]$to) {
        # Reorient tree to "from" node. Get path from "from" to "to" node. Error if if either node not found
        if (-not ($this.FindPath($from, $null)) -or -not ($this.FindPath($to, $null))) { Throw "No path found" }
        return @($this.FromPov($from).FindPath($to, $null).Value)
    }

    [Tree[]] FindPath([string]$target, [Tree[]]$path) {
        # Find target using Depth First Search and keep track of path
        $path = $path ?? @($this)
        if ($this.Value -eq $target) { return $path }

        foreach ($child in $this.children) {
            if ($newPath = $child.FindPath($target, ($path + $child))) { return $newPath }
        }

        # Indicate target not found
        return @()
    }

    [bool] Equals([object]$other) {
        if ($this.Value -ne $other.Value -or $this.Children.Count -ne $other.Children.Count) { return $false }

        $thisSortedChildren = $this.Children | Sort-Object -Property Value
        $otherSortedChildren = $other.Children | Sort-Object -Property Value
        for ($i = 0; $i -lt $thisSortedChildren.Count; $i++) {
            if ($thisSortedChildren[$i] -ne $otherSortedChildren[$i]) { return $false }
        }

        return $true
    }
}
