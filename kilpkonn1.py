from turtle import*
import turtle
'''
colormode(hex)
pencolor("#FF6BDE")
fillcolor("#CC6BFE")
goto(180,180)
setpos(180,0)
setx(-180)
exitonclick()
''' 
s = int(input("Enter the length of the side of square: "))
pencolor("#FF6BDE")
fillcolor("#FF6BDE")
begin_fill
for _ in range(4):
  forward(s) # Forward turtle by s units
  left(90) # Turn turtle by 90 degree
end_fill
exitonclick()