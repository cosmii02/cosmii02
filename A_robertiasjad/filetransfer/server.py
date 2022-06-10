import socket # Impordib socket mooduli

s = socket.socket() # Loob socket objekti
host = socket.gethostname() # Otsib hostnamei
port = 8080 # port on 8080
s.bind((host,port)) # saab serveri aadressi ja porti
s.listen(1) # kuulab kasutajat
print(host) # kontrollib, kas hostname on olemas
print("Waiting for any incoming connections ... ") # kontrollib, kas kasutaja on ühendatud
conn, addr = s.accept() # kuulab kasutajat
print(addr, "Has connected to the server") # kontrollib, kas kasutaja on ühendatud

filename = input(str("Please enter the filename of the file : ")) # küsib kasutajalt failinime
file = open(filename , 'rb') # avab faili
file_data = file.read(1024) # loeb faili
conn.send(file_data) # saadab faili
print("Data has been transmitted successfully") # kontrollib, kas fail on edukalt saadetud