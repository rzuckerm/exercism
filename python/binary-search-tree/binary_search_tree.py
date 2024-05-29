class TreeNode:
    def __init__(self, data, left=None, right=None):
        self.data, self.left, self.right = data, left, right


class BinarySearchTree:
    def __init__(self, tree_data: list):
        self.root = None
        for data in tree_data:
            self.insert(self.root, TreeNode(data))

    def insert(self, n: TreeNode | None, d: TreeNode) -> TreeNode:
        if self.root is None:
            self.root = d

        if n is None:
            return d

        n.left, n.right = (self.insert(n.left, d), n.right) if d.data <= n.data else (n.left, self.insert(n.right, d))
        return n

    def data(self) -> TreeNode | None:
        return self.root

    def sorted_data(self) -> list:
        return self.order(self.root)

    def order(self, node: TreeNode):
        return [] if node is None else self.order(node.left) + [node.data] + self.order(node.right)
