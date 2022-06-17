from tkinter import * # impordib tkinteri mooduli
import time # impordib time mooduli
import random # impordib random mooduli

winner      = False # Defineerib winner
red_horse_x = 0 # Defineerib red_horse_x
red_horse_y = 20 # Defineerib red_horse_y

blue_horse_x = -28 # Defineerib blue_horse_x
blue_horse_y = 110 # Defineerib blue_horse_y

def start_game(): # Defineerib funktsiooni
    global blue_horse_x # Defineerib blue_horse_x
    global red_horse_x  # Defineerib red_horse_x
    global winner # Defineerib winner

    while winner == False: # Korduv while loop
        time.sleep(0.05) # Sleep funktsiooni parameeter
        random_move_blue_horse = random.randint(0,20) # Defineerib random_move_blue_horse, mis on random.randint funktsiooni parameeter
        random_move_red_horse  = random.randint(0,20) # Defineerib random_move_red_horse
        #Update the x positions of both horses
        blue_horse_x += random_move_blue_horse # Defineerib blue_horse_x
        red_horse_x  += random_move_red_horse # Defineerib red_horse_x

        move_horses(random_move_red_horse,random_move_blue_horse) # Käivitab funktsiooni
        main_screen.update() # Update main_screen
        winner = check_winner() # Käivitab funktsiooni

    if winner == "Tie": # If winner == "Tie"
        Label(main_screen,text=winner,font=('calibri',20),fg="green").place(x=200,y=450) # Defineerib Labeli
    else: # Else
        Label(main_screen,text=winner+" Wins !!",font=('calibri',20),fg="green").place(x=200,y=450) # Defineerib Labeli


def move_horses(red_horse_random_move,blue_horse_random_move): # Defineerib funktsiooni
    canvas.move(red_horse,red_horse_random_move,0) # Defineerib canvasi move funktsiooni parameeter
    canvas.move(blue_horse,blue_horse_random_move,0) # Defineerib canvasi move funktsiooni parameeter

def check_winner(): # Defineerib funktsiooni
    if blue_horse_x >= 550 and red_horse_x >= 550: # If blue_horse_x >= 550 and red_horse_x >= 550
        return "Tie" # Return "Tie"
    if blue_horse_x >= 550: # If blue_horse_x >= 550
        return "Blue Horse" # Return "Blue Horse"
    if red_horse_x >= 550: # If red_horse_x >= 550
        return "Red Horse" # Return "Red Horse"
    return False # Return False

#Setting up the main screen
main_screen = Tk() # Defineerib main_screen
main_screen.title('Horse Racing') # Defineerib main_screeni title
main_screen.geometry('600x500') # Defineerib main_screeni geometry
main_screen.config(background='white') # Defineerib main_screeni background

#Setting up the Canvas
canvas = Canvas(main_screen,width=600,height=200,bg="white") # Defineerib canvasi
canvas.pack(pady=20) # Defineerib canvasi

#Import the images
red_horse_img = PhotoImage(file="./images/red-horse.png") # Defineerib red_horse_img
blue_horse_img = PhotoImage(file="./images/blue-horse.png") # Defineerib blue_horse_img

#Resizing the images
red_horse_img = red_horse_img.zoom(15) # Defineerib red_horse_img
red_horse_img = red_horse_img.subsample(50) # Defineerib red_horse_img
blue_horse_img = blue_horse_img.zoom(15) # Defineerib blue_horse_img
blue_horse_img = blue_horse_img.subsample(90) # Defineerib blue_horse_img

#Adding images to the canvas
red_horse = canvas.create_image(red_horse_x,red_horse_y,anchor=NW,image=red_horse_img) # Defineerib red_horse
blue_horse = canvas.create_image(blue_horse_x,blue_horse_y,anchor=NW,image=blue_horse_img) # Defineerib blue_horse

#Adding labels to screen (text)
l1 = Label(main_screen,text='Select your horse',font=('calibri',20),bg="white") # Defineerib Labeli
l1.place(x=230,y=280) # Defineerib Labeli
l2 = Label(main_screen,text='Click play when ready!',font=('calibri',20),bg='white') # Defineerib Labeli
l2.place(x=200,y=330) # Defineerib Labeli

b1 = Button(main_screen,text='Play!',height=2,width=15,bg='white',font=('calibri',10),command=start_game) # Defineerib Buttoni
b1.place(x=250,y=390) # Defineerib Buttoni

main_screen.mainloop() # Main screen loop et prograam käivitatakse