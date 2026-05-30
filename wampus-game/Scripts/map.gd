extends Node2D

@onready var CornerA = preload("res://Scenes/2door/CornerA.tscn")
@onready var CornerB = preload("res://Scenes/2door/CornerB.tscn")
@onready var CornerC = preload("res://Scenes/2door/CornerC.tscn")
@onready var CornerD = preload("res://Scenes/2door/CornerD.tscn")
@onready var HallwayA = preload("res://Scenes/2door/HallwayA.tscn")
@onready var HallwayB = preload("res://Scenes/2door/HallwayB.tscn")

@onready var SideA = preload("res://Scenes/3door/SideA.tscn")
@onready var SideB = preload("res://Scenes/3door/SideB.tscn")
@onready var SideC = preload("res://Scenes/3door/SideC.tscn")
@onready var SideD = preload("res://Scenes/3door/SideD.tscn")

@onready var DeadEndA = preload("res://Scenes/deadend/DeadA.tscn")
@onready var DeadEndB = preload("res://Scenes/deadend/DeadB.tscn")
@onready var DeadEndC = preload("res://Scenes/deadend/DeadC.tscn")
@onready var DeadEndD = preload("res://Scenes/deadend/DeadD.tscn")

@onready var BatCutscene = preload("res://Scenes/bat cutscene.tscn")
@onready var Pit = preload("res://Scenes/pit.tscn")
@onready var Wumpus = preload("res://Scenes/wampus cutscenes.tscn")

#list of collumns of rooms
var roomList = []
var curRoom = []
var curRoomChild
var wumpusSelected = false
var hazardsLeft = 4
var swordsLeft = 10
var roomsPresent = 0
var doneWithHazard = false
var wumpusHealth = 3
var transitioning = false
var travels = 0
var wumpusLocation

func layout(type):
	match type:
		1: # Layout 1
			roomList = [
			[craftRoom(null,null,null,null,DeadEndD),craftRoom(null,null,null,null,DeadEndB),craftRoom(null,null,null,null,SideC),craftRoom(null,null,null,null,SideC),craftRoom(null,null,null,null,SideC),craftRoom(null,null,null,null,DeadEndA)],
			[craftRoom(null,null,null,null,SideB),craftRoom(null,null,null,null,HallwayA),craftRoom(null,null,null,null,CornerA),craftRoom(null,null,null,null,CornerB),craftRoom(null,null,null,null,SideA),craftRoom(null,null,null,null,DeadEndD)],
			[craftRoom(null,null,null,null,SideB),craftRoom(null,null,null,null,SideC),craftRoom(null,null,null,null,CornerC),craftRoom(null,null,null,null,CornerD),craftRoom(null,null,null,null,SideD),craftRoom(null,null,null,null,CornerA)],
			[craftRoom(null,null,null,null,HallwayB),craftRoom(null,null,null,null,SideB),craftRoom(null,null,null,null,SideA),craftRoom(null,null,null,null,SideB),craftRoom(null,null,null,null,CornerC),craftRoom(null,null,null,null,DeadEndD)],
			[craftRoom(null,null,null,null,DeadEndC),craftRoom(null,null,null,null,CornerB),craftRoom(null,null,null,null,CornerA),craftRoom(null,null,null,null,DeadEndC),craftRoom(null,null,null,null,CornerB),craftRoom(null,null,null,null,CornerA)],
			]
			# Row 1
			roomList[0][0][2] = roomList[1][0] # Dead facing down
			roomList[0][1][1] = roomList[0][2] # Dead facing right
			roomList[0][2][1] = roomList[0][3] # Side facing down
			roomList[0][2][2] = roomList[1][2]
			roomList[0][2][3] = roomList[0][1] 
			roomList[0][3][1] = roomList[0][4] # Side facing bottom
			roomList[0][3][2] = roomList[1][3]
			roomList[0][3][3] = roomList[0][2]
			roomList[0][4][1] = roomList[0][5] # Side facing bottom
			roomList[0][4][2] = roomList[1][4]
			roomList[0][4][3] = roomList[0][3]
			roomList[0][5][3] = roomList[0][4] # Dead facing left
			# Row 2
			roomList[1][0][0] = roomList[0][0] # Side facing right
			roomList[1][0][1] = roomList[1][1]
			roomList[1][0][2] = roomList[2][0]
			roomList[1][1][1] = roomList[1][2] # Hallway horizontal
			roomList[1][1][3] = roomList[1][0]
			roomList[1][2][0] = roomList[0][2] # Corner up left
			roomList[1][2][3] = roomList[1][1]
			roomList[1][3][0] = roomList[0][3] # Corner up right
			roomList[1][3][1] = roomList[1][4]
			roomList[1][4][0] = roomList[0][4] # Side facing left
			roomList[1][4][2] = roomList[2][4]
			roomList[1][4][3] = roomList[1][3]
			roomList[1][5][2] = roomList[2][5] # dead facing down
			# Row 3
			roomList[2][0][0] = roomList[1][0] # Side facing right
			roomList[2][0][1] = roomList[2][1]
			roomList[2][0][2] = roomList[3][0]
			roomList[2][1][1] = roomList[2][2] # Side facing down
			roomList[2][1][2] = roomList[3][1]
			roomList[2][1][3] = roomList[2][0]
			roomList[2][2][2] = roomList[3][2] # Corner down left
			roomList[2][2][3] = roomList[2][1]
			roomList[2][3][1] = roomList[2][4] # Corner down right
			roomList[2][3][2] = roomList[3][3]
			roomList[2][4][0] = roomList[1][4] # Side facing up
			roomList[2][4][1] = roomList[2][5]
			roomList[2][4][3] = roomList[2][3]
			roomList[2][5][0] = roomList[1][5] # Corner up left
			roomList[2][5][3] = roomList[2][4]
			# Row 4
			roomList[3][0][0] = roomList[2][0] # Hallway vertical
			roomList[3][0][2] = roomList[4][0]
			roomList[3][1][0] = roomList[2][1] # Side facing right
			roomList[3][1][1] = roomList[3][2]
			roomList[3][1][2] = roomList[4][1]
			roomList[3][2][0] = roomList[2][2] # Side facing left
			roomList[3][2][2] = roomList[4][2]
			roomList[3][2][3] = roomList[3][1]
			roomList[3][3][0] = roomList[2][3] # Side facing right
			roomList[3][3][1] = roomList[3][4]
			roomList[3][3][2] = roomList[4][3]
			roomList[3][4][2] = roomList[4][4] # Corner down left
			roomList[3][4][3] = roomList[3][3]
			roomList[3][5][2] = roomList[4][5] # Dead facing down
			# Row 5
			roomList[4][0][0] = roomList[3][0] # Dead facing up
			roomList[4][1][0] = roomList[3][1] # Corner up right
			roomList[4][1][1] = roomList[4][2]
			roomList[4][2][0] = roomList[3][2] # Corner up left
			roomList[4][2][3] = roomList[4][1]
			roomList[4][3][0] = roomList[3][3] # Dead facing up
			roomList[4][4][0] = roomList[3][4] # Corner facing up right
			roomList[4][4][1] = roomList[4][5]
			roomList[4][5][0] = roomList[3][5] # Corner facing up left
			roomList[4][5][3] = roomList[4][4]
		2: # Layout 2
			roomList = [
			[craftRoom(null,null,null,null,DeadEndD),craftRoom(null,null,null,null,CornerD),craftRoom(null,null,null,null,SideC),craftRoom(null,null,null,null,SideC),craftRoom(null,null,null,null,SideC),craftRoom(null,null,null,null,CornerC)],
			[craftRoom(null,null,null,null,SideB),craftRoom(null,null,null,null,SideD),craftRoom(null,null,null,null,CornerA),craftRoom(null,null,null,null,CornerB),craftRoom(null,null,null,null,SideA),craftRoom(null,null,null,null,HallwayB)],
			[craftRoom(null,null,null,null,SideB),craftRoom(null,null,null,null,SideC),craftRoom(null,null,null,null,CornerC),craftRoom(null,null,null,null,CornerD),craftRoom(null,null,null,null,SideD),craftRoom(null,null,null,null,CornerA)],
			[craftRoom(null,null,null,null,HallwayB),craftRoom(null,null,null,null,SideB),craftRoom(null,null,null,null,SideA),craftRoom(null,null,null,null,SideB),craftRoom(null,null,null,null,CornerC),craftRoom(null,null,null,null,DeadEndD)],
			[craftRoom(null,null,null,null,CornerB),craftRoom(null,null,null,null,SideD),craftRoom(null,null,null,null,CornerA),craftRoom(null,null,null,null,DeadEndC),craftRoom(null,null,null,null,CornerB),craftRoom(null,null,null,null,CornerA)],
			]
			# Row 1
			roomList[0][0][2] = roomList[1][0] # Dead facing down
			roomList[0][1][1] = roomList[0][2] # Corner down right
			roomList[0][1][2] = roomList[1][1]
			roomList[0][2][1] = roomList[0][3] # Side facing down
			roomList[0][2][2] = roomList[1][2]
			roomList[0][2][3] = roomList[1][1] 
			roomList[0][3][1] = roomList[0][4] # Side facing bottom
			roomList[0][3][2] = roomList[1][3]
			roomList[0][3][3] = roomList[0][2]
			roomList[0][4][1] = roomList[0][5] # Side facing bottom
			roomList[0][4][2] = roomList[1][4]
			roomList[0][4][3] = roomList[0][3]
			roomList[0][5][3] = roomList[0][4] # Corner down left
			roomList[0][5][2] = roomList[1][5]
			# Row 2
			roomList[1][0][0] = roomList[0][0] # Side facing right
			roomList[1][0][1] = roomList[1][1]
			roomList[1][0][2] = roomList[2][0]
			roomList[1][1][1] = roomList[1][2] # Side facing up
			roomList[1][1][3] = roomList[1][0]
			roomList[1][1][0] = roomList[0][1]
			roomList[1][2][0] = roomList[0][2] # Corner up left
			roomList[1][2][3] = roomList[1][1]
			roomList[1][3][0] = roomList[0][3] # Corner up right
			roomList[1][3][1] = roomList[1][4]
			roomList[1][4][0] = roomList[0][4] # Side facing left
			roomList[1][4][2] = roomList[2][4]
			roomList[1][4][3] = roomList[1][3]
			roomList[1][5][2] = roomList[2][5] # Hallway vertical
			roomList[1][5][0] = roomList[0][5]
			# Row 3
			roomList[2][0][0] = roomList[1][0] # Side facing right
			roomList[2][0][1] = roomList[2][1]
			roomList[2][0][2] = roomList[3][0]
			roomList[2][1][1] = roomList[2][2] # Side facing down
			roomList[2][1][2] = roomList[3][1]
			roomList[2][1][3] = roomList[2][0]
			roomList[2][2][2] = roomList[3][2] # Corner down left
			roomList[2][2][3] = roomList[2][1]
			roomList[2][3][1] = roomList[2][4] # Corner down right
			roomList[2][3][2] = roomList[3][3]
			roomList[2][4][0] = roomList[1][4] # Side facing up
			roomList[2][4][1] = roomList[2][5]
			roomList[2][4][3] = roomList[2][3]
			roomList[2][5][0] = roomList[1][5] # Corner up left
			roomList[2][5][3] = roomList[2][4]
			# Row 4
			roomList[3][0][0] = roomList[2][0] # Hallway vertical
			roomList[3][0][2] = roomList[4][0]
			roomList[3][1][0] = roomList[2][1] # Side facing right
			roomList[3][1][1] = roomList[3][2]
			roomList[3][1][2] = roomList[4][1]
			roomList[3][2][0] = roomList[2][2] # Side facing left
			roomList[3][2][2] = roomList[4][2]
			roomList[3][2][3] = roomList[3][1]
			roomList[3][3][0] = roomList[2][3] # Side facing right
			roomList[3][3][1] = roomList[3][4]
			roomList[3][3][2] = roomList[4][3]
			roomList[3][4][2] = roomList[4][4] # Corner down left
			roomList[3][4][3] = roomList[3][3]
			roomList[3][5][2] = roomList[4][5] # Dead facing down
			# Row 5
			roomList[4][0][0] = roomList[3][0] # Corner up right
			roomList[4][0][1] = roomList[4][1]
			roomList[4][1][0] = roomList[3][1] # Side facing up
			roomList[4][1][1] = roomList[4][2]
			roomList[4][1][3] = roomList[4][0]
			roomList[4][2][0] = roomList[3][2] # Corner up left
			roomList[4][2][3] = roomList[4][1]
			roomList[4][3][0] = roomList[3][3] # Dead facing up
			roomList[4][4][0] = roomList[3][4] # Corner facing up right
			roomList[4][4][1] = roomList[4][5]
			roomList[4][5][0] = roomList[3][5] # Corner facing up left
			roomList[4][5][3] = roomList[4][4]
		3: # Layout 3
			roomList = [
			[craftRoom(null,null,null,null,DeadEndD),craftRoom(null,null,null,null,CornerD),craftRoom(null,null,null,null,SideC),craftRoom(null,null,null,null,SideC),craftRoom(null,null,null,null,SideC),craftRoom(null,null,null,null,CornerC)],
			[craftRoom(null,null,null,null,SideB),craftRoom(null,null,null,null,SideD),craftRoom(null,null,null,null,CornerA),craftRoom(null,null,null,null,CornerB),craftRoom(null,null,null,null,SideC),craftRoom(null,null,null,null,SideA)],
			[craftRoom(null,null,null,null,SideB),craftRoom(null,null,null,null,HallwayA),craftRoom(null,null,null,null,CornerC),craftRoom(null,null,null,null,CornerD),craftRoom(null,null,null,null,SideD),craftRoom(null,null,null,null,SideA)],
			[craftRoom(null,null,null,null,SideB),craftRoom(null,null,null,null,SideC),craftRoom(null,null,null,null,SideA),craftRoom(null,null,null,null,SideB),craftRoom(null,null,null,null,SideC),craftRoom(null,null,null,null,SideA)],
			[craftRoom(null,null,null,null,CornerB),craftRoom(null,null,null,null,SideD),craftRoom(null,null,null,null,CornerA),craftRoom(null,null,null,null,DeadEndC),craftRoom(null,null,null,null,CornerB),craftRoom(null,null,null,null,CornerA)],
			]
			# Row 1
			roomList[0][0][2] = roomList[1][0] # Dead facing down
			roomList[0][1][1] = roomList[0][2] # Corner down right
			roomList[0][1][2] = roomList[1][1]
			roomList[0][2][1] = roomList[0][3] # Side facing down
			roomList[0][2][2] = roomList[1][2]
			roomList[0][2][3] = roomList[1][1] 
			roomList[0][3][1] = roomList[0][4] # Side facing bottom
			roomList[0][3][2] = roomList[1][3]
			roomList[0][3][3] = roomList[0][2]
			roomList[0][4][1] = roomList[0][5] # Hallway horizontal
			roomList[0][4][3] = roomList[0][3]
			roomList[0][5][3] = roomList[0][4] # Corner down left
			roomList[0][5][2] = roomList[1][5]
			# Row 2
			roomList[1][0][0] = roomList[0][0] # Side facing right
			roomList[1][0][1] = roomList[1][1]
			roomList[1][0][2] = roomList[2][0]
			roomList[1][1][1] = roomList[1][2] # Side facing up
			roomList[1][1][3] = roomList[1][0]
			roomList[1][1][0] = roomList[0][1]
			roomList[1][2][0] = roomList[0][2] # Corner up left
			roomList[1][2][3] = roomList[1][1]
			roomList[1][3][0] = roomList[0][3] # Corner up right
			roomList[1][3][1] = roomList[1][4]
			roomList[1][4][1] = roomList[1][5] # Side facing down
			roomList[1][4][2] = roomList[2][4]
			roomList[1][4][3] = roomList[1][3]
			roomList[1][5][2] = roomList[2][5] # Side facing left
			roomList[1][5][0] = roomList[0][5]
			roomList[1][5][3] = roomList[1][4]
			# Row 3
			roomList[2][0][0] = roomList[1][0] # Side facing right
			roomList[2][0][1] = roomList[2][1]
			roomList[2][0][2] = roomList[3][0]
			roomList[2][1][1] = roomList[2][2] # Hallway horizontal
			roomList[2][1][3] = roomList[2][0]
			roomList[2][2][2] = roomList[3][2] # Corner down left
			roomList[2][2][3] = roomList[2][1]
			roomList[2][3][1] = roomList[2][4] # Corner down right
			roomList[2][3][2] = roomList[3][3]
			roomList[2][4][0] = roomList[1][4] # Side facing up
			roomList[2][4][1] = roomList[2][5]
			roomList[2][4][3] = roomList[2][3]
			roomList[2][5][0] = roomList[1][5] # Side facing left
			roomList[2][5][2] = roomList[3][5]
			roomList[2][5][3] = roomList[2][4]
			# Row 4
			roomList[3][0][0] = roomList[2][0] # Side facing right
			roomList[3][0][1] = roomList[3][1]
			roomList[3][0][2] = roomList[4][0]
			roomList[3][1][3] = roomList[3][0] # Side facing down
			roomList[3][1][1] = roomList[3][2]
			roomList[3][1][2] = roomList[4][1]
			roomList[3][2][0] = roomList[2][2] # Side facing left
			roomList[3][2][2] = roomList[4][2]
			roomList[3][2][3] = roomList[3][1]
			roomList[3][3][0] = roomList[2][3] # Side facing right
			roomList[3][3][1] = roomList[3][4]
			roomList[3][3][2] = roomList[4][3]
			roomList[3][4][2] = roomList[4][4] # Side facing down
			roomList[3][4][1] = roomList[3][5]
			roomList[3][4][3] = roomList[3][3]
			roomList[3][5][2] = roomList[4][5] # Side facing left
			roomList[3][5][0] = roomList[2][5]
			roomList[3][5][3] = roomList[3][4]
			# Row 5
			roomList[4][0][0] = roomList[3][0] # Corner up right
			roomList[4][0][1] = roomList[4][1]
			roomList[4][1][0] = roomList[3][1] # Side facing up
			roomList[4][1][1] = roomList[4][2]
			roomList[4][1][3] = roomList[4][0]
			roomList[4][2][0] = roomList[3][2] # Corner up left
			roomList[4][2][3] = roomList[4][1]
			roomList[4][3][0] = roomList[3][3] # Dead facing up
			roomList[4][4][0] = roomList[3][4] # Corner facing up right
			roomList[4][4][1] = roomList[4][5]
			roomList[4][5][0] = roomList[3][5] # Corner facing up left
			roomList[4][5][3] = roomList[4][4]
		4: # Layout 4
			roomList = [
			[craftRoom(null,null,null,null,CornerD),craftRoom(null,null,null,null,HallwayA),craftRoom(null,null,null,null,SideC),craftRoom(null,null,null,null,SideC),craftRoom(null,null,null,null,HallwayA),craftRoom(null,null,null,null,CornerC)],
			[craftRoom(null,null,null,null,HallwayB),craftRoom(null,null,null,null,CornerD),craftRoom(null,null,null,null,SideA),craftRoom(null,null,null,null,SideB),craftRoom(null,null,null,null,CornerC),craftRoom(null,null,null,null,HallwayB)],
			[craftRoom(null,null,null,null,SideB),craftRoom(null,null,null,null,SideA),craftRoom(null,null,null,null,DeadEndC),craftRoom(null,null,null,null,DeadEndC),craftRoom(null,null,null,null,SideB),craftRoom(null,null,null,null,SideA)],
			[craftRoom(null,null,null,null,HallwayB),craftRoom(null,null,null,null,CornerB),craftRoom(null,null,null,null,CornerC),craftRoom(null,null,null,null,CornerD),craftRoom(null,null,null,null,CornerA),craftRoom(null,null,null,null,HallwayB)],
			[craftRoom(null,null,null,null,CornerB),craftRoom(null,null,null,null,HallwayA),craftRoom(null,null,null,null,SideD),craftRoom(null,null,null,null,SideD),craftRoom(null,null,null,null,HallwayA),craftRoom(null,null,null,null,CornerA)],
			]
			# Row 1
			roomList[0][0][1] = roomList[0][1] # Corner down right
			roomList[0][0][2] = roomList[1][0]
			roomList[0][1][1] = roomList[0][2] # Hallway horizontal
			roomList[0][1][3] = roomList[0][0]
			roomList[0][2][1] = roomList[0][3] # Side facing down
			roomList[0][2][2] = roomList[1][2]
			roomList[0][2][3] = roomList[0][1]
			roomList[0][3][1] = roomList[0][4] # Side facing down
			roomList[0][3][2] = roomList[1][3]
			roomList[0][3][3] = roomList[0][2]
			roomList[0][4][1] = roomList[0][5] # Hallway horizontal
			roomList[0][4][3] = roomList[0][3]
			roomList[0][5][2] = roomList[1][5] # Corner down left
			roomList[0][5][3] = roomList[0][4]
			# Row 2
			roomList[1][0][0] = roomList[0][0] # Hallway vertical
			roomList[1][0][2] = roomList[2][0]
			roomList[1][1][1] = roomList[1][2] # Corner down right
			roomList[1][1][2] = roomList[2][1]
			roomList[1][2][0] = roomList[0][2] # Side facing left
			roomList[1][2][2] = roomList[2][2]
			roomList[1][2][3] = roomList[1][1]
			roomList[1][3][0] = roomList[0][3] # Side facing right
			roomList[1][3][1] = roomList[1][4]
			roomList[1][3][2] = roomList[2][3]
			roomList[1][4][2] = roomList[2][4] # Corner down left
			roomList[1][4][3] = roomList[1][3]
			roomList[1][5][0] = roomList[0][5] # Hallway vertical
			roomList[1][5][2] = roomList[2][5]
			# Row 3
			roomList[2][0][0] = roomList[1][0] # Side facing right
			roomList[2][0][1] = roomList[2][1]
			roomList[2][0][2] = roomList[3][0]
			roomList[2][1][0] = roomList[1][1] # Side facing left
			roomList[2][1][2] = roomList[3][1]
			roomList[2][1][3] = roomList[2][0]
			roomList[2][2][0] = roomList[1][2] # Dead facing up
			roomList[2][3][0] = roomList[1][3] # Dead facing up
			roomList[2][4][0] = roomList[1][4] # Side facing right
			roomList[2][4][1] = roomList[2][5]
			roomList[2][4][2] = roomList[3][4]
			roomList[2][5][0] = roomList[1][5] # Side facing left
			roomList[2][5][2] = roomList[3][5]
			roomList[2][5][3] = roomList[2][4]
			# Row 4
			roomList[3][0][0] = roomList[2][0] # Hallwa vertical
			roomList[3][0][2] = roomList[4][0]
			roomList[3][1][0] = roomList[2][1] # Corner up right
			roomList[3][1][1] = roomList[3][2]
			roomList[3][2][2] = roomList[4][2] # Corner down left
			roomList[3][2][3] = roomList[3][1]
			roomList[3][3][1] = roomList[3][4] # Corner down right
			roomList[3][3][2] = roomList[4][3]
			roomList[3][4][0] = roomList[2][4] # Corner up left
			roomList[3][4][3] = roomList[3][3]
			roomList[3][5][0] = roomList[2][5] # Hallway horizontal
			roomList[3][5][2] = roomList[4][5]
			# Row 5
			roomList[4][0][0] = roomList[3][0] # Corner up right
			roomList[4][0][1] = roomList[4][1]
			roomList[4][1][1] = roomList[4][2] # Hallway horizontal
			roomList[4][1][3] = roomList[4][0]
			roomList[4][2][0] = roomList[3][2] # Side facing up
			roomList[4][2][1] = roomList[4][3]
			roomList[4][2][3] = roomList[4][1]
			roomList[4][3][0] = roomList[3][3] # Side facing up
			roomList[4][3][1] = roomList[4][4]
			roomList[4][3][3] = roomList[4][2]
			roomList[4][4][1] = roomList[4][5] # Hallway horizontal
			roomList[4][4][3] = roomList[4][3]
			roomList[4][5][0] = roomList[3][5] # Corner up left
			roomList[4][5][3] = roomList[4][4]
		5: # Layout 5
			roomList = [
			[craftRoom(null,null,null,null,DeadEndD),craftRoom(null,null,null,null,DeadEndD),craftRoom(null,null,null,null,CornerD),craftRoom(null,null,null,null,CornerC),craftRoom(null,null,null,null,DeadEndD),craftRoom(null,null,null,null,DeadEndD)],
			[craftRoom(null,null,null,null,CornerB),craftRoom(null,null,null,null,SideD),craftRoom(null,null,null,null,SideA),craftRoom(null,null,null,null,SideB),craftRoom(null,null,null,null,SideD),craftRoom(null,null,null,null,CornerA)],
			[craftRoom(null,null,null,null,DeadEndB),craftRoom(null,null,null,null,SideC),craftRoom(null,null,null,null,CornerA),craftRoom(null,null,null,null,CornerB),craftRoom(null,null,null,null,SideC),craftRoom(null,null,null,null,DeadEndA)],
			[craftRoom(null,null,null,null,CornerD),craftRoom(null,null,null,null,SideA),craftRoom(null,null,null,null,CornerD),craftRoom(null,null,null,null,CornerC),craftRoom(null,null,null,null,SideB),craftRoom(null,null,null,null,CornerC)],
			[craftRoom(null,null,null,null,DeadEndC),craftRoom(null,null,null,null,CornerB),craftRoom(null,null,null,null,CornerA),craftRoom(null,null,null,null,CornerB),craftRoom(null,null,null,null,CornerA),craftRoom(null,null,null,null,DeadEndC)],
			]
			# Row 1
			roomList[0][0][2] = roomList[1][0] # Dead facing down
			roomList[0][1][2] = roomList[1][1] # Dead facing down
			roomList[0][2][1] = roomList[0][3] # Corner down right
			roomList[0][2][2] = roomList[1][2]
			roomList[0][3][2] = roomList[1][3] # Corner down left
			roomList[0][3][3] = roomList[0][2]
			roomList[0][4][2] = roomList[1][4] # Dead facing down
			roomList[0][5][2] = roomList[1][5]
			# Row 2
			roomList[1][0][0] = roomList[0][0] # Corner up right
			roomList[1][0][1] = roomList[1][1]
			roomList[1][1][0] = roomList[0][1] # Side facing up
			roomList[1][1][1] = roomList[1][2]
			roomList[1][1][3] = roomList[1][0]
			roomList[1][2][0] = roomList[0][2] # Side facing left
			roomList[1][2][2] = roomList[2][2]
			roomList[1][2][3] = roomList[1][1]
			roomList[1][3][0] = roomList[0][3] # Side facing right
			roomList[1][3][1] = roomList[1][4]
			roomList[1][3][2] = roomList[2][3]
			roomList[1][4][0] = roomList[0][4] # Side facing up
			roomList[1][4][1] = roomList[1][5]
			roomList[1][4][3] = roomList[1][3]
			roomList[1][5][0] = roomList[0][5] # Corner up left
			roomList[1][5][3] = roomList[1][4]
			# Row 3
			roomList[2][0][1] = roomList[2][1] # Dead facing right
			roomList[2][1][1] = roomList[2][2] # Side facing down
			roomList[2][1][2] = roomList[3][1]
			roomList[2][1][3] = roomList[2][0]
			roomList[2][2][0] = roomList[1][2] # Corner up left
			roomList[2][2][3] = roomList[2][1]
			roomList[2][3][0] = roomList[1][3] # Corner up right
			roomList[2][3][1] = roomList[2][4]
			roomList[2][4][1] = roomList[2][5] # Side facing down
			roomList[2][4][2] = roomList[3][4]
			roomList[2][4][3] = roomList[2][3]
			roomList[2][5][3] = roomList[2][4] # Dead facing left
			# Row 4
			roomList[3][0][1] = roomList[3][1] # Corner down right
			roomList[3][0][2] = roomList[4][0]
			roomList[3][1][0] = roomList[2][1] # Side facing left
			roomList[3][1][2] = roomList[4][1]
			roomList[3][1][3] = roomList[3][0]
			roomList[3][2][1] = roomList[3][3] # Corner down right
			roomList[3][2][2] = roomList[4][2]
			roomList[3][3][2] = roomList[4][3] # Corner down left
			roomList[3][3][3] = roomList[3][2]
			roomList[3][4][0] = roomList[2][4] # Side facing right
			roomList[3][4][1] = roomList[3][5]
			roomList[3][4][2] = roomList[4][4]
			roomList[3][5][2] = roomList[4][5] # Corner down left
			roomList[3][5][3] = roomList[3][4]
			# Row 5
			roomList[4][0][0] = roomList[3][0] # Dead facing up
			roomList[4][1][0] = roomList[3][1] # Corner up right
			roomList[4][1][1] = roomList[4][2]
			roomList[4][2][0] = roomList[3][2] # Corner up left
			roomList[4][2][3] = roomList[4][1]
			roomList[4][3][0] = roomList[3][3] # Corner up right
			roomList[4][3][1] = roomList[4][4]
			roomList[4][4][0] = roomList[3][4] # Corner up left
			roomList[4][4][3] = roomList[4][3]
			roomList[4][5][0] = roomList[3][5] # Dead facing up
			
func remove_sword():
	curRoom[7] = 0
	$"CanvasLayer/Labels for Directions/Sword".text = "You Have a Sword!"

func craftRoom(adjN,adjE,adjS,adjW,tileset):
	# Setting up variables for the room
	var wumpus = false
	var hazard = -1
	var sword = 0
	roomsPresent+=1
	if roomsPresent > 1: # Will never have wumpus or hazard in the first room, obviously
		if wumpusSelected == false and randi_range(1,30) > 27:
			wumpus = true
			wumpusSelected = true
			wumpusLocation = roomsPresent-1
			#print("wampus is in a " + str(roomsPresent-1))
		if randi_range(0,11) > 8 and hazardsLeft > 0:
			hazardsLeft -= 1
			hazard = randi_range(0,1) # 0 means bats, 1 means pit
			#print("hazard in " + str(roomsPresent-1))
		if swordsLeft > 0 and randi_range(0,3) > 1: # Setting up swords, should be at most 10 in the cave
			swordsLeft -= 1
			sword = 1
			#print("theres a sword in " + str(roomsPresent-1))
	return([null,null,null,null,tileset,wumpus,hazard,sword,roomsPresent-1])

func _ready() -> void:
	for r in 5:
		roomList.append([])
		for c in 6:
			roomList[r].append([])
	layout(randi_range(1,5))
	if wumpusSelected == false or wumpusLocation == null: # If it didn't manage to spawn a wumpus, it will just be set to the bottom right corner room
		roomList[4][5][5] = true
	curRoom = roomList[0][0]
	enterRoom(1)
	$Character.taking_input = true
	print(wumpusLocation)
	
	
	#connectRooms()
	#print(roomList)
	#var curRoom = roomList[0][0]
	#enterRoom(curRoom.entrance.WEST)
	#print(curRoom.entrance.WEST)
	#add_child(curRoom)
	#print(curRoom)
	#print(curRoom.position)

enum entrance {
	NORTH,
	WEST,
	SOUTH,
	EAST
}

func runHazard(hazard):
	if hazard == 0 and wumpusHealth > 0:
		var bats = BatCutscene.instantiate()
		add_child(bats)
		$Character.taking_input = false
		$Character.visible = false
		await get_tree().create_timer(5).timeout
		bats.queue_free()
		$Character.visible = true
		curRoom[6] = -1 # Getting rid of bats from this room
		roomList[randi_range(0,4)][randi_range(0,5)][6] = 0 # Moving bats to another room
		curRoom = roomList[randi_range(0,4)][randi_range(0,5)]
		curRoom[6] = -1 # Making sure it doesn't send you straight into other hazards
		#print("new room is " + str(curRoom[8]))
		enterRoom(4)
		$Character.taking_input = true
	elif hazard == 1:
		var pit = Pit.instantiate()
		pit.player = $Character
		$Character.position = Vector2(140,20)
		add_child(pit)
		$Character.taking_input = false
		curRoom = roomList[0][0]

func runWumpus():
	$Character.taking_input = false
	$Character.visible = false
	var wumpus = Wumpus.instantiate()
	add_child(wumpus)
	if $Character.has_sword:
		if wumpusHealth > 1:
			wumpus._animation_player.play("wampus hit")
		else:
			wumpus._animation_player.play("wampus defeated")
			#print("YOU WON")
			Global.makeScore($Character.coins,travels)
	else:
		wumpus._animation_player.play("wampus not hit")
		#print("YOU DIED")
	await get_tree().create_timer(6).timeout
	wumpus.queue_free()
	wumpusHealth -= 1
	if wumpusHealth == 0 or $Character.has_sword == false:
		await get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	$Character.has_sword = false
	$"CanvasLayer/Labels for Directions/Sword".text = "You Lack a Sword"
	curRoom[5] = false
	var row = randi_range(0,4)
	var col = randi_range(0,5)
	roomList[row][col][5] = true
	wumpusLocation = roomList[row][col][8]
	$Character.taking_input = true
	$Character.visible = true

func enterRoom(direction):
	if curRoom:
		if curRoom[5] == true:
			await runWumpus()
		if not doneWithHazard and curRoom[6] >= 0:
			await runHazard(curRoom[6])
			return
		var roomInstance = curRoom[4].instantiate()
		if curRoom[6] != 1 or doneWithHazard:
			add_child(roomInstance)
			$"CanvasLayer2/Parallax Control".offset()
			travels += 1
			for node in roomInstance.get_children():
				if node.name == "Sword" and curRoom[7] != 1:
					node.queue_free()
		curRoomChild = roomInstance
		$Character.velocity = Vector2(0,0)
		match direction:
			entrance.SOUTH:
				$Character.position = Vector2(670, 70)
			entrance.NORTH:
				 #NEEDS TO BE LOWER THAN ROOM EXIT HIEGHT
				$Character.position = Vector2(670,830)
				$Character.velocity.y=-300
			entrance.EAST:
				$Character.position = Vector2(1380, 530)
			entrance.WEST:
				$Character.position = Vector2(60, 530)
			4:
				$Character.position = Vector2(724,422)
		#print(curRoom[5])
		$"CanvasLayer/Labels for Directions/Current Room".text = str(curRoom[8])
		$Character.smelling = false
		$Character.hearing = false
		$Character.feeling = false
		if curRoom[0]!=null and curRoom[0][5] == true:
			$Character.smelling = true
		if curRoom[0]!=null and curRoom[0][6] == 0:
			$Character.hearing = true
		elif curRoom[0]!=null and curRoom[0][6] == 1:
			$Character.feeling = true
		if curRoom[1]!=null and curRoom[1][5] == true:
			$Character.smelling = true
		if curRoom[1]!=null and curRoom[1][6] == 0:
			$Character.hearing = true
		elif curRoom[1]!=null and curRoom[1][6] == 1:
			$Character.feeling = true
		if curRoom[2]!=null and curRoom[2][5] == true:
			$Character.smelling = true
		if curRoom[2]!=null and curRoom[2][6] == 0:
			$Character.hearing = true
		elif curRoom[2]!=null and curRoom[2][6] == 1:
			$Character.feeling = true
		if curRoom[3]!=null and curRoom[3][5] == true:
			$Character.smelling = true
		if curRoom[3]!=null and curRoom[3][6] == 0:
			$Character.hearing = true
		elif curRoom[3]!=null and curRoom[3][6] == 1:
			$Character.feeling = true
		if doneWithHazard and $"Hazard Timer".time_left == 0:
			$"Hazard Timer".start()

func _on_character_exit_room(direction: Variant) -> void:
	if transitioning:
		return
	transitioning = true
	set_process(false)
	set_physics_process(false)
	call_deferred("_do_room_transition", direction)

func _do_room_transition(direction):
	if curRoomChild:
		curRoomChild.queue_free()
		set_process(true)
		set_physics_process(true)

	var next_room = curRoom[direction]
	if next_room == null:
		return
	curRoom = next_room
	enterRoom(direction)
	transitioning = false


func _on_hazard_timer_timeout() -> void:
	doneWithHazard = false

# A hotkey for the store would be nice so I added this
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("open store"):
		_on_store_pressed()
	if Input.is_action_just_pressed("open map"):
		_on_map_pressed()
	$"Store ui/Control/Coins".text = str($Character.coins)

# opening through button
func _on_store_pressed() -> void:
	if $"Store ui".visible:
		$"Store ui".visible = false
		$CanvasLayer3/Store.text = "Open Store (LShift)"
	else:
		$"Store ui".visible = true
		$"Store ui/Control/The hint".visible = false
		$"Store ui/Control/Coins".text = "Coins: " + str($Character.coins)
		$CanvasLayer3/Store.text = "Close Store (LShift)"

# Getting a wumpus hint, takes 15 coins in exchange for showing which room the wumpus is in
func _on_hint_pressed() -> void:
	if $Character.coins >= 15:
		$Character.coins -= 15
		$"Store ui/Control/The hint".visible = true
		$"Store ui/Control/The hint".text = "Wumpus is in Room " + str(wumpusLocation)


func _on_invulner_pressed() -> void:
	if $Character.coins >= 20 and not doneWithHazard:
		$Character.coins -= 20
		doneWithHazard = true
		$"Hazard Timer".start()


func _on_sword_pressed() -> void:
	if $Character.coins >= 10 and !$Character.has_sword:
		$Character.coins -= 10
		$Character.sword()
		$"CanvasLayer/Labels for Directions/Sword".text = "You Have a Sword!"
		$Character.has_sword = true


func _on_map_pressed() -> void:
	if $"Map ui".visible:
		$"Map ui".visible = false
		$CanvasLayer3/Map.text = "Open Map (Enter)"
	else:
		$"Map ui".visible = true
		$CanvasLayer3/Map.text = "Close Map (Enter)"

# Can get extra coins for a coin with a given chance
func _on_gamble_pressed() -> void:
	if $Character.coins >= 1:
		$Character.coins -= 1
		if randi_range(1,150) == 150:
			$Character.coins += 99
