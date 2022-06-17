from tkinter import *
import time
import random

winner      = False
red_horse_x = 0
red_horse_y = 20

blue_horse_x = -28
blue_horse_y = 110

def start_game():
    global blue_horse_x
    global red_horse_x 
    global winner

    while winner == False:
        time.sleep(0.05)
        random_move_blue_horse = random.randint(0,20)
        random_move_red_horse  = random.randint(0,20)
        #Update the x positions of both horses
        blue_horse_x += random_move_blue_horse
        red_horse_x  += random_move_red_horse

        move_horses(random_move_red_horse,random_move_blue_horse)
        main_screen.update()
        winner = check_winner()

    if winner == "Tie":
        Label(main_screen,text=winner,font=('calibri',20),fg="green").place(x=200,y=450)
    else:
        Label(main_screen,text=winner+" Wins !!",font=('calibri',20),fg="green").place(x=200,y=450)


def move_horses(red_horse_random_move,blue_horse_random_move):
    canvas.move(red_horse,red_horse_random_move,0)
    canvas.move(blue_horse,blue_horse_random_move,0)

def check_winner():
    if blue_horse_x >= 550 and red_horse_x >= 550:
        return "Tie"
    if blue_horse_x >= 550:
        return "Blue Horse"
    if red_horse_x >= 550:
        return "Red Horse"
    return False

#Setting up the main screen
main_screen = Tk()
main_screen.title('Horse Racing')
main_screen.geometry('600x500')
main_screen.config(background='white')

#Setting up the Canvas
canvas = Canvas(main_screen,width=600,height=200,bg="white")
canvas.pack(pady=20)

#Import the images
red_horse_img = PhotoImage(file="./images/red-horse.png")
blue_horse_img = PhotoImage(file="./images/blue-horse.png")

#Resizing the images
red_horse_img = red_horse_img.zoom(15)
red_horse_img = red_horse_img.subsample(50)
blue_horse_img = blue_horse_img.zoom(15)
blue_horse_img = blue_horse_img.subsample(90)

#Adding images to the canvas
red_horse = canvas.create_image(red_horse_x,red_horse_y,anchor=NW,image=red_horse_img)
blue_horse = canvas.create_image(blue_horse_x,blue_horse_y,anchor=NW,image=blue_horse_img)

#Adding labels to screen (text)
l1 = Label(main_screen,text='Select your horse',font=('calibri',20),bg="white")
l1.place(x=230,y=280)
l2 = Label(main_screen,text='Click play when ready!',font=('calibri',20),bg='white')
l2.place(x=200,y=330)

b1 = Button(main_screen,text='Play!',height=2,width=15,bg='white',font=('calibri',10),command=start_game)
b1.place(x=250,y=390)

main_screen.mainloop()