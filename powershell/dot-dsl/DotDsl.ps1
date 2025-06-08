<#
.SYNOPSIS
    Write a Domain Specific Language similar to the Graphviz dot language.

.DESCRIPTION
    Implement the classes to stimulate a DSL similar to the Graphviz dot language.

    Node class : represent the nodes inside the graph.
    Edge class : represent the relationship between two nodes.
    Attr class : represent the attributes of other objects (node, edge or graph).
    Graph class: represent the graph, contains info about nodes, edges and attributes.

    Node, Edge and Attr should have the 'Equals' method implemented for the purpose of comparison in the test suite.
#>

Class Node {
    [string]$Name
    [Attr]$Attrs

    Node([string]$name) {
        $this.Name = $name
        $this.Attrs = [Attr]::new()
    }

    Node([string]$name, [hashtable]$attrs) {
        $this.Name = $name
        $this.Attrs = [Attr]::new($attrs)
    }

    [bool] Equals([object]$other) { return $this.Name -eq $other.Name -and $this.Attrs -eq $other.Attrs }
}

Class Edge {
    [string]$Source
    [string]$Dest
    [Attr]$Attrs

    Edge([string]$source, [string]$dest) {
        $this.Source = $source
        $this.Dest = $dest
        $this.Attrs = [Attr]::new()
    }

    Edge([string]$source, [string]$dest, [hashtable]$attrs) {
        $this.Source = $source
        $this.Dest = $dest
        $this.Attrs = [Attr]::new($attrs)
    }

    [bool] Equals([object]$other) {
        return $this.Source -eq $other.Source -and $this.Dest -eq $other.Dest -and $this.Attrs -eq $other.Attrs
    }
}

Class Attr {
    hidden [hashtable]$Data = @{}

    Attr() {}

    Attr([hashtable]$data) { $this.Data = $data }

    [bool] Equals([object]$other) {
        $matchesKeys = -not (Compare-Object $this.Data.Keys $other.Data.Keys)
        $matchesValues = -not (Compare-Object $this.Data.Values $other.Data.Values)
        return $matchesKeys -and $matchesValues
    }
}

Class Graph {
    [Node[]] $Nodes = @()
    [Edge[]] $Edges = @()
    [Attr[]] $Attrs = @()

    Graph() {}

    Graph([object[]]$data) {
        switch ($data) {
            { $_ -is [Node] } { $this.Nodes += $_ }
            { $_ -is [Edge] } { $this.Edges += $_ }
            { $_ -is [Attr] } { $this.Attrs += $_ }
            default { throw "Graph can only contain node, egde or attribute" }
        }
    }
}
