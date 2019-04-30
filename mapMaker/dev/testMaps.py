from random import randint
from Maps import *
from Node import *
from Pathfinder import *
import copy

def changeTestTgt(x, y, tgt_x, tgt_y):
    if (x == tgt_x and y == tgt_y):
        return False
    if (x == tgt_x + 1 and y == tgt_y):
        return False
    if (x == tgt_x - 1 and y == tgt_y):
        return False
    if (x == tgt_x and y == tgt_y +1 ):
        return False
    if (x == tgt_x and y == tgt_y - 1):
        return False
    return True
    
def makeNewMap(Map, root, target):
    cleanMapLocal = copy.deepcopy(Map)
    for x in range(len(Map)):
        for y in range(len(Map[0])):
            if (changeTestTgt(x, y, root.row, root.col) and changeTestTgt(x,y,target.row,target.col)):
                randomInt = randint(0, 2)
                if(randomInt == 2):
                    Map[x][y] = 1
        print (Map[x])
    pathfinder = Pathfinder(Map,root,target)

    if not (pathfinder.search()):
        print("oops lets make a new map!")
        Map = makeNewMap(cleanMapLocal, root, target)
    return Map

#def newTarget

root = Node(0,0)
target = Node(9,9)

newMap = makeNewMap(copy.deepcopy(cleanMap),root,target)
print (newMap)

