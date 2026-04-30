extends Node2D
class_name Room

enum entrance {
	NORTH,
	SOUTH,
	EAST,
	WEST
}

# list of rooms each room is [room scene, connection] so that north means that traveling from this 
#to that scene would have you enter via the north
var adjacents = []





func getAdjacents():
	return adjacents

#set ajacents to a new list
func setAdjacents(adjacentList):
	adjacents=adjacentList

#add an adjacent node
func appendAdjacents(room, enter):
	adjacents.append([room, enter])

#remove an adjacent node
func rmAdjacents(room):
	for i in range(adjacents.size):
		if (adjacents[i][0]==room):
			adjacents.remove_at(i)
			
func fillRooms():
	pass

func enterRoom(direction):
	
	match direction:
		entrance.NORTH:
			$Character.velocity.y=-800
			$Character.position = Vector2(670,830)
		entrance.SOUTH:
			$Character.position = Vector2(670, 70) #NEEDS TO BE LOWER THAN ROOM EXIT HIEGHT
		entrance.EAST:
			$Character.position = Vector2(60, 530)
		entrance.WEST:
			$Character.position = Vector2(1380, 530)


func _ready():
	
	$Character.exit_room.connect(_on_exit_room)

func _on_exit_room(d):
	match d:
		1:
			for adjacent in adjacents:
				if adjacent[1] == entrance.WEST:
					adjacent.getRealRoom()
					adjacent.enterRoom(entrance.WEST)
					add_child(adjacent)
		2:
			for adjacent in adjacents:
				if adjacent[1] == entrance.EAST:
					adjacent.getRealRoom()
					adjacent.enterRoom(entrance.EAST)
					add_child(adjacent)
		3:
			for adjacent in adjacents:
				if adjacent[1] == entrance.NORTH:
					adjacent.getRealRoom()
					adjacent.enterRoom(entrance.NORTH)
					add_child(adjacent)
		4:
			for adjacent in adjacents:
				if adjacent[1] == entrance.SOUTH:
					adjacent.getRealRoom()
					adjacent.enterRoom(entrance.SOUTH)
					add_child(adjacent)
	self.queue_free()

func getRealRoom():
	var realRoom
	match adjacents.size():
		1:
			match adjacents[0][1]:
				entrance.NORTH:
					realRoom = preload("res://Scenes/deadend/DeadC.tscn")
				entrance.SOUTH:
					realRoom = preload("res://Scenes/deadend/DeadD.tscn")
				entrance.EAST:
					realRoom = preload("res://Scenes/deadend/DeadA.tscn")
				entrance.WEST:
					realRoom = preload("res://Scenes/deadend/DeadB.tscn")
		2:
			var directions = [adjacents[0][1],adjacents[1][1]]
			match directions:
				[entrance.EAST,entrance.NORTH], [entrance.NORTH,entrance.EAST]:
					realRoom = preload("res://Scenes/2door/CornerB.tscn")
				[entrance.EAST,entrance.WEST], [entrance.WEST,entrance.EAST]:
					realRoom = preload("res://Scenes/2door/HallwayA.tscn")
				[entrance.EAST,entrance.SOUTH], [entrance.SOUTH,entrance.EAST]:
					realRoom = preload("res://Scenes/2door/CornerD.tscn")
				[entrance.WEST,entrance.NORTH], [entrance.NORTH,entrance.WEST]:
					realRoom = preload("res://Scenes/2door/CornerA.tscn")
				[entrance.WEST,entrance.SOUTH], [entrance.SOUTH,entrance.WEST]:
					realRoom = preload("res://Scenes/2door/CornerC.tscn")
				[entrance.SOUTH,entrance.NORTH], [entrance.NORTH,entrance.SOUTH]:
					realRoom = preload("res://Scenes/2door/HallwayB.tscn")
		3:
			var directions = [adjacents[0][1],adjacents[1][1], adjacents[2][1]]
			if entrance.NORTH not in directions:
				realRoom = preload("res://Scenes/3door/SideC.tscn")
			elif entrance.SOUTH not in directions:
				realRoom = preload("res://Scenes/3door/SideD.tscn")
			elif entrance.EAST not in directions:
				realRoom = preload("res://Scenes/3door/SideA.tscn")
			else:
				realRoom = preload("res://Scenes/3door/SideB.tscn")
	if realRoom == null:
		print("Failed to load room!")
		print(adjacents.size())
	
	realRoom = realRoom.instantiate()
	realRoom.setAdjacents(adjacents)
	return realRoom
