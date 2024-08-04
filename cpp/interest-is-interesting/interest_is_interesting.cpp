// interest_rate returns the interest rate for the provided balance.
double interest_rate(double balance)
{
    double interest{2.475};
    if (balance < 0.0)
    {
        interest = 3.213;
    }
    else if (balance < 1000.0)
    {
        interest = 0.5;
    }
    else if (balance < 5000.0)
    {
        interest = 1.621;
    }

    return interest;
}

// yearly_interest calculates the yearly interest for the provided balance.
double yearly_interest(double balance)
{
    return interest_rate(balance) / 100.0 * balance;
}

// annual_balance_update calculates the annual balance update, taking into
// account the interest rate.
double annual_balance_update(double balance)
{
    return yearly_interest(balance) + balance;
}

// years_until_desired_balance calculates the minimum number of years required
// to reach the desired balance.
int years_until_desired_balance(double balance, double target_balance)
{
    int years{0};
    while (balance < target_balance)
    {
        years++;
        balance = annual_balance_update(balance);
    }

    return years;
}