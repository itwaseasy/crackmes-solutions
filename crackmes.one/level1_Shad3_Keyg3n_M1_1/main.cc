#include <iostream>
#include <array>
#include <random>

// https://crackmes.one/crackme/5e66aea233c5d4439bb2dde8

std::string randString(size_t size) {
  static const std::array<char, 23> charset = {
      'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k',
      'l', 'm', 'n', 'o', 'p', 'q', 'r', 's',
      't', 'u', 'v', 'w', 'x', 'y', 'z'};

  std::default_random_engine randomEngine(std::random_device{}());
  std::uniform_int_distribution<> distribution(0, charset.size() - 1);

  auto randCharacter = [&charset = std::as_const(charset),
      &randomEngine, &distribution]() {
    return charset[distribution(randomEngine)];
  };

  std::string result(size, 0);
  std::generate_n(result.begin(), size, randCharacter);

  return result;
}

int main() {
  std::cout << "Key: " << randString(10) << std::endl;
  return 0;
}
