from __future__ import annotations
from dataclasses import dataclass, field
from copy import deepcopy


@dataclass
class Tree:
    label: str = ""
    children: list[Tree] = field(default_factory=list)

    def __eq__(self, other: Tree) -> bool:
        # Compare label and children sorted by label
        return self.label == other.label and sorted(self.children, key=lambda x: x.label) == sorted(
            other.children, key=lambda x: x.label
        )

    def from_pov(self, from_node: str) -> Tree:
        # Find the "from" node. Raise error if not found
        if not (path := deepcopy(self).find_path(from_node)):
            raise ValueError("Tree could not be reoriented")

        # Start tree with current "from" node and its children
        node = tree = path[-1]

        # Iterate from "from" node's parent (if any) to root
        for xpar in reversed(path[:-1]):
            # Create new node from ex-parent of this node and its children, excluding this node.
            # Add new node to children of this node, and move to new node
            node.children.append(node := Tree(xpar.label, [t for t in xpar.children if t.label != node.label]))

        return tree

    def path_to(self, from_node: str, to_node: str) -> list[str]:
        # Reorient tree to "from" node. Get path from "from" to "to" node.
        # Raise error if either node not found
        if not (tree := self.from_pov(from_node)) or not (path := tree.find_path(to_node)):
            raise ValueError("No path found")

        return [t.label for t in path]

    def find_path(self, target: str, path: list[Tree] | None = None) -> list[Tree]:
        # Find target using Depth First Search and keep track of path
        path = path or [self]
        if self.label == target:
            return path

        for child in self.children:
            if new_path := child.find_path(target, path + [child]):
                return new_path

        # Indicate target not found
        return []
