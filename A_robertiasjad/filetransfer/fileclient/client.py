import socket # Impordib socket mooduli
s = socket.socket() # Loob socket objekti
host = input(str("Sisestage saatja hosti aadress : ")) # host = "
port = 8080 # port on 8080
s.connect((host,port)) #saab serveri aadressi ja porti
print("Ühendatud ... ") # kontrollib, kas ühendus on loodud

filename = input(str("Sisestage sissetuleva faili failinimi : "))
file = open(filename, 'wb') # avab faili
file_data = s.recv(1024) # saadab faili
file.write(file_data) # kirjutab faili
file.close() # sulgeb faili
print("Fail on edukalt vastu võetud.")