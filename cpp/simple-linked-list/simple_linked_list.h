#pragma once
#include <memory>

namespace simple_linked_list {
class List {
   public:
    List() = default;

    std::size_t size() const;
    void push(int entry);
    int pop();
    void reverse();

   private:
    struct Element {
        Element(int data, std::shared_ptr<Element> next = nullptr) : data{data}, next{next} {};
        int data{};
        std::shared_ptr<Element> next{};
    };

    std::shared_ptr<Element> head;
    std::size_t current_size{0};
};
}  // namespace simple_linked_list
