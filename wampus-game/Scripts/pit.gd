extends Control

@onready var announcement = $Label
@onready var announcement2 = $Label2
@onready var question = $Question
@onready var answers = $Answers
@onready var player = $"../Character"
@onready var timer = $"../Timer"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	announcement.hide()
	announcement2.hide()
	question.hide()
	answers.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player.position.y > 700:
		announcement.show()
		announcement2.show()
		timer.start()
	


func _on_timer_timeout() -> void:
	announcement.hide()
	announcement2.hide()
	question.show()
	answers.show()
