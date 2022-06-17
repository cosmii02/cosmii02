import random # Impordib random mooduli

chars = 'abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()' # Defineerib kasutatavad sümbolid

while 1: # Korduv while loop
    password_len=int(input('Enter the length of the password: ')) # Küsi kasutaja sisestamist
    password_count=int(input('Enter the number of passwords to be generated: ')) # Küsi kasutaja sisestamist
    for x in range (0, password_count): # For loop, mis loob passwordi
        password = '' # Defineerib passwordi
        for x in range (0, password_len): # For loop, mis loob passwordi
            password_char = random.choice(chars) # Defineerib passwordi
            password = password + password_char # Defineerib passwordi
        print('Here is your password: ' ,password) # Printib passwordi