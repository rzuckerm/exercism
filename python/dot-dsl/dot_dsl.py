NODE, EDGE, ATTR = range(3)
ITEM_INFO = {NODE: (3, "Node"), EDGE: (4, "Edge"), ATTR: (3, "Attribute")}


class Node:
    def __init__(self, name: str, attrs: dict[str, str]):
        self.name, self.attrs = name, attrs

    def __eq__(self, other):
        return self.name == other.name and self.attrs == other.attrs


class Edge:
    def __init__(self, src, dst, attrs):
        self.src, self.dst, self.attrs = src, dst, attrs

    def __eq__(self, other):
        return self.src == other.src and self.dst == other.dst and self.attrs == other.attrs


class Graph:
    def __init__(self, data=None):
        if not isinstance(data, (type(None), list)):
            raise TypeError("Graph data malformed")

        self.nodes, self.edges, self.attrs = [], [], {}
        for item in data or []:
            if len(item) < 2:
                raise TypeError("Graph item incomplete")

            if item[0] not in ITEM_INFO:
                raise ValueError("Unknown item")

            if len(item) != ITEM_INFO[item[0]][0]:
                raise ValueError(f"{ITEM_INFO[item[0]][1]} is malformed")

            if item[0] == NODE:
                self.nodes.append(Node(*item[1:]))
            elif item[0] == EDGE:
                self.edges.append(Edge(*item[1:]))
            else:
                self.attrs[item[1]] = item[2]
