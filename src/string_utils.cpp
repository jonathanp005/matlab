#include "string_utils.hpp"

#include <algorithm>
#include <cctype>
#include <sstream>

namespace {

bool is_space(char ch) {
    return std::isspace(static_cast<unsigned char>(ch)) != 0;
}

}  // namespace

namespace basic {

bool is_palindrome(const std::string& text) {
    std::string normalized;
    normalized.reserve(text.size());

    for (char ch : text) {
        if (!std::isalnum(static_cast<unsigned char>(ch))) {
            continue;
        }
        normalized.push_back(static_cast<char>(std::tolower(static_cast<unsigned char>(ch))));
    }

    const std::size_t len = normalized.size();
    for (std::size_t i = 0; i < len / 2; ++i) {
        if (normalized[i] != normalized[len - 1 - i]) {
            return false;
        }
    }

    return true;
}

std::string join(const std::vector<std::string>& parts, const std::string& delimiter) {
    if (parts.empty()) {
        return {};
    }

    std::ostringstream oss;
    for (std::size_t i = 0; i < parts.size(); ++i) {
        if (i > 0) {
            oss << delimiter;
        }
        oss << parts[i];
    }

    return oss.str();
}

std::string trim(const std::string& text) {
    if (text.empty()) {
        return {};
    }

    const auto first = std::find_if_not(text.begin(), text.end(), is_space);
    if (first == text.end()) {
        return {};
    }

    const auto last = std::find_if_not(text.rbegin(), text.rend(), is_space).base();
    return {first, last};
}

}  // namespace basic
