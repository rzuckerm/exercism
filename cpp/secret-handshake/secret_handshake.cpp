#include "secret_handshake.h"
#include <algorithm>

namespace secret_handshake
{
static std::string actions[]{"wink", "double blink", "close your eyes", "jump"};

std::vector<std::string> commands(unsigned char code)
{
    std::vector<std::string> cmds;
    std::for_each_n(std::vector<unsigned char>{0, 1, 2, 3}.begin(), 4, [code, &cmds](auto n) {
        if (code & (1 << n))
        {
            cmds.emplace_back(actions[n]);
        }
    });
    return (code & 0x10) ? std::vector<std::string>(cmds.rbegin(), cmds.rend()) : cmds;
}
} // namespace secret_handshake
