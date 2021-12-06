from turtle import*
import turtle

hideturtle()


	#  write("Sõber!", align="left", font=("Arial", 8, "normal"))
bgpic("sitt.png")
def koch(2, 3):
	if tase == 1:     	 
    	forward(pikkus)
    	left(60)
    	forward(pikkus)
    	right(120)
    	forward(pikkus)
    	left(60)
    	forward(pikkus)
	else:
    	koch(tase - 1, pikkus / 3)   
    	left(60)
    	koch(tase - 1, pikkus / 3)
    	right(120)
    	koch(tase - 1, pikkus / 3)
    	left(60)
    	koch(tase - 1, pikkus / 3)
for külg in range(3):
	koch(3, 50)
	right(120)
exitonclick()