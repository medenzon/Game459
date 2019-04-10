
class Node:
    
    def __init__(self,row,col,parent=None):
        self.row = row
        self.col = col
        self.parent = parent

    def __eq__(self,node):
        return self.row == node.row and self.col == node.col
    
    def __str__(self):
        return '{0},{1}'.format(str(self.row),str(self.col))