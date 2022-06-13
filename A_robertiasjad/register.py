from tkinter import * # Imprdib tkinter mooduli
import os # Impordib os mooduli


def delete2(): # Kustutab login väljundi
    screen3.destroy() # Kustutab login väljundi


def delete3(): # Kustutab login väljundi
    screen4.destroy() # Kustutab login väljundi


def delete4(): # Kustutab login väljundi
    screen5.destroy() # Kustutab login väljundi


def login_sucess(): # Eduka sisselogimise funktsioon
    global screen3 # Muudab login väljundi
    screen3 = Toplevel(screen) # Muudab login väljundi
    screen3.title("Success") # Määrab akna tiiteltektsi
    screen3.geometry("150x100") # Määrab akna suuruse
    Label(screen3, text="Login Sucess").pack() # Määrab login väljundi
    Button(screen3, text="OK", command=delete2).pack() # Määrab login väljundi


def password_not_recognised(): # Eduka sisselogimise funktsioon
    global screen4 # Muudab login väljundi
    screen4 = Toplevel(screen) # Muudab login väljundi
    screen4.title("Success") # Määrab akna tiiteltektsi
    screen4.geometry("150x100") # Määrab akna suuruse
    Label(screen4, text="Password Error").pack() # Määrab login väljundi
    Button(screen4, text="OK", command=delete3).pack() # Määrab login väljundi


def user_not_found(): # Eduka sisselogimise funktsioon
    global screen5 # Muudab login väljundi
    screen5 = Toplevel(screen) # Muudab login väljundi
    screen5.title("Success") # Määrab akna tiiteltektsi
    screen5.geometry("150x100") # Määrab akna suuruse
    Label(screen5, text="User Not Found").pack() # Määrab login väljundi
    Button(screen5, text="OK", command=delete4).pack() # Määrab login väljundi


def register_user(): # Kasutaja registreerimise funktsioon
    print("working") # Kontrollimiseks

    username_info = username.get() # Kasutaja nimi
    password_info = password.get() # Kasutaja parool

    file = open(username_info, "w") # Avab faili
    file.write(username_info + "\n") # Kirjutab faili
    file.write(password_info) # Kirjutab faili
    file.close() # Sulgeb faili

    username_entry.delete(0, END) # Kustutab kasutaja nime väljast
    password_entry.delete(0, END) # Kustutab kasutaja parooli väljast

    Label(screen1, text="Registration Sucess", fg="green", font=("calibri", 11)).pack() # Määrab registreerimise väljundi


def login_verify(): # Eduka sisselogimise funktsioon
    username1 = username_verify.get() # Kasutaja nimi
    password1 = password_verify.get() # Kasutaja parool
    username_entry1.delete(0, END) # Kustutab kasutaja nime väljast
    password_entry1.delete(0, END) # Kustutab kasutaja parooli väljast

    list_of_files = os.listdir() # Loob kataloogist failide nimekirja
    if username1 in list_of_files: # Kontrollib kas kasutaja on olemas
        file1 = open(username1, "r") # Avab faili
        verify = file1.read().splitlines() # Loob faili sisestuseks
        if password1 in verify: # Kontrollib kas parool on olemas
            login_sucess() # Kutsub login sucess funktsiooni
        else: # Kui parool ei ole olemas
            password_not_recognised() # Kutsub password error funktsiooni

    else: # Kui kasutaja ei ole olemas
        user_not_found() # Kutsub user not found funktsiooni


def register(): # Kasutaja registreerimise funktsioon
    global screen1 # Muudab login väljundi
    screen1 = Toplevel(screen) # Muudab login väljundi
    screen1.title("Register") # Määrab akna tiiteltektsi
    screen1.geometry("300x250") # Määrab akna suuruse

    global username # Muudab login väljundi
    global password # Muudab login väljundi
    global username_entry # Muudab login väljundi
    global password_entry # Muudab login väljundi
    username = StringVar() # Muudab login väljundi
    password = StringVar() # Muudab login väljundi

    Label(screen1, text="Please enter details below").pack() # Määrab login väljundi
    Label(screen1, text="").pack() # Määrab login väljundi
    Label(screen1, text="Username * ").pack() # Määrab login väljundi

    username_entry = Entry(screen1, textvariable=username) # Määrab login väljundi
    username_entry.pack() # Määrab login väljundi
    Label(screen1, text="Password * ").pack() # Määrab login väljundi
    password_entry = Entry(screen1, textvariable=password) # Määrab login väljundi
    password_entry.pack() # Määrab login väljundi
    Label(screen1, text="").pack() # Määrab login väljundi
    Button(screen1, text="Register", width=10, height=1, command=register_user).pack() # Määrab login väljundi


def login(): # Eduka sisselogimise funktsioon
    global screen2 # Muudab login väljundi
    screen2 = Toplevel(screen) # Muudab login väljundi
    screen2.title("Login") # Määrab akna tiiteltektsi
    screen2.geometry("300x250") # Määrab akna suuruse
    Label(screen2, text="Please enter details below to login").pack() # Määrab login väljundi
    Label(screen2, text="").pack() # Määrab login väljundi

    global username_verify # Muudab login väljundi
    global password_verify # Muudab login väljundi

    username_verify = StringVar() # Muudab login väljundi
    password_verify = StringVar() # Muudab login väljundi

    global username_entry1 # Muudab login väljundi
    global password_entry1 # Muudab login väljundi

    Label(screen2, text="Username * ").pack() # Määrab login väljundi
    username_entry1 = Entry(screen2, textvariable=username_verify) # Määrab login väljundi
    username_entry1.pack() # Määrab login väljundi
    Label(screen2, text="").pack() # Määrab login väljundi
    Label(screen2, text="Password * ").pack() # Määrab login väljundi
    password_entry1 = Entry(screen2, textvariable=password_verify) # Määrab login väljundi
    password_entry1.pack() # Määrab login väljundi
    Label(screen2, text="").pack() # Määrab login väljundi
    Button(screen2, text="Login", width=10, height=1, command=login_verify).pack() # Määrab login väljundi


def main_screen(): # Eduka sisselogimise funktsioon
    global screen # Muudab login väljundi
    screen = Tk() # Muudab login väljundi
    screen.geometry("300x250") # Määrab akna suuruse
    screen.title("Notes 1.0") # Määrab akna tiiteltektsi
    Label(text="Notes 1.0", bg="grey", width="300", height="2", font=("Calibri", 13)).pack() # Määrab login väljundi
    Label(text="").pack() # Määrab login väljundi
    Button(text="Login", height="2", width="30", command=login).pack() # Määrab login väljundi
    Label(text="").pack() # Määrab login väljundi
    Button(text="Register", height="2", width="30", command=register).pack() # Määrab login väljundi

    screen.mainloop() # Muudab login väljundi


main_screen() # Käivitab main_screen funktsiooni

