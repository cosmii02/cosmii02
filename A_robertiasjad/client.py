import socket,sys,time


s=socket.socket() # Loob socket objekti
host=input('Enter host: ') # Hosti nimi
port=8080 # määrab pordi
s.connect((host,port)) # ühendab hosti
print('Connected to ' + host + ' on port ' + str(port)) # Prindib ühenduse teade
while 1:
    incoming_message = s.recv(1024) # Võtab kliendilt sõnumit
    incoming_message = incoming_message.decode() # Dekodeerib sõnum
    print('[+] Message received: ' + incoming_message) # Prindib sõnumi
    print('')  # Prindib tühja rea
    message = input(str('>> ')) # Küsib klientilt sõnumit
    message = message.encode() # Kodeerib sõnum
    s.send(message) # Saadab kliendilt sõnumi
    print('[+] Message sent') # Prindib sõnumi saatmise teate
    print('')  # Prindib tühja rea