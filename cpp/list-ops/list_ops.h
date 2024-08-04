#pragma once
#include <vector>

namespace list_ops {
template <typename T>
void append(std::vector<T> &lhs, const std::vector<T> &rhs) {
    lhs.insert(lhs.end(), rhs.begin(), rhs.end());
}

template <typename T>
std::vector<T> concat(const std::vector<std::vector<T>> &lists) {
    std::vector<T> result;
    for (auto list : lists) {
        append(result, list);
    }

    return result;
}

template <typename T, typename F>
std::vector<T> filter(const std::vector<T> &list, F func) {
    std::vector<T> result;
    for (auto item : list) {
        if (func(item)) {
            result.emplace_back(item);
        }
    }

    return result;
}

template <typename T>
std::size_t length(const std::vector<T> &list) {
    return list.size();
}

template <typename T, typename F>
std::vector<T> map(const std::vector<T> &list, F func) {
    std::vector<T> result;
    for (auto item : list) {
        result.emplace_back(func(item));
    }

    return result;
}

template <typename T, typename F>
T foldl(const std::vector<T> &list, T init, F func) {
    T result{init};
    for (auto item : list) {
        result = func(result, item);
    }

    return result;
}

template <typename T>
std::vector<T> reverse(const std::vector<T> &list) {
    return std::vector<T>(list.rbegin(), list.rend());
}
template <typename T, typename F>
T foldr(const std::vector<T> &list, T init, F func) {
    return foldl(reverse(list), init, func);
}
}  // namespace list_ops
