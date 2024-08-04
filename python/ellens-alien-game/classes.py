"""Solution to Ellen's Alien Game exercise."""

from __future__ import annotations


class Alien:
    """Create an Alien object with location x_coordinate and y_coordinate.

    Attributes
    ----------
    (class)total_aliens_created: int
    x_coordinate: int - Position on the x-axis.
    y_coordinate: int - Position on the y-axis.
    health: int - Number of health points.

    Methods
    -------
    hit(): Decrement Alien health by one point.
    is_alive(): Return a boolean for if Alien is alive (if health is > 0).
    teleport(new_x_coordinate, new_y_coordinate): Move Alien object to new coordinates.
    collision_detection(other): Implementation TBD.
    """

    total_aliens_created: int = 0

    def __init__(self, x_coordinate: int, y_coordinate: int):
        self.x_coordinate = x_coordinate
        self.y_coordinate = y_coordinate
        self.health = 3
        Alien.total_aliens_created += 1

    def hit(self):
        """Record hit"""
        self.health = max(self.health - 1, 0)

    def is_alive(self) -> bool:
        """
        Indicate whether alien is alive

        :return: True if alien is alive, False otherwise
        """

        return self.health > 0

    def teleport(self, x_coordinate: int, y_coordinate: int):
        """
        Teleport to new coordinate

        :param x_coordinate: X-coordinate
        :param y_coordinate: Y-coordinate
        """
        self.x_coordinate = x_coordinate
        self.y_coordinate = y_coordinate

    def collision_detection(self, alien: "Alien"):
        """TBD"""


def new_aliens_collection(coordinates: list[tuple[int, int]]) -> list[Alien]:
    """
    Create new alien collection

    :param coordinates: Coordinates for each Alien
    :return: List of aliens
    """

    return [Alien(x_coordinate, y_coordinate) for x_coordinate, y_coordinate in coordinates]
