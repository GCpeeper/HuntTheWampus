extends Node2D

#list of collumns of rooms
var roomList = []

func _ready() -> void:
	pass


func connectRooms():
	#add rooms to array
	for i in range(6):
		#create a collumn
		roomList.append([])
		#fill in collumn
		for j in range(5):
			var room = load("res://Scenes/room.tscn")
			var roomScene = room.instantiate()
			roomList[i].append(roomScene)
	
	#connect rooms vertically, and randomly right to left
	for i in range(6):
		for j in range(5):
			if (roomList[i][j].getAdjacents()==null):
				if (Global.rng.randi_range(0,1)==1): #randomly decide if the room gets an extra connection
					roomList[i][j].setAdjacents([
						[roomList[i][(j+1)%5],roomList[i][j].enterance.SOUTH],
						[roomList[i][(j-1)%5],roomList[i][j].enterance.NORTH],
						#[roomList[(i+1)%6][j-(i%2)],null],
						#[roomList[(i+1)%6][j+1-(i%2)],null],
					])
				elif (Global.rng.randi_range(0,1)==1): #randomly decide if up or down
					roomList[i][j].setAdjacents([
						[roomList[i][(j+1)%5],roomList[i][j].enterance.SOUTH],
						[roomList[i][(j-1)%5],roomList[i][j].enterance.NORTH],
						
						[roomList[(i+1)%6][j-(i%2)],roomList[i][j].enterance.EAST],

					])
					roomList[(i+1)%6][j-(i%2)].appendAdjacents([roomList[i][j], roomList[(i+1)%6][j-(i%2)].enterence.WEST])
				else:
					roomList[i][j].setAdjacents([
						[roomList[i][(j+1)%5],roomList[i][j].enterance.SOUTH],
						[roomList[i][(j-1)%5],roomList[i][j].enterance.NORTH],
						
						[roomList[(i+1)%6][j+1-(i%2)],roomList[i][j].enterance.EAST],
					])
					roomList[(i+1)%6][j+1-(i%2)].appendAdjacents([roomList[i][j], roomList[(i+1)%6][j+1-(i%2)].enterence.WEST])
	#TODO: the behavior here is wierd with wrapping
	
	
	#PLACEHOLDER randomly delete connections



		
		
