from turtle import*
import turtle
#pylint:disable=W0311

hideturtle()
happy=Screen()
happy.bgcolor("#000000")
turtle=turtle.Turtle()
shape("arrow")
color("#6A0DAD")
turtle.width(7)
colors=["peru", "ivory", "dark orange", "coral", "cyan", "hot pink", "gold", "ivory", "yellow", "red", "pink", "green", "blue", "light blue", "light green"]

def f1():
    
    for i in range(7):
        pensize(5)
        pencolor("light blue")
        color(colors[i % 19])
        begin_fill()
        left(330)
        forward(55)
        begin_fill()
        rt(110)
        circle(33)
        end_fill()
        rt(11)
        backward(33)
        end_fill()

def cake(x, y):
    fd(x)
    rt(90)
    fd(y)
    rt(90)
    fd(x)
    rt(90)
    fd(y)

def move(x, y):
    up()
    setposition(0, 0)
    setheading(90)
    rt(90)
    fd(x)
    lt(90)
    fd(y)
    pendown()

def mov(x, y):
    turtle.up()
    turtle.setposition(0, 0)
    setheading(90)
    lt(90)
    fd(x)
    rt(90)
    fd(y)
    pendown()

def A(size):
    rt(16)
    forward(size)
    rt(150)
    fd(size)
    backward(size / 2)
    rt(105)
    fd(size / 3)

def B():
    forward(60)
    rt(90)
    for i in range(18):
        rt(9)
        fd(3)
    for i in range(18):
        rt(13)
        backward(3)

def C():
    circle(2)

    for i in range(40):
        lt(5)
        backward(5)

def d(size):
    fd(size)
    backward(size)
    lt(90)
    fd(26)
    for i in range(15):
        rt(12)
        fd(4)
        fd(14)

def i ():
    fd(60)

def t(size):
    fd(size)
    backward(size / 2)
    lt(90)
    fd(10)
    backward(20)

def H():
    fd(60)
    backward(30)
    rt(90)
    fd(30)
    lt(90)
    fd(30)
    backward(60)

def P():
    fd(60)
    rt(90)
    fd(7)
    for i in range(8):
        rt(20)
        fd(5)

def Y():
    fd(40)
    left(60)
    fd(20)
    backward(20)
    rt(90)
    fd(35)

def R():
    fd(60)
    rt(90)
    fd(7)
    for i in range(15):
        rt(12)
        fd(3)
    lt(120)
    fd(49)

def D():
    fd(60)
    rt(90)
    fd(9)
    for i in range(13):
        rt(13)
        fd(7)

width(9)
pencolor("peru")
mov(325, 400)
A(104)
mov(220, 400)
d(90)
mov(200, 400)
i()
mov(180, 400)
t(92)
mov(160, 400)
i()
pencolor("hot pink")
mov(220, 300)
H()
mov(180, 300)
A(65)
mov(135, 300)
P()
mov(100, 300)
P()
mov(52, 300)
Y()
mov(28, 300)
B()
move(12, 300)
i()
move(36, 300)
R()
move(80, 300)
t(100)
move(102, 300)
H()
move(150, 300)
D()
move(190, 300)
A(65)
move(250, 300)
Y()
mov(120, 400)
color(colors[8 % 5])
begin_fill()
cake(40, 180)
end_fill()
mov(110, 435)
color(colors[8 % 3])
begin_fill()
cake(40, 160)
end_fill()
mov(100, 470)
color("hot pink")
begin_fill()
cake(40, 140)
end_fill()
mov(30, 510)
width(11)
exitonclick()