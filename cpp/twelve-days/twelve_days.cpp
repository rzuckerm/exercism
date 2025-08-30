#include "twelve_days.h"

namespace twelve_days {
const std::string lyrics[12][2] = {
    {"first", "a Partridge in a Pear Tree."},
    {"second", "two Turtle Doves, and"},
    {"third", "three French Hens,"},
    {"fourth", "four Calling Birds,"},
    {"fifth", "five Gold Rings,"},
    {"sixth", "six Geese-a-Laying,"},
    {"seventh", "seven Swans-a-Swimming,"},
    {"eighth", "eight Maids-a-Milking,"},
    {"ninth", "nine Ladies Dancing,"},
    {"tenth", "ten Lords-a-Leaping,"},
    {"eleventh", "eleven Pipers Piping,"},
    {"twelfth", "twelve Drummers Drumming,"},
};

std::string recite_verse(int n) {
    std::string verse{"On the " + lyrics[n][0] + " day of Christmas my true love gave to me: "};
    for (int i = n; i >= 0; i--) {
        verse += lyrics[i][1] + std::string((i > 0) ? " " : "\n");
    }

    return verse;
}

std::string recite(int start, int end) {
    std::string result{""};
    for (int n = start; n <= end; n++) {
        result += recite_verse(n - 1) + std::string((n < end) ? "\n" : "");
    }

    return result;
}
}  // namespace twelve_days
