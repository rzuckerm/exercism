<#
.SYNOPSIS
    Creating a zipper for a binary tree.

.DESCRIPTION
    Implement a class for a tree data structure with value, left child and right child as properties.

    Implement a zipper class data structure which support these operations:
    - 'FromTree' (get a zipper out of a binary tree, the focus is on the root node)
    - 'ToTree' (get the binary tree out of the zipper)
    - 'Value' (get the value of the focus node)
    - 'GoLeft' (move the focus to the left child node, returns a new zipper)
    - 'GoRight' (move the focus to the right child node, returns a new zipper)
    - 'GoUp' (move the focus to the parent, returns a new zipper)
    - 'SetValue' (set the value of the focus node, returns a new zipper)
    - 'SetLeft' (insert a new subtree before the focus node, it
    becomes the 'Left' of the focus node, returns a new zipper)
    - 'SetRight' (insert a new subtree after the focus node, it becomes
    the 'Right' of the focus node, returns a new zipper)
    - 'Delete' (removes the focus node and all subtrees, focus moves to the
    'Right' node if possible otherwise to the 'Left' node if possible,
    otherwise to the parent node, returns a new zipper) 
    
    *'Delete' operation is optional and there is no tests for it.

    You also need to implement the Equals methods so the test can run correctly while comparing objects.

.EXAMPLE
    $tree = [Tree]::new(5, [Tree]::new(4, $null, $null), [Tree]::new(7, $null, $null))
    $zipper = [Zipper]::FromTree($tree)

    $zipper.GetValue()
    Returns: 5

    $zipper.GoLeft().GetValue()
    Returns: 4

    $zipper.GoRight().GoUp().GetValue()
    Returns: 5
#>
Class Tree {
    [int]$Value
    [Tree]$Left
    [Tree]$Right

    Tree([int]$data, [Tree]$left, [Tree]$right) {
        $this.Value = $data
        $this.Left = $left
        $this.Right = $right
    }

    [bool] Equals([object]$other) {
        return $this.Value -eq $other.Value -and $this.Left -eq $other.Left -and $this.Right -eq $other.Right
    }
}

Class Zipper {
    [Tree]$Tree
    [Tree[]]$Parents

    Zipper([Tree]$tree, [object[]]$parents) {
        $this.Tree = $tree
        $this.Parents = $parents
    }

    [int] GetValue() { return $this.Tree.Value }

    [Zipper] SetValue([int]$data) {
        $this.Tree.Value = $data
        return [Zipper]::new($this.Tree, $this.Parents)
    }

    [Zipper] GoLeft() { return ($this.Tree.Left) ? [Zipper]::new($this.Tree.Left, $this.Parents + $this.Tree) : $null }

    [Zipper] SetLeft([Tree]$tree) {
        $this.Tree.Left = $tree
        return [Zipper]::new($this.Tree, $this.Parents)
    }

    [Zipper] GoRight() { return ($this.Tree.Right) ? [Zipper]::new($this.Tree.Right, $this.Parents + $this.Tree) : $null }

    [Zipper] SetRight([Tree]$tree) {
        $this.Tree.Right = $tree
        return [Zipper]::new($this.Tree, $this.Parents)
    }

    [Zipper] GoUp() {
        return ($this.Parents) ? [Zipper]::new($this.Parents[-1], ($this.Parents | Select-Object -SkipLast 1)) : $null
    }

    [Tree] ToTree() { return ($this.Parents) ? $this.Parents[0] : $this.Tree }

    static [Zipper] FromTree([Tree]$tree) { return [Zipper]::new($tree, @()) }

    [bool] Equals([object]$other) { return $this.ToTree() -eq $other.ToTree() }
}
