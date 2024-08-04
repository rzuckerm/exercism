namespace hellmath
{
    enum class AccountStatus
    {
        troll,
        guest,
        user,
        mod
    };

    enum class Action
    {
        read,
        write,
        remove
    };

    bool display_post(AccountStatus poster, AccountStatus viewer)
    {
        return (poster == AccountStatus::troll) ? (viewer == AccountStatus::troll) : true;
    }

    bool permission_check(Action action, AccountStatus status)
    {
        bool result;
        switch (action)
        {
        case Action::read:
            result = true;
            break;

        case Action::write:
            result = (status != AccountStatus::guest);
            break;

        case Action::remove:
            result = (status == AccountStatus::mod);
            break;
        }

        return result;
    }

    bool valid_player_combination(AccountStatus status1, AccountStatus status2)
    {
        bool result;
        switch (status1)
        {
        case AccountStatus::troll:
            result = (status2 == AccountStatus::troll);
            break;

        case AccountStatus::guest:
            result = false;
            break;

        default:
            result = (status2 == AccountStatus::user || status2 == AccountStatus::mod);
        }

        return result;
    }

    bool has_priority(AccountStatus status1, AccountStatus status2)
    {
        return status1 > status2;
    }
}
