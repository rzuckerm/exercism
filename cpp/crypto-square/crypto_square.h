#pragma once
#include <string>

namespace crypto_square
{
class cipher
{
  public:
    cipher(const std::string &text);
    std::string normalized_cipher_text() const;

  private:
    std::string cleaned;
};
} // namespace crypto_square
