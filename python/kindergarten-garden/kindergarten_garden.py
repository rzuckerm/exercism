DEFAULT_STUDENTS = "Alice Bob Charlie David Eve Fred Ginny Harriet Ileana Joseph Kincaid Larry".split()
PLANTS = {"V": "Violets", "C": "Clover", "R": "Radishes", "G": "Grass"}


class Garden:
    def __init__(self, diagram: str, students: None | list[str] = None):
        self.diagram = [[PLANTS[n] for n in list(row)] for row in diagram.splitlines()]
        self.students = sorted(students or DEFAULT_STUDENTS)

    def plants(self, student: str) -> list:
        k = self.students.index(student)
        return sum([self.diagram[m][2 * k : 2 * k + 2] for m in [0, 1]], [])
