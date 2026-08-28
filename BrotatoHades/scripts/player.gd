extends CharacterBody2D
class_name Player

@export_category("Movement")
@export var max_speed: float = 250.0
@export var acceleration: float = 1400.0
@export var deceleration: float = 1800.0

@export_category("Dash")
@export var dash_speed: float = 700.0
@export var dash_duration: float = 0.12
@export var dash_cooldown: float = 0.5

var dash_timer: float = 0.0
var dash_cooldown_timer: float = 0.0
var dash_direction: Vector2 = Vector2.ZERO


func _physics_process(delta: float) -> void:
	dash_cooldown_timer = max(dash_cooldown_timer - delta, 0.0)

	if dash_timer > 0.0:
		update_dash(delta)
	else:
		update_movement(delta)

	move_and_slide()


func update_movement(delta: float) -> void:
	var input_direction := Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down"
	)

	if input_direction != Vector2.ZERO:
		var target_velocity := input_direction * max_speed

		velocity = velocity.move_toward(
			target_velocity,
			acceleration * delta
		)
	else:
		velocity = velocity.move_toward(
			Vector2.ZERO,
			deceleration * delta
		)

	if Input.is_action_just_pressed("dash") and dash_cooldown_timer <= 0.0:
		start_dash(input_direction)


func start_dash(input_direction: Vector2) -> void:
	if input_direction == Vector2.ZERO:
		input_direction = velocity.normalized()

	if input_direction == Vector2.ZERO:
		input_direction = Vector2.RIGHT

	dash_direction = input_direction.normalized()

	dash_timer = dash_duration
	dash_cooldown_timer = dash_cooldown

	velocity = dash_direction * dash_speed


func update_dash(delta: float) -> void:
	dash_timer -= delta

	velocity = dash_direction * dash_speed
