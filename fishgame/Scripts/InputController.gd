extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -325.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sfx: AudioStreamPlayer2D = $JumpSFX
@onready var cyote_timer: Timer = $CyoteTimer

var hasCyoteTime = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if !is_on_floor():
		velocity += get_gravity() * delta
		
		#Start cyote time
		if !hasCyoteTime:
			hasCyoteTime = true
			cyote_timer.start()

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() || Input.is_action_just_pressed("jump") && hasCyoteTime:
		velocity.y = JUMP_VELOCITY
		jump_sfx.play()

	# Get the input direction 
	var direction := Input.get_axis("move_left", "move_right")
	
	#Handle sprite flipping
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
	
	#Handle animations
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("Idle")
		else:
			animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("jump")
	
	#Apply Movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


#End of cyote time
func _on_cyote_timer_timeout() -> void:
	hasCyoteTime = false
