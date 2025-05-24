<#
.SYNOPSIS
    Implement simple linked list (singly linked list) data structure.

.DESCRIPTION
    Implement two classes: Node and LinkedList
    Node should have these properties:
        - Data, contain the value of the node
        - Next, contain the reference to the next linked Node
    
    LinkedList's constrcutor should be able to accept : zero value, one single value, and an array of values to create the linked list.
    LinkedList should have these methods:
        - Size: returns how many elements in the list
        - Head: returns the current Node that is currently the head of the list.
        - Push: add a new Node to the beginning of the list.
        - Pop : remove a Node from the beginning of the list, returns the value of that Node.
        - Reverse : reverse the order of the list
        - ToArray : returns an array of the list in the correct order.

    Extra: implement enumberable behavior, e.g. can call Foreach-Object on the list. Remove the skipped test to run, only for local environment.

.EXAMPLE
    $list = [LinkedList]::new(@(1, 2, 3))

    $list.Pop()
    Returns: 3

    $list.Push(4)
    $list.ToArray()
    Returns: @(4, 2, 1)
#>
Class Node {
    [Node]$Next
    [object]$Data

    Node([object]$data = $null, [Node]$next = $null) {
        $this.Next = $next
        $this.Data = $data
    }
}

Class LinkedList {
    [Node]$Hd = $null
    [int]$Count = 0

    LinkedList() {}
    LinkedList([object[]]$values) { $values | ForEach-Object { $this.Push($_)  } }

    [int] Size() { return $this.Count }

    [Node] Head() {
        if (-not $this.Hd) { throw "The list is empty" }
        return $this.Hd
    }

    Push([object] $data) {
        $this.Hd = [Node]::new($data, $this.Hd)
        $this.Count++
    }

    [object] Pop() {
        $oldHead, $this.Hd = $this.Head(), $this.hd.Next 
        $this.Count--
        return $oldHead.Data
    }

    Reverse() {
        $prev = $null
        for ($node = $this.Hd; $node; $node = $next) {
            $next = $node.Next
            $node.Next = $prev
            $prev = $node
        }

        $this.Hd = $prev
    }

    [object[]] ToArray() {
        $array = @()
        for ($node = $this.Hd; $node; $node = $node.Next) { $array += $node.Data }
        return $array
    }
}
