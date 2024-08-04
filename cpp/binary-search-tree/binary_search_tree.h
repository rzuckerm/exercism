#pragma once
#include <memory>

namespace binary_search_tree {
template <typename T>
class binary_tree {
   public:
    binary_tree(const T &data, binary_tree *parent = nullptr) : data_(data), parent(parent) {}
    const std::unique_ptr<binary_tree> &left() const { return left_; }
    const std::unique_ptr<binary_tree> &right() const { return right_; }
    const T &data() const { return data_; }
    void insert(const T &data) {
        auto &side = (data <= data_) ? left_ : right_;
        if (side.get()) {
            side->insert(data);
        } else {
            side = std::make_unique<binary_tree>(data, this);
        }
    }

    class iterator {
       public:
        iterator() = default;
        iterator(const binary_tree *root) : ptr(descend_left(root)) {}
        const T &operator*() const { return ptr->data_; }
        bool operator!=(iterator &other) const { return ptr != other.ptr; }
        iterator &operator++() {
            binary_tree *node = ptr->right_.get();
            if (node) {
                ptr = descend_left(node);
            } else {
                T data = ptr->data_;
                do {
                    ptr = ptr->parent;
                } while (ptr && ptr->data_ < data);
            }

            return *this;
        }

       private:
        binary_tree *descend_left(const binary_tree *node) {
            while (node && node->left_) {
                node = node->left_.get();
            }

            return const_cast<binary_tree *>(node);
        }
        binary_tree *ptr;
    };

    iterator begin() const { return iterator(this); }
    iterator end() const { return {}; }

   private:
    T data_;
    binary_tree *parent;
    std::unique_ptr<binary_tree> left_, right_;
};
}  // namespace binary_search_tree
