#pragma once
#include <functional>
#include <mutex>

namespace Bankaccount {
class Bankaccount {
   public:
    Bankaccount();
    void open();
    void close();
    int balance() const;
    void deposit(int amount);
    void withdraw(int amount);

   private:
    void do_if_open(std::function<void()> action);
    void update_balance(int amount, int multiplier);

    bool is_open;
    int balance_;
    mutable std::mutex lock;
};  // class Bankaccount

}  // namespace Bankaccount
