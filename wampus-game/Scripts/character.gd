extends CharacterBody2D

@onready var _sprite = $Sprite2D2 # replaced it with a different asset pack placeholder as the other one didnt work very well with animations and frame division
@onready var _animation_player = $AnimationPlayer # made and animation player system which could work better for more complicated animations (attacks and stuff mainly but otherwise works the same as other method)

const SPEED = 300.0
const JUMP_VELOCITY = -500.0
var start_pos
signal exit_room(direction)
var sliding = false

func _ready() -> void:
	start_pos = position
	_animation_player.play("fall")


func _physics_process(delta: float) -> void:
	if position.y >= 2000:
		emit_signal("exit_room", 4)
	elif position.y <= 2000:
		emit_signal("exit_room", 3)
	elif position.x <= 50:
		emit_signal("exit_room", 1)
	elif position.x>=1390:
		emit_signal("exit_room", 2)
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if $ShapeCast2D.is_colliding() and velocity.y > 0:
			velocity.y *= 0.5
			sliding = true
		else:
			sliding = false
		await get_tree().process_frame
		if velocity.y > 0:
			_animation_player.play("fall")
	else:
		sliding = false

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() or !$CoyoteTime.is_stopped() or sliding:
			_animation_player.play("jump")
			velocity.y = JUMP_VELOCITY
			if sliding:
				$WallJump.start()
				if _sprite.flip_h:
					velocity.x = 1000
				else:
					velocity.x = -1000

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction and $WallJump.is_stopped():
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
