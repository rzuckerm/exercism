import io


class Stats:
    def __init__(self):
        self.read_bytes, self.read_ops, self.write_bytes, self.write_ops = 0, 0, 0, 0

    def read(self, func) -> bytes:
        self.read_ops += 1
        self.read_bytes += len(data := func())
        return data

    def write(self, func) -> int:
        self.write_ops += 1
        self.write_bytes += (num_bytes := func())
        return num_bytes


class MeteredFile(io.BufferedRandom):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self._stats = Stats()

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        return super().__exit__(exc_type, exc_val, exc_tb)

    def __iter__(self):
        while (line := self._stats.read(lambda: super().readline())) != b"":
            yield line

    def read(self, size: int = -1) -> bytes:
        return self._stats.read(lambda: super().read(size))

    @property
    def read_bytes(self) -> int:
        return self._stats.read_bytes

    @property
    def read_ops(self) -> int:
        return self._stats.read_ops

    def write(self, b: bytes) -> int:
        return self._stats.write(lambda: super().write(b))

    @property
    def write_bytes(self) -> int:
        return self._stats.write_bytes

    @property
    def write_ops(self) -> int:
        return self._stats.write_ops


class MeteredSocket:
    def __init__(self, socket):
        self._socket, self._stats = socket, Stats()

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        return self._socket.__exit__(exc_type, exc_val, exc_tb)

    def recv(self, bufsize: int, flags: int = 0) -> bytes:
        return self._stats.read(lambda: self._socket.recv(bufsize, flags))

    @property
    def recv_bytes(self) -> int:
        return self._stats.read_bytes

    @property
    def recv_ops(self) -> int:
        return self._stats.read_ops

    def send(self, data: bytes, flags: int = 0) -> int:
        return self._stats.write(lambda: self._socket.send(data, flags))

    @property
    def send_bytes(self) -> int:
        return self._stats.write_bytes

    @property
    def send_ops(self) -> int:
        return self._stats.write_ops
