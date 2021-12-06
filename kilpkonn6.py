
#pylint:disable=W0311

import turtle
happy=turtle.Screen()
happy.bgcolor("black")
turtle=turtle.Turtle()
turtle.shape("circle")
turtle.color("yellow")
turtle.width(7)
colors=["peru","ivory","dark orange","coral","cyan","hot pink","gold","ivory","yellow","red","pink","green","blue","light blue","light green",]



def draw_happy(i,x,y):
    turtle.pencolor("linen")
    turtle.color(colors[i%7])
    turtle.begin_fill()
    turtle.lt(70)
    turtle.penup()
    turtle.goto(x,y)
    turtle.pendown()
    turtle.circle(33)
    turtle.end_fill()

def ballon(x,y):
    for i in range(5):
        draw_happy(i,x,y)  

def f1():
   
  for i in range(7):
    turtle.pensize(5)
    turtle.pencolor('light blue')
    turtle.color(colors[i%19])
    turtle.begin_fill()
    turtle.left(330)
    turtle.forward(55)
    turtle.begin_fill()
    turtle.rt(110)
    turtle.circle(33)
    turtle.end_fill()
    turtle.rt(11)
    turtle.backward(33)
    turtle.end_fill()


def cake(x,y):
   turtle.fd(x)
   turtle.rt(90)
   turtle.fd(y)
   turtle.rt(90)
   turtle.fd(x)
   turtle.rt(90)
   turtle.fd(y)


def heart():
   for i in range(43):
         
         turtle.pencolor(colors[i%9])
         turtle.rt(5)
         turtle.fd(5)
         
   turtle.fd(150)
   turtle.penup()
   turtle.rt(140)
   turtle.fd(147)
   turtle.pendown()
   for i in range(43):
         turtle.pencolor(colors[i%9])
         turtle.lt(5)
         turtle.fd(5)
   turtle.lt(7)
   turtle.fd(151)


def move(x,y):
   turtle.up()
   turtle.setposition(0,0)
   turtle.setheading(90)
   turtle.rt(90)
   turtle.fd(x)
   turtle.lt(90)
   turtle.fd(y)
   turtle.pendown()


def mov(x,y):
   turtle.up()
   turtle.setposition(0,0)
   turtle.setheading(90)
   turtle.lt(90)
   turtle.fd(x)
   turtle.rt(90)
   turtle.fd(y)
   turtle.pendown()


def A(size):
  turtle.rt(19)
  turtle.forward(size)
  turtle.rt(141)
  turtle.fd(size)
  turtle.backward(size/2)
  turtle.rt(105)
  turtle.fd(int(size/3))

  
def B(size):
   turtle.forward(size)
   turtle.rt(90)
   for i in range(18):
      turtle.rt(9)
      turtle.fd(size//20)
   for i in range(18):
      turtle.rt(size//5)
      turtle.backward(size//20)

def C(size):
    turtle.rt(140)
    turtle.up()
    for i in range(0,int(size/4)):
        turtle.fd(int(size/20))
        turtle.lt(5)
    turtle.down()
    for i in range(int((int(size/4)*3))):
        turtle.back(int(size/20))
        turtle.rt(5)
        
      


def D(size):
   turtle.fd(size)
   turtle.rt(90)
   turtle.fd(size//10)
   for i in range(13):
      turtle.rt(13)
      turtle.fd(size//8)  


def E(size):
    turtle.rt(90)
    turtle.fd(int(size/3))
    turtle.back(int(size/3))
    turtle.left(90)
    turtle.fd(size/2)
    turtle.rt(90)
    turtle.fd(int(size/3))
    turtle.back(int(size/3))
    turtle.lt(90)
    turtle.fd(size/2)
    turtle.rt(90)
    turtle.fd(int(size/3))

def F(size):
    turtle.fd(size)
    turtle.rt(90)
    turtle.fd(size//2)
    turtle.backward(size//2)
    turtle.rt(90)
    turtle.fd(size//3)
    turtle.lt(90)
    turtle.fd(size//3)


def G(size):
    pass


def H(size):
   turtle.fd(size)
   turtle.backward(size//2)
   turtle.rt(90)
   turtle.fd(size//2)
   turtle.lt(90)
   turtle.fd(size//2)
   turtle.backward(size)

def I(size):
   turtle.fd(size)
   turtle.rt(90)
   turtle.circle(size//8)
   

def J(size):
    turtle.lt(180)
    turtle.fd(size/1.2)
    for i in range(13):
        turtle.rt(13)
        turtle.fd(int(size/21))
    turtle.ht()
    

def K(size):
    turtle.fd(size)
    #turtle.width(9)
    turtle.backward(size//2)
    turtle.rt(60)
    turtle.fd(size//1.5)
    turtle.backward(size//2)
    turtle.rt(80)
    turtle.fd(size//1.3)


def L(size):
    turtle.rt(90)
    turtle.fd(int(size/2))
    turtle.back(int(size/2))
    turtle.lt(90)
    turtle.fd(size)


def M(size):
    turtle.fd(int(size/2))
    turtle.rt(135)
    turtle.fd(int(size/3))
    turtle.lt(90)
    turtle.fd(int(size/3))
    turtle.rt(135)
    turtle.fd(int(size/2))

def N(size):
    turtle.fd(size)
    turtle.rt(150)
    turtle.fd(size+int(size/6))
    turtle.lt(150)
    turtle.fd(size)


def O(size):
    turtle.right(90)
    turtle.circle(size//2)


def P(size):
   turtle.fd(size)
   turtle.rt(90)
   turtle.fd(size//8)
   for i in range(8):
       turtle.rt(20)
       turtle.fd(size//9)
   

def Q(size):
    turtle.circle(100)
    for i in range(0,int(size/6)):
        turtle.lt(9)
        turtle.fd(5)
    turtle.back(int(size))

def R():
   turtle.fd(60)
   turtle.rt(90)
   turtle.fd(7)
   for i in range(15):
      turtle.rt(12)
      turtle.fd(3)
   turtle.lt(120)
   turtle.fd(40)


def S(size):
    turtle.rt(90)
    for i in range(0,5):
        if i<3:
            turtle.fd(size/2)
            turtle.lt(90)
            if i==2:
                turtle.rt(90)
        else:
            turtle.right(90)
            turtle.fd(size/2)
   
def T(size):
   turtle.fd(size)
   turtle.rt(90)
   turtle.fd(size//2)
   turtle.backward(size//2)



def U(size):
	turtle.rt(90)
	for i in range(size//10):
		turtle.lt(15)
		turtle.fd(size//10)
	turtle.fd(size//2)
	turtle.back(size//2)
	
	for i in range(size//10):
		turtle.rt(13)
		turtle.back(size//10)
	turtle.lt(5)
	for i in range(size//10):
		turtle.rt(17)
		turtle.back(size//10)
	turtle.back(size//2)
	

def V(size):
	turtle.right(20)
	turtle.fd(size)
	turtle.back(size)
	turtle.lt(40)
	turtle.fd(size)
	turtle.back(size)

def W(size):
	
	turtle.lt(20)
	turtle.fd(size)
	turtle.back(size)
	turtle.rt(50)
	turtle.fd(size//1.5)
	turtle.lt(60)
	turtle.backward(size//1.5)
	turtle.rt(50)
	turtle.fd(size)
	
	
def X(size):
    turtle.rt(30)
    turtle.fd(size)
    turtle.backward(size//2)
    turtle.rt(120)
    turtle.fd(size//2)
    turtle.backward(size)
    
def Y(size):
   turtle.fd(size)
   turtle.left(60)
   turtle.fd(size//2)
   turtle.backward(size//2)
   turtle.rt(90)
   turtle.fd(size//1.5)


def Z(size):
    turtle.lt(90)
    turtle.fd(size)
    turtle.rt(135)
    turtle.fd(size+(size//2))
    turtle.lt(135)
    turtle.fd(size)

turtle.speed(19)
#Cake maker section


mov(120,100)
turtle.color(colors[8%5])
turtle.begin_fill()
cake(40,180)
turtle.end_fill()
mov(110,135)
turtle.color("hot pink")
turtle.begin_fill()
cake(40,160)
turtle.end_fill()
mov(100,170)
turtle.color("blanched almond")
turtle.begin_fill()
cake(40,140)
turtle.end_fill()
mov(30,210)
turtle.width(11)
turtle.pencolor("red")
turtle.circle(7)
#end Of Cake Section

#section of Ballons
move(180,307)
mov(0,0)
ballon(-490, 200)
ballon(490, 200)
ballon(183,-100)
ballon(-133,-100)
    

#end Section of ballons

#Name section
turtle.speed(7)  
turtle.width(15)
turtle.pencolor("yellow")

mov(260,240)
Y(size=70)

turtle.width(11)
mov(230,240)
A(60)
mov(180,240)
N(size=60)
mov(130,240)
A(size=60)


#happybithday
turtle.pencolor("cyan")
turtle.width(13)
mov(260,0)
H(100)
turtle.width(7)
mov(190,0)
A(65)
mov(135,0)
P(60)
mov(100,0)
P(60)
mov(52,0)
Y(60)
mov(28,0)
B(60)
move(12,0)
I(60)
move(36,0)
R()
move(80,0)
T(100)
move(102,0)
H(60)
move(150,0)
turtle.pencolor('hotpink')
D(200)
move(160,0)
A(60)
move(220,0)
Y(60)
#ballon(80)
turtle.pencolor('yellow')
turtle.width(15)
mov(100, -280)
I(size=60)
mov(-30,-120)
turtle.width(11)
heart()  
mov(-150, -280)
U(60)
happy.exitonclick()