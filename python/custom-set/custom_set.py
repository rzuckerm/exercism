class CustomSet(set):
    def isempty(self) -> bool:
        return not self

    def __add__(self, other):
        return self | other
