"""Functions to prevent a nuclear meltdown."""

NumberT = int | float

CRITICAL_TEMP = 800
MIN_ELECTRONS_PER_SECOND = 500
MAX_TEMP_ELECTONS_PRODUCT = 500_000

MIN_GREEN_LEVEL = 80
MIN_ORANGE_LEVEL = 60
MIN_RED_LEVEL = 30

LOW_THRESH = 0.9
NORMAL_ABS_THRESH = 0.1


def is_criticality_balanced(temperature: NumberT, neutrons_emitted: NumberT) -> bool:
    """Verify criticality is balanced.

    :param temperature: int or float - temperature value in kelvin.
    :param neutrons_emitted: int or float - number of neutrons emitted per second.
    :return: bool - is criticality balanced?

    A reactor is said to be critical if it satisfies the following conditions:
    - The temperature is less than 800 K.
    - The number of neutrons emitted per second is greater than 500.
    - The product of temperature and neutrons emitted per second is less than 500000.
    """

    return (
        temperature < CRITICAL_TEMP
        and neutrons_emitted > MIN_ELECTRONS_PER_SECOND
        and temperature * neutrons_emitted < MAX_TEMP_ELECTONS_PRODUCT
    )


def reactor_efficiency(voltage: NumberT, current: NumberT, theoretical_max_power: NumberT) -> str:
    """Assess reactor efficiency zone.

    :param voltage: int or float - voltage value.
    :param current: int or float - current value.
    :param theoretical_max_power: int or float - power that corresponds to a 100% efficiency.
    :return: str - one of ('green', 'orange', 'red', or 'black').

    Efficiency can be grouped into 4 bands:

    1. green -> efficiency of 80% or more,
    2. orange -> efficiency of less than 80% but at least 60%,
    3. red -> efficiency below 60%, but still 30% or more,
    4. black ->  less than 30% efficient.

    The percentage value is calculated as
    (generated power/ theoretical max power)*100
    where generated power = voltage * current
    """

    efficiency = 100 * voltage * current / theoretical_max_power
    if efficiency >= MIN_GREEN_LEVEL:
        return "green"

    if efficiency >= MIN_ORANGE_LEVEL:
        return "orange"

    if efficiency >= MIN_RED_LEVEL:
        return "red"

    return "black"


def fail_safe(
    temperature: NumberT, neutrons_produced_per_second: NumberT, threshold: NumberT
) -> str:
    """Assess and return status code for the reactor.

    :param temperature: int or float - value of the temperature in kelvin.
    :param neutrons_produced_per_second: int or float - neutron flux.
    :param threshold: int or float - threshold for category.
    :return: str - one of ('LOW', 'NORMAL', 'DANGER').

    1. 'LOW' -> `temperature * neutrons per second` < 90% of `threshold`
    2. 'NORMAL' -> `temperature * neutrons per second` +/- 10% of `threshold`
    3. 'DANGER' -> `temperature * neutrons per second` is not in the above-stated ranges
    """

    temp_neutron_product = temperature * neutrons_produced_per_second
    if temp_neutron_product < LOW_THRESH * threshold:
        return "LOW"

    if abs(temp_neutron_product - threshold) <= NORMAL_ABS_THRESH * threshold:
        return "NORMAL"

    return "DANGER"
