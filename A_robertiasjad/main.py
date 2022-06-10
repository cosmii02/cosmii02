from tkinter import * # Impordib tkinter mooduli


def save_info(): # Funktsioon, mis salvestab andmed
    firstname_info = firstname.get() # Võtame väärtuse
    lastname_info = lastname.get() # Võtame väärtuse
    age_info = age.get() # Võtame väärtuse
    age_info = str(age_info) # Muudame väärtuse stringiks
    print(firstname_info, lastname_info, age_info) # Prindime andmed

    file = open("../user.txt", "w") # Avame faili kirjutamiseks
    file.write(firstname_info) # Kirjutame andmed faili
    file.write(lastname_info) # Kirjutame andmed faili
    file.write(age_info) # Kirjutame andmed faili
    file.close() # Sulgeme faili
    print(" User ", firstname_info, " has been registered successfully") # Prindime teate

    firstname_entry.delete(0, END) # Kustutame välja väärtused
    lastname_entry.delete(0, END) # Kustutame välja väärtused
    age_entry.delete(0, END) # Kustutame välja väärtused


screen = Tk() # Loome Tk'i objekti
screen.geometry("500x500") # Määrame ekraani suuruse
screen.title("Python Form") # Määrame ekraani pealkirja
heading = Label(text="Python Form", bg="grey", fg="black", width="500", height="3") # Määrame pealkirja
heading.pack() # Pakime ekraanile
firstname_text = Label(text="Firstname * ", ) # Määrame väljade pealkirjad
lastname_text = Label(text="Lastname * ", ) # Määrame väljade pealkirjad
age_text = Label(text="Age * ", ) # Määrame väljade pealkirjad
firstname_text.place(x=15, y=70) # Määrame väljade asukohad
lastname_text.place(x=15, y=140) # Määrame väljade asukohad
age_text.place(x=15, y=210) # Määrame väljade asukohad

firstname = StringVar() # Määrame väljade väärtused
lastname = StringVar() # Määrame väljade väärtused
age = IntVar() # Määrame väljade väärtused

firstname_entry = Entry(textvariable=firstname, width="30") # Määrame väljade objektid
lastname_entry = Entry(textvariable=lastname, width="30") # Määrame väljade objektid
age_entry = Entry(textvariable=age, width="30") # Määrame väljade objektid

firstname_entry.place(x=15, y=100) # Määrame väljade asukohad
lastname_entry.place(x=15, y=180) # Määrame väljade asukohad
age_entry.place(x=15, y=240) # Määrame väljade asukohad

register = Button(screen, text="Register", width="30", height="2", command=save_info, bg="grey") # Määrame nuppu
register.place(x=15, y=290) # Määrame nupu asukohta

screen.mainloop() # Käivitame ekraani