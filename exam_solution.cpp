#include <iomanip>
#include <iostream>
#include <string>
#include <vector>

class Item {
 private:
  std::string name;
  float price;
  int quantity;

 public:
  Item(const std::string& name, float price, int quantity)
      : name(name), price(price), quantity(quantity) {}

  float get_total_price() const { return price * static_cast<float>(quantity); }

  void update_price(float multiplier) { price *= multiplier; }

  void print_info() const {
    std::cout << name << " - Price: $" << std::fixed << std::setprecision(2) << price
              << " - Qty: " << quantity << "\n";
  }
};

float calculate_inventory_value(const std::vector<Item>& items) {
  float total = 0.0f;
  for (const Item& item : items) {
    total += item.get_total_price();
  }
  return total;
}

void apply_inflation(std::vector<Item>& items, float multiplier) {
  for (Item& item : items) {
    item.update_price(multiplier);
  }
}

int main() {
  Item laptop("Laptop", 999.99f, 2);
  Item mouse("Mouse", 24.50f, 10);
  Item keyboard("Keyboard", 79.95f, 5);

  std::vector<Item> inventory;
  inventory.push_back(laptop);
  inventory.push_back(mouse);
  inventory.push_back(keyboard);

  std::cout << "Items:\n";
  for (const Item& item : inventory) {
    item.print_info();
  }

  std::cout << std::fixed << std::setprecision(2);
  std::cout << "Initial inventory value: $" << calculate_inventory_value(inventory)
            << "\n";

  apply_inflation(inventory, 1.1f);

  std::cout << "After 10% inflation:\n";
  for (const Item& item : inventory) {
    item.print_info();
  }

  std::cout << "New inventory value: $" << calculate_inventory_value(inventory) << "\n";

  return 0;
}
