extends Node2D

enum entrance {
	NORTH,
	SOUTH,
	EAST,
	WEST
}

# list of rooms each room is [room scene, connection] so that north means that traveling from this 
#to that scene would have you enter via the north
var adjacents = []

#set ajacents to a new list
func setAdjacents(adjacentList):
	adjacents=adjacentList

#add an adjacent node
func appendAdjacents(room, enterance):
	adjacents.append([room, enterance])

#remove an adjacent node
func rmAdjacents(room):
	for i in range(adjacents.size):
		if (adjacents[i][0]==room):
			adjacents.remove_at(i)
