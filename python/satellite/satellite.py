def tree_from_traversals(preorder: list, inorder: list) -> dict:
    if (preorder_len := len(preorder)) != len(inorder):
        raise ValueError("traversals must have the same length")

    if (preorder_set := set(preorder)) != set(inorder):
        raise ValueError("traversals must have the same elements")

    if len(preorder_set) != preorder_len:
        raise ValueError("traversals must contain unique items")

    return _build_tree(preorder, inorder)


def _build_tree(p_ord: list, i_ord: list) -> dict:
    if not p_ord:
        return {}

    # First preorder node is root node
    # Find root node in inorder
    r = i_ord.index(v := p_ord[0])

    # Store value of root node and recursively build left and right nodes of tree
    return {"v": v, "l": _build_tree(p_ord[1 : r + 1], i_ord[:r]), "r": _build_tree(p_ord[r + 1 :], i_ord[r + 1 :])}
