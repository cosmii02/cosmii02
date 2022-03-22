import pygame
pygame.init()

screen=pygame.display.set_mode([300,300])
pygame.display.set_caption("Foor")

screen.fill([0, 0, 0])
pygame.draw.rect(screen, [80, 80, 80], [90, 20, 120, 260], 2)
pygame.draw.circle(screen, [255, 0, 0], [150,64], 40, 100)
pygame.draw.circle(screen, [255, 255, 0], [150,150], 40, 100)
pygame.draw.circle(screen, [0, 255, 0], [150,235], 40, 100)
pygame.display.flip()















running = True
while running:
  for event in pygame.event.get():
    if event.type == pygame.QUIT:
      running = False
    if running == False:
      pygame.quit()