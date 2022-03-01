enteredString = input("What's the upper number? ")
myNumber = int(enteredString)
sum = 0
for number in range(1, myNumber + 1): # don't forget to add one to the upper range
    sum += number # this does the same thing as
    # sum = sum + number
print(sum)
