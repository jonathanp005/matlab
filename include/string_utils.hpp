#pragma once

#include <string>
#include <vector>

namespace basic {

bool is_palindrome(const std::string& text);
std::string join(const std::vector<std::string>& parts, const std::string& delimiter);
std::string trim(const std::string& text);

}  // namespace basic
