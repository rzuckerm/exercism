from collections import defaultdict, deque


class RelativeDistance:
    def __init__(self, family_tree):
        # Convert family tree into an undirected graph
        self.relatives = defaultdict(set)
        for parent, children in family_tree.items():
            # Connect parent and children
            self.relatives[parent].update(children)

            # Connect siblings
            children_set = set(children)
            for sibling in children:
                self.relatives[sibling].add(parent)
                self.relatives[sibling].update(children_set - {sibling})

    def degree_of_separation(self, person_a, person_b):
        # If either person is not in the graph, indicate not related
        for letter, person in [("A", person_a), ("B", person_b)]:
            if person not in self.relatives:
                raise ValueError(f"Person {letter} not in family tree.")

        # Do breadth first search from person A to person B
        queue = deque([(person_a, 0)])
        visited = {person_a}
        while queue:
            person, distance = queue.popleft()
            if person == person_b:
                return distance

            for relative in self.relatives[person]:
                if not relative in visited:
                    visited.add(relative)
                    queue.append((relative, distance + 1))

        raise ValueError("No connection between person A and person B.")
