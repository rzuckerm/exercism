from collections import deque


class BufferFullException(BufferError):
    """Exception raised when CircularBuffer is full.

    message: explanation of the error.

    """


class BufferEmptyException(BufferError):
    """Exception raised when CircularBuffer is empty.

    message: explanation of the error.

    """


class CircularBuffer:
    def __init__(self, capacity: int):
        self.buffer = deque([], capacity)

    def read(self):
        if len(self.buffer) == 0:
            raise BufferEmptyException("Circular buffer is empty")

        return self.buffer.popleft()

    def write(self, data):
        if len(self.buffer) == self.buffer.maxlen:
            raise BufferFullException("Circular buffer is full")

        self.buffer.append(data)

    def overwrite(self, data):
        if len(self.buffer) == self.buffer.maxlen:
            self.read()

        self.write(data)

    def clear(self):
        self.buffer.clear()
