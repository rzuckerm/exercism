class Node:
    def __init__(self, value, nxt):
        self.val = value
        self.nxt = nxt

    def value(self):
        return self.val

    def next(self):
        return self.nxt


class LinkedList:
    def __init__(self, values=None):
        self.hd = None
        self.len = 0
        for value in values or []:
            self.push(value)

    def __len__(self):
        return self.len

    def __iter__(self):
        node = self.hd
        while node:
            yield node.value()
            node = node.next()

    def head(self):
        if not self.hd:
            raise EmptyListException("The list is empty.")

        return self.hd

    def push(self, value):
        self.hd = Node(value, self.hd)
        self.len += 1

    def pop(self):
        old_head, self.hd = self.head(), self.hd.next()
        self.len -= 1
        return old_head.value()

    def reversed(self):
        return reversed(list(self))


class EmptyListException(Exception):
    pass
