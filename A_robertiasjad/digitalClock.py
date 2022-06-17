from tkinter import Tk # impordib tkinteri
from tkinter import Label # impordib tkinteri
import time # impordib time mooduli
import sys # impordib sys mooduli

master = Tk() # Defineerib master
master.title("Digital Clock") # Defineerib masteri title

def get_time(): # Defineerib funktsiooni
    timeVar = time.strftime("%I:%M:%S %p") # Defineerib timeVar, mis on time.strftime funktsiooni parameeter
    clock.config(text=timeVar) # Defineerib clocki textiks timeVar
    clock.after(200,get_time) # Defineerib clocki after funktsiooni parameeter


Label(master,font=("Arial",30),text="Digital Clock",fg="white",bg="black").pack() # Defineerib Labeli
clock = Label(master, font=("Arial",100),bg="black",fg="white") # Defineerib Labeli
clock.pack() # Defineerib clocki

get_time() # Käivitab funktsiooni

master.mainloop() # Defineerib masteri mainloop