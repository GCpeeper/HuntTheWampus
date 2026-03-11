extends Node2D

#list of collumns of rooms
var roomList = []


func fillrooms():
	#add rooms to array
	for i in range(6):
		#create a collumn
		roomList.append([])
		#fill in collumn
		for j in range(5):
			var room = load("res://Scenes/room.tscn")
			roomList[i].append(room)
	
	#fully connect rooms
	for i in range(6):
		for j in range(5):
			roomList[i][j].setAdjacents([])
	
	
	#PLACEHOLDER randomly delete connections
	
	
		
		
