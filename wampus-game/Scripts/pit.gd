extends Control

@onready var announcement = $Label
@onready var announcement2 = $Label2
@onready var question = $Question
@onready var answers = $Answers
@onready var player = $"../Character"
@onready var timer = $"../Timer"
var step = 0
var riddleList = []
var riddle1 = ["What has roots that nobody sees, is taller than trees, up, up it goes, and yet never grows?", "A tall tree.", "A mountain", "A shadow.", "The Parthenon."]
var riddle2 = ["There is a right triangle with sides A, B, and C. Side AB is 5 feet, angle A is 45, and angle B is 90. What is the area of the triangle?", "56 feet squared.", "25 feet squared.", "12.5 feet squared.", "25.5 feet squared."]
var riddle3 = ["Idk man.", "56 feet squared.", "25 feet squared.", "12.5 feet squared.", "25.5 feet squared."]



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	announcement.hide()
	announcement2.hide()
	question.hide()
	answers.hide()
	riddleList = [riddle1, riddle2, riddle3]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player.position.y > 700 and step == 0:
		announcement.show()
		announcement2.show()
		timer.start()
		step += 1



func _on_timer_timeout() -> void:
	print("this works")
	announcement.hide()
	announcement2.hide()
	question.show()
	answers.show()
	var riddleChoice = randi_range(0,2)
	print(riddleChoice)
	$Question.text = (riddleList[riddleChoice])[0]
	$Answers.text = "A: " + (riddleList[riddleChoice])[1] + "\nB: " + (riddleList[riddleChoice])[2] + "\nC: " + (riddleList[riddleChoice])[3] + "\nD: " + (riddleList[riddleChoice])[4]
