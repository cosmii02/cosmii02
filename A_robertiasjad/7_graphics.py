from tkinter import * # impordib tkinter mooduli


def run(): # Defineerib funktsiooni
    name1 = name_storage.get() # Defineerib name1, mis on name_storage.get funktsiooni parameeter
    print(name1) # prindib name1
    name.delete(0, END) # kustutab name kasti sisu


screen = Tk() # Defineerib screen, mis on Tk() funktsiooni parameeter
screen.title("My first graphics program") # Defineerib screen.title funktsiooni parameeter
screen.geometry("500x500") # Defineerib screen.geometry funktsiooni parameeter

welcome_text = Label(text="Welcome to our first graphics program ", fg="red", bg="yellow") # Defineerib welcome_text, mis on Labeli
welcome_text.pack() # Defineerib welcome_texti

click_me = Button(text="Click me", fg="red", bg="yellow", command=run) # Defineerib click_me, mis on Buttoni
click_me.place(x=10, y=20) # Defineerib click_mei

name_storage = StringVar() # Defineerib name_storage, mis on StringVar() funktsiooni parameeter
name = Entry(textvariable=name_storage) # Defineerib name, mis on Entryi
name.pack() # Defineerib namei
screen.mainloop() # Defineerib screeni mainloop
