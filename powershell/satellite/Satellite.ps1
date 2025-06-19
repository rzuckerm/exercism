Function Get-TreeFromTraversals() {
    <#
    .SYNOPSIS
    Write the software for the satellite to rebuild the tree from the traversals.

    .DESCRIPTION
    GIven the preorder and inorder traverse of a tree, rebuild the tree.
    Read the instructions for more information of preorder, inorder and example.

    The rebuilt tree should be represent by the Node class template below.
    Implement the Equals class method in the Node class for comparison.

    .PARAMETER Preorder
    An array represent the preorder traverse of the original tree.

    .PARAMETER Inorder
    An array represent the inorder traverse of the original tree.

    .EXAMPLE
    Get-TreeFromTraversals -Preorder @("a", "b") -Inorder @("b", "a")
    Return: [Node]::new(
                "a",
                [Node]::new("b"),
                [Node]::new()
            )
    #>
    [CmdletBinding()]
    Param(
        [object[]]$Preorder,
        [object[]]$Inorder
    )

    if ($Preorder.Length -ne $Inorder.Length) { throw "Traversals must have the same length" }
    if (Compare-Object -PassThru $Preorder $Inorder) { throw "Traversals must have the same elements" }
    if (($Preorder | Select-Object -Unique).Length -ne $PreOrder.Length) { throw "Traversals must contain unique items" }

    # First preorder node is root node
    $n = $PreOrder.Length
    $v = $PreOrder[0]
    if ($n -le 1) { return [Node]::new($v) }

    # Find root node in inorder
    $r = $Inorder.IndexOf($v)

    # Store value of root node and recursively build left and right nodes of tree
    [Node]::new(
        $v,
        (Get-TreeFromTraversals $PreOrder[1..$r] $Inorder[0..($r - 1)]),
        (Get-TreeFromTraversals $PreOrder[($r + 1)..$n] $Inorder[($r + 1)..$n])
    )
}

Class Node {
    [object]$Value = $null
    [Node]$Left = $null
    [Node]$Right = $null

    Node() {}

    Node([object]$value) { $this.Value = $value }

    Node([object]$value, [Node]$left, [Node]$right) {
        $this.Value = $value
        $this.Left = $left
        $this.Right = $right
    }

    [bool] Equals([object]$other) { return -not (Compare-Object $this $other -Property Value, Left, Right) }
}
