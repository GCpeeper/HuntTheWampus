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
			if (roomList[i][j].getAdjacents()==0):
				if (Global.rng.randi_range(0,1)==1):
					roomList[i][j].setAdjacents([
						[roomList[i][(j+1)%5],roomList[i][j].enterance.SOUTH],
						[roomList[i][(j-1)%5],roomList[i][j].enterance.NORTH],
						
						
						#[roomList[(i+1)%6][j-(i%2)],null],
						#[roomList[(i+1)%6][j+1-(i%2)],null],

					])
	
	
	
	#PLACEHOLDER randomly delete connections
	
	
		
		
