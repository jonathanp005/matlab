#1. The Comprehension Challenge
#The original list
names = ["alice", "bob", "CHAD", "diana"]


#New list with long names capitalized
formatted_names = [name.capitalize() for name in names if len(name) > 3]
print("Formatted names:", formatted_names)


#2. The Timing Decorator
import time


#Define the timer function
def timer(func):
    def wrapper(*args, **kwargs):
        start_time = time.time()
        result = func(*args, **kwargs)
        end_time = time.time()
        print(f"{func.__name__} took {end_time - start_time:.6f} seconds to execute.")
        return result

    return wrapper


#Create an example task
@timer
def example_task():
    time.sleep(0.2)
    return "Task complete."


print(example_task())


#3. The Infinite Generator
def powers_of_two():
    value = 2
    while True:
        yield value
        value *= 2


# Safe usage: take only the first 5 values.
generator = powers_of_two()
for _ in range(5):
    print(next(generator))
