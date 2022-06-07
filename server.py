import socket, sys, time # Imprdib need moodulid


s=socket.socket() # Loob socket objekti
host=socket.gethostname() # Hosti nimi
port=8080 # Port
s.bind((host,port)) # Bindi host ja port
print('') # Prindib tühja rea
print('Hostname: '+host) # Prindib hosti nime
print('') # Prindib tühja rea
print('[+] Server started on port ' + str(port)) # Prindib serveri porti
print('')  # Prindib tühja rea
print('server is waiting for connection...') # Prindib serveri ootamise teade
print('')  # Prindib tühja rea
s.listen(1) # Loob serveri kuulamise
c, addr = s.accept() # Accepti klienti
print('[+] Got connection from ' + str(addr)) # Prindib kliendi aadressi
print('')  # Prindib tühja rea
while 1: # Loob serveri kuulamise
    message = input(str('>> ')) # Küsib klientilt sõnumit
    message = message.encode() # Kodeerib sõnum
    c.send(message) # Saadab kliendile sõnumit
    print('[+] Message sent') # Prindib sõnumi saatmise teate
    print('')  # Prindib tühja rea
    incoming_message = c.recv(1024) # Võtab kliendilt sõnumit
    incoming_message = incoming_message.decode() # Dekodeerib sõnum
    print('[+] Message received: ' + incoming_message) # Prindib sõnumi
    print('')  # Prindib tühja rea