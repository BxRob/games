extends CharacterBody2D


@export var move_speed := 150.0

func _process(delta: float) -> void:
	velocity.x = 0
	
	if Input.is_action_pressed("move_left"):
		velocity.x = -move_speed
	elif Input.is_action_pressed("move_right"):
		velocity.x = move_speed
	
	position.x = clamp(position.x, 53.0, 1096.0)
	
	move_and_slide()
