import re

def ip0s():
    fh = open('lorem.txt')
    for line in fh:
        if re.search('[.]', line):
             print(line,end='')
def passes():
    fh = open('lorem.txt')
    for line in fh:
        if re.search('[A-Z]', line):
            if re.search('[0-9]', line):
                if re.search('[a-zA-Z]', line):
                    print(line, end='')
userask=str(input("1. IP aadressid\n2. Paroolid\n"))
if userask=="1" or userask=="1.":
    ip0s()
elif userask=="2"or userask=="2.":
    passes()
else:
    print("Incorrect input, the following are correct inputs: 1 | 1. | 2 | 2.")