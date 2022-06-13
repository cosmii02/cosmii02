import smtplib # Impordib smtplib mooduli

sender_email = "12northolt@gmail.com" # Saatja e-maili aadress
rec_email = "johangodinho69@gmail.com" # küsib kasutajalt saaja e-maili
password = input(str("Please enter your password : ")) # küsib sisestatud parooli
message = "Hey, this was sent using python" # sõnum, mida saadetakse

server = smtplib.SMTP('smtp.gmail.com', 587) # Sisestab sisestatud e-maili
server.starttls() # alustab starttls protokolli
server.login(sender_email, password) # Sisestab sisestatud e-maili
print("Login success") # Annab teada et sisselogimine õnnestus
server.sendmail(sender_email, rec_email, message) # Sisestab sisestatud e-maili
print("Email has been sent to ", rec_email) # Annab teada et e-mail on saadetud
