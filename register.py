from tkinter import * # Impordib moodulid


def register_user(): # Funktsioon registreerimiseks

  username_info = username.get() # Võtame väärtuse kasutajanime väljalt
  password_info = password.get() # Võtame väärtuse parooli väljalt

  file=open(username_info+".txt", "w") # Avame faili kirjutamiseks
  file.write(username_info+"\n") # Kirjutame faili kasutajanime
  file.write(password_info) # Kirjutame faili parooli
  file.close() # Sulgeme faili

  username_entry.delete(0, END) # Kustutame välja väärtused
  password_entry.delete(0, END) # Kustutame välja väärtused

  Label(screen1, text = "Registration Sucess", fg = "green" ,font = ("calibri", 11)).pack() # Kui kasutaja on registreeritud, teeme teade

def register(): # Funktsioon registreerimiseks
  global screen1 # Muutujate defineerimine
  screen1 = Toplevel(screen) # Topleveli loomine
  screen1.title("Register") # Topleveli nimi
  screen1.geometry("300x250") # Topleveli suurus

  global username # Muutujate defineerimine
  global password # Muutujate defineerimine
  global username_entry # Muutujate defineerimine
  global password_entry # Muutujate defineerimine
  username = StringVar() # Muutuja defineerimine
  password = StringVar() # Muutuja defineerimine

  Label(screen1, text = "Please enter details below").pack() # Teksti kuvamine
  Label(screen1, text = "").pack() # Teksti kuvamine
  Label(screen1, text = "Username * ").pack() # Teksti kuvamine
  username_entry = Entry(screen1, textvariable = username) # Väljade kuvamine
  username_entry.pack() # Väljade kuvamine
  Label(screen1, text = "Password * ").pack() # Teksti kuvamine
  password_entry =  Entry(screen1, textvariable = password) # Väljade kuvamine
  password_entry.pack() # Väljade kuvamine
  Label(screen1, text = "").pack()
  Button(screen1, text = "Register", width = 10, height = 1, command = register_user).pack() # Nuppu kuvamine

def login(): # Funktsioon sisselogimiseks
  print("Login session started") # Kontrollime, et sisselogimine on alustatud


def main_screen(): # Funktsioon põhiväljale
  global screen # Muutujate defineerimine
  screen = Tk() # Tk-i loomine
  screen.geometry("300x250") # Tk-i suurus
  screen.title("Notes 1.0") # Tk-i nimi
  Label(text = "Notes 1.0", bg = "grey", width = "300", height = "2", font = ("Calibri", 13)).pack() # Teksti kuvamine
  Label(text = "").pack() # Teksti kuvamine
  Button(text = "Login", height = "2", width = "30", command = login).pack() # Nuppu kuvamine
  Label(text = "").pack() # Teksti kuvamine
  Button(text = "Register",height = "2", width = "30", command = register).pack() # Nuppu kuvamine

  screen.mainloop() # Tk-i käivitamine

main_screen() # Käivitame funktsiooni
  
