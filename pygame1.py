import pygame
pygame.init()

screen = pygame.display.set_mode([300,300])
pygame.display.set_caption("Lumemees - Kenneth ja Kaup")

#colors

#joonistus

pygame.draw.circle(screen,[255,255,255], [150,200],40,100)
pygame.draw.circle(screen,[255,255,255], [150,135],30,100)
pygame.draw.circle(screen,[255,255,255], [150,88],20,100)

#lumememme nina
pygame.draw.polygon(screen, [255,153,0], [[147,90],[151,90],[150,100]],3)

pygame.display.flip()