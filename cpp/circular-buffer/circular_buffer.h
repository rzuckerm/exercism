#pragma once
#include <algorithm>
#include <stdexcept>
#include <vector>

namespace circular_buffer
{
template <typename T> class circular_buffer
{
  public:
    circular_buffer(std::size_t n) : size(n), read_idx(0), count(0)
    {
        buffer.resize(n);
        std::fill_n(buffer.begin(), n, T{});
    }

    void clear()
    {
        count = 0;
    }

    T read()
    {
        count = (count >= 1) ? count - 1 : throw std::domain_error("Buffer is empty");
        T item = buffer[read_idx];
        read_idx = (read_idx + 1) % size;
        return item;
    }

    void write(T item)
    {
        count = (count < size) ? count + 1 : throw std::domain_error("Buffer is full");
        buffer[(read_idx + count - 1) % size] = item;
    }

    void overwrite(T item)
    {
        if (count >= size)
        {
            read();
        }

        write(item);
    }

  private:
    std::vector<T> buffer;
    std::size_t size;
    std::size_t read_idx;
    std::size_t count;
};
} // namespace circular_buffer
