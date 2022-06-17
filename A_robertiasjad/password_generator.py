import random

chars = 'abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()'

while 1:
    password_len=int(input('Enter the length of the password: '))
    password_count=int(input('Enter the number of passwords to be generated: '))
    for x in range (0, password_count):
        password = ''
        for x in range (0, password_len):
            password_char = random.choice(chars)
            password = password + password_char
        print('Here is your password: ' ,password)