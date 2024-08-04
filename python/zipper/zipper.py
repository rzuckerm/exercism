class Zipper:
    def __init__(self, tree, parents=None):
        self.tree, self.parents = tree, parents or []

    @staticmethod
    def from_tree(tree):
        return Zipper(tree)

    def value(self):
        return self.tree.get("value")

    def set_value(self, value):
        self.tree["value"] = value
        return self

    def left(self):
        tree = self.tree.get("left")
        return Zipper(tree, self.parents + [self.tree]) if tree else None

    def set_left(self, tree):
        self.tree["left"] = tree
        return self

    def right(self):
        tree = self.tree.get("right")
        return Zipper(tree, self.parents + [self.tree]) if tree else None

    def set_right(self, tree):
        self.tree["right"] = tree
        return self

    def up(self):
        return Zipper(self.parents[-1], self.parents[:-1]) if self.parents else None

    def to_tree(self):
        return self.parents[0] if self.parents else self.tree
