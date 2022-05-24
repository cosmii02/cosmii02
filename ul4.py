import pygame, sys, random, time # Imports the said modules
pygame.init() #initialize pygame
# initialize display at 640x480
screen = pygame.display.set_mode((640, 480)) # set screen size
pygame.display.set_caption("Animeerimine") # set window title
clock = pygame.time.Clock() # create clock object
# start timer
start_time = time.time() # get current time
Score = 0 # initialize score

bg = pygame.image.load("bg_rally.jpg") # load background image

f1_blue = pygame.image.load("f1_blue.png") # load car image
f1_blue = pygame.transform.rotate(f1_blue, 180) # rotate car image

f2_blue = pygame.image.load("f1_blue.png") # load car image
f2_blue = pygame.transform.rotate(f2_blue, 180) # rotate car image

f1_red = pygame.image.load("f1_red.png") # load car image

# speed and position

BspeedY = 3 # initialize car speed

BposY = random.randint(0, 100) # initialize car position
B2posY = random.randint(0, 100) # initialize car position
RposX, RposY = 298, 390 # initialize car position
RspeedY = 0 # initialize car speed
gameover = False # initialize gameover flag
BposX = random.randint(450, 460)  # initialize car position
B2posX = random.randint(450, 460) # initialize 2nd car position
while not gameover: # while game is not over loop
    # fps
    clock.tick(120) # set frame rate
    # quit game if window is closed
    for event in pygame.event.get(): # event handling loop
        if event.type == pygame.QUIT: # if window is closed
            sys.exit() # quit game

    # pildi lisamine ekraanile
    screen.blit(bg, (0, 0)) # blit background image
    screen.blit(f1_blue, (BposX, BposY)) # blit car image
    screen.blit(f2_blue, (B2posX, B2posY)) # blit car image
    BposY += BspeedY # move car
    B2posY += BspeedY+1 # move car

    screen.blit(f1_red, (RposX, RposY)) # blit car image
    RposY += RspeedY # move car
    screen.blit(pygame.font.Font(None, 30).render(f"Score: {Score}", True, [255, 255, 255]), [10, 460]) # score

    if BposY >= 480: # if car is out of screen
        BposY = -120 # reset car position
        Score += 1 # increase score
        BposX = random.randint(130, 280) # initialize car position

    # move red car with arrow keys
    keys = pygame.key.get_pressed() # get pressed keys
    if keys[pygame.K_UP]: # move car up
        RposY -= 5 # move car up
    if keys[pygame.K_DOWN]: # move car down
        RposY += 5 # move car down
    if keys[pygame.K_LEFT]: # move car left
        RposX -= 5 # move car left
    if keys[pygame.K_RIGHT]: # move right
        RposX += 5 # move car right

    if B2posY >= 480: # if car is out of screen
        B2posY = -120 # reset car position
        Score += 1 # add score
        B2posX = random.randint(300, 480) # initialize 2nd car position

    if RposY >= 480: # if car is out of screen
        RposY = -120 # reset car position

        # end game if f1_blue or f2_blue hits f1_red
    if B2posY <= RposY + 58 and B2posY >= RposY - 58: # if f1_blue is in the same y-position as f1_red
        if B2posX <= RposX + 55 and B2posX >= RposX - 55: # if f1_blue is in the same x-position as f1_red
            gameover = True # set gameover flag

    if BposY <= RposY + 58 and BposY >= RposY - 58: # end game if f1_blue or f2_blue hits f1_red
        if BposX <= RposX + 55 and BposX >= RposX - 55: # end game if f1_blue or f2_blue hits f1_red
            gameover = True # end game
    # increase speed by 1 every 10 seconds
    if time.time() % 10 == 0: # if time is divisible by 10
        BspeedY += 1 # increase speed by 1

    # show time elapsed on top right

    screen.blit(pygame.font.Font(None, 20).render(f"Time elapsed: {int(time.time() - start_time)}", True, [255, 255, 255]), [519, 40]) # show time elapsed


    # show current speed on top left as text
    screen.blit(pygame.font.Font(None, 30).render(f"Speed: {BspeedY}", True, [255, 255, 255]), [10, 10]) # show current speed on top left as text


    pygame.display.flip() # update display
gameoverbg= pygame.image.load("gameover.png") # load gameover image
# dont quit pygame unless you want to close the window
while True: # endless loop for gameover scene

    if gameover == True: # if gameover is true
        screen.blit(gameoverbg, (0, 0)) # show gameover image
        # shpw score without font
        screen.blit(pygame.font.Font(None, 50).render(f"Score: {Score}", True, [255, 255, 255]), [250, 400]) # show score
        pygame.display.flip() # update display
    for event in pygame.event.get(): # checks for events
        if event.type == pygame.QUIT: # quit game if window is closed
            sys.exit() # quit pygame if window is closed