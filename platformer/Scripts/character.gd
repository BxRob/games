extends CharacterBody2D

# Movement
@export var max_speed := 260.0
@export var acceleration := 1800.0
@export var ground_friction := 2200.0
@export var air_acceleration := 900.0

# Jump
@export var jump_force := -520.0
@export var gravity := 1400.0
@export var fall_gravity_multiplier := 1.8
@export var jump_cut_multiplier := 2.5

# Timing forgiveness
@export var coyote_time := 0.12
@export var jump_buffer_time := 0.12

var coyote_timer := 0.0
var jump_buffer_timer := 0.0


func _physics_process(delta):

	# Timers
	if is_on_floor():
		coyote_timer = coyote_time
	else:
		coyote_timer -= delta

	if jump_buffer_timer > 0:
		jump_buffer_timer -= delta


	# Input
	var direction = Input.get_axis("left", "right")


	# Horizontal movement
	if direction != 0:

		var target_speed = direction * max_speed

		if is_on_floor():
			velocity.x = move_toward(
				velocity.x,
				target_speed,
				acceleration * delta
			)
		else:
			velocity.x = move_toward(
				velocity.x,
				target_speed,
				air_acceleration * delta
			)

	else:

		# Ground has stronger stopping power
		if is_on_floor():
			velocity.x = move_toward(
				velocity.x,
				0,
				ground_friction * delta
			)


	# Gravity
	if not is_on_floor():

		var gravity_strength = gravity

		# Faster falling = better platforming feel
		if velocity.y > 0:
			gravity_strength *= fall_gravity_multiplier

		velocity.y += gravity_strength * delta


	# Jump input buffering
	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer = jump_buffer_time


	# Execute jump
	if jump_buffer_timer > 0 and coyote_timer > 0:

		velocity.y = jump_force

		jump_buffer_timer = 0
		coyote_timer = 0


	# Variable jump height
	if Input.is_action_just_released("jump") and velocity.y < 0:

		velocity.y *= 0.5


	move_and_slide()
