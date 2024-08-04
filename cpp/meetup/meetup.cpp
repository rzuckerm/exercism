#include "meetup.h"

#define TEENTH_IMPL(dow, Dow)                                                                                          \
    const boost::gregorian::date scheduler::dow##teenth() const                                                        \
    {                                                                                                                  \
        return teenth(boost::date_time::Dow##day);                                                                     \
    }

#define NTH_IMPL(ord, dow, Dow)                                                                                        \
    const boost::gregorian::date scheduler::ord##_##dow##day() const                                                   \
    {                                                                                                                  \
        return nth(boost::gregorian::nth_day_of_the_week_in_month::ord, boost::date_time::Dow##day);                   \
    }

#define LAST_IMPL(dow, Dow)                                                                                            \
    const boost::gregorian::date scheduler::last_##dow##day() const                                                    \
    {                                                                                                                  \
        return last(boost::date_time::Dow##day);                                                                       \
    }

#define DOW_IMPLS(dow, Dow)                                                                                            \
    TEENTH_IMPL(dow, Dow)                                                                                              \
    NTH_IMPL(first, dow, Dow)                                                                                          \
    NTH_IMPL(second, dow, Dow)                                                                                         \
    NTH_IMPL(third, dow, Dow)                                                                                          \
    NTH_IMPL(fourth, dow, Dow)                                                                                         \
    LAST_IMPL(dow, Dow)

namespace meetup
{
scheduler::scheduler(boost::gregorian::date::month_type month, boost::gregorian::date::year_type year)
    : month(month), year(year)
{
}

DOW_IMPLS(mon, Mon)
DOW_IMPLS(tues, Tues)
DOW_IMPLS(wednes, Wednes)
DOW_IMPLS(thurs, Thurs)
DOW_IMPLS(fri, Fri)
DOW_IMPLS(satur, Satur)
DOW_IMPLS(sun, Sun)

const boost::gregorian::date scheduler::teenth(boost::date_time::weekdays dow) const
{
    return boost::gregorian::first_day_of_the_week_after(dow).get_date(boost::gregorian::date(year, month, 12));
}

const boost::gregorian::date scheduler::nth(boost::gregorian::nth_day_of_the_week_in_month::week_num n,
                                            boost::date_time::weekdays dow) const
{
    return boost::gregorian::nth_day_of_the_week_in_month(n, dow, month).get_date(year);
}

const boost::gregorian::date scheduler::last(boost::date_time::weekdays dow) const
{
    return boost::gregorian::last_day_of_the_week_in_month(dow, month).get_date(year);
}
} // namespace meetup
