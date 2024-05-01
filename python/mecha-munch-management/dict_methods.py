"""Functions to manage a users shopping cart items."""

from typing import Iterable

ItemQuantityT = dict[str, int]
RecipeT = dict[str, ItemQuantityT]
AisleMappingT = dict[str, list[str, bool]]
FulfillmentT = dict[str, list[int, str, bool]]
InventoryT = dict[str, list[int | str, str, bool]]


def add_item(current_cart: ItemQuantityT, items_to_add: Iterable[str]) -> ItemQuantityT:
    """Add items to shopping cart.

    :param current_cart: dict - the current shopping cart.
    :param items_to_add: iterable - items to add to the cart.
    :return: dict - the updated user cart dictionary.
    """

    for item in items_to_add:
        current_cart[item] = current_cart.get(item, 0) + 1

    return current_cart


def read_notes(notes: Iterable[str]) -> ItemQuantityT:
    """Create user cart from an iterable notes entry.

    :param notes: iterable of items to add to cart.
    :return: dict - a user shopping cart dictionary.
    """

    return dict.fromkeys(notes, 1)


def update_recipes(ideas: RecipeT, recipe_updates: ItemQuantityT) -> RecipeT:
    """Update the recipe ideas dictionary.

    :param ideas: dict - The "recipe ideas" dict.
    :param recipe_updates: dict - dictionary with updates for the ideas section.
    :return: dict - updated "recipe ideas" dict.
    """

    ideas.update(recipe_updates)
    return ideas


def sort_entries(cart: ItemQuantityT) -> ItemQuantityT:
    """Sort a users shopping cart in alphabetically order.

    :param cart: dict - a users shopping cart dictionary.
    :return: dict - users shopping cart sorted in alphabetical order.
    """

    return dict(sorted(cart.items()))


def send_to_store(cart: ItemQuantityT, aisle_mapping: AisleMappingT) -> FulfillmentT:
    """Combine users order to aisle and refrigeration information.

    :param cart: dict - users shopping cart dictionary.
    :param aisle_mapping: dict - aisle and refrigeration information dictionary.
    :return: dict - fulfillment dictionary ready to send to store.
    """

    fulfillment: FulfillmentT = {item: [qty] + aisle_mapping[item] for item, qty in cart.items()}
    return dict(sorted(fulfillment.items(), reverse=True))


def update_store_inventory(
    fulfillment_cart: FulfillmentT, store_inventory: InventoryT
) -> InventoryT:
    """Update store inventory levels with user order.

    :param fulfillment cart: dict - fulfillment cart to send to store.
    :param store_inventory: dict - store available inventory
    :return: dict - store_inventory updated.
    """

    for item, fulfillment in fulfillment_cart.items():
        store_inventory[item][0] -= fulfillment[0]
        if store_inventory[item][0] <= 0:
            store_inventory[item][0] = "Out of Stock"

    return store_inventory
