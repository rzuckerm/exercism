#include "sublist.h"

#include <algorithm>

namespace sublist {
List_comparison sublist(const std::vector<int> &list1, const std::vector<int> &list2) {
    if (list1 == list2) {
        return List_comparison::equal;
    }

    bool side = (list1.size() < list2.size());
    const std::vector<int> &a{side ? list1 : list2}, &b{side ? list2 : list1};
    auto match = std::search(b.begin(), b.end(), a.begin(), a.end());
    if (match != b.end()) {
        return side ? List_comparison::sublist : List_comparison::superlist;
    }

    return List_comparison::unequal;
}
}  // namespace sublist
