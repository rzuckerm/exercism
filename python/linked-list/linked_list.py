class Node:
    def __init__(self, value, succeeding=None, previous=None):
        self.value = value
        self.nxt = succeeding
        self.prev = previous


class LinkedList:
    def __init__(self):
        self.tail = Node(None)
        self.head = Node(None, succeeding=self.tail)
        self.tail.prev = self.head
        self.length = 0

    def __len__(self) -> int:
        return self.length

    def push(self, value):
        # Add node to tail
        self._add_node(value, previous=self.tail.prev, succeeding=self.tail)

    def pop(self):
        # Remove node from tail
        return self._del_node(self.tail.prev)

    def unshift(self, value):
        # Add node to head
        self._add_node(value, previous=self.head, succeeding=self.head.nxt)

    def shift(self):
        # Remove node from head
        return self._del_node(self.head.nxt)

    def delete(self, value):
        # Delete node with matching value from list
        node = self.head
        while node := node.nxt:
            if node.value == value:
                return self._del_node(node)

        raise ValueError("Value not found")

    def _add_node(self, value, succeeding=None, previous=None):
        succeeding.prev = previous.nxt = Node(value, succeeding=succeeding, previous=previous)
        self.length += 1

    def _del_node(self, node):
        if self.length == 0:
            raise IndexError("List is empty")

        node.prev.nxt = node.nxt
        node.nxt.prev = node.prev
        self.length -= 1
        return node.value
