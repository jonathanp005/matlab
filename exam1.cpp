#include <iostream>
#include <iomanip>
#include <string>
#include <utility>
#include <vector>

struct Product {
    std::string name;
    double price;
    int quantity;

    Product(std::string name, double price, int quantity)
        : name(std::move(name)), price(price), quantity(quantity) {}
};

double calculateTotalValue(const std::vector<Product>& inventory) {
    double total = 0.0;
    for (const auto& product : inventory) {
        total += product.price * product.quantity;
    }
    return total;
}

void findLowStock(const std::vector<Product>& inventory, int threshold) {
    for (const auto& product : inventory) {
        if (product.quantity < threshold) {
            std::cout << product.name << '\n';
        }
    }
}

int main() {
    std::vector<Product> inventory;
    inventory.emplace_back("Laptop", 999.99, 5);
    inventory.emplace_back("Mouse", 19.50, 50);
    inventory.emplace_back("Monitor", 150.00, 2);

    std::cout << std::fixed << std::setprecision(2);
    std::cout << "Total inventory value: $" << calculateTotalValue(inventory) << '\n';

    std::cout << "Items needing restock (threshold: 10):" << '\n';
    findLowStock(inventory, 10);

    return 0;
}
