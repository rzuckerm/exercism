#pragma once
#include <boost/date_time/gregorian/gregorian.hpp>

#define TEENTH_DECL(dow) const boost::gregorian::date dow##teenth() const;
#define NTH_DECL(ord, dow) const boost::gregorian::date ord##_##dow##day() const;
#define DOW_DECLS(dow)                                                                                                 \
    TEENTH_DECL(dow)                                                                                                   \
    NTH_DECL(first, dow)                                                                                               \
    NTH_DECL(second, dow)                                                                                              \
    NTH_DECL(third, dow)                                                                                               \
    NTH_DECL(fourth, dow)                                                                                              \
    NTH_DECL(last, dow)

namespace meetup
{
class scheduler
{
  public:
    scheduler(boost::gregorian::date::month_type month, boost::gregorian::date::year_type year);
    DOW_DECLS(mon)
    DOW_DECLS(tues)
    DOW_DECLS(wednes)
    DOW_DECLS(thurs)
    DOW_DECLS(fri)
    DOW_DECLS(satur)
    DOW_DECLS(sun)

  private:
    const boost::gregorian::date teenth(boost::date_time::weekdays dow) const;
    const boost::gregorian::date nth(boost::gregorian::nth_day_of_the_week_in_month::week_num n,
                                     boost::date_time::weekdays dow) const;
    const boost::gregorian::date last(boost::date_time::weekdays dow) const;
    boost::gregorian::date::month_type month;
    boost::gregorian::date::year_type year;
};
} // namespace meetup
