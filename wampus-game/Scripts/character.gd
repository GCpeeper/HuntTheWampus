extends CharacterBody2D

@onready var _sprite = $Sprite2D2 # replaced it with a different asset pack placeholder as the other one didnt work very well with animations and frame division
@onready var _animation_player = $AnimationPlayer # made and animation player system which could work better for more complicated animations (attacks and stuff mainly but otherwise works the same as other method)
@onready var _sense = $Label
@onready var _coin_lost_timer = $"Coin lost timer"
@onready var _coin_lost = $"Coin lost"

const SPEED = 300.0
const JUMP_VELOCITY = -500.0
var start_pos
signal exit_room(direction)
var sliding = false # Wall sliding
var taking_input = false
var coins = 0
var has_sword = false
var smelling = false # Wumpus nearby
var hearing = false # Bats nearby
var feeling = false # Pit nearby

func _ready() -> void:
	start_pos = position
	_animation_player.play("fall")

func coin():
	$coin.play()

func sword():
	$sword.play()

func _process(delta: float) -> void:
	# Updating the text depending on nearby hazards/wumpus
	if smelling:
		_sense.visible = true
		if hearing:
			if feeling:
				_sense.text = "I smell a wumpus, hear bats, and feel an updraft"
			else:
				_sense.text = "I smell a wumpus and hear bats"
		elif feeling:
			_sense.text = "I smell a wumpus and feel an updraft"
		else:
			_sense.text = "I smell a WUMPUS"
	elif hearing:
		_sense.visible = true
		if feeling:
			_sense.text = "I hear bats and feel an updraft"
		else:
			_sense.text = "I hear bats"				
	elif feeling:
		_sense.visible = true
		_sense.text = "I feel an updraft"
	else:
		_sense.visible = false

# Physics process
func _physics_process(delta: float) -> void:
	if taking_input: # Signal for exiting room, doesn't happen if in a cutscene
		if position.y >= 875:
			emit_signal("exit_room", 2)
		elif position.y <= 0:
			emit_signal("exit_room", 0)
		elif position.x <= 50:
			emit_signal("exit_room", 3)
		elif position.x>=1390:
			emit_signal("exit_room", 1)
	
	# Add the gravity.
	if not is_on_floor() and taking_input:
		velocity += get_gravity() * delta
		# Sliding functionality, allows you to walljump
		if $ShapeCast2D.is_colliding() and velocity.y > 0:
			velocity.y *= 0.8
			sliding = true
			
		else:
			sliding = false
		await get_tree().process_frame
		if velocity.y > 0:
			_animation_player.play("fall")
	else:
		sliding = false
	if taking_input:
		# Handle jump.
		if Input.is_action_just_pressed("jump"):
			if is_on_floor() or !$CoyoteTime.is_stopped() or sliding:
				_animation_player.play("jump")
				velocity.y = JUMP_VELOCITY
				if sliding:
					$WallJump.start() # Wall jump timer so that its direction doesn't get overrided
					# Moving away from the wall
					if _sprite.flip_h:
						velocity.x = 1000
					else:
						velocity.x = -1000

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis("left", "right")
		if direction and $WallJump.is_stopped(): # Determining direction
			velocity.x = direction * SPEED
			# Flipping sprite and hitboxes accordingly
			_sprite.flip_h = direction < 0
			$ShapeCast2D.rotation_degrees = -90*direction
			if is_on_floor() and velocity.y == 0:
				_animation_player.play("walk")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if is_on_floor() and velocity.y == 0:
				_animation_player.play("idle")
	var was_on_floor = is_on_floor()
	move_and_slide()
	
	if was_on_floor and !is_on_floor(): # Adds more leniency towards jumps
		$CoyoteTime.start()

# Hiding the indicator for losing a coin to spikes
func _on_coin_lost_timer_timeout() -> void:
	_coin_lost.visible = false
