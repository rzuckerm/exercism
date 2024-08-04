#include "simple_linked_list.h"

#include <stdexcept>

namespace simple_linked_list {

std::size_t List::size() const { return current_size; }

void List::push(int entry) {
    head = std::make_shared<List::Element>(entry, head);
    current_size++;
}

int List::pop() {
    current_size = (current_size) ? current_size - 1 : throw std::runtime_error("List is empty");
    int data = head->data;
    head = head->next;
    return data;
}

void List::reverse() {
    auto reversed_list = std::make_shared<List>();
    while (current_size) {
        reversed_list->push(pop());
    }

    head = reversed_list->head;
    current_size = reversed_list->current_size;
}
}  // namespace simple_linked_list
