#include <iostream>
#include <unordered_map>
#include <gmp.h>

constexpr int jumble(const int c) noexcept {
  int result{c > 96 ? c + 9 : c};
  result = 2 * (result % 16);

  return result > 15 ? result + 1 : result;
}

std::string get_flag(const auto &result) {
  mpz_t a, b, xored;

  mpz_init(xored);
  mpz_init_set_str(a, static_cast<const char *>(result.data()), 16);
  mpz_init_set_str(b,
                   "b4cbb83d4a7f83550fd73ec65ff938a736bda45a4a5fb08311afbef1fc42d48945062661b3d76dd4358ef91c5d16cc0104b3",
                   16);

  mpz_xor(xored, a, b);
  void *exported{mpz_export(nullptr, nullptr, 1, sizeof(char), 0, 0, xored)};

  std::string flag{static_cast<const char *>(exported)};

  mpz_clears(a, b, xored, nullptr);
  free(exported);

  return flag;
}

int main() {
  const std::string &alphabet{"0123456789abcdef"};
  const std::string &encrypted
      {"jbgkfmgkknbiblpmibgkcneiedgokibmekffokamknbkhgnlhnajeefpekiefmjgeogjbflijnekebeokpgngjnfbimlkdjdjhan"};

  std::unordered_map<int, char> jumbled_chars;
  std::vector<int> decrypted(encrypted.length());
  std::vector<char> result(encrypted.length());

  for (const auto c: alphabet) {
    jumbled_chars.emplace(jumble(c) % 16, c);
  }

  for (size_t i = 0; i < encrypted.length(); ++i) {
    int encrypted_val{encrypted[i] - 'a'};
    int prev_result{i != 0 ? decrypted[i - 1] : 0};

    auto need{(16 - prev_result) + encrypted_val};
    auto decoded{jumbled_chars.end()};

    while ((decoded = jumbled_chars.find(need % 16)) == jumbled_chars.end())
      need += 16;

    decrypted[i] = (prev_result + need) % 16;
    result[i] = decoded->second;
  }

  std::cout << get_flag(result) << std::endl;

  return 0;
}

