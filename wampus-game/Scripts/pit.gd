extends Control

@onready var announcement = $Label
@onready var announcement2 = $Label2
@onready var question = $Question
@onready var answers = $Answers
@onready var player = $"../Character"
@onready var timer = $"../Timer"
@onready var riddleTimer = $"../Riddle_Timer"
@onready var timerBar = $ProgressBar
var step = 0
var riddleList = []
var riddle1 = ["What has roots that nobody sees, is taller than trees, up, up it goes, and yet never grows?", "A tall tree.", "A mountain", "A shadow.", "The Parthenon.", 2]
var riddle2 = ["There is a right triangle with sides A, B, and C. Side AB is 5 feet, angle A is 45, and angle B is 90. What is the area of the triangle?", "56 feet squared.", "25 feet squared.", "12.5 feet squared.", "25.5 feet squared.", 3]
var riddle3 = ["Idk man.", "56 feet squared.", "25 feet squared.", "12.5 feet squared.", "25.5 feet squared.", 1]
var riddle4 = ["When was the Parthenon completed?", "431 BC", "432 BC", "433 BC", "259 BC", "All of the Above", 2]
var riddle5 = ["What is the only land mammal that can't jump?", "Whale", "Deer", "Goat", "Elephant", 4]
var riddle6 = ["Who made the original Hunt the Wumpus?","Jimmy Donaldson","Gregory Donaldson","Gregory Yob", "Jimmy Yob", 3]
var riddle7 = ["How many peanuts does it take to make a jar of peanut butter?", "540", "320", "342", "200", 1]
var riddle8 = ["Using Archimedes' Principle, if the bouyant force on an object is 10 newtons, what is the mass of the object (using 9.8 meters squared)?", "2.3","1.56","1.02", "3",3]
var answer: int
var buttonList : Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	announcement.hide()
	announcement2.hide()
	question.hide()
	answers.hide()
	timerBar.value = 15
	riddleList = [riddle1, riddle2, riddle3, riddle4,riddle5,riddle6,riddle7,riddle8]
	buttonList = {$Buttons/A: 1,$Buttons/B: 2,$Buttons/C: 3,$Buttons/D:4}
	for i in buttonList.keys():
		i.pressed.connect(some_button_pressed)

func some_button_pressed():
	print("yeah")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player.position.y > 700 and step == 0:
		announcement.show()
		announcement.text = "You fell down the Pit!"
		announcement2.show()
		timer.start()
		step += 1
	if timerBar.visible == true:
		timerBar.value = riddleTimer.time_left



func _on_timer_timeout() -> void:
	announcement.hide()
	announcement2.hide()
	question.show()
	answers.show()
	$Buttons.show()
	timerBar.show()
	riddleTimer.start()
	var riddleChoice = randi_range(0,7)
	print(riddleChoice)
	question.text = (riddleList[riddleChoice])[0]
	answers.text = ": " + (riddleList[riddleChoice])[1] + "\n: " + (riddleList[riddleChoice])[2] + "\n: " + (riddleList[riddleChoice])[3] + "\n: " + (riddleList[riddleChoice])[4]


func _on_pressed() -> void:
	pass # Replace with function body.


func _on_riddle_timer_timeout() -> void:
	announcement.show()
	announcement.text = "You ran out of time!"
	question.hide()
	answers.hide()
	$Buttons.hide()
	timerBar.hide()
