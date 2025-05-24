<#
.SYNOPSIS
Implement the circular buffer data structure.

.DESCRIPTION
A circular buffer, cyclic buffer or ring buffer is a data structure that uses a single, fixed-size buffer as if it were connected end-to-end.
Please implement the circular buffer class with these methods:
- Write     : write new value into the buffer, raise error if the buffer is full.
- Overwrite : overwrite the oldest element in the buffer if the buffer is full, otherwise behave like write.
- Clear     : clear all elements in the buffer, it is now empty.
- Read      : read the oldest element in the buffer, and return its value.

.EXAMPLE
$buffer = [CircularBuffer]::new(2)

$buffer.Write(1)
$buffer.Read()
Return: 1

$buffer.Write(2)
$buffer.Write(3)
$buffer.Overwrite(5)
$buffer.Read()
Return: 5

$buffer.Clear()
$buffer.Read()
Throw "BufferError: Circular buffer is empty"
#>

Class CircularBuffer {
    [object[]]$Buffer
    [int]$Size
    [int]$ReadIdx
    [int]$WriteIdx
    [int]$Count

    CircularBuffer([int]$size) {
        $this.Buffer = @($null) * $size
        $this.Size = $size
        $this.Clear()
    }

    Write([int]$value) {
        if ($this.Count -ge $this.Size) { throw "BufferError: Circular buffer is full" }

        $this.Buffer[$this.WriteIdx] =$value
        $this.WriteIdx = ($this.WriteIdx + 1) % $this.Size
        $this.Count++
    }

    Overwrite([object]$Value) {
        if ($this.Count -ge $this.Size) { $this.Read() }
        $this.Write($Value)
    }

    Clear() {
        $this.ReadIdx = $this.WriteIdx = $this.Count = 0
    }

    [int] Read() {
        if ($this.Count -lt 1) { throw "BufferError: Circular buffer is empty" }

        $value = $this.Buffer[$this.ReadIdx]
        $this.ReadIdx = ($this.ReadIdx + 1) % $this.Size
        $this.Count--
        return $value
    }
}
