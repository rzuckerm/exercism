class School:
    def __init__(self):
        self.students: dict[str, int] = {}
        self.is_added: list[bool] = []

    def add_student(self, name: str, grade: int):
        self.is_added.append(name not in self.students)
        self.students.setdefault(name, grade)

    def roster(self) -> list[str]:
        return [name for name, _ in sorted(self.students.items(), key=lambda x: (x[1], x[0]))]

    def grade(self, grade_number: int) -> list[str]:
        return sorted(student for student, grade in self.students.items() if grade == grade_number)

    def added(self):
        return self.is_added
