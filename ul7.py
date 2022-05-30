import pygame, random # imports the said modules

pygame.init() #initialize pygame

(width, height) = (640, 480) #set screen size
screen = pygame.display.set_mode((width, height)) #create screen
pygame.display.set_caption("ul7") #set caption
screen.fill((0, 0, 0)) #fill screen with black

min_intensity = 0 #set minimum size
max_intensity = 255 #set maximum size
radius=10 #Starting at 10px size

running = True #set running to true
while running: #while running
    ev=pygame.event.get() #get events
    pygame.display.flip() #update screen

    # draw circles with mouse
    for event in ev:
        if event.type == pygame.MOUSEBUTTONUP: #if mouse button is released
            pos = pygame.mouse.get_pos() #get mouse position
            color=(random.randint(min_intensity, max_intensity), random.randint(min_intensity, max_intensity), random.randint(min_intensity, max_intensity)) #random color
            random.randint(min_intensity, max_intensity) #random color
            pygame.draw.circle(screen, color, pos, radius, width=1) #draw circle
            radius+=1 #increase radius
            pygame.display.flip() #update screen
            if radius > 100: #if radius is greater than 100
                radius = 10 #reset radius
                pygame.display.flip() #update screen
        if event.type == pygame.QUIT: #if user quits
            running = False #set running to false