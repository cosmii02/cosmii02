import pygame, sys, time
#import the Paddle Class & the Ball Class
from paddle import Paddle
from ball import Ball
from pypresence import Presence
pygame.init() # initialise the pygame library

client_id = '917360810576187433'  # Fake ID, put your real one here
RPC = Presence(client_id)  # Initialize the client class
RPC.connect() # Start the handshake loop

# Define some colors
WHITE = (255, 255, 255) # Defines the color white
DARKBLUE = (36, 90, 190) # Defines dark blue color
LIGHTBLUE = (0, 176, 240) # Defines light blue color
RED = (255, 0, 0) # Defines red color
ORANGE = (255, 100, 0) # Defines orange color
YELLOW = (255, 255, 0) # Defines yellow color

score = 0 # Score variable

# Open a new window
size = (800, 600)
screen = pygame.display.set_mode(size)
pygame.display.set_caption("Breakout Game") # Set the title of the window

# This will be a list that will contain all the sprites we intend to use in our game.
all_sprites_list = pygame.sprite.Group()
# load onhit.wav as onhit
onhit = pygame.mixer.Sound('onhit.wav')
gameover = pygame.mixer.Sound('gameover.wav')
tetris = pygame.mixer.Sound('tetris.wav')
# Create the Paddle
# load pad.png
pygame.image.load("pad.png")
paddle = Paddle(DARKBLUE, 250, 10) #(color, x, y)
paddle.rect.x = 350 # x coordinate
paddle.rect.y = 560 # y coordinate

# Create the ball sprite
ball = Ball(DARKBLUE, 0, 10) # x coordinate, y coordinate
ball.rect.x = 345 # x coordinate
ball.rect.y = 195 # y coordinate

# Add the paddle and the ball to the list of sprites
all_sprites_list.add(paddle)
all_sprites_list.add(ball)

# The loop will carry on until the user exit the game (e.g. clicks the close button).
carryOn = True # This is a boolean variable that will be used to carry on the main loop

# The clock will be used to control how fast the screen updates
clock = pygame.time.Clock()

# -------- Main Program Loop -----------
while carryOn:
    # --- Main event loop
    for event in pygame.event.get():  # User did something
        if event.type == pygame.QUIT:  # If user clicked close
            carryOn = False  # Flag that we are done so we exit this loop

    # Moving the paddle when the use uses the arrow keys
    keys = pygame.key.get_pressed() # checking pressed keys
    if keys[pygame.K_LEFT]: # If the left arrow key is pressed
        paddle.moveLeft(5) # Move left
    if keys[pygame.K_RIGHT]: # If the right arrow key is pressed
        paddle.moveRight(5) # Move the paddle left or right

    all_sprites_list.update() # This is the place to call the update() method for any sprites.
    tetris.play() # play tetris
    # Check if the ball is bouncing against any of the 4 walls:
    if ball.rect.x >= 790: # Ball is touching the right wall
        ball.velocity[0] = -ball.velocity[0] # Reverse the ball direction
    if ball.rect.x <= 0: # Ball is touching the left wall
        ball.velocity[0] = -ball.velocity[0] # Reverse the ball direction
    if ball.rect.y > 590: # Ball is touching the bottom wall
        ball.velocity[1] = -ball.velocity[1] # Reverse the ball direction
        tetris.stop()
        gameover.play()
        font = pygame.font.Font(None, 74) # Set font
        text = font.render("GAME OVER", 1, WHITE) # Set text
        screen.blit(text, (250, 300)) # Display text
        pygame.display.flip() # Update the display
        pygame.time.wait(3000) # Wait 3 seconds

        # Stop the Game
        carryOn = False # Flag that we are done so we exit this loop
    if ball.rect.y < 40: # If the ball hits the top
        ball.velocity[1] = -ball.velocity[1] # Reverse the ball's y direction

    # Detect collisions between the ball and the paddles
    if pygame.sprite.collide_mask(ball, paddle): # If the ball hits the paddle
        ball.rect.x -= ball.velocity[0] # Move the ball back to the paddle
        ball.rect.y -= ball.velocity[1] # Move the ball back to the paddle
        onhit.play() # Play the onhit sound
        ball.bounce() # Reverse the ball's x direction
        score += 1 # Add to the score

        print(RPC.update(state="Ball go brr",
                         details="Score: " + str(score)))  # Set the presence

    screen.fill(DARKBLUE) # Fill the screen with dark blue
    pygame.draw.line(screen, WHITE, [0, 38], [800, 38], 2) # Draw the top border

    # Display the score and the number of lives at the top of the screen
    font = pygame.font.Font(None, 34) # Set the font
    text = font.render("Score: " + str(score), 1, WHITE) # Render the text
    screen.blit(text, (20, 10)) # Draw the text at the top left of the screen

    all_sprites_list.draw(screen) # Draw all sprites in one go.

    pygame.display.flip() # Update the screen with what we've drawn.

    clock.tick(60)# Limit to 60 frames per second

pygame.quit() # Close the window and quit.