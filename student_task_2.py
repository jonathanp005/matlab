#1. The List Filter: Isolating Even Numbers
# Create a list of 10 numbers
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]


# Loop through and filter
even_numbers = []
for number in numbers:
    if number % 2 == 0:
        even_numbers.append(number)

print("Even numbers:", even_numbers)


#2. The Dictionary Lookup: Price Checker
# Dictionary of items and prices
items_and_prices = {
    "Notebook": 3,
    "Pen": 1,
    "Backpack": 25,
}


#Function returning price
def get_item_price(items, item_name):
    if item_name in items:
        return f"Price is ${items[item_name]}"
    return "Item not found."


# Testing the function
print(get_item_price(items_and_prices, "Pen"))
print(get_item_price(items_and_prices, "Pencil"))


# 3. The String Formatter: Future Age Calculator
def future_age_message(name, age):
    return f"In 5 years, {name} will be {age + 5} years old."


print(future_age_message("Alex", 20))
