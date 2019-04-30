from Node import *

class Pathfinder:

    def __init__(self,map,root,target):
        self.map = map
        self.mapRows = len(map)
        self.mapCols = len(map[0])
        self.root = root
        self.target = target
        self.current = self.root
        self.onstack = []
        self.offstack = []
        self.found = False

        self.checked = []
    
    def search(self):
        while not self.found:
            self.checked.append(self.current)
            if self.current == self.target:
                self.found = True
            else:
                self.checkUp(self.current)
                self.checkDown(self.current)
                self.checkLeft(self.current)
                self.checkRight(self.current)
                self.offstack.append(self.current)
                if len(self.onstack) == 0: 
                    return False
                self.current = self.onstack.pop()
        return self.current

    def retrace(self):
        nodes = []
        temp = self.current
        while temp.parent != None:
            nodes.insert(0,temp)
            temp = temp.parent
        return nodes

    def checkUp(self,node):
        newRow = node.row - 1
        inBounds = newRow >= 0 and newRow < self.mapRows
        traversable = inBounds and self.map[newRow][node.col] == 0
        newNode = Node(newRow,node.col,parent=node)
        if traversable and newNode not in self.offstack:
            self.onstack.insert(0,newNode)

    def checkDown(self,node):
        newRow = node.row + 1
        inBounds = newRow >= 0 and newRow < self.mapRows
        traversable = inBounds and self.map[newRow][node.col] == 0
        newNode = Node(newRow,node.col,parent=node)
        if traversable and newNode not in self.offstack:
            self.onstack.insert(0,newNode)

    def checkLeft(self,node):
        newCol = node.col - 1
        inBounds = newCol >= 0 and newCol < self.mapCols
        traversable = inBounds and self.map[node.row][newCol] == 0
        newNode = Node(node.row,newCol,parent=node)
        if traversable and newNode not in self.offstack:
            self.onstack.insert(0,newNode)

    def checkRight(self,node):
        newCol = node.col + 1
        inBounds = newCol >= 0 and newCol < self.mapCols
        traversable = inBounds and self.map[node.row][newCol] == 0
        newNode = Node(node.row,newCol,parent=node)
        if traversable and newNode not in self.offstack:
            self.onstack.insert(0,newNode)