#include "bank_account.h"

#include <stdexcept>

namespace Bankaccount {
Bankaccount::Bankaccount() : is_open(false), balance_(0) {}

void Bankaccount::open() {
    std::lock_guard<std::mutex> g(lock);
    balance_ = (!is_open) ? 0 : throw std::runtime_error("Account already open");
    is_open = true;
}

void Bankaccount::close() {
    do_if_open([this]() { is_open = false; });
}

int Bankaccount::balance() const {
    std::lock_guard<std::mutex> g(lock);
    return (is_open) ? balance_ : throw std::runtime_error("Account not open");
}

void Bankaccount::deposit(int amount) {
    do_if_open([this, amount]() { update_balance(amount, 1); });
}

void Bankaccount::withdraw(int amount) {
    do_if_open([this, amount]() { update_balance(amount, -1); });
}

void Bankaccount::do_if_open(std::function<void()> action) {
    std::lock_guard<std::mutex> g(lock);
    (is_open) ? action() : throw std::runtime_error("Account not open");
}

void Bankaccount::update_balance(int amount, int multiplier) {
    if (amount < 0) {
        throw std::runtime_error("Amount cannot be negative");
    }

    int new_balance{balance_ + multiplier * amount};
    balance_ = (new_balance >= 0) ? new_balance : throw std::runtime_error("Balance cannot be negative");
}
}  // namespace Bankaccount
