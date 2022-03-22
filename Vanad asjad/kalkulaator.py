class Calculator:
    def addition(self):
        print(a + b)
    def subtraction(self):
        print(a - b)
    def multiplication(self):
        print(a * b)
    def division(self):
        print(a / b)
a = float(input("Enter first number:"))
b = float(input("Enter second number:"))
obj = Calculator()
choice = 1
while choice != 0:
    print("1. ADDING")
    print("2. SUBTRACTING")
    print("3. MULTIPLYING")
    print("4. DIVIDING")
    choice = float(input("Enter your choice:"))
    if choice == 1:
        print(obj.addition())
    elif choice == 2:
        print(obj.subtraction())
    elif choice == 3:
        print(obj.multiplication())
    elif choice == 4:
        print(obj.division())
    else:
        print("Invalid choice")