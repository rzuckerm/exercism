class BankAccount:
    def __init__(self):
        self.balance = None

    def get_balance(self):
        return self._do_if_open(lambda: self.balance)

    def open(self):
        if self.balance is not None:
            raise ValueError("account already open")

        self.balance = 0

    def deposit(self, amount):
        self._do_if_open(lambda: self._update_balance(amount, 1))

    def withdraw(self, amount):
        self._do_if_open(lambda: self._update_balance(amount, -1))

    def close(self):
        self._do_if_open(self.__init__)

    def _do_if_open(self, task_func):
        if self.balance is None:
            raise ValueError("account not open")

        return task_func()

    def _update_balance(self, amount, multiplier):
        if amount < 0:
            raise ValueError("amount must be greater than 0")

        if (new_balance := self.balance + multiplier * amount) < 0:
            raise ValueError("amount must be less than balance")

        self.balance = new_balance
