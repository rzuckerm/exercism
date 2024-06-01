class InputCell:
    def __init__(self, value=None):
        self._value = value
        self._deps = []
        self.update_counter = 0

    @property
    def value(self):
        return self._value

    @value.setter
    def value(self, new_value):
        self.update_counter += 1
        self._value = new_value
        for dep in self._deps:
            dep.compute()

    def compute(self):
        pass

    def add_dependency(self, dep):
        if dep not in self._deps:
            self._deps.append(dep)


class ComputeCell(InputCell):
    def __init__(self, inputs, compute_function):
        super().__init__()
        self._inputs = inputs
        self._compute_func = compute_function
        self._callbacks = []
        self.compute()
        for dep in inputs:
            dep.add_dependency(self)

    def compute(self):
        # Don't recompute until values have settled
        if len({x.update_counter for x in self._inputs}) == 1:
            new_value = self._compute_func([x.value for x in self._inputs])

            # Fire callbacks when value changes
            if self._value != new_value:
                self.value = new_value
                for callback in self._callbacks:
                    callback(self._value)

    def add_callback(self, callback):
        if callback not in self._callbacks:
            self._callbacks.append(callback)

    def remove_callback(self, callback):
        if callback in self._callbacks:
            self._callbacks.remove(callback)
