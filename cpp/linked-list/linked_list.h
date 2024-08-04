#pragma once
#include <memory>
#include <stdexcept>

namespace linked_list {
template <typename T>
class Node {
   public:
    using node_ptr = std::shared_ptr<Node<T>>;
    Node(const T &data, node_ptr next = nullptr, node_ptr prev = nullptr) : data(data), next(next), prev(prev) {}

    T data;
    node_ptr next;
    node_ptr prev;
};

template <typename T>
class List {
   public:
    using node_ptr = std::shared_ptr<Node<T>>;
    List() {
        tail = std::make_shared<Node<T>>(T{});
        head = tail->prev = std::make_shared<Node<T>>(T{}, tail);
    }

    std::size_t count() const { return size; }
    void push(const T &data) { insert(data, tail, tail->prev); }
    T pop() { return remove(tail->prev); }
    void unshift(const T &data) { insert(data, head->next, head); }
    T shift() { return remove(head->next); }

    void erase(const T &data) {
        auto ptr = head->next;
        while (ptr != tail && ptr->data != data) {
            ptr = ptr->next;
        }

        if (ptr != tail) {
            remove(ptr);
        }
    }

   private:
    void insert(const T &data, node_ptr next, node_ptr prev) {
        next->prev = prev->next = std::make_shared<Node<T>>(data, next, prev);
        size++;
    }

    T remove(node_ptr node) {
        size = (size) ? size - 1 : throw std::runtime_error("Linked list is empty");
        T data = node->data;
        node->prev->next = node->next;
        node->next->prev = node->prev;
        return data;
    }

    node_ptr head;
    node_ptr tail;
    std::size_t size{};
};
}  // namespace linked_list
