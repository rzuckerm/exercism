<#
.SYNOPSIS
Implement two classes, one for tree node and one for binary search tree.

.DESCRIPTION
Create a binary search tree made by many different tree node.
Each tree node instance contain the value for the node and its children if exist.
The binary search tree should have these methods:
- Insert    : take in an array of number, create node and insert them follow the property of the binary search tree.
- GetData   : return the root node that contain the entire tree's data
- Search    : take in a number to find in the binary tree, return a boolean value
- Inorder   : return an array of values in order of inorder travel
- Postorder : return an array of values in order of postorder travel
- Preorder  : return an array of values in order of preorder travel
- Remove    : delete an value from the binary search tree

.EXAMPLE
$tree = [BinarySearchTree]::new(@(3,4,2))

$tree.Search(3)
Return: true

$tree.Inorder()
Return: @(2, 3, 4)

$tree.PreOrder()
Return: @(3, 2, 4)

$tree.Postorder()
Return: @(2, 4, 3)
#>
Class TreeNode {
    [int]$data
    [TreeNode]$left = $null
    [TreeNode]$right = $null

    TreeNode([int]$data) { $this.data = $data }

    TreeNode([int]$data, [TreeNode]$left, [TreeNode]$right) {
        $this.data = $data
        $this.left = $left
        $this.right = $right
    }
}


Class BinarySearchTree {
    hidden [TreeNode]$root = $null

    BinarySearchTree([int[]]$values) { $values | ForEach-Object { $this.Insert($_) } }

    [void] Insert([int]$data) { $this.root = $this.Insert($data, $this.root) }

    hidden [TreeNode] Insert([int]$data, [TreeNode]$node) {
        if (-not $node) { $node = [TreeNode]::new($data) }
        elseif ($data -le $node.data) { $node.left = $this.Insert($data, $node.left) }
        else { $node.right = $this.Insert($data, $node.right) }
        return $node
    }

    [TreeNode] GetData() { return $this.root }

    [bool] Search([int]$value) { return $this.Search($value, $this.root) }

    [bool] hidden Search([int]$value, [TreeNode]$node) {
        if (-not $node) { return $false }
        if ($value -eq $node.data) { return $true }
        return ($value -lt $node.data) ? $this.Search($value, $node.left) : $this.Search($value, $node.right)
    }

    [int[]] Inorder() { return $this.Inorder(@(), $this.root) }

    [int[]] hidden Inorder([int[]]$values, [TreeNode]$node) {
        return ($node) ? $this.Inorder($this.Inorder($values, $node.left) + @($node.data), $node.right) : $values
    }

    [int[]] PreOrder() { return $this.PreOrder(@(), $this.root) }

    [int[]] PreOrder([int[]]$values, [TreeNode]$node) {
        return ($node) ? $this.PreOrder($this.PreOrder($values + @($node.data), $node.left), $node.right) : $values
    }

    [int[]] PostOrder() { return $this.PostOrder(@(), $this.root) }

    [int[]] hidden PostOrder([int[]]$values, [TreeNode]$node) {
        return ($node) ? $this.PostOrder($this.PostOrder($values, $node.left), $node.right) + @($node.data) : $values
    }

    [void] Remove([int]$value) { $this.root = $this.Remove($value, $this.root) }

    # Reference: https://www.geeksforgeeks.org/deletion-in-binary-search-tree/
    [TreeNode] hidden Remove([int]$value, [TreeNode]$node) {
        if (-not $node) { return $null }

        if ($node.data -gt $value) { $node.left = $this.Remove($value, $node.left) }
        elseif ($node.data -lt $value) { $node.right = $this.Remove($value, $node.right) }
        elseif (-not $node.left -or -not $node.right) { return $node.left ?? $node.right }
        else {
            $successor = $node.right
            while ($successor.left) { $successor = $successor.left }
            $node.data = $successor.data
            $node.right = $this.Remove($node.data, $node.right)
        }

        return $node
    }
}
