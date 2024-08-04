class Record:
    def __init__(self, record_id: int, parent_id: int):
        self.record_id = record_id
        self.parent_id = parent_id


class Node:
    def __init__(self, node_id: int):
        self.node_id = node_id
        self.children = []


def BuildTree(records: list[Record]) -> Node | None:
    nodes = {}
    for n, r in enumerate(sorted(records, key=lambda x: x.record_id)):
        if r.record_id != n:
            raise ValueError("Record id is invalid or out of order.")

        if r.record_id < r.parent_id:
            raise ValueError("Node parent_id should be smaller than it's record_id.")

        nodes[r.record_id] = Node(r.record_id)
        if r.record_id:
            if r.record_id == r.parent_id:
                raise ValueError("Only root should have equal record and parent id.")

            nodes[r.parent_id].children.append(nodes[r.record_id])

    return nodes.get(0)
