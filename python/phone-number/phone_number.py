import re


class PhoneNumber:  # pylint: disable=too-few-public-methods
    def __init__(self, number: str):
        number = re.sub(r"[\s().+-]", "", number)
        self.number = number[1:] if number.startswith("1") and len(number) == 11 else number
        raise_value_error_if(len(self.number) < 10, "must not be fewer than 10 digits")
        raise_value_error_if(len(self.number) == 11, "11 digits must start with 1")
        raise_value_error_if(len(self.number) > 11, "must not be greater than 11 digits")
        raise_value_error_if(any(map(str.isalpha, self.number)), "letters not permitted")
        raise_value_error_if(not self.number.isdigit(), "punctuations not permitted")

        self.area_code, self.exchange, self.subscriber = self.number[:3], self.number[3:6], self.number[6:]
        raise_value_error_if_zero_or_one(self.area_code, "area code")
        raise_value_error_if_zero_or_one(self.exchange, "exchange code")

    def pretty(self) -> str:
        return f"({self.area_code})-{self.exchange}-{self.subscriber}"


def raise_value_error_if(cond: bool, error: str):
    if cond:
        raise ValueError(error)


def raise_value_error_if_zero_or_one(field: str, field_name: str):
    raise_value_error_if(field[0] == "0", f"{field_name} cannot start with zero")
    raise_value_error_if(field[0] == "1", f"{field_name} cannot start with one")
