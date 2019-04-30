from Graphics import *
from Maps import *
from Node import *
from Pathfinder import *
from time import sleep

width,height = 500,500
w,h = width,height
win = GraphWin('Pathfinder',width,height)

map = map4
rows = len(map)
cols = len(map[0])

boxWidth = width//cols
boxHeight = height//rows
borderWidth = 0.3
borderColor = '#E0E0E0'

root = Node(0,0)
target = Node(9,9)

dots = []

# GRAPHICS SETUP
def drawLabel(text,row,col,color='#000000',size=14):
    x = (row*boxWidth)+((size/3)*len(text))
    y = (col*boxHeight)+size
    point = Point(x,y)
    label = Text(point,text)
    label.setFill(color)
    label.setSize(size)
    label.draw(win)

def drawGrid():
    for i in range(h):
        line = Line(Point(0,i*boxHeight),Point(w,i*boxHeight))
        line.setWidth(borderWidth)
        line.setFill(borderColor)
        line.draw(win)
    for i in range(w):
        line = Line(Point(i*boxWidth,0),Point(i*boxWidth,h))
        line.setWidth(borderWidth)
        line.setFill(borderColor)
        line.draw(win)
    for row in range(rows):
        for col in range(cols):
            print(row,col)
            if map[row][col] == 1:
                p1 = Point(col*boxWidth,row*boxHeight)
                p2 = Point(p1.getX()+boxWidth,p1.getY()+boxHeight)
                box = Rectangle(p1,p2)
                box.setFill('#707070')
                box.setOutline(borderColor)
                box.draw(win)
            if Node(row,col) == root:
                drawLabel('Root',row,col)
            if Node(row,col) == target:
                drawLabel('Target',row,col)

def drawNode(node):
    x = (node.col*boxWidth)+(boxWidth/2)
    y = (node.row*boxHeight)+(boxHeight/2)
    center = Point(x,y)
    radius = min(boxWidth,boxHeight)/3
    dot = Circle(center,radius)
    if node == target:
        dot.setFill('#00ff7d')
    else:
        dot.setFill('#ff004b')
    dot.setWidth(0)
    dots.append(dot)
    dots[-1].draw(win)

def drawPathNode(node,number):
    x = (node.col*boxWidth)+(boxWidth/2)
    y = (node.row*boxHeight)+(boxHeight/2)
    center = Point(x,y)
    radius = min(boxWidth,boxHeight)/4
    dot = Circle(center,radius)
    if node == target:
        dot.setFill('#00ff7d')
    else:
        dot.setFill('#007dff')
    dot.draw(win)
    dot.setWidth(0)
    label = Text(center,str(number))
    label.setFill('#ffffff')
    label.setSize(min(boxWidth,boxHeight)/6)
    label.draw(win)

pathfinder = Pathfinder(map,root,target)
pathfinder.search()
checked = pathfinder.checked
path = pathfinder.retrace()

drawGrid()

for node in checked:
    drawNode(node)
sleep(0.5)
for i in range(len(path)):
    drawPathNode(path[i],i+1)
sleep(0.5)
for dot in dots:
    dot.undraw()

win.getMouse()
