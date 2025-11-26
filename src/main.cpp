#include "math_utils.hpp"
#include "string_utils.hpp"

#include <iostream>
#include <vector>

int main() {
    using namespace basic;

    std::vector<int> numbers{3, 7, 11, 15};
    std::cout << "Add 3 + 7 = " << add(3, 7) << '\n';
    std::cout << "Subtract 15 - 11 = " << subtract(15, 11) << '\n';
    std::cout << "Average of {3,7,11,15} = " << average(numbers) << '\n';

    const std::vector<std::string> words{"basic", "c++", "project"};
    std::cout << "Joined words: " << join(words, " | ") << '\n';

    const std::string phrase = "  Never odd or even  ";
    const std::string trimmed = trim(phrase);
    std::cout << "Trimmed phrase: '" << trimmed << "'\n";
    std::cout << "Is palindrome? " << std::boolalpha << is_palindrome(trimmed) << '\n';

    return 0;
}
