class SpaceAge:
    EARTH_YEAR_IN_SEC = 31557600
    PLANET_YEARS = {
        "mercury": 0.2408467,
        "venus": 0.61519726,
        "earth": 1.0,
        "mars": 1.8808158,
        "jupiter": 11.862615,
        "saturn": 29.447498,
        "uranus": 84.016846,
        "neptune": 164.79132,
    }

    def __init__(self, seconds: int):
        self.years = seconds / SpaceAge.EARTH_YEAR_IN_SEC
        for planet, ratio in SpaceAge.PLANET_YEARS.items():
            setattr(self, f"on_{planet}", self.on_planet(ratio))

    def on_planet(self, ratio: float) -> float:
        return lambda: round(self.years / ratio, 2)
