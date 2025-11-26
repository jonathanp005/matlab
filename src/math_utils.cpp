#include "math_utils.hpp"

#include <numeric>
#include <stdexcept>

namespace basic {

int add(int a, int b) {
    return a + b;
}

int subtract(int a, int b) {
    return a - b;
}

double average(const std::vector<int>& values) {
    if (values.empty()) {
        throw std::invalid_argument("Cannot compute average of an empty set");
    }

    const long long sum = std::accumulate(values.begin(), values.end(), 0LL);
    return static_cast<double>(sum) / static_cast<double>(values.size());
}

}  // namespace basic
