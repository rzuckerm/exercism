<#
.SYNOPSIS
    Implement a linked list.

.DESCRIPTION
    The linked list is a fundamental data structure in computer science, often used in the implementation of other data structures.
    As the name suggests, it is a list of nodes that are linked together.
    In a 'doubly linked list', each node links to both the node that comes before, as well as the node that comes after.

    The class to represent the linked list should support these operations:
    - Push    : accept a value, append it to the end of the list.
    - Pop     : remove a value of the end of the list, return it.
    - Unshift : accept a value, append it to the front of the list.
    - Shift   : remove a value from the front of the list, return it.
    - Delete  : accept a value, remove the first occurence of it in the list.

    The class should also have a 'Count' property to reflect the current length of the list.
    Any attempt of removal operation on an empty list should throw an error.

.EXAMPLE
    $linked = [LinkedList]::new()

    $linked.Push(5)
    $linked.Unshift(7)
    $linked.Push(8)

    $linked.Pop()
    Returns: 8

    $linked.Count
    Returns: 2
#>
class Node {
    [int]$Value = $null
    [Node]$Next = $null
    [Node]$Prev = $null

    Node() {}

    Node([int]$value, [Node]$next, [Node]$prev) {
        $this.Value = $value
        $this.Next = $next
        $this.Prev = $prev
    }
}

class LinkedList {
    [int]$Count
    [Node]$Head
    [Node]$Tail

    LinkedList() {
        $this.Count = 0
        $this.Tail = [Node]::new()
        $this.Head = [Node]::new($null, $this.Tail, $null)
        $this.Tail.Prev = $this.Head
    }

    Push($value) { $this.AddItem($value, $this.Tail, $this.Tail.Prev) }

    [int] Pop() { return $this.DeleteItem($this.Tail.Prev) }

    Unshift($value) { $this.AddItem($value, $this.Head.Next, $this.Head) }

    [int] Shift() { return $this.DeleteItem($this.Head.Next) }

    Delete($value) {
        for ($node = $this.Head.Next; $node -and $node.Value -ne $value; $node = $node.Next) {}
        if ($node) { $this.DeleteItem($node) }
    }

    hidden AddItem([int]$value, [Node]$next, [Node]$prev) {
        $this.Count++
        $next.Prev = $prev.Next = [Node]::new($value, $next, $prev)
    }

    hidden [int] DeleteItem([Node]$node) {
        if ($this.Count -lt 1) { throw "List is empty" }
        $this.Count--
        $node.Prev.Next = $node.Next;
        $node.Next.Prev = $node.Prev;
        return $node.Value;
    }
}
